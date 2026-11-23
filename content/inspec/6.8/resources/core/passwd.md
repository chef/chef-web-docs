+++
title = "passwd resource"
draft = false

platform = "linux"

[menu.inspec_6_8]
    title = "passwd"
    identifier = "resources/core/passwd.md passwd resource"
    parent = "resources/core"
+++

Use the `passwd` Chef InSpec audit resource to test the contents of `/etc/passwd`, which contains the following information for users that may log into the system and/or as users that own running processes. The format for `/etc/passwd` includes:

- A username
- The password for that user (on newer systems passwords should be stored in `/etc/shadow` )
- The user identifier (UID) assigned to that user
- The group identifier (GID) assigned to that user
- Additional information about that user
- That user's home directory
- That user's default command shell

These entries are defined as a colon-delimited row in the file, one row for each user:

```ruby
root:x:1234:5678:additional_info:/home/dir/:/bin/bash
```

## Availability

### Install

{{< readfile file="content/inspec/6.8/reusable/md/inspec_installation.md" >}}

### Version

This resource first became available in v1.0.0 of InSpec.

## Syntax

A `passwd` resource block declares one (or more) users and associated user information to be tested:

```ruby
describe passwd do
  its('users') { should_not include 'forbidden_user' }
end

describe passwd.uids(filter) do
  its('users') { should cmp 'root' }
  its('count') { should eq 1 }
end
```

where:

- `homes`, `gids`, `passwords`, `shells`, `uids`, and `users` are valid accessors for `passwd`
- `filter` one (or more) arguments, for example: `passwd.users(/name/)` used to define filtering
- `filter` may take any of the following arguments: `count` (retrieves the number of entries), `lines` (provides raw `passwd` lines), and `params` (returns an array of maps for all entries)

## Properties

### gids

The `gids` property tests if the group identifiers in the test match group identifiers in `/etc/passwd`:

```ruby
its('gids') { should include 1234 }
its('gids') { should cmp 0 }
```

### homes

The `homes` property tests the absolute path to a user's home directory:

```ruby
its('home') { should eq '/' }
```

### length

The `length` property tests the length of a password that appears in `/etc/passwd`:

```ruby
its('length') { should be <= 32 }
```

This matcher is best used in conjunction with filters. For example:

```ruby
describe passwd.users('highlander') do
   its('length') { should_not be < 16 }
end
```

### passwords

The `passwords` property tests if passwords are

- Encrypted
- Have direct logins disabled, as indicated by an asterisk (`*`)
- In the `/etc/shadow` file, as indicated by the letter x (`x`)

For example:

```ruby
its('passwords') { should eq ['x'] }
its('passwords') { should cmp '*' }
```

### shells

The `shells` property tests the absolute path of a shell (or command) to which a user has access:

```ruby
its('shells') { should_not include 'user' }
```

or to find all users with the nologin shell:

```ruby
describe passwd.shells(/nologin/) do
  its('users') { should_not include 'my_login_user' }
end
```

### uids

The `uids` property tests if the user identifiers in the test match user identifiers in `/etc/passwd`:

```ruby
its('uids') { should eq ['1234', '1235'] }
```

or:

```ruby
describe passwd.uids(0) do
  its('users') { should cmp 'root' }
  its('count') { should eq 1 }
end
```

### users

The `users` property tests if the user names in the test match user names in `/etc/passwd`:

```ruby
its('users') { should eq ['root', 'www-data'] }
```

## Examples

The following examples show how to use this Chef InSpec audit resource.

### Test usernames and UIDs

```ruby
describe passwd do
  its('users') { should eq ['root', 'www-data'] }
  its('uids') { should eq [0, 33] }
end
```

### Select one user and test for multiple occurrences

```ruby
describe passwd.uids(0) do
  its('users') { should cmp 'root' }
  its('count') { should eq 1 }
end

describe passwd.where { user == 'www-data' } do
  its('uids') { should cmp 33 }
  its('count') { should eq 1 }
end
```

## Matchers

{{< readfile file="content/inspec/6.8/reusable/md/inspec_matchers_link.md" >}}
