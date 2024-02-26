+++
title = "azure_api_management Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_api_management"
identifier = "inspec/resources/azure/azure_api_management Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_api_management` InSpec audit resource to test the properties and configuration of an Azure API Management Service.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

`resource_group` and `name`, or the `resource_id` are required parameters.

```ruby
describe azure_api_management(resource_group: 'RESOURCE_GROUP', name: 'NAME') do
  it { should exist }
end
```

```ruby
describe azure_api_management(resource_id: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.ApiManagement/service/{apim01}') do
  it { should exist }
end
```

## Parameters

`resource_group`
: Azure resource group where the targeted resource resides.

`name`
: The unique name of the API Management Service.

`api_management_name`
: Alias for the `name` parameter.

`resource_id`
: The unique resource ID.

Either one of the parameter sets can be provided for a valid query:

- `resource_id`
- `resource_group` and `name`
- `resource_group` and `api_management_name`

## Properties

`identity`
: Managed service identity of the API Management service. It is an [API Management Service](https://docs.microsoft.com/en-us/rest/api/apimanagement/current-ga/api-management-service/get?tabs=HTTP#apimanagementservicegetservice).

`sku`
: The SKU (pricing tier) of the resource.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/apimanagement/current-ga/api-management-service/get?tabs=HTTP) for other properties available. Any attribute in the response may be accessed with the key names separated by dots (`.`).

## Examples

### Test API Management Service's publisher Email value

```ruby
describe azure_api_management(resource_group: RESOURCE_GROUP, api_management_name: API_MANAGEMENT_NAME) do
  its('properties.publisherEmail') { should eq 'company@inspec.io' }
end
```

### Loop through resources via plural resource

```ruby
azure_api_managements.ids.each do |resource_id|
  describe azure_api_management(resource_id: resource_id) do
    its('properties.publisherEmail') { should eq 'company@inspec.io' }
  end
end
```

See [integration tests](https://github.com/inspec/inspec-azure/blob/main/test/integration/verify/controls/azure_api_management.rb) for more examples.

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://docs.chef.io/inspec/matchers/).

### exists

```ruby
# If we expect 'APIM01' always to exist.

describe azure_api_management(resource_group: 'RESOURCE_GROUP', name: 'APIM01') do
  it { should exist }
end
```

### not_exists

```ruby
# If we expect 'APIM01' to never exist.

describe azure_api_management(resource_group: 'RESOURCE_GROUP', name: 'APIM01') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
