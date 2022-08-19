+++
title = "alicloud_ram_user_mfa Resource"
platform = "alicloud"
draft = false
gh_repo = "inspec-alicloud"

[menu.inspec]
title = "alicloud_ram_user_mfa"
identifier = "inspec/resources/alicloud/alicloud_ram_user_mfa Resource"
parent = "inspec/resources/alicloud"
+++

Use the `alicloud_ram_user_mfa` InSpec audit resource to test properties of a single Alicloud RAM user's MFA settings.

## Syntax

An `alicloud_ram_user_mfa` resource block declares the tests for a single Alicloud RAM user's MFA settings by user name.

```ruby
describe alicloud_ram_user_mfa(user_name: 'rpatel') do
  it { should exist }
end
```

## Parameters

`user_name` _(required)_

: This resource accepts a single parameter, the RAM user's username which uniquely identifies the user.  
  This can be passed either as a string or as a `user_name: 'value'` key-value entry in a hash.

See also the [Alicloud documentation on RAM users](https://www.alibabacloud.com/help/doc-detail/122148.htm?spm=a2c63.p38356.b99.20.12456fb6z4r7Hz).

## Properties

`user_name`
: The RAM user's username.

`serial_number`
: The serial number of the RAM User's MFA device.

`type`
: The MFA type (VMFA: virtual NFA device, or U2F: Universal 2nd Factor security key).

## Examples

The following example shows how to use this InSpec audit resource.

**Test that a user has MFA configured.**

```ruby
describe alicloud_ram_user_mfa(user_name: 'jakobp') do
  it { should exist }
  its('serial_number') { should eq 'acs:ram::1234567890123456:mfa/jakobp' }
  its('type') { should eq 'VMFA' }
end
```

## Matchers

{{% inspec_matchers_link %}}

### exist

The control will pass if the describe returns at least one result.

```ruby
it { should exist }
```

Use `should_not` to test the entity should not exist.

```ruby
it { should_not exist }
```

### Alicloud Permissions

{{% alicloud_principal_action action="ram:GetUserMFAInfo" %}}

{{% alibaba_access_management_doc %}}
{{% alibaba_authentication_ram_api_doc %}}
