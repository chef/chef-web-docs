+++
title = "alicloud_ims_user Resource"
platform = "alicloud"
draft = false
gh_repo = "inspec-alicloud"

[menu.inspec]
title = "alicloud_disk"
identifier = "inspec/resources/alicloud/alicloud_ims_user Resource"
parent = "inspec/resources/alicloud"
+++

Use the `alicloud_ims_user` InSpec audit resource to test properties of a single AliCloud IAM User information.

## Syntax

**Ensure an user exists**

```ruby
describe alicloud_ims_user("USER_PRINCIPAL_NAME") do
  it { should exist }
end
```

**You may also use hash syntax to pass the user principal name**

```ruby
describe alicloud_ims_user(user_principal_name: "USER_PRINCIPAL_NAME") do
  it { should exist }
end
```

## Parameters

This resource accepts a single parameter, `user_principal_name`.

`user_principal_name` _(required)

: The user name of the IMS user.  

See also the [Alicloud documentation on cloud disks](https://www.alibabacloud.com/help/doc-detail/25383.htm).

## Properties

`status`
: The status of the IAM user.

`update_date`
: The update date of the IAM user.

`password_reset_required`
: The password reset required of the IAM user. It accepts boolean value.

`user_principal_name`
: The user name of the IAM user.

`mfa_bind_required`
: The mfa bind required of the IAM user. It accepts boolean value.

## Examples

**Test that an user does not exist.**

```ruby
describe alicloud_ims_user("USER_PRINCIPAL_NAME") do
  it { should_not exist }
end
```

**Test that an user is MFA bind.**

```ruby
describe alicloud_ims_user("USER_PRINCIPAL_NAME") do
  its('mfa_bind_required') { should eq true }
end
```

**Test that an user has an `ACTIVE` status.**

```ruby
describe alicloud_ims_user("USER_PRINCIPAL_NAME") do
  its('status') { should eq 'Active' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

### exist

The control will pass if the describe returns at least one result.

Use `should` to test the entity should not exist.

```ruby
describe alicloud_ims_user("USER_PRINCIPAL_NAME") do
  it { should exist }
end
```

Use `should_not` to test the entity should not exist.

```ruby
describe alicloud_ims_user("USER_PRINCIPAL_NAME") do
  it { should_not exist }
end
```

### Alicloud Permissions

{{% inspec-alicloud/alicloud_principal_action action="ims:GetLoginProfile" %}}
