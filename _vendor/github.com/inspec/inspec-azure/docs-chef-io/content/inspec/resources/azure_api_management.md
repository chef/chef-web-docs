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

Use the `azure_api_management` InSpec audit resource to test properties and configuration of an Azure API Management Service.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

`resource_group` and `name` or the `resource_id` must be given as a parameter.
```ruby
describe azure_api_management(resource_group: 'inspec-resource-group-9', name: 'apim01') do
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
: Azure resource group that the targeted resource resides in. `MyResourceGroup`.

`name`
: The unique name of the API Management Service. `apim01`.

`api_management_name`
: Alias for the `name` parameter.

`resource_id`
: The unique resource ID. `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.ApiManagement/service/{apim01}`.

Either one of the parameter sets can be provided for a valid query:
- `resource_id`
- `resource_group` and `name`
- `resource_group` and `api_management_name`

## Properties

`identity`
: Managed service identity of the Api Management service. It is an [api management service identity object](https://docs.microsoft.com/en-us/rest/api/apimanagement/2019-12-01/apimanagementservice/get#apimanagementserviceidentity).

`sku`
: The SKU (pricing tier) of the resource.

For properties applicable to all resources, such as `type`, `name`, `id`, `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/apimanagement/2019-12-01/apimanagementservice/get#apimanagementserviceresource) for other properties available. 
Any attribute in the response may be accessed with the key names separated by dots (`.`).

## Examples

**Test API Management Service's Publisher Email Value.**

```ruby
describe azure_api_management(resource_group: resource_group, api_management_name: api_management_name) do
  its('properties.publisherEmail') { should eq 'company@inspec.io' }
end
```

**Loop through Resources via Plural Resource.**

```ruby
azure_api_managements.ids.each do |resource_id|
  describe azure_api_management(resource_id: resource_id) do
    its('properties.publisherEmail') { should eq 'company@inspec.io' }
  end
end
```
See [integration tests](../../test/integration/verify/controls/azurerm_api_management.rb) for more examples.

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://docs.chef.io/inspec/matchers/).

### exists

```ruby
# If we expect 'apim01' to always exist
describe azure_api_management(resource_group: 'example', name: 'apim01') do
  it { should exist }
end

# If we expect 'apim01' to never exist
describe azure_api_management(resource_group: 'example', name: 'apim01') do
  it { should_not exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}

