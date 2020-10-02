+++
title = "users resource"
draft = false
platform = "os"

[menu]
  [menu.inspec]
    title = "users"
    identifier = "inspec/resources/os/users.md users resource"
    parent = "inspec/resources/os"
+++

[\[edit on GitHub\]](https://github.com/inspec/inspec/blob/master/docs-chef-io/content/inspec/resources/users.md)

Use the `users` Chef InSpec audit resource to look up all local users available on the system, and then test specific properties of those users. This resource does not return information about users that may be located on other systems, such as LDAP or Active Directory.

## Availability

### Installation

This resource is distributed along with Chef InSpec itself. You can use it automatically.

### Version

This resource first became available in v1.0.0 of InSpec.

## Syntax

A `users` resource block declares a user name, and then one (or more) matchers:

    describe users.where(uid: 0).entries do
      it { should eq ['root'] }
      its('uids') { should eq [1234] }
      its('gids') { should eq [1234] }
    end

where

- `gid`, `group`, `groups`, `home`, `maxdays`, `mindays`, `shell`, `uid`, `warndays`, `passwordage`, `maxbadpasswords` and `badpasswordattempts` are valid matchers for this resource
- `where(uid: 0).entries` represents a filter that runs the test only against matching users

For example:

    describe users.where { username =~ /.*/ } do
      it { should exist }
    end

or:

    describe users.where { uid =~ /^S-1-5-[0-9-]+-501$/ } do
      it { should exist }
    end

## Examples

The following examples show how to use this Chef InSpec audit resource.

### Use a regular expression to find users

    describe users.where { uid =~ /S\-1\-5\-21\-\d+\-\d+\-\d+\-500/ } do
      it { should exist }
    end

### Test only allowed users exist

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

## Matchers

For a full list of available matchers, please visit our [matchers page](/inspec/matchers/).

### exist

The `exist` matcher tests if the named user exists:

    it { should exist }

### gid

The `gid` matcher tests the group identifier:

    its('gid') { should eq 1234 } }

where `1234` represents the user identifier.

### group

The `group` matcher tests the group to which the user belongs:

    its('group') { should eq 'root' }

where `root` represents the group.

### groups

The `groups` matcher tests two (or more) groups to which the user belongs:

    its('groups') { should eq ['root', 'other']}

### home

The `home` matcher tests the home directory path for the user:

    its('home') { should eq '/root' }

### maxdays

The `maxdays` matcher tests the maximum number of days between password changes:

    its('maxdays') { should eq 99 }

where `99` represents the maximum number of days.

### mindays

The `mindays` matcher tests the minimum number of days between password changes:

    its('mindays') { should eq 0 }

where `0` represents the maximum number of days.

### shell

The `shell` matcher tests the path to the default shell for the user:

    its('shells') { should eq ['/bin/bash'] }

### uid

The `uid` matcher tests the user identifier:

    its('uid') { should eq 1234 } }

where `1234` represents the user identifier.

### warndays

The `warndays` matcher tests the number of days a user is warned before a password must be changed:

    its('warndays') { should eq 5 }

where `5` represents the number of days a user is warned.

### passwordage

The `passwordage` matcher tests the number of days a user changed its password:

    its('passwordage') { should_be <= 365 }

where `365` represents the number of days since the last password change.

### maxbadpasswords

The `maxbadpasswords` matcher tests the count of max badpassword settings for a specific user.

    its('maxbadpasswords') { should eq 7 }

where `7` is the count of maximum bad password attempts.

### badpasswordattempts

The `badpasswordattempts` matcher tests the count of bad password attempts for a user.

    its('badpasswordattempts') { should eq 0 }

where `0` is the count of bad passwords for a user.
On Linux based operating systems it relies on `lastb` and for Windows it uses information stored for the user object.
These settings will be resetted to `0` depending on your operating system configuration.
