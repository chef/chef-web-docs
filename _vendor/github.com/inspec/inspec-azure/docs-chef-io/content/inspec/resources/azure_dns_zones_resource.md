+++
title = "azure_dns_zones_resource Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_dns_zones_resource"
identifier = "inspec/resources/azure/azure_dns_zones_resource Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_dns_zones_resource` InSpec audit resource to test properties of an Azure DNS zone.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

This resource requires either the `resource_group` and DNS zone resource `name`, or the `resource_id`.

```ruby
describe azure_dns_zones_resource(resource_group: 'RESOURCE_GROUP_NAME', name: 'DNS_ZONE_NAME') do
  it { should exist }
end
```

or

```ruby
describe azure_dns_zones_resource(resource_id: 'DNS_ZONE_RESOURCE_ID') do
  it { should exist }
end
```

## Parameters

`resource_group`
: Azure resource group that the targeted resource resides in.

`name`
: Name of the DNS zone to test.

`resource_id`
: The resource ID of the DNS zone to test.

The `resource_group` and `name`, or the `resource_id` are required parameters.

## Properties

`name`
: Name of the Azure resource to test.

`type`
: The type of DNS zone.

`max_number_of_recordsets`
: The maximum number of record sets that can be created in this DNS zone.

`number_of_record_sets`
: The current number of record sets in this DNS zone.

`name_servers`
: The name servers for this DNS zone.

`properties`
: The properties of the Azure DNS zone resource.

`location`
: The DNS zone resource location.


Also, refer to the [Azure documentation](https://docs.microsoft.com/en-us/rest/api/dns/zones/get)
for other available properties.
Any attribute in the response may be accessed with the key names separated by dots (`.`).

## Examples

**Test that the Azure DNS zone resource has the correct resource type.**

```ruby
describe azure_dns_zones_resource(resource_group: 'RESOURCE_GROUP_NAME', name: 'DNS_ZONE_NAME') do
  its('type') { should eq 'Microsoft.Network/dnszones' }
end
```

**Test that the location of the Azure DNS zone resource is `global`.**

```ruby
describe azure_dns_zones_resource(resource_group: 'RESOURCE_GROUP_NAME', name: 'DNS_ZONE_NAME') do
  its('location') { should eq 'global' }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](/inspec/matchers/).

### exists

```ruby
# If a DNS Zone resource is found it will exist

describe azure_dns_zones_resource(resource_group: 'RESOURCE_GROUP_NAME', name: 'DNS_ZONE_NAME') do
  it { should exist }
end

# DNS Zone resources that aren't found will not exist
describe azure_dns_zones_resource(resource_group: 'RESOURCE_GROUP_NAME', name: 'DNS_ZONE_NAME') do
  it { should_not exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
