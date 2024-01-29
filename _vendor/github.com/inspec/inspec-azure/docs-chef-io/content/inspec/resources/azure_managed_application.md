+++
title = "azure_managed_application Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_managed_application"
identifier = "inspec/resources/azure/azure_managed_application Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_managed_application` InSpec audit resource to test the properties related to an Azure Managed application.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

`name` and `resource_group` are required parameters.

```ruby
describe azure_managed_application(resource_group: 'RESOURCE_GROUP', name: 'MANAGED_APPLICATION_NAME') do
  it                                      { should exist }
  its('type')                             { should eq 'Microsoft.ServiceBus/Namespaces' }
  its('location')                         { should eq 'East US' }
end
```

```ruby
describe azure_managed_application(resource_group: 'RESOURCE_GROUP', name: 'MANAGED_APPLICATION_NAME') do
  it  { should exist }
end
```

## Parameters

`name` _(required)_
: Name of the Azure managed applications to test.

`resource_group` _(required)_
: Azure resource group where the targeted resource resides.

## Properties

`id`
: Resource ID.

`name`
: Resource name.

`type`
: Resource type. `Microsoft.Solutions/applications`.

`location`
: Resource location.

`properties`
: The properties of the managed application.

`properties.plan`
: The plan information.

`properties.identity`
: The identity of the resource.

`properties.provisioningState`
: Provisioning state of the namespace.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/managedapplications/applications/get) for other properties available.

## Examples

### Test that the managed applications are provisioned successfully

```ruby
describe azure_managed_application(resource_group: 'RESOURCE_GROUP', name: 'MANAGED_APPLICATION_NAME') do
  its('properties.provisioningState') { should eq 'Succeeded' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# If a Managed application is found, it will exist.

describe azure_managed_application(resource_group: 'RESOURCE_GROUP', name: 'MANAGED_APPLICATION_NAME') do
  it { should exist }
end
```

### not_exists

```ruby
# If a Managed application is not found, it will not exist.

describe azure_managed_application(resource_group: 'RESOURCE_GROUP', name: 'MANAGED_APPLICATION_NAME') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="reader" %}}
