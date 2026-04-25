+++
title = "Create a RESTful custom resource"


[menu]
  [menu.client_18]
    title = "REST resource"
    identifier = "resources/custom/rest"
    parent = "resources/custom"
    weight = 50
+++

The REST resource DSL is a base resource class in Chef Infra Client that allows you to create custom resources that interact with RESTful APIs.
Instead of writing HTTP request handling code from scratch, you can extend this resource to create custom resources that automatically handle API interactions, JSON mapping, and state management.

With the REST resource, you can:

- Define resource properties that map directly to API fields.
- Declare the target API endpoint directly in the resource class.
- Use built-in actions to create, update, and delete resources with REST APIs.
- Create nested JSON structures using JMESPath expressions.
- Handle authentication, pagination, and error conditions cleanly.

## Requirements

The REST custom resource DSL has the following requirements:

- The custom resource must use the `core::rest_resource` partial.
- Use `property` to define the properties you want to map to the REST API.
- The target REST API endpoints (collection and document URLs) must be accessible.
- The Chef Infra Client node must have network access to the REST API endpoints.
- Any required API authentication (tokens, credentials) must be handled, typically with resource properties or configuration.

## Configure the API endpoint

You can configure an API endpoint using Train transport.

### Train transport endpoint

Configure the base URL in the Chef target mode transport (Train). The resource then uses relative paths only, and Train prepends its configured endpoint.

Set the transport endpoint using either a Policyfile or a knife configuration file:

```ruby
# .chef/config.rb or Policyfile transport block
transport:
  name:     rest
  endpoint: https://api.example.com
```

With the endpoint's base URL configured, define the resource's relative paths:

```ruby
class Chef::Resource::ApiUser < Chef::Resource
  use "core::rest_resource"

  resource_name :api_user
  provides :api_user

  # Base URL comes from the Train transport
  rest_api_collection "/api/v1/users"
  rest_api_document   "/api/v1/users/{username}"

  property :username, String, name_property: true
  property :email,    String

  rest_property_map({ username: "username", email: "email" })
end
```

Once defined, you can use the custom resource to add and remove a user in a recipe. For example:

```ruby
# Create or update a user
api_user "jdoe" do
  email "jdoe@example.com"
  active true
  action :configure
end

# Delete a user
api_user "jdoe" do
  action :delete
end
```

## Methods and actions

The `rest_resource` has the following methods and actions.

### Methods

The REST resource provides several DSL methods for configuring API interactions.
These methods are called within your custom resource class definition.

#### `rest_api_collection`

This method defines the base URL path for the resource collection. Chef Infra Client uses this URL to list resources and create new ones.

This method has the following syntax:

```ruby
rest_api_collection "/path/to/collection"
```

- Path must be absolute (start with `/`)
- Used for GET (list all) and POST (create) operations
- Subclasses inherit this value unless they override it

For example:

```ruby
rest_api_collection "/api/v1/users"
```

#### `rest_api_document`

This method defines the URL pattern for individual resource documents and supports RFC 6570 URI templates for dynamic URLs.

This method has the following syntax:

```ruby
rest_api_document "/path/to/{resource_id}", first_element_only: false
```

Parameters:

- `path` (String): URL pattern with optional `{template}` placeholders matching property names
- `first_element_only` (Boolean): If `true`, extracts the first element from an array response. Default is `false`.

For example:

- Path-based selection:

    ```ruby
    rest_api_document "/api/v1/users/{username}"
    ```

- Query-based selection:

    ```ruby
    rest_api_document "/api/v1/users?name={username}&org={organization}"
    ```

- Get the first item in an array:

    ```ruby
    rest_api_document "/api/v1/search?q={name}", first_element_only: true
    ```

    With `first_element_only: true`, if the API response returns an array, the resource extracts only the first element.

    For example, if this is the response:

    ```ruby
    [{"name": "alice", "email": "alice@example.com"}, {"name": "bob", "email": "bob@example.com"}]
    ```

    The resource extracts the following: `{"name": "alice", "email": "alice@example.com"}`.

#### `rest_identity_map`

This method explicitly defines which properties uniquely identify a resource. This is usually inferred automatically from the document URL template variables, but can be specified for composite keys or when the JSON field name differs from the URI template variable.

This method has the following syntax:

```ruby
rest_identity_map(<MAPPING>)
```

Replace `<MAPPING>` with a hash mapping JSON field paths to property symbols. For example:

```ruby
# Single identity property
rest_identity_map({ "username" => :username })

# Composite identity
rest_identity_map({
  "user.name"       => :username,
  "organization.id" => :org_id
})
```

#### `rest_post_only_properties`

Declares properties that should only be sent during resource creation (POST) and excluded from updates (PATCH).

This method has the following syntax:

```ruby
rest_post_only_properties <PROPERTY_OR_ARRAY>
```

Replace `<PROPERTY_OR_ARRAY>` with a single symbol or array of symbols representing property names. For example:

- Single property:

    ```ruby
    rest_post_only_properties :password
    ```

