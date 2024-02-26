+++
title = "azure_network_security_group Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_network_security_group"
identifier = "inspec/resources/azure/azure_network_security_group Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_network_security_group` InSpec audit resource to test the properties of an Azure Network Security group.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_network_security_group` resource block identifies a Network Security group by `name` and `resource_group`, or the `resource_id`.

```ruby
describe azure_network_security_group(resource_group: 'RESOURCE_GROUP', name: 'GROUP_NAME') do
  it { should exist }
end
```

```ruby
describe azure_network_security_group(resource_id: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Network/networkSecurityGroups/{nsgName}') do
  it { should exist }
end
```

## Parameters

`resource_group`
: Azure resource group where the targeted resource resides.

`name`
: Name of the Azure resource to test.

`resource_id`
: The unique resource ID. `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Network/networkSecurityGroups/{nsgName}`.

`resource_data`
: In-memory cached Azure Network Security group data. Passing data to this parameter can increase performance since it avoids multiple network calls to the same Azure resource. When provided, it binds the values directly to the resource. Data passed to the `resource_data` parameter could be stale. It is the user's responsibility to refresh the data.

Provide one of the following parameter sets for a valid query:

- `resource_id`
- `resource_group` and `name`
- `resource_data`

## Properties

`security_rules`
: The set of security rules.

`default_security_rules`
: The set of default security rules.

`allow_ssh_from_internet<superscript>*</superscript>`
: A boolean value determined by analysing the security rules and default security rules for unrestricted SSH access. `it { should_not allow_ssh_from_internet }`.

`allow_rdp_from_internet<superscript>*</superscript>`
: A boolean value determined by analysing the security rules and default security rules for unrestricted RDP access. `it { should_not allow_rdp_from_internet }`.

`allow_port_from_internet<superscript>*</superscript>`
: A boolean value determined by analysing the security rules and default security rules for unrestricted access to a specified port. `it { should_not allow_port_from_internet('443') }`.

`allow?<superscript>**</superscript>`
: Indicates if a provided criteria is complaint with the security rules including the default ones. `it { should allow(source_ip_range: '10.0.0.0/24'), direction: 'inbound' }`.

`allowed?<superscript>**</superscript>`
: Alias for `allow?`. `it { should be_allowed(source_ip_range: '10.0.0.0/24'), direction: 'inbound' }`.

`allow_in?<superscript>**</superscript>`
: Indicates if a provided criteria is complaint with the **inbound** security rules including the default ones. `it { should_not allow_in(service_tag: 'Internet') }`.

`allowed_in?<superscript>**</superscript>`
: Alias for `allow_in?`. `it { should_not be_allowed_in(service_tag: 'Internet') }`.

`allow_out?<superscript>**</superscript>`
: Indicates if a provided criteria is complaint with the **outbound** security rules including the default ones. `it { should_not allow_out(service_tag: 'Internet') }`.

`allowed_out?<superscript>**</superscript>`
: Alias for `allow_out?`. `it { should_not be_allowed_out(service_tag: 'Internet') }`.

<superscript>*</superscript> These properties do not take the priorities of security rules into account. For example, if suppose there are two security rules. In that case, one of them is allowing SSH from the internet while the other is prohibiting, `allow_ssh_from_internet` will pass without comparing the priority of the conflicting security rules. Therefore, it is recommended to use `allow`, `allow_in`, or `allow_out` properties with which the priorities are considered.

