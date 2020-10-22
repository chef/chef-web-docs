+++
title = "file resource"
draft = false
platform = "os"

[menu]
  [menu.inspec]
    title = "file"
    identifier = "inspec/resources/os/file.md file resource"
    parent = "inspec/resources/os"
+++

[\[edit on GitHub\]](https://github.com/inspec/inspec/blob/master/docs-chef-io/content/inspec/resources/file.md)

Use the `file` Chef InSpec audit resource to test all system file types, including files, directories, symbolic links, named pipes, sockets, character devices, block devices, and doors.

## Availability

### Installation

This resource is distributed along with Chef InSpec itself. You can use it automatically.

### Version

This resource first became available in v1.0.0 of InSpec.

## Syntax

A `file` resource block declares the location of the file type to be tested, the expected file type (if required), and one (or more) resource properties.

    describe file('path') do
      it { should PROPERTY 'value' }
    end

where

- `('path')` is the name of the file and/or the path to the file.
- `PROPERTY` is a valid resource property for this resource'
- `'value'` is the value to be tested.

## Properties

### General Properties

- `content`
- `size`
- `basename`
- `path`
- `owner`
- `group`
- `type`

### Unix/Linux Properties

- `symlink`
- `mode`
- `link_path`
- `shallow_link_path`
- `mtime`
- `size`
- `selinux_label`
- `md5sum`
- `sha256sum`
- `path`
- `source`
- `source_path`
- `uid`
- `gid`

### Windows Properties

- `file_version`
- `product_version`

## Resource Property Examples

### content

The `content` property tests if contents in the file match the value specified in a regular expression. The values of the `content` property are arbitrary and depend on the file type being tested and also the type of information that is expected to be in that file:

    its('content') { should match REGEX }

The following complete example tests the `pg_hba.conf` file in PostgreSQL for MD5 requirements. The tests look at all `host` and `local` settings in that file, and then compare the MD5 checksums against the values in the test:

    describe file('/etc/postgresql/9.1/main/pg_hba.conf') do
      its('content') { should match(%r{local\s.*?all\s.*?all\s.*?md5}) }
      its('content') { should match(%r{host\s.*?all\s.*?all\s.*?127.0.0.1\/32\s.*?md5}) }
      its('content') { should match(%r{host\s.*?all\s.*?all\s.*?::1\/128\s.*?md5}) }
    end

### file_version

The `file_version` property tests if a Windows file's version matches the specified value. The difference between a file's "file version" and "product version" is that the file version is the version number of the file itself, whereas the product version is the version number associated with the application from which that file originates:

    its('file_version') { should eq '1.2.3' }

### group

The `group` property tests if the group to which a file belongs matches the specified value.

    its('group') { should eq 'admins' }

The following examples show how to use this Chef InSpec audit resource.

### link_path

The `link_path` property tests if the file exists at the specified path. If the file is a symlink,
Chef InSpec will resolve the symlink recursively and return the ultimate linked file.

    its('link_path') { should eq '/some/path/to/file' }

### shallow_link_path

The `shallow_link_path` property returns the path that the file refers to, only resolving
it once (that is, it performs a readlink operation). If the file is not a symlink, nil is returned.

    its('shallow_link_path') { should eq '/some/path/to/file' }

### md5sum

The `md5sum` property tests if the MD5 checksum for a file matches the specified value.

    its('md5sum') { should eq '3329x3hf9130gjs9jlasf2305mx91s4j' }

### mode

The `mode` property tests if the mode assigned to the file matches the specified value.

    its('mode') { should cmp '0644' }

Chef InSpec [octal](https://en.wikipedia.org/wiki/Leading_zero#0_as_a_prefix) values begin the numeric mode specification with zero.

For example, write:

    { should cmp '0644' }

not

    { should cmp '644' }

or write:

    { should cmp '01775' }

not

    { should cmp '1775' }

Without the zero prefix for the octal value, Chef InSpec will interpret it as the _decimal_ value 644, which is octal 1024 or `-----w-r-T`, and any test for a file that is `-rw-r--r--` will fail.

Note: see the [`be_more_permissive_than(mode)`](<#be_more_permissive_than?(mode)>) matcher for upper and lower bounds on file mode.

### mtime

The `mtime` property tests if the file modification time for the file matches the specified value. The mtime, where supported, is returned as the number of seconds since the epoch.

    describe file('/') do
      its('mtime') { should <= Time.now.to_i }
      its('mtime') { should >= Time.now.to_i - 1000 }
    end

### owner

The `owner` property tests if the owner of the file matches the specified value.

    its('owner') { should eq 'root' }

### product_version

The `product_version` property tests if a Windows file's product version matches the specified value. The difference between a file's "file version" and "product version" is that the file version is the version number of the file itself, whereas the product version is the version number associated with the application from which that file originates.

    its('product_version') { should eq '2.3.4' }

### selinux_label

The `selinux_label` property tests if the SELinux label for a file matches the specified value.

    its('selinux_label') { should eq 'system_u:system_r:httpd_t:s0' }

### sha256sum

The `sha256sum` property tests if the SHA-256 checksum for a file matches the specified value.

    its('sha256sum') { should eq 'b837ch38lh19bb8eaopl8jvxwd2e4g58jn9lkho1w3ed9jbkeicalplaad9k0pjn' }

### size

The `size` property tests if a file's size matches, is greater than, or is less than the specified value. For example, equal:

    its('size') { should eq 32375 }

Greater than:

    its('size') { should > 64 }

Less than:

    its('size') { should < 10240 }

### type

The `type` property tests for the file type. The available types are:

`file`
: the object is a file

`directory`
: the object is a directory

`link`
: the object is a symbolic link

`pipe`
: the object is a named pipe

`socket`
: the object is a socket

`character_device`
: the object is a character device

`block_device`
: the object is a block device

`door`
: the object is a door device

The `type` method usually returns the type as a Ruby "symbol". We recommend using the `cmp` matcher to match
either by symbol or string.

For example:

    its('type') { should eq :file }
    its('type') { should cmp 'file' }

or:

    its('type') { should eq :socket }
    its('type') { should cmp 'socket' }

### Test the contents of a file for MD5 requirements

    describe file('/etc/postgresql/9.1/main/pg_hba.conf') do
      its('content') { should match /local\s.*?all\s.*?all\s.*?md5/ }
      its('content') { should match %r{/host\s.*?all\s.*?all\s.*?127.0.0.1\/32\s.*?md5/} }
      its('content') { should match %r{/host\s.*?all\s.*?all\s.*?::1\/128\s.*?md5/} }
    end

### Test if a file exists

    describe file('/tmp') do
      it { should exist }
    end

### Test that a file does not exist

    describe file('/tmpest') do
      it { should_not exist }
    end

### Test if a path is a directory

    describe file('/tmp') do
      its('type') { should eq :directory }
      it { should be_directory }
    end

### Test if a path is a file and not a directory

    describe file('/proc/version') do
      its('type') { should cmp 'file' }
      it { should be_file }
      it { should_not be_directory }
    end

### Test if a file is a symbolic link

    describe file('/dev/stdout') do
      its('type') { should cmp 'symlink' }
      it { should be_symlink }
      it { should_not be_file }
      it { should_not be_directory }
    end

### Test if a file is a character device

    describe file('/dev/zero') do
      its('type') { should cmp 'character' }
      it { should be_character_device }
      it { should_not be_file }
      it { should_not be_directory }
    end

### Test if a file is a block device

    describe file('/dev/zero') do
      its('type') { should cmp 'block' }
      it { should be_character_device }
      it { should_not be_file }
      it { should_not be_directory }
    end

### Test the mode for a file

    describe file('/dev') do
     its('mode') { should cmp '00755' }
    end

### Test the owner of a file

    describe file('/root') do
      its('owner') { should eq 'root' }
    end

### Test if a file is owned by the root user

    describe file('/dev') do
      it { should be_owned_by 'root' }
    end

### Test the mtime for a file

    describe file('/') do
      its('mtime') { should <= Time.now.to_i }
      its('mtime') { should >= Time.now.to_i - 1000 }
    end

### Test that a file's size is between 64 and 10240

    describe file('/') do
      its('size') { should be > 64 }
      its('size') { should be < 10240 }
    end

### Test that a file's size is zero

    describe file('/proc/cpuinfo') do
      its('size') { should be 0 }
    end

### Test an MD5 checksum

    require 'digest'
    cpuinfo = file('/proc/cpuinfo').content

    md5sum = Digest::MD5.hexdigest(cpuinfo)

    describe file('/proc/cpuinfo') do
      its('md5sum') { should eq md5sum }
    end

### Test an SHA-256 checksum

    require 'digest'
    cpuinfo = file('/proc/cpuinfo').content

    sha256sum = Digest::SHA256.hexdigest(cpuinfo)

    describe file('/proc/cpuinfo') do
      its('sha256sum') { should eq sha256sum }
    end

### Verify NTP

The following example shows how to use the `file` audit resource to verify if the `ntp.conf` and `leap-seconds` files are present, and then the `command` resource to verify if NTP is installed and running:

    describe file('/etc/ntp.conf') do
      it { should be_file }
    end

    describe file('/etc/ntp.leapseconds') do
      it { should be_file }
    end

    describe command('pgrep ntp') do
      its('exit_status') { should eq 0 }
    end

### Test parameters of symlinked file

If you need to test the parameters of the target file for a symlink, you can use the `link_path` (recursive resolution) or `shallow_link_path` (direct link) method for the `file` resource.

For example, for the following symlink:

    lrwxrwxrwx. 1 root root 11 03-10 17:56 /dev/virtio-ports/com.redhat.rhevm.vdsm -> ../vport2p1

... you can write controls for both the link and the target.

    describe file('/dev/virtio-ports/com.redhat.rhevm.vdsm') do
      it { should be_symlink }
    end

    virito_port_vdsm = file('/dev/virtio-ports/com.redhat.rhevm.vdsm').link_path
    describe file(virito_port_vdsm) do
      it { should exist }
      it { should be_character_device }
      it { should be_owned_by 'ovirtagent' }
      it { should be_grouped_into 'ovirtagent' }
    end

## Matchers

For a full list of available matchers, please visit our [matchers page](/inspec/matchers/).

### be_allowed

The `be_allowed` matcher tests if the file contains a certain permission set, such as `execute` or `write` in Unix and [`full-control` or `modify` in Windows](https://www.codeproject.com/Reference/871338/AccessControl-FileSystemRights-Permissions-Table).

    it { should be_allowed('read') }

Just like with `be_executable` and other permissions, one can check for the permission with respect to the specific user or group.

    it { should be_allowed('full-control', by_user: 'MyComputerName\Administrator') }

OR

    it { should be_allowed('write', by: 'root') }

### be_block_device

The `be_block_device` matcher tests if the file exists as a block device, such as `/dev/disk0` or `/dev/disk0s9`:

    it { should be_block_device }

### be_character_device

The `be_character_device` matcher tests if the file exists as a character device (that corresponds to a block device), such as `/dev/rdisk0` or `/dev/rdisk0s9`:

    it { should be_character_device }

### be_directory

The `be_directory` matcher tests if the file exists as a directory, such as `/etc/passwd`, `/etc/shadow`, or `/var/log/httpd`:

    it { should be_directory }

### be_executable

The `be_executable` matcher tests if the file exists as an executable:

    it { should be_executable }

The `be_executable` matcher may also test if the file is executable by a specific owner, group, or user. For example, a group:

    it { should be_executable.by('group') }

an owner:

    it { should be_executable.by('owner') }

any user other than the owner or members of the file's group:

    it { should be_executable.by('others') }

a user:

    it { should be_executable.by_user('user') }

### be_file

The `be_file` matcher tests if the file exists as a file. This can be useful with configuration files like `/etc/passwd` where there typically is not an associated file extension---`passwd.txt`:

    it { should be_file }

### be_grouped_into

The `be_grouped_into` matcher tests if the file exists as part of the named group:

    it { should be_grouped_into 'group' }

### be_linked_to

The `be_linked_to` matcher tests if the file is linked to the named target:

    it { should be_linked_to '/etc/target-file' }

### be_owned_by

The `be_owned_by` matcher tests if the file is owned by the named user, such as `root`:

    it { should be_owned_by 'root' }

### be_pipe

The `be_pipe` matcher tests if the file exists as first-in, first-out special file (`.fifo`) that is typically used to define a named pipe, such as `/var/log/nginx/access.log.fifo`:

    it { should be_pipe }

### be_readable

The `be_readable` matcher tests if the file is readable:

    it { should be_readable }

The `be_readable` matcher may also test if the file is readable by a specific owner, group, or user. For example, a group:

    it { should be_readable.by('group') }

an owner:

    it { should be_readable.by('owner') }

any user other than the owner or members of the file's group:

    it { should be_readable.by('others') }

a user:

    it { should be_readable.by_user('user') }

### be_setgid

The `be_setgid` matcher tests if the 'setgid' permission is set on the file or directory. On executable files, this causes the process to be started owned by the group that owns the file, rather than the primary group of the invocating user. This can result in escalation of privilege. On Linux, when setgid is set on directories, setgid causes newly created files and directories to be owned by the group that owns the setgid parent directory; additionally, newly created subdirectories will have the setgid bit set. To use this matcher:

    it { should be_setgid }

### be_socket

The `be_socket` matcher tests if the file exists as socket (`.sock`), such as `/var/run/php-fpm.sock`:

    it { should be_socket }

### be_sticky

The `be_sticky` matcher tests if the 'sticky bit' permission is set on the directory. On directories, this restricts file deletion to the owner of the file, even if the permission of the parent directory would normally permit deletion by others. This is commonly used on /tmp filesystems. To use this matcher:

    it { should be_sticky }

### be_setuid

The `be_setuid` matcher tests if the 'setuid' permission is set on the file. On executable files, this causes the process to be started owned by the user that owns the file, rather than invocating user. This can result in escalation of privilege. To use this matcher:

    it { should be_setuid }

### be_symlink

The `be_symlink` matcher tests if the file exists as a symbolic, or soft link that contains an absolute or relative path reference to another file:

    it { should be_symlink }

### be_version

The `be_version` matcher tests the version of the file:

    it { should be_version '1.2.3' }

### be_writable

The `be_writable` matcher tests if the file is writable:

    it { should be_writable }

The `be_writable` matcher may also test if the file is writable by a specific owner, group, or user. For example, a group:

    it { should be_writable.by('group') }

an owner:

    it { should be_writable.by('owner') }

any user other than the owner or members of the file's group:

    it { should be_writable.by('others') }

a user:

    it { should be_writable.by_user('user') }

### exist

The `exist` matcher tests if the named file exists:

    it { should exist }

### have_mode

The `have_mode` matcher tests if a file has a mode assigned to it:

    it { should have_mode }

### `be_more_permissive_than(mode)`

`be_more_permissive_than(mode)` takes the maximum desired mode - in `octal format`
('0644' or '0777') - of your file as a `String` and returns a `Boolean`. It will
return `true` if your file has a mode with greater permissions than specified.

    describe file('/etc/passwd') do
      it { should_not be_more_permissive_than('0644') }
      it { should be_more_permissive_than('0000') }
    end
