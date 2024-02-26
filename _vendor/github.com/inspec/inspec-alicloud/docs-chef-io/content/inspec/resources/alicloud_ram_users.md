+++
title = "alicloud_ram_users Resource"
platform = "alicloud"
draft = false
gh_repo = "inspec-alicloud"

[menu.inspec]
title = "alicloud_ram_users"
identifier = "inspec/resources/alicloud/alicloud_ram_users Resource"
parent = "inspec/resources/alicloud"
+++

Use the `alicloud_ram_users` InSpec audit resource to test properties of some or all Alicloud RAM users.


## Syntax

An `alicloud_ram_users` resource block returns all RAM users and allows the testing of that group of RAM users.

```ruby
describe alicloud_ram_users do
  its('user_names') { should include 'payroll-admin' }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`user_names`
: The user names of the returned RAM users.

`user_ids`
: The unique IDs of the returned RAM users.

`display_names`
: Display names of the returned RAM users.

`comments`
: Comments about the returned RAM users.

`create_dates`
: The times when the returned RAM users were created.

`update_dates`
: The times when the information about the returned RAM users was last updated.

`access_keys`
: An array of hashes each containing metadata about a user's access keys (active and inactive).

`active_access_keys`
: An array of hashes each containing metadata about a user's active access keys.

`has_access_key`
: Boolean indicating whether each user has any access keys or not.

`has_active_access_key`
: Boolean indicating whether each user has any active access keys or not.

`has_console_access`
: Boolean indicating whether each user has console access.

`has_console_and_key_access`
: Boolean indicating whether each user has both console access as well as one or more active access keys.

`has_mfa_enabled`
: Boolean indicating whether each user has MFA enabled or not.

`entries`
: Provides access to the raw results of the query, which can be treated as an array of hashes.

## Examples

**Ensure there are no RAM users who do not have MFA enabled.**

```ruby
describe alicloud_ram_users.where(has_mfa_enabled: false) do
  it { should_not exist }
**less readable test, but it gives better output.**

end
```

**Ensure there are no RAM users who have console access and do not have MFA enabled.**

```ruby
alicloud_ram_users.where(has_console_access: true).user_names.each do |u|
  describe alicloud_ram_user_mfa(u) do
    it { should exist }
  end
end
```

**Ensure there are no RAM users with console access and one or more active access keys.**

```ruby
describe alicloud_ram_users.where(has_console_and_key_access: true) do
  its('user_names') { should be_empty }
end
```

```ruby
or
```

```ruby
alicloud_ram_users.where { active_access_keys.count > 0 }.user_names.each do |u|
  describe alicloud_ram_user(u) do
    its('has_console_access') { should be false }
  end
end
```

## Matchers

For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe alicloud_ram_users.where( <property>: <value>) do
  it { should exist }
end
```

```ruby
describe alicloud_ram_users.where( <property>: <value>) do
  it { should_not exist }
end
```

### Alicloud Permissions

Your Principal will need the following permissions action with Effect set to Allow: `ram:Listusers`, `ram:GetLoginProfile`, `ram:ListAccessKeys`, `ram:GetUserMFAInfo`

{{< readfile file="content/inspec/resources/reusable/md/alibaba_access_management_doc.md" >}}
{{< readfile file="content/inspec/resources/reusable/md/alibaba_authentication_ram_api_doc.md" >}}
