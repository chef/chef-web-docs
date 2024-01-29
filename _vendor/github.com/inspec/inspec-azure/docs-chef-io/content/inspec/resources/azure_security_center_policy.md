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

Use the `azure_security_center_policy` InSpec audit resource to test the properties and configuration of an Azure security policy.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_security_center_policy` resource block will lookup the `default` policy unless `resource_group` and `name`, or the `resource_id` parameter is given.

```ruby
# The default security policy will be interrogated.

describe azure_security_center_policy do
  its('name') { should cmp 'default' }
end
```

```ruby
describe azure_security_center_policy(resource_group: 'RESOURCE_GROUP', name: 'POLICY_NAME') do
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
: Azure resource group where the targeted resource resides.

`name`
: Name of the security policy to test.

`resource_id`
: The unique resource ID. `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/microsoft.Security/policies/{policy-name}`.

`default_policy_api_version<superscript>*</superscript>`
: The endpoint API version for the `default_policy` property. The latest version will be used unless provided.

`auto_provisioning_settings_api_version<superscript>*</superscript>`
: The endpoint API version for the `auto_provisioning_settings` property. The latest version will be used unless provided.

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
: This is the default set of policies monitored by Azure security center.

`auto_provisioning_settings<superscript>*</superscript>`
: This is the default auto provisioning setting for the subscription.

<superscript>*</superscript>Only applicable to the default security policy.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Any attribute in the response may be accessed with the key names separated by dots (`.`). For example, `properties.<attribute>`.

## Examples

### Test if log collection is enabled

```ruby
describe azure_security_center_policy(resource_group: 'my-rg', name: 'my_policy') do
  its('log_collection') { should cmp 'On' }
end
```

**Test If Notifications are Enabled.**

```ruby
describe azure_security_center_policy(resource_group: 'RESOURCE_GROUP', name: 'POLICY_NAME') do
  its('notifications_enabled') { should be true }
end
```

See [integration tests](https://github.com/inspec/inspec-azure/blob/main/test/integration/verify/controls/azure_security_center_policy.rb) for more examples.

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### have_auto_provisioning_enabled

Test if auto provisioning is enabled. This can be used via the default security policy only.

```ruby
describe azure_security_center_policy do
  it { should have_auto_provisioning_enabled }
end
```

### exists

```ruby
# If we expect a resource to always exist.

describe azure_security_center_policy(resource_group: 'RESOURCE_GROUP', name: 'POLICY_NAME') do
  it { should exist }
end
```

### not_exists

```ruby
# If we expect a resource to never exist.

describe azure_security_center_policy(resource_group: 'RESOURCE_GROUP', name: 'POLICY_NAME') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
