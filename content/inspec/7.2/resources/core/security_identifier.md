+++
title = "security_identifier resource"
draft = false

platform = "windows"

[menu.inspec_7_2]
    title = "security_identifier"
    identifier = "resources/core/security_identifier.md security_identifier resource"
    parent = "resources/core"
+++

Use the `security_identifier` Chef InSpec resource to test the [Security Identifier (SID)](https://docs.microsoft.com/en-us/windows/desktop/secauthz/security-identifiers) for user and group trustees on Windows.

## Availability

### Install

{{< readfile file="content/inspec/7.2/reusable/md/inspec_installation.md" >}}

## Resource Parameters

A `security_identifier` resource should specify the name and type of the trustee to test the SID for:

```ruby
describe security_identifier(group: 'Everyone') do
  its('sid') { should eq 'S-1-1-0' }
end
```

where:

- `group:` specifies that `'Everyone'` should be a group. `user:` can be used to specify a user account.
  \*\* It's necessary to declare the type of the trustee because Windows allows users, groups and other entities to share names. If you really need to not specify the type, `unspecified:` can be used. This will attempt to match the name to a group and then a user account. This may take longer to execute and comes with the risk of Chef InSpec matching the name to an unintended trustee.

## Examples

The following examples show how to use this Chef InSpec resource.

### Verify that the Administrator user has a SID

```ruby
describe security_identifier(user: 'Administrator') do
  it { should exist }
end
```

### Verify that a SID is the expected value

```ruby
describe security_identifier(group: 'Everyone') do
  its('sid') { should eq 'S-1-1-0' }
end
```

### Use in conjunction with the security_policy resource to specify the trustee to test for in the audit policy

```ruby
describe security_policy do
  its("SeRemoteInteractiveLogonRight") { should_not include security_identifier(group: 'Guests') }
end
```

## Properties

### sid

```ruby
describe security_identifier(group: 'Everyone') do
  its('sid') { should eq 'S-1-1-0' }
end
```

## Matchers

This Chef InSpec audit resource has the following special matchers. {{< readfile file="content/inspec/7.2/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

For this resource, `exist` is true if a Security Identifier (SID) exists on the target host for the specified trustee.