<superscript>**</superscript> These properties do not compare criteria defined by explicit IP ranges with the security rules defined by [Azure service tags](https://docs.microsoft.com/en-us/azure/virtual-network/service-tags-overview) and vice versa.

For example, providing that a network security group has a single security rule allowing all traffic from the internet by using `Internet` service tag in the source will fail the `allow_in(ip_range: '64.233.160.0')` test due to incompatible source definitions. This is because the InSpec Azure resource pack has no control over which IP ranges are defined in Azure service tags. Therefore, tests using these methods should be written explicitly for service tags and IP ranges. For more information about network security groups and security rules, refer to [here](https://docs.microsoft.com/en-us/azure/virtual-network/security-overview).

`*ip_range` used in these methods supports IPv4 and IPv6. The IP range criteria should be written in CIDR notation.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/virtualnetwork/networksecuritygroups/get#networksecuritygroup) for other properties available. Any property in the response may be accessed with the key names separated by dots (`.`).

## Examples

### Test that a resource group has the specified Network Security group

```ruby
describe azure_network_security_group(resource_group: 'RESOURCE_GROUP', name: 'GROUP_NAME') do
  it { should exist }
end
```

### Test that a Network Security group allows SSH from the internet

```ruby
describe azure_network_security_group(resource_group: 'RESOURCE_GROUP', name: 'GROUP_NAME') do
  it { should allow_ssh_from_internet }
end
```

### Test that a Network Security group allows inbound traffics from a certain IP range in any port and protocol

```ruby
describe azure_network_security_group(resource_group: 'RESOURCE_GROUP', name: 'GROUP_NAME') do
  it { should allow(source_ip_range: '10.0.0.0/24', direction: 'inbound') }
**same test with the specific inbound rule check.**
end
```

### Test that a Network Security group allows inbound traffics from internet service tag in port `80` and `TCP` protocol

```ruby
describe azure_network_security_group(resource_group: 'RESOURCE_GROUP', name: 'GROUP_NAME') do
  it { should allow(source_service_tag: 'Internet', destination_port: '22', protocol: 'TCP', direction: 'inbound') }
**same test with the specific inbound rule check.**

end
```

### Test that a Network Security group allows inbound traffics from virtual network service tag in a port range and protocol

```ruby
describe azure_network_security_group(resource_group: 'RESOURCE_GROUP', name: 'GROUP_NAME') do
  it { should allow(source_service_tag: 'VirtualNetwork', destination_port: %w{22 8080 56-78}, direction: 'inbound') }
**same test with the specific inbound rule check.**

end
```

### Test that a Network Security group allows outbound traffics to a certain IP range in any port and protocol

```ruby
describe azure_network_security_group(resource_group: 'RESOURCE_GROUP', name: 'GROUP_NAME') do
  it { should allow(destination_ip_range: '10.0.0.0/24', direction: 'outbound') }
**same test with the specific outbound rule check.**

end
```

### Loop through multiple Network Security groups and verify that each group does not allow inbound traffic from already cached data

```ruby
azure_network_security_groups.entries.each do |azure_network_security_group_data|
  describe azure_network_security_group(resource_data: azure_network_security_group_data) do
    it { should_not allow(destination_ip_range: '10.0.0.0/24', direction: 'inbound') }
**same test with the specific outbound rule check.**

  end
end
```

{{< note >}}

Please note that `allow` requires the `direction` parameter to be set to `inbound` or `outbound` and you must prefix the `ip_range`, `service_tag`, and `port` with `source_` or `destination_` identifiers.

{{< /note >}}

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

The control passes if the resource returns a result. Use `should_not` if you expect zero matches.

```ruby
# If we expect 'GROUPNAME' to always exist.

describe azure_network_security_group(resource_group: 'RESOURCE_GROUP', name: 'GROUP_NAME') do
  it { should exist }
end
```

### not_exists

```ruby
# If we expect 'EMPTYGROUPNAME' to never exist.

describe azure_network_security_group(resource_group: 'RESOURCE_GROUP', name: 'GROUP_NAME') do
  it { should_not exist }
end
```
### Test that a Network Security group should not allow UDP from the internet

```ruby
describe azure_network_security_group(resource_group: 'RESOURCE_GROUP', name: 'GROUP_NAME') do
  it { should_not allow_udp_from_internet }
end
```
### Validating Number of days to retain flow log records.

```ruby
describe azure_network_security_group(resource_group: 'RESOURCE_GROUP', name: 'GROUP_NAME') do
  its('flow_log_retention_period') { should eq 0 }
end
```
## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="reader" %}}
