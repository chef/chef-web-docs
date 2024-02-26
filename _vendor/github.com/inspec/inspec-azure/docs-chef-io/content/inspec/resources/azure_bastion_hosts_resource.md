+++
title = "azure_bastion_hosts_resource Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_bastion_hosts_resource"
identifier = "inspec/resources/azure/azure_bastion_hosts_resource Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_bastion_hosts_resource` InSpec audit resource to test the properties related to a Bastion hosts resource.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

`resource_group` and bastion hosts resource `name`, or the `resource_id` are required parameters.

```ruby
describe azure_bastion_hosts_resource(resource_group: 'RESOURCE_GROUP', name: 'NAME') do
  it { should exist }
end
```

## Parameters

`resource_group`
: Azure resource group where the targeted resource resides.

`name`
: Name of the virtual network to test.

Both the parameter sets should be provided for a valid query: `resource_group` and `name`.

## Properties

`name`
: Name of the Azure resource to test.

`tags`
: A list of `tag:value` pairs defined on the resources.

`type`
: type of Bastion hostname.

`provisioning_state`
: State of Bastion host name creation.

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/virtualnetwork/bastion-hosts/get) for other properties available. Any attribute in the response may be accessed with the key names separated by dots (`.`).

## Examples

### Test to ensure that the Bastion hosts resource is from the same type

```ruby
describe azure_bastion_hosts_resource(resource_group: 'RESOURCE_GROUP', name: 'NAME') do
  its('type') { should eq 'Microsoft.Network/bastionHosts' }
end
```

### Test to ensure that the Bastion hosts resource is in a successful state

```ruby
describe azure_bastion_hosts_resource(resource_group: 'RESOURCE_GROUP', name: 'NAME') do
  its('provisioning_state') { should include('Succeeded') }
end
```

### Test to ensure that the Bastion hosts resource is from the same location

```ruby
describe azure_bastion_hosts_resource(resource_group: 'RESOURCE_GROUP', name: 'NAME') do
  its('location') { should include df_location }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](/inspec/matchers/).

### exists

```ruby
# If a Bastion hosts resource is found, it will exist.

describe azure_bastion_hosts_resource(resource_group: 'RESOURCE_GROUP', name: 'NAME') do
  it { should exist }
end
```

### not_exists

```ruby
# Bastion hosts resources that are not found, will not exist.

describe azure_bastion_hosts_resource(resource_group: 'RESOURCE_GROUP', name: 'DOES_NOT_EXIST') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
