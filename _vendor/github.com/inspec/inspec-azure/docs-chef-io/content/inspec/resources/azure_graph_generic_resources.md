+++
title = "azure_graph_generic_resources Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_graph_generic_resources"
identifier = "inspec/resources/azure/azure_graph_generic_resources Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_graph_generic_resources` Inspec audit resource to test any valid Azure resource available through Microsoft Azure Graph API.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

```ruby
describe azure_graph_generic_resources(resource: 'RESOURCE', filter: {starts_with_property_name: 'A'}, select: %w(properties to be tested)) do
  its('property') { should eq 'value' }
end
```

> where
>
> - Resource parameters are used to query Azure Graph API endpoint for the resource to be tested.
> - `property` - This generic resource dynamically creates the properties on the fly based on the type of resource that has been targeted and the parameters provided with the `select` parameter.
> - `value` is the expected output from the chosen property.

## Parameters

The following parameters can be passed for targeting specific Azure resources.

`resource`
: Azure resource type where the targeted resource belongs. This is the only **MANDATORY** parameter. For example, `users`.

`filter`
: A hash containing the filtering options and their values. The `starts_with_` operator can be used for fuzzy string matching. Parameter names are in the snake case. For example, `{ starts_with_given_name: 'J', starts_with_department: 'Core', country: 'United Kingdom', given_name: John}`.

`filter_free_text`
: [OData](https://www.odata.org/getting-started/basic-tutorial/) query string in double quotes, `"`. Property names are in the camel case, refer to [Azure query parameters documentation](https://docs.microsoft.com/en-us/graph/query-parameters#filter-parameter) for more information. For example, `"startswith(displayName,'J') and surname eq 'Doe'"`.

`select`
: A list of the query parameters defining the attributes the resource will expose and to be tested. Property names are in camel case. If not provided then the predefined attributes will be returned from the API. For example, `['givenName', 'surname', 'department']`.

`api_version`
: API version of the Azure Graph API to use when interrogating the resource. If not set, then the predefined stable version will be used. For example, `v1.0` or `beta`.

It is advised to use `filter` or `filter_free_text` to narrow down the targeted resources at the server side, Azure Graph API, for a more efficient test.

## Properties

Attributes will be created dynamically by pluralizing the name of the properties of the resources and converting them to `snake_case` form.

For example, if the query parameters are `select: %w{ country department givenName }`, then the parameters will be:

- `ids` (default)
- `countries`
- `departments`
- `given_names`

### Filter Criteria

Returned resources can be filtered by their parameters provided with the `select` option, or the default values returned from the API unless the `select` is used.

For example, if the query parameters are `select: %w{ country department givenName }`, then the filter criteria will be:

- `id` (default)
- `country`
- `department`
- `givenName`

## Examples

### Test a selection of user accounts

```ruby
**Using filter parameter.**

describe azure_graph_generic_resources(resource: 'USERS', filter: { starts_with_given_name: 'J', starts_with_department: 'customer', country: 'United Kingdom' },  select: %w{ country userPrincipalName}) do
  it { should exist }
  its('countries'.uniq) { should eq ['United Kingdom'] }
end

**Using filter_free_text parameter.**

describe azure_graph_generic_resources(resource: 'USERS', filter_free_text: "startswith(givenName,'J') and startswith(department,'customer') and country eq 'United States'",  select: %w{ country userPrincipalName}) do
  it { should exist }
  its('countries'.uniq) { should eq ['United States'] }
end
```

### Filter<superscript>*</superscript> the results to only include that match the given country (Client-Side Filtering is NOT Recommended)

```ruby
    describe azure_graph_generic_resources(resource: 'USERS', select: %w{ country }).where(country: 'United Kingdom') do
      it { should exist }
    end
```

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

**Test `given_names` Parameter.**

```ruby
azure_graph_generic_resources(resource: 'USERS', filter: { starts_with_given_name: 'J' }, select: %w{ givenName }).given_names.each do |name|
  describe name do
    it { should start_with('J') }
  end
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

```ruby
# Should not exist if there is no resource with a given name.

describe azure_graph_generic_resources(resource: 'USERS', filter: { given_name: 'fake_name'}, select: %w{ givenName }) do
  it { should_not exist }
end
```

### not_exists

```ruby

# Should exist if there is at least one resource with a given name.

describe azure_graph_generic_resources(resource: 'USERS', filter: { given_name: 'valid_name'}, select: %w{ givenName }) do
  it { should exist }
end
```

## Azure Permissions

Graph resources require specific privileges granted to your service principal.

Please refer to the [Microsoft Documentation](https://docs.microsoft.com/en-us/azure/active-directory/develop/active-directory-integrating-applications#updating-an-application) for information on how to grant these permissions to your application.
