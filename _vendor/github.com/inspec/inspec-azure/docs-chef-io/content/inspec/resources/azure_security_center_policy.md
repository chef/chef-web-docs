+++
title = "azure_security_center_policy Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_security_center_policy"
identifier = "inspec/resources/azure/azure_security_center_policy Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_security_center_policy` InSpec audit resource to test properties and configuration of an Azure security policy.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

An `azure_security_center_policy` resource block will lookup the `default` policy unless `resource_group` and `name` or the `resource_id` parameter is given.
```ruby
# The default security policy will be interrogated.

describe azure_security_center_policy do
  its('name') { should cmp 'default' }
end
```
```ruby
describe azure_security_center_policy(resource_group: 'inspec-resource-group-9', name: 'example_policy') do
  it { should exist }
end
```
```ruby
describe azure_security_center_policy(resource_id: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/microsoft.Security/policies/{policy-name}') do
  it { should exist }
end
```

## Parameters

`resource_group`
: Azure resource group that the targeted resource resides in. `MyResourceGroup`.

`name`
: Name of the security policy to test. `policy-name`.

`resource_id`
: The unique resource ID. `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/microsoft.Security/policies/{policy-name}`.

`default_policy_api_version<superscript>*</superscript>`
: The endpoint api version for the `default_policy` property. The latest version will be used unless provided.

`auto_provisioning_settings_api_version<superscript>*</superscript>`
: The endpoint api version for the `auto_provisioning_settings` property. The latest version will be used unless provided.

<superscript>*</superscript> It will be ignored unless the default policy is tested.

Either one of the parameter sets can be provided for a valid query:
- `resource_id`
- `resource_group` and `name`
- `name: 'default'`: This is for backward compatibility. It is advised not to pass any parameters if the default security policy is tested.

## Properties

`log_collection`
: Indicates if the log collection is enabled (`On`, `Off`).

`pricing_tier`
: Cost/Feature Model under which the subscription is operating.

`patch`
: Indicates if patch scanner notifications are enabled (`On`, `Off`).

`baseline`
: Indicates if baseline scanner notifications are enabled (`On`, `Off`).

`anti_malware`
: Indicates if anti-malware protection task notifications are enabled (`On`, `Off`).

`network_security_groups`
: Indicates if network security group recommendations are enabled are enabled (`On`, `Off`).

`web_application_firewall`
: Indicates if WAF protection task notifications are enabled (`On`, `Off`).

`vulnerability_assessment`
: Indicates if vulnerability assessment recommendations are enabled (`On`, `Off`).

`storage_encryption`
: Indicates if storage encryption recommendations are enabled (`On`, `Off`).

`just_in_time_network_access`
: Indicates if just in time network access recommendations are enabled (`On`, `Off`).

`app_whitelisting`
: Indicates if app whitelisting recommendations are enabled (`On`, `Off`).

`sql_auditing`
: Indicates if sql auditing recommendations are enabled (`On`, `Off`).

`sql_transparent_data_encryption`
: Indicates if sql transparent data encryption recommendations are enabled (`On`, `Off`).

`notifications_enabled`
: Indicates if security alerts are emailed to the security contact (`true`, `false`).

`send_security_email_to_admin`
: Indicates if the subscription admin will receive security alerts (`true`, `false`).

`contact_emails`
: Contains a list of security email addresses.

`contact_phone`
: Contains the security contact phone number.

`default_policy<superscript>*</superscript>`
: This is the default set of policies monitored by Azure Security Center.

`auto_provisioning_settings<superscript>*</superscript>`
: This is the default auto provisioning setting for the subscription.

<superscript>*</superscript>Only applicable to the default security policy.

For properties applicable to all resources, such as `type`, `name`, `id`, `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Any attribute in the response may be accessed with the key names separated by dots (`.`), eg. `properties.<attribute>`.

## Examples

**Test If Log Collection is Enabled.**

```ruby
describe azure_security_center_policy(resource_group: 'my-rg', name: 'my_policy') do
  its('log_collection') { should cmp 'On' }
end
```
**Test If Notifications are Enabled.**

```ruby
describe azure_security_center_policy(resource_group: 'my-rg', name: 'my_policy') do
  its('notifications_enabled') { should be true }
end
```    
See [integration tests](../../test/integration/verify/controls/azurerm_security_center_policy.rb) for more examples.

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### have_auto_provisioning_enabled

Test if auto provisioning is enabled. This can be used via the default security policy only.
```ruby
describe azure_security_center_policy do
  it { should have_auto_provisioning_enabled }
end
```
### exists

```ruby
# If we expect a resource to always exist

describe azure_security_center_policy(resource_group: 'my-rg', server_name: 'my_policy') do
  it { should exist }
end
# If we expect a resource to never exist

describe azure_security_center_policy(resource_group: 'my-rg', server_name: 'my_policy') do
  it { should_not exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
