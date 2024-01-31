+++
title = "azure_graph_generic_resource Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_graph_generic_resource"
identifier = "inspec/resources/azure/azure_graph_generic_resource Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_graph_generic_resource` Inspec audit resource to test any valid Azure resource available through Microsoft Azure Graph API.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

```ruby
describe azure_graph_generic_resource(resource: 'RESOURCE', id: 'GUID', select: %w(attributes to be tested)) do
  its('property') { should eq 'value' }
end
```

> where:
>
> - Resource parameters are used to query Azure Graph API endpoint for the resource to be tested.
> - `property` - This generic resource dynamically creates the properties on the fly based on the property names provided with the `select` parameter.
> - `value` is the expected output from the chosen property.

## Parameters

The following parameters can be passed for targeting a specific Azure resource.

`resource`
: Azure resource type where the targeted resource belongs. For example, `users`.

`id`
: Globally unique ID of the targeted resource. For example, `jdoe@example.com`.

`select`
: The list of query parameters defining which attributes the resource will expose. If not provided, then the predefined attributes will be returned from the API. For example, `givenName`, `surname`, and `department`.

`api_version`
: API version of the GRAPH API to use when interrogating the resource. If not set, then the predefined stable version will be used. For example, `v1.0`, or `beta`.

## Properties

The properties that can be tested are entirely dependent on the Azure Resource that is tested and the query parameters provided with the `select` parameter.

## Examples

### Test properties of a user account

```ruby
describe azure_graph_generic_resource(resource: 'USERS', id: 'jdoe@contoso.com', select: %w{ surname givenName }) do
  its('surname') { should cmp 'Doe' }
  its('givenName') { should cmp 'John' }
end
```

For more examples, please see the [integration tests](https://github.com/inspec/inspec-azure/blob/main/test/integration/verify/controls/azure_graph_generic_resource.rb).

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

```ruby
# Should not exist if there is no resource with a given name.

describe azure_graph_generic_resource(resource: 'users', id: 'fake_id') do
  it { should_not exist }
end
```

### not_exists

```ruby
# Should exist if there is one resource with a given name.

describe azure_graph_generic_resource(resource: 'users', id: 'valid_id') do
  it { should exist }
end
```

## Azure Permissions

Graph resources require specific privileges granted to your service principal.

Please refer to the [Microsoft Documentation](https://docs.microsoft.com/en-us/azure/active-directory/develop/active-directory-integrating-applications#updating-an-application) for information on how to grant these permissions to your application.