- Multiple properties:

    ```ruby
    rest_post_only_properties [:password, :initial_role, :creation_token]
    ```

Common use cases:

- Passwords or secrets that can't be updated with the API
- Resource size or capacity that's immutable after creation
- Template or source identifiers used only during initialization

#### `rest_property_map`

The `rest_property_map` method maps resource properties to JSON API fields. This supports simple mappings and complex nested structures using JMESPath.

This method has the following syntax:

```ruby
rest_property_map <MAPPING>
```

Replace `<MAPPING>` with:

- An array of 1:1 mappings
- A hash mapping resource properties to JSON fields or [JMESPaths](https://jmespath.org/)
- A hash mapping resource properties to symbols for custom serialization functions

For example:

- Array of mappings. If your property names match the JSON field names, you can use an array:

  ```ruby
  rest_property_map [:username, :email, :role]
  # Equivalent to: { username: 'username', email: 'email', role: 'role' }
  ```

- String values. If your property names differ from the JSON fields, or you need to map to nested fields, use a hash:

  ```ruby
  rest_property_map({
    full_name: "profile.fullName",
    email:     "contact.email.primary"
  })
  ```

- Symbol values. Map a property to a symbol to use custom serialization and deserialization methods:

  ```ruby
  rest_property_map({
    tags: :tags_mapping  # Uses tags_from_json and tags_to_json methods
  })
  ```

See the following examples for more information:

- [Use JMESPath expressions to map data](#use-jmespath-expressions-to-map-data-in-a-json-structure)

### Actions

The REST resource provides two built-in actions.

#### `:configure` (default)

The `:configure` action creates a new resource or updates an existing one. This action is idempotent and does the following:

- Checks if the resource exists by querying the API
- If it doesn't exist: sends a POST request to create it
- If it exists and properties are changed: sends a PATCH request to update it
- If it exists and nothing changed: takes no action

For example:

```ruby
api_user "john" do
  email "john@example.com"
  role "admin"
  action :configure  # This is the default action
end
```

#### `:delete`

The `:delete` action deletes a resource from the REST API. This action is idempotent and does the following:

- Checks if the resource exists
- If it exists: sends a DELETE request
- If it doesn't exist: takes no action

For example:

```ruby
api_user "john" do
  action :delete
end
```

## More features

### Custom headers and authentication

Override the `rest_headers` method in your action class to add custom headers such as authentication tokens.

```ruby
class Chef::Resource::ApiResource < Chef::Resource
  use "core::rest_resource"

  rest_api_collection "/api/v1/resources"
  rest_api_document   "/api/v1/resources/{id}"

  property :id, String, name_property: true

  rest_property_map({ id: "id" })

  action_class do
    def rest_headers
      {
        "Authorization" => "Bearer #{node['api_token']}",
        "X-API-Version" => "2024-01-01",
        "Content-Type"  => "application/json"
      }
    end
  end
end
```

### Response post-processing

Override the `rest_postprocess` method to transform API responses, handle pagination, or extract embedded data.

```ruby
action_class do
  def rest_postprocess(response)
    # Extract data from paginated response
    if response.data.is_a?(Hash) && response.data["items"]
      response.data = response.data["items"]
    end

    # Add custom logging
    Chef::Log.debug("API response: #{response.data.inspect}")

    response
  end
end
```

### Custom error handling

Override the `rest_errorhandler` method to provide user-friendly error messages or handle specific error codes.

```ruby
action_class do
  def rest_errorhandler(error_obj)
    case error_obj.response&.code
    when 404
      Chef::Log.warn("Resource not found - it may have been deleted externally")
      nil
    when 429
      raise "API rate limit exceeded. Please try again later."
    when 401, 403
      raise "Authentication failed. Check your API credentials."
    else
      raise error_obj  # Re-raise for unexpected errors
    end
  end
end
```

### Conditional property requirements

Use the `conditionally_require_on_setting` helper to enforce dependencies between properties.

```ruby
action_class do
  def load_current_resource
    super

    # If ssl_enabled is true, require ssl_cert and ssl_key
    conditionally_require_on_setting(:ssl_enabled, [:ssl_cert, :ssl_key])
  end
end
```

## Examples

### Create a REST resource using the Train transport endpoint

The following `api_user` resource uses the Chef target mode Train transport to provide the base URL. The resource uses relative paths only, and Train prepends its configured endpoint.

```ruby
class Chef::Resource::ApiUser < Chef::Resource
  use "core::rest_resource"

  resource_name :api_user
  provides :api_user

  # Base URL comes from the Train transport
  rest_api_collection "/api/v1/users"
  rest_api_document   "/api/v1/users/{username}"

  property :username,   String, name_property: true, identity: true
  property :email,      String, required: true
  property :first_name, String
  property :last_name,  String
  property :role,       String, equal_to: ["admin", "user", "readonly"], default: "user"
  property :active,     [true, false], default: true
  property :password,   String, sensitive: true

  rest_property_map({
    username:   "username",
    email:      "email",
    first_name: "profile.firstName",
    last_name:  "profile.lastName",
    role:       "permissions.role",
    active:     "status.active",
    password:   "password"
  })

  rest_post_only_properties :password
end
```

Configure the base URL in the Chef target mode transport:

```ruby
# .chef/config.rb or Policyfile transport block
transport:
  name:     rest
  endpoint: https://api.example.com
```

The recipe usage is identical in both cases.

### Use JMESPath expressions to map data in a JSON structure

JMESPath navigates and extracts data from JSON structures. The REST resource supports JMESPath for both reading from and writing to APIs.

#### JMESPath dot notation

You can use dot notation to specify nested data.

This code extracts data from the following JSON:

```ruby
rest_property_map({
  username: "username",           # Top-level field
  email:    "contact.email",      # Nested field
  city:     "address.location.city"  # Deeply nested field
})
```

```json
{
  "username": "jdoe",
  "contact": {
    "email": "jdoe@example.com",
    "phone": "+1-555-0100"
  },
  "address": {
    "location": {
      "city": "San Francisco",
      "state": "CA",
      "zip": "94102"
    }
  }
}
```

#### JMESPath wildcard notation

You can use a JMESPath wildcard expression to extract data from a JSON structure.

For example, the following extracts the email address from each member in this JSON:

```ruby
rest_property_map({
  member_emails: "members[*].email"
})
```

```json
{
  "members": [
    {
      "name": "Admin1",
      "email": "admin1@example.com",
      "role": "admin"
    },
    {
      "name": "User1",
      "email": "user1@example.com",
      "role": "user"
    }
  ]
}
```

#### JMESPath filter projection

You can use a filter projection to extract JSON data matching a condition.

For example, the following returns the names of active users (`["Alice Johnson", "Carol White"]`) from this JSON:

```ruby
rest_property_map({
  active_users: "users[?active==`true`].name"  # Filter and extract
})
```

```json
{
  "users": [
    {
      "id": "user-001",
      "name": "Alice Johnson",
      "email": "alice@example.com",
      "active": true,
      "department": "Engineering"
    },
    {
      "id": "user-002",
      "name": "Bob Smith",
      "email": "bob@example.com",
      "active": false,
      "department": "Sales"
    },
    {
      "id": "user-003",
      "name": "Carol White",
      "email": "carol@example.com",
      "active": true,
      "department": "Marketing"
    }
  ]
}
```

### Query-based resource selection

This example demonstrates how to use query parameters to identify a unique resource when the API doesn't support path-based resource selection. It also shows how to use `rest_identity_map` when the JSON field names differ from the URI template variable names.

```ruby
class Chef::Resource::DnsRecord < Chef::Resource
  use "core::rest_resource"

  resource_name :dns_record
  provides :dns_record

  rest_api_endpoint   "https://dns.example.com"
  rest_api_collection "/api/v1/zones/example.com/records"
  rest_api_document   "/api/v1/zones/example.com/records?name={record_name}&type={record_type}"

  property :record_name, String, name_property: true
  property :record_type, String, equal_to: ["A", "AAAA", "CNAME", "MX", "TXT"], default: "A"
  property :value,       String, required: true
  property :ttl,         Integer, default: 3600

  rest_property_map({
    record_name: "name",
    record_type: "type",
    value:       "content",
    ttl:         "ttl"
  })

  # Explicitly define composite identity
  rest_identity_map({
    "name" => :record_name,
    "type" => :record_type
  })
end
```

In a recipe:

```ruby
dns_record "www.example.com" do
  record_type "A"
  value       "192.0.2.1"
  ttl         300
  action      :configure
end
```

## Troubleshooting

### Debugging API requests

Enable debug logging to see API requests and responses:

```ruby
action_class do
  def rest_postprocess(response)
    Chef::Log.debug("API Request: #{rest_url_document}")
    Chef::Log.debug("API Response: #{response.data.inspect}")
    response
  end
end
```

### Common issues

#### Issue: "No such file" error for identity property

This usually means the identity mapping is incorrect or the document URL template doesn't match the property name.

```ruby
# Ensure template variables match property names
rest_api_document "/api/v1/users/{username}"  # Template variable: username
property :username, String, identity: true    # Property name: username
```

#### Issue: Properties not updating

Check if properties are accidentally marked as post-only:

```ruby
rest_post_only_properties [:password]  # Only password is post-only
# Don't include properties that should be updatable
```

#### Issue: "Can't resolve property to JSON"

Verify your property map includes all properties you are trying to set:

```ruby
property :email, String
property :role,  String

rest_property_map({
  email: "email",
  role:  "role"
})
```

## Additional resources

- [Custom resources documentation](/resources/custom/)
- [JMESPath Tutorial](https://jmespath.org/tutorial.html)
- [RFC 6570 URI Template Specification](https://tools.ietf.org/html/rfc6570)
- [REST API Tutorial](https://restfulapi.net/)
