+++
title = "users resource"
draft = false

platform = "os"

[menu.inspec_5_23]
    title = "users"
    identifier = "resources/core/users.md users resource"
    parent = "resources/core"
+++

Use the `users` Chef InSpec audit resource to look up all local users available on the system, and then test specific properties of those users. This resource doesn't return information about users that may be located on other systems, such as LDAP or Active Directory.

## Availability

### Install

{{< readfile file="content/inspec/5.23/reusable/md/inspec_installation.md" >}}

### Version

This resource first became available in v1.0.0 of InSpec.

## Syntax

A `users` resource block declares a user name, and then one (or more) matchers:

```ruby
describe users.where(uid: 0).entries do
  it { should eq ['root'] }
  its('uids') { should eq [1234] }
  its('gids') { should eq [1234] }
end
```

where:

- `gid`, `group`, `groups`, `home`, `maxdays`, `mindays`, `shell`, `uid`, `warndays`, `passwordage`, `maxbadpasswords` and `badpasswordattempts` are valid matchers for this resource
- `where(uid: 0).entries` represents a filter that runs the test only against matching users

For example:

```ruby
describe users.where { username =~ /.*/ } do
  it { should exist }
end
```

or:

```ruby
describe users.where { uid =~ /^S-1-5-[0-9-]+-501$/ } do
  it { should exist }
end
```

## Properties

### gid

The `gid` property tests the group identifier:

```ruby
its('gid') { should eq 1234 } }
```

where `1234` represents the user identifier.

### group

The `group` property tests the group to which the user belongs:

```ruby
its('group') { should eq 'root' }
```

where `root` represents the group.

### groups

The `groups` property tests two (or more) groups to which the user belongs:

```ruby
its('groups') { should eq ['root', 'other']}
```

### home

The `home` property tests the home directory path for the user:

```ruby
its('home') { should eq '/root' }
```

### maxdays

The `maxdays` property tests the maximum number of days between password changes:

```ruby
its('maxdays') { should eq 99 }
```

where `99` represents the maximum number of days.

### mindays

The `mindays` property tests the minimum number of days between password changes:

```ruby
its('mindays') { should eq 0 }
```

where `0` represents the maximum number of days.

### shell

The `shell` property tests the path to the default shell for the user:

```ruby
its('shells') { should eq ['/bin/bash'] }
```

### uid

The `uid` property tests the user identifier:

```ruby
its('uid') { should eq 1234 } }
```

where `1234` represents the user identifier.

### warndays

The `warndays` property tests the number of days a user is warned before a password must be changed:

```ruby
its('warndays') { should eq 5 }
```

where `5` represents the number of days a user is warned.

### passwordage

The `passwordage` property tests the number of days a user changed its password:

```ruby
its('passwordage') { should_be <= 365 }
```

where `365` represents the number of days since the last password change.

### maxbadpasswords

The `maxbadpasswords` property tests the count of max badpassword settings for a specific user.

```ruby
its('maxbadpasswords') { should eq 7 }
```

where `7` is the count of maximum bad password attempts.

### badpasswordattempts

The `badpasswordattempts` property tests the count of bad password attempts for a user.

```ruby
its('badpasswordattempts') { should eq 0 }
```

where `0` is the count of bad passwords for a user.
On Linux based operating systems it relies on `lastb` and for Windows it uses information stored for the user object.
These settings will reset to `0` depending on your operating system configuration.

## Examples

The following examples show how to use this Chef InSpec audit resource.

Use a regular expression to find users:

```ruby
describe users.where { uid =~ /S\-1\-5\-21\-\d+\-\d+\-\d+\-500/ } do
  it { should exist }
end
```

Test that only allowed users exist:

```ruby
allowed_users = %w(user1 user2 user3)

users.where { uid > 1000 && uid < 65534 }.usernames.sort.each do |u|
  describe user(u) do
    if allowed_users.include?(u)
      it { should exist }
    else
      it { should_not exist }
    end
  end
end
```

## Matchers

{{< readfile file="content/inspec/5.23/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The `exist` matcher tests if the named user exists:

```ruby
it { should exist }
```
