
InSpec Reference
****************

InSpec is an open-source run-time framework and rule language used to
specify compliance, security, and policy requirements for testing any
node in your infrastructure.

* The project name refers to "infrastructure specification"

* InSpec includes a collection of resources to help you write auditing
  rules quickly and easily using the Compliance DSL

* Use InSpec to examine any node in your infrastructure; run the tests
  locally or remotely

* Any detected security, compliance, or policy issues are flagged in a
  log

* The InSpec audit resource framework is fully compatible with Chef
  Compliance

See below for more information about each InSpec audit resource, its
related matchers, and examples of how to use it in a recipe.


apache_conf
===========

Use the ``apache_conf`` InSpec audit resource to test the
configuration settings for Apache. This file is typically located
under ``/etc/apache2`` on the Debian and Ubuntu platforms and under
``/etc/httpd`` on the Fedora, CentOS, Red Hat Enterprise Linux, and
Arch Linux platforms. The configuration settings may vary
significantly from platform to platform.


Syntax
------

An ``apache_conf`` InSpec audit resource block declares configuration
settings that should be tested:

::

   describe apache_conf('path') do
     its('setting_name') { should eq 'value' }
   end

where

* ``'setting_name'`` is a configuration setting defined in the Apache
  configuration file

* ``('path')`` is the non-default path to the Apache configuration
  file

* ``{ should eq 'value' }`` is the value that is expected


Matchers
--------

This InSpec audit resource matches any service that is listed in the
Apache configuration file:

::

   its('PidFile') { should_not eq '/var/run/httpd.pid' }

or:

::

   its('Timeout') { should eq 300 }

For example:

::

   describe apache_conf do
     its('MaxClients') { should eq 100 }
     its('Listen') { should eq '443'}
   end


Examples
--------

The following examples show how to use this InSpec audit resource.

**Test for blocking .htaccess files on CentOS**

::

   describe apache_conf do
     its('AllowOverride') { should eq 'None' }
   end

**Test ports for SSL**

::

   describe apache_conf do
     its('Listen') { should eq '443'}
   end


apt
===

Use the ``apt`` InSpec audit resource to verify Apt repositories on
the Debian and Ubuntu platforms, and also PPA repositories on the
Ubuntu platform.


Syntax
------

An ``apt`` InSpec audit resource block tests the contents of Apt and
PPA repositories:

::

   describe apt('path') do
     it { should exist }
     it { should be_enabled }
   end

where

* ``apt('path')`` must specify an Apt or PPA repository

* ``('path')`` may be an ``http://`` address, a ``ppa:`` address, or a
  short ``repo-name/ppa`` address

* ``exist`` and ``be_enabled`` are a valid matchers for this InSpec
  audit resource


Matchers
--------

This InSpec audit resource has the following matchers.


be_enabled
~~~~~~~~~~

The ``be_enabled`` matcher tests if a package exists in the
repository:

::

   it { should be_enabled }


exist
~~~~~

The ``exist`` matcher tests if a package exists on the system:

::

   it { should exist }


Examples
--------

The following examples show how to use this InSpec audit resource.

**Test if apt repository exists and is enabled**

::

   describe apt('http://ppa.launchpad.net/juju/stable/ubuntu') do
     it { should exist }
     it { should be_enabled }
   end

**Verify that a PPA repository exists and is enabled**

::

   describe apt('ppa:nginx/stable') do
     it { should exist }
     it { should be_enabled }
   end

**Verify that a repository is not present**

::

   describe apt('ubuntu-wine/ppa') do
     it { should_not exist }
     it { should_not be_enabled }
   end


audit_policy
============

Use the ``audit_policy`` InSpec audit resource to test auditing
policies on the Microsoft Windows platform. An auditing policy is a
category of security-related events to be audited. Auditing is
disabled by default and may be enabled for categories like account
management, logon events, policy changes, process tracking, privilege
use, system events, or object access. For each auditing category
property that is enabled, the auditing level may be set to ``No
Auditing``, ``Not Specified``, ``Success``, ``Success and Failure``,
or ``Failure``.


Syntax
------

An ``audit_policy`` InSpec audit resource block declares a parameter
that belongs to an audit policy category or subcategory:

::

   describe audit_policy do
     its('parameter') { should eq 'value' }
   end

where

* ``'parameter'`` must specify a parameter

* ``'value'`` must be one of ``No Auditing``, ``Not Specified``,
  ``Success``, ``Success and Failure``, or ``Failure``


Matchers
--------

This InSpec audit resource does not have any matchers.


Examples
--------

The following examples show how to use this InSpec audit resource.

**Test that a parameter is not set to "No Auditing"**

::

   describe audit_policy do
     its('Other Account Logon Events') { should_not eq 'No Auditing' }
   end

**Test that a parameter is set to "Success"**

::

   describe audit_policy do
     its('User Account Management') { should eq 'Success' }
   end


auditd_conf
===========

Use the ``auditd_conf`` InSpec audit resource to test the
configuration settings for the audit daemon. This file is typically
located under ``/etc/audit/auditd.conf'`` on UNIX and Linux platforms.


Syntax
------

A ``auditd_conf`` InSpec audit resource block declares configuration
settings that should be tested:

::

   describe auditd_conf('path') do
     its('keyword') { should eq 'value' }
   end

where

* ``'keyword'`` is a configuration setting defined in the
  ``auditd.conf`` configuration file

* ``('path')`` is the non-default path to the ``auditd.conf``
  configuration file

* ``{ should eq 'value' }`` is the value that is expected


Matchers
--------

This InSpec audit resource matches any keyword that is listed in the
``auditd.conf`` configuration file:

::

   its('log_format') { should eq 'raw' }


Examples
--------

The following examples show how to use this InSpec audit resource.

**Test the auditd.conf file**

::

   describe auditd_conf do
     its('log_file') { should eq '/full/path/to/file' }
     its('log_format') { should eq 'raw' }
     its('flush') { should eq 'none' }
     its('freq') { should eq '1' }
     its('num_logs') { should eq '0' }
     its('max_log_file') { should eq '6' }
     its('max_log_file_action') { should eq 'email' }
     its('space_left') { should eq '2' }
     its('action_mail_acct') { should eq 'root' }
     its('space_left_action') { should eq 'email' }
     its('admin_space_left') { should eq '1' }
     its('admin_space_left_action') { should eq 'halt' }
     its('disk_full_action') { should eq 'halt' }
     its('disk_error_action') { should eq 'halt' }
   end


auditd_rules
============

Use the ``auditd_rules`` InSpec audit resource to test the rules for
logging that exist on the system. The ``audit.rules`` file is
typically located under ``/etc/audit/`` and contains the list of rules
that define what is captured in log files.


Syntax
------

An ``auditd_rules`` InSpec audit resource block declares one (or more)
rules to be tested, and then what that rule should do:

::

   describe auditd_rules do
     its('LIST_RULES') { should eq [
       'exit,always syscall=rmdir,unlink',
       'exit,always auid=1001 (0x3e9) syscall=open',
       'exit,always watch=/etc/group perm=wa',
       'exit,always watch=/etc/passwd perm=wa',
       'exit,always watch=/etc/shadow perm=wa',
       'exit,always watch=/etc/sudoers perm=wa',
       'exit,always watch=/etc/secret_directory perm=r',
     ] }
   end

or test that individual rules are defined:

::

   describe auditd_rules do
     its('LIST_RULES') {
       should contain_match(/^exit,always watch=\/etc\/group perm=wa key=identity/)
     }
     its('LIST_RULES') {
       should contain_match(/^exit,always watch=\/etc\/passwd perm=wa key=identity/)
     }
     its('LIST_RULES') {
       should contain_match(/^exit,always watch=\/etc\/gshadow perm=wa key=identity/)
     }
     its('LIST_RULES') {
       should contain_match(/^exit,always watch=\/etc\/shadow perm=wa key=identity/)
     }
     its('LIST_RULES') {
       should contain_match(/^exit,always watch=\/etc\/security\/opasswd perm=wa key=identity/)
     }
   end

where each test must declare one (or more) rules to be tested.


Examples
--------

The following examples show how to use this InSpec audit resource.

**Test if a rule contains a matching element that is identified by a
regular expression**

::

   describe audit_daemon_rules do
     its("LIST_RULES") {
       should contain_match(/^exit,always arch=.*\
       key=time-change\
       syscall=adjtimex,settimeofday/)
     }
   end


bond
====

Use the ``bond`` InSpec audit resource to test a logical, bonded
network interface (i.e. "two or more network interfaces aggregated
into a single, logical network interface"). On Linux platforms, any
value in the ``/proc/net/bonding`` directory may be tested.


Syntax
------

A ``bond`` InSpec audit resource block declares a bonded network
interface, and then specifies the properties of that bonded network
interface to be tested:

::

   describe bond('name') do
     it { should exist }
   end

where

* ``'name'`` is the name of the bonded network interface

* ``{ should exist }`` is a valid matcher for this InSpec audit
  resource


Matchers
--------

This InSpec audit resource has the following matchers.


content
~~~~~~~

The ``content`` matcher tests if contents in the file that defines the
bonded network interface match the value specified in the test. The
values of the ``content`` matcher are arbitrary:

::

   its('content') { should match('value') }


exist
~~~~~

The ``exist`` matcher tests if the bonded network interface is
available:

::

   it { should exist }


have_interface
~~~~~~~~~~~~~~

The ``have_interface`` matcher tests if the bonded network interface
has one (or more) secondary interfaces:

::

   it { should have_interface }


interfaces
~~~~~~~~~~

The ``interfaces`` matcher tests if the named secondary interfaces are
available:

::

   its('interfaces') { should eq ['eth0', 'eth1', ...] }


params
~~~~~~

The ``params`` matcher tests arbitrary parameters for the bonded
network interface:

::

   its('params') { should eq 'value' }


Examples
--------

The following examples show how to use this InSpec audit resource.

**Test if eth0 is a secondary interface for bond0**

::

   describe bond('bond0') do
     it { should exist }
     it { should have_interface 'eth0' }
   end

**Test parameters for bond0**

::

   describe bond('bond0') do
     its('Bonding Mode') { should eq 'IEEE 802.3ad Dynamic link aggregation' }
     its('Transmit Hash Policy') { should eq 'layer3+4 (1)' }
     its('MII Status') { should eq 'up' }
     its('MII Polling Interval (ms)') { should eq '100' }
     its('Up Delay (ms)') { should eq '0' }
     its('Down Delay (ms)') { should eq '0' }
   end


bridge
======

Use the ``bridge`` InSpec audit resource to test basic network bridge
properties, such as name, if an interface is defined, and the
associations for any defined interface.

* On Linux platforms, any value in the
  ``/sys/class/net/{interface}/bridge`` directory may be tested

* On the Microsoft Windows platform, the ``Get-NetAdapter`` cmdlet is
  associated with the ``Get-NetAdapterBinding`` cmdlet and returns the
  ``ComponentID ms_bridge`` value as a JSON object


Syntax
------

A ``bridge`` InSpec audit resource block declares the bridge to be
tested and what interface it should be associated with:

::

   describe bridge('br0') do
     it { should exist }
     it { should have_interface 'eth0' }
   end


Matchers
--------

This InSpec audit resource has the following matchers.


exist
~~~~~

The ``exist`` matcher tests if the network bridge is available:

::

   it { should exist }


have_interface
~~~~~~~~~~~~~~

The ``have_interface`` matcher tests if the named interface is defined
for the network bridge:

::

   it { should have_interface 'eth0' }


interfaces
~~~~~~~~~~

The ``interfaces`` matcher tests if the named interface is present:

::

   its('interfaces') { should eq 'foo' }
   its('interfaces') { should eq 'bar' }
   its('interfaces') { should include('foo') }


command
=======

Use the ``command`` InSpec audit resource to test an arbitrary command
that is run on the system.


Syntax
------

A ``command`` InSpec audit resource block declares a command to be
run, one (or more) expected outputs, and the location to which that
output is sent:

::

   describe command('command') do
     it { should exist }
     its('matcher') { should eq 'output' }
   end

where

* ``'command'`` must specify a command to be run

* ``'matcher'`` is one of ``exit_status``, ``stderr``, or ``stdout``

* ``'output'`` tests the output of the command run on the system
  versus the output value stated in the test


Matchers
--------

This InSpec audit resource has the following matchers.


exist
~~~~~

The ``exist`` matcher tests if a command may be run on the system:

::

   it { should exist }


exit_status
~~~~~~~~~~~

The ``exit_status`` matcher tests the exit status for the command:

::

   its('exit_status') { should eq 123 }


stderr
~~~~~~

The ``stderr`` matcher tests results of the command as returned in
standard error (stderr):

::

   its('stderr') { should eq 'error' }


stdout
~~~~~~

The ``stdout`` matcher tests results of the command as returned in
standard output (stdout). The following example shows matching output
using a regular expression:

::

   describe command('echo 1') do
      its('stdout') { should match (/[0-9]/) }
   end


Examples
--------

The following examples show how to use this InSpec audit resource.

**Test for PostgreSQL database running a RC, development, or beta
release**

::

   describe command('psql -V') do
     its('stdout') { should eq '/RC/' }
     its('stdout') { should_not eq '/DEVEL/' }
     its('stdout') { should_not eq '/BETA/' }
   end

**Test standard output (stdout)**

::

   describe command('echo hello') do
     its('stdout') { should eq 'hello\n' }
     its('stderr') { should eq '' }
     its('exit_status') { should eq 0 }
   end

**Test standard error (stderr)**

::

   describe command('>&2 echo error') do
     its('stdout') { should eq '' }
     its('stderr') { should eq 'error\n' }
     its('exit_status') { should eq 0 }
   end

**Test an exit status code**

::

   describe command('exit 123') do
     its('stdout') { should eq '' }
     its('stderr') { should eq '' }
     its('exit_status') { should eq 123 }
   end

**Test if the command shell exists**

::

   describe command('/bin/sh').exist? do
     it { should eq true }
   end

**Test for a command that should not exist**

::

   describe command('this is not existing').exist? do
     it { should eq false }
   end


csv
===

Use the ``csv`` InSpec audit resource to test configuration data in a
CSV file.


Syntax
------

A ``csv`` InSpec audit resource block declares the configuration data
to be tested:

::

   describe csv('file') do
     its('name') { should eq 'foo' }
   end

where

* ``'file'`` is the path to a CSV file

* ``name`` is a configuration setting in a CSV file

* ``should eq 'foo'`` tests a value of ``name`` as read from a CSV
  file versus the value declared in the test


Matchers
--------

This InSpec audit resource has the following matchers.


name
~~~~

The ``name`` matcher tests the value of ``name`` as read from a CSV
file versus the value declared in the test:

::

   its('name') { should eq 'foo' }


Examples
--------

The following examples show how to use this InSpec audit resource.

**Test a CSV file**

::

   describe csv('some_file.csv') do
     its('setting') { should eq 1 }
   end


directory
=========

Use the ``directory`` InSpec audit resource to test if the file type
is a directory. This is equivalent to using the ``file`` InSpec audit
resource and the ``be_directory`` matcher, but provides a simpler and
more direct way to test directories. All of the matchers available to
``file`` may be used with ``directory``.


Syntax
------

A ``directory`` InSpec audit resource block declares the location of
the directory to be tested, and then one (or more) matchers:

::

   describe directory('path') do
     it { should MATCHER 'value' }
   end


Matchers
--------

This InSpec audit resource may use any of the matchers available to
the ``file`` resource that are useful for testing a directory.


etc_group
=========

Use the ``etc_group`` InSpec audit resource to test groups that are
defined on Linux and UNIX platforms. The ``/etc/group`` file stores
details about each group---group name, password, group identifier,
along with a comma-separate list of users that belong to the group.


Syntax
------

A ``etc_group`` InSpec audit resource block declares a collection of
properties to be tested:

::

   describe etc_group('path') do
     its('matcher') { should eq 'some_value' }
   end

or:

::

   describe etc_group.where(item: 'value', item: 'value') do
     its('gids') { should_not contain_duplicates }
     its('groups') { should include 'user_name' }
     its('users') { should include 'user_name' }
   end

where

* ``('path')`` is the non-default path to the ``inetd.conf`` file

* ``.where()`` may specify a specific item and value, to which the
  matchers are compared

* ``'gids'``, ``'groups'``, and ``'users'`` are valid matchers for
  this InSpec audit resource


Matchers
--------

This InSpec audit resource has the following matchers.


gids
~~~~

The ``gids`` matcher tests if the named group identifier is present or
if it contains duplicates:

::

   its('gids') { should_not contain_duplicates }


groups
~~~~~~

The ``groups`` matcher tests all groups for the named user:

::

   its('groups') { should include 'my_group' }


users
~~~~~

The ``users`` matcher tests all groups for the named user:

::

   its('users') { should include 'my_user' }


where
~~~~~

The ``where`` matcher allows the test to be focused to one (or more)
specific items:

::

   etc_group.where(item: 'value', item: 'value')

where ``item`` may be one (or more) of:

* ``name: 'name'``

* ``group_name: 'group_name'``

* ``password: 'password'``

* ``gid: 'gid'``

* ``group_id: 'gid'``

* ``users: 'user_name'``

* ``members: 'member_name'``


Examples
--------

The following examples show how to use this InSpec audit resource.

**Test group identifiers (GIDs) for duplicates**

::

   describe etc_group do
     its('gids') { should_not contain_duplicates }
   end

**Test all groups to see if a specific user belongs to one (or more)
groups**

::

   describe etc_group.where(name: 'my_group') do
     its('users') { should include 'my_user' }
   end

**Test all groups for a specific user name**

::

   describe etc_group do
     its('users') { should include 'my_user' }
   end

**Filter a list of groups for a specific user**

::

   describe etc_group do
     its('groups') { should include 'my_group' }
   end


file
====

Use the ``file`` InSpec audit resource to test all system file types,
including files, directories, symbolic links, named pipes, sockets,
character devices, block devices, and doors.


Syntax
------

A ``file`` InSpec audit resource block declares the location of the
file type to be tested, what type that file should be (if required),
and then one (or more) matchers:

::

   describe file('path') do
     it { should MATCHER 'value' }
   end

where

* ``('path')`` is the name of the file and/or the path to the file

* ``MATCHER`` is a valid matcher for this InSpec audit resource

* ``'value'`` is the value to be tested


Matchers
--------

This InSpec audit resource has the following matchers.


be_block_device
~~~~~~~~~~~~~~~

The ``be_block_device`` matcher tests if the file exists as a block
device, such as ``/dev/disk0`` or ``/dev/disk0s9``:

::

   it { should be_block_device }


be_character_device
~~~~~~~~~~~~~~~~~~~

The ``be_character_device`` matcher tests if the file exists as a
character device (that corresponds to a block device), such as
``/dev/rdisk0`` or ``/dev/rdisk0s9``:

::

   it { should be_character_device }


be_directory
~~~~~~~~~~~~

The ``be_directory`` matcher tests if the file exists as a directory,
such as ``/etc/passwd``, ``/etc/shadow``, or ``/var/log/httpd``:

::

   it { should be_directory }


be_executable
~~~~~~~~~~~~~

The ``be_executable`` matcher tests if the file exists as an
executable:

::

   it { should be_executable }

The ``be_executable`` matcher may also test if the file is executable
by a specific owner, group, or user. For example, a group:

::

   it { should be_executable.by('group') }

an owner:

::

   it { should be_executable.by('owner') }

a user:

::

   it { should be_executable.by_user('user') }


be_file
~~~~~~~

The ``be_file`` matcher tests if the file exists as a file. This can
be useful with configuration files like ``/etc/passwd`` where there
typically is not an associated file extension---``passwd.txt``:

::

   it { should be_file }


be_grouped_into
~~~~~~~~~~~~~~~

The ``be_grouped_into`` matcher tests if the file exists as part of
the named group:

::

   it { should be_grouped_into 'group' }


be_immutable
~~~~~~~~~~~~

The ``be_immutable`` matcher tests if the file is immutable, i.e.
"cannot be changed":

::

   it { should be_immutable }


be_linked_to
~~~~~~~~~~~~

The ``be_linked_to`` matcher tests if the file is linked to the named
target:

::

   it { should be_linked_to '/etc/target-file' }


be_mounted
~~~~~~~~~~

The ``be_mounted`` matcher tests if the file is accessible from the
file system:

::

   it { should be_mounted }


be_owned_by
~~~~~~~~~~~

The ``be_owned_by`` matcher tests if the file is owned by the named
user, such as ``root``:

::

   it { should be_owned_by 'root' }


be_pipe
~~~~~~~

The ``be_pipe`` matcher tests if the file exists as first-in,
first-out special file (``.fifo``) that is typically used to define a
named pipe, such as ``/var/log/nginx/access.log.fifo``:

::

   it { should be_pipe }


be_readable
~~~~~~~~~~~

The ``be_readable`` matcher tests if the file is readable:

::

   it { should be_readable }

The ``be_readable`` matcher may also test if the file is readable by a
specific owner, group, or user. For example, a group:

::

   it { should be_readable.by('group') }

an owner:

::

   it { should be_readable.by('owner') }

a user:

::

   it { should be_readable.by_user('user') }


be_socket
~~~~~~~~~

The ``be_socket`` matcher tests if the file exists as socket
(``.sock``), such as ``/var/run/php-fpm.sock``:

::

   it { should be_socket }


be_symlink
~~~~~~~~~~

The ``be_symlink`` matcher tests if the file exists as a symbolic, or
soft link that contains an absolute or relative path reference to
another file:

::

   it { should be_symlink }


be_version
~~~~~~~~~~

The ``be_version`` matcher tests the version of the file:

::

   it { should be_version '1.2.3' }


be_writable
~~~~~~~~~~~

The ``be_writable`` matcher tests if the file is writable:

::

   it { should be_writable }

The ``be_writable`` matcher may also test if the file is writable by a
specific owner, group, or user. For example, a group:

::

   it { should be_writable.by('group') }

an owner:

::

   it { should be_writable.by('owner') }

a user:

::

   it { should be_writable.by_user('user') }


content
~~~~~~~

The ``content`` matcher tests if contents in the file match the value
specified in the test. The values of the ``content`` matcher are
arbitrary and depend on the file type being tested and also the type
of information that is expected to be in that file:

::

   its('content') { should contain 'value' }

The following complete example tests the ``pg_hba.conf`` file in
PostgreSQL for MD5 requirements.  The tests look at all ``host`` and
``local`` settings in that file, and then compare the MD5 checksums
against the values in the test:

::

   describe file(hba_config_file) do
     its('content') { should match '/local\s.*?all\s.*?all\s.*?md5/' }
     its('content') { should match '%r{/host\s.*?all\s.*?all\s.*?127.0.0.1\/32\s.*?md5/}' }
     its('content') { should match '%r{/host\s.*?all\s.*?all\s.*?::1\/128\s.*?md5/}' }
   end


exist
~~~~~

The ``exist`` matcher tests if the named file exists:

::

   it { should exist }


file_version
~~~~~~~~~~~~

The ``file_version`` matcher tests if the file's version matches the
specified value. The difference between a file's "file version" and
"product version" is that the file version is the version number of
the file itself, whereas the product version is the version number
associated with the application from which that file originates:

::

   its('file_version') { should eq '1.2.3' }


group
~~~~~

The ``group`` matcher tests if the group to which a file belongs
matches the specified value:

::

   its('group') { should eq 'admins' }


have_mode
~~~~~~~~~

The ``have_mode`` matcher tests if a file has a mode assigned to it:

::

   it { should have_mode }


link_path
~~~~~~~~~

The ``link_path`` matcher tests if the file exists at the specified
path:

::

   its('link_path') { should eq '/some/path/to/file' }


link_target
~~~~~~~~~~~

The ``link_target`` matcher tests if a file that is linked to this
file exists at the specified path:

::

   its('link_target') { should eq '/some/path/to/file' }


md5sum
~~~~~~

The ``md5sum`` matcher tests if the MD5 checksum for a file matches
the specified value:

::

   its('md5sum') { should eq '3329x3hf9130gjs9jlasf2305mx91s4j' }


mode
~~~~

The ``mode`` matcher tests if the mode assigned to the file matches
the specified value:

::

   its('mode') { should eq 0644 }


mtime
~~~~~

The ``mtime`` matcher tests if the file modification time for the file
matches the specified value:

::

   its('mtime') { should eq 'October 31 2015 12:10:45' }

or:

::

   describe file('/').mtime.to_i do
     it { should <= Time.now.to_i }
     it { should >= Time.now.to_i - 1000}
   end


owner
~~~~~

The ``owner`` matcher tests if the owner of the file matches the
specified value:

::

   its('owner') { should eq 'root' }


product_version
~~~~~~~~~~~~~~~

The ``product_version`` matcher tests if the file's product version
matches the specified value. The difference between a file's "file
version" and "product version" is that the file version is the version
number of the file itself, whereas the product version is the version
number associated with the application from which that file
originates:

::

   its('product_version') { should eq 2.3.4 }


selinux_label
~~~~~~~~~~~~~

The ``selinux_label`` matcher tests if the SELinux label for a file
matches the specified value:

::

   its('selinux_label') { should eq 'system_u:system_r:httpd_t:s0' }


sha256sum
~~~~~~~~~

The ``sha256sum`` matcher tests if the SHA-256 checksum for a file
matches the specified value:

::

   its('sha256sum') { should eq 'b837ch38lh19bb8eaopl8jvxwd2e4g58jn9lkho1w3ed9jbkeicalplaad9k0pjn' }


size
~~~~

The ``size`` matcher tests if a file's size matches, is greater than,
or is less than the specified value. For example, equal:

::

   its('size') { should eq 32375 }

Greater than:

::

   its('size') { should > 64 }

Less than:

::

   its('size') { should < 10240 }


type
~~~~

The ``type`` matcher tests if the first letter of the file's mode
string contains one of the following characters:

* ``-`` or ``f`` (the file is a file); use ``'file`` to test for this
  file type

* ``d`` (the file is a directory); use ``'directory`` to test for this
  file type

* ``l`` (the file is a symbolic link); use ``'link`` to test for this
  file type

* ``p`` (the file is a named pipe); use ``'pipe`` to test for this
  file type

* ``s`` (the file is a socket); use ``'socket`` to test for this file
  type

* ``c`` (the file is a character device); use ``'character`` to test
  for this file type

* ``b`` (the file is a block device); use ``'block`` to test for this
  file type

* ``D`` (the file is a door); use ``'door`` to test for this file type

For example:

::

   its('type') { should eq 'file' }

or:

::

   its('type') { should eq 'socket' }


Examples
--------

The following examples show how to use this InSpec audit resource.

**Test the contents of a file for MD5 requirements**

::

   describe file(hba_config_file) do
     its('content') { should match '/local\s.*?all\s.*?all\s.*?md5/' }
     its('content') { should match '%r{/host\s.*?all\s.*?all\s.*?127.0.0.1\/32\s.*?md5/}' }
     its('content') { should match '%r{/host\s.*?all\s.*?all\s.*?::1\/128\s.*?md5/}' }
   end

**Test if a file exists**

::

   describe file('/tmp') do
    it { should exist }
   end

**Test that a file does not exist**

::

   describe file('/tmpest') do
    it { should_not exist }
   end

**Test if a path is a directory**

::

   describe file('/tmp') do
    its('type') { should eq :directory }
    it { should be_directory }
   end

**Test if a path is a file and not a directory**

::

   describe file('/proc/version') do
     its('type') { should eq 'file' }
     it { should be_file }
     it { should_not be_directory }
   end

**Test if a file is a symbolic link**

::

   describe file('/dev/stdout') do
     its('type') { should eq 'symlink' }
     it { should be_symlink }
     it { should_not be_file }
     it { should_not be_directory }
   end

**Test if a file is a character device**

::

   describe file('/dev/zero') do
     its('type') { should eq 'character' }
     it { should be_character_device }
     it { should_not be_file }
     it { should_not be_directory }
   end

**Test if a file is a block device**

::

   describe file('/dev/zero') do
     its('type') { should eq 'block' }
     it { should be_character_device }
     it { should_not be_file }
     it { should_not be_directory }
   end

**Test the mode for a file**

::

   describe file('/dev') do
    its('mode') { should eq 00755 }
   end

**Test the owner of a file**

::

   describe file('/root') do
     its('owner') { should eq 'root' }
   end

**Test if a file is owned by the root user**

::

   describe file('/dev') do
     it { should be_owned_by 'root' }
   end

**Test the mtime for a file**

::

   describe file('/').mtime.to_i do
     it { should <= Time.now.to_i }
     it { should >= Time.now.to_i - 1000}
   end

**Test that a file's size is between 64 and 10240**

::

   describe file('/') do
     its('size') { should be > 64 }
     its('size') { should be < 10240 }
   end

**Test that a file's size is zero**

::

   describe file('/proc/cpuinfo') do
     its('size') { should be 0 }
   end

**Test that a file is not mounted**

::

   describe file('/proc/cpuinfo') do
     it { should_not be_mounted }
   end

**Test an MD5 checksum**

::

   require 'digest'
   cpuinfo = file('/proc/cpuinfo').content

   md5sum = Digest::MD5.hexdigest(cpuinfo)

   describe file('/proc/cpuinfo') do
     its('md5sum') { should eq md5sum }
   end

**Test an SHA-256 checksum**

::

   require 'digest'
   cpuinfo = file('/proc/cpuinfo').content

   sha256sum = Digest::SHA256.hexdigest(cpuinfo)

   describe file('/proc/cpuinfo') do
     its('sha256sum') { should eq sha256sum }
   end


gem
===

Use the ``gem`` InSpec audit resource to test if a global gem package
is installed.


Syntax
------

A ``gem`` InSpec audit resource block declares a package and
(optionally) a package version:

::

   describe gem('gem_package_name') do
     it { should be_installed }
   end

where

* ``('gem_package_name')`` must specify a gem package, such as
  ``'rubocop'``

* ``be_installed`` is a valid matcher for this InSpec audit resource


Matchers
--------

This InSpec audit resource has the following matchers.


be_installed
~~~~~~~~~~~~

The ``be_installed`` matcher tests if the named gem package is
installed:

::

   it { should be_installed }


version
~~~~~~~

The ``version`` matcher tests if the named package version is on the
system:

::

   its('version') { should eq '0.33.0' }


Examples
--------

The following examples show how to use this InSpec audit resource.

**Verify that a gem package is installed, with a specific version**

::

   describe gem('rubocop') do
     it { should be_installed }
     its('version') { should eq '0.33.0' }
   end

**Verify that a gem package is not installed**

::

   describe gem('rubocop') do
     it { should_not be_installed }
   end


group
=====

Use the ``group`` InSpec audit resource to test groups on the system.


Syntax
------

A ``group`` InSpec audit resource block declares a group, and then the
details to be tested, such as if the group is a local group, the group
identifier, or if the group exists:

::

   describe group('group_name') do
     it { should exist }
     its('gid') { should eq 0 }
   end

where

* ``'group_name'`` must specify the name of a group on the system

* ``exist`` and ``'gid'`` are valid matchers for this InSpec audit
  resource


Matchers
--------

This InSpec audit resource has the following matchers.


be_local
~~~~~~~~

The ``be_local`` matcher tests if the group is a local group:

::

   it { should be_local }


exist
~~~~~

The ``exist`` matcher tests if the named user exists:

::

   it { should exist }


gid
~~~

The ``gid`` matcher tests the named group identifier:

::

   its('gid') { should eq 1234 }


Examples
--------

The following examples show how to use this InSpec audit resource.

**Test the group identifier for the root group**

::

   describe group('root') do
     it { should exist }
     its('gid') { should eq 0 }
   end


host
====

Use the ``host`` InSpec audit resource to test the name used to refer
to a specific host and its availability, including the Internet
protocols and ports over which that host name should be available.


Syntax
------

A ``host`` InSpec audit resource block declares a host name, and then
(depending on what is to be tested) a port and/or a protocol:

::

   describe host('example.com', port: 80, proto: 'tcp') do
     it { should be_reachable }
   end

where

* ``host()`` must specify a host name and may specify a port number
  and/or a protocol

* ``'example.com'`` is the host name

* ``port:`` is the port number

* ``proto: 'name'`` is the Internet protocol: TCP (``proto: 'tcp'``),
  UDP (``proto: 'udp'`` or  ICMP (``proto: 'icmp'``))

* ``be_reachable`` is a valid matcher for this InSpec audit resource


Matchers
--------

This InSpec audit resource has the following matchers.


be_reachable
~~~~~~~~~~~~

The ``be_reachable`` matcher tests if the host name is available:

::

   it { should be_reachable }


be_resolvable
~~~~~~~~~~~~~

The ``be_resolvable`` matcher tests for host name resolution, i.e.
"resolvable to an IP address":

::

   it { should be_resolvable }


ipaddress
~~~~~~~~~

The ``ipaddress`` matcher tests if a host name is resolvable to a
specific IP address:

::

   its('ipaddress') { should include '93.184.216.34' }


Examples
--------

The following examples show how to use this InSpec audit resource.

**Verify host name is reachable over a specific protocol and port
number**

::

   describe host('example.com', port: 53, proto: 'udp') do
     it { should be_reachable }
   end

**Verify that a specific IP address can be resolved**

::

   describe host('example.com', port: 80, proto: 'tcp') do
     it { should be_resolvable }
     its('ipaddress') { should include '192.168.1.1' }
   end


inetd_conf
==========

Use the ``inetd_conf`` InSpec audit resource to test if a service is
enabled in the ``inetd.conf`` file on Linux and UNIX platforms.
inetd---the Internet service daemon---listens on dedicated ports, and
then loads the appropriate program based on a request. The
``inetd.conf`` file is typically located at ``/etc/inetd.conf`` and
contains a list of Internet services associated to the ports on which
that service will listen. Only enabled services may handle a request;
only services that are required by the system should be enabled.


Syntax
------

An ``inetd_conf`` InSpec audit resource block declares the list of
services that are enabled in the ``inetd.conf`` file:

::

   describe inetd_conf('path') do
     its('service_name') { should eq 'value' }
   end

where

* ``'service_name'`` is a service listed in the ``inetd.conf`` file

* ``('path')`` is the non-default path to the ``inetd.conf`` file

* ``should eq 'value'`` is the value that is expected


Matchers
--------

This InSpec audit resource matches any service that is listed in the
``inetd.conf`` file. You may want to ensure that specific services do
not listen via ``inetd.conf``:

::

   its('shell') { should eq nil }

or:

::

   its('netstat') { should eq nil }

or:

::

   its('systat') { should eq nil }

For example:

::

   describe inetd_conf do
     its('shell') { should eq nil }
     its('login') { should eq nil }
     its('exec') { should eq nil }
   end


Examples
--------

The following examples show how to use this InSpec audit resource.

**Verify that FTP is disabled**

The contents if the ``inetd.conf`` file contain the following:

::

   #ftp      stream   tcp   nowait   root   /usr/sbin/tcpd   in.ftpd -l -a
   #telnet   stream   tcp   nowait   root   /usr/sbin/tcpd   in.telnetd

and the following test is defined:

::

   describe inetd_conf do
     its('ftp') { should eq nil }
     its('telnet') { should eq nil }
   end

Because both the ``ftp`` and ``telnet`` Internet services are
commented out (``#``), both services are disabled. Consequently, both
tests will return ``true``. However, if the ``inetd.conf`` file is set
as follows:

::

   ftp       stream   tcp   nowait   root   /usr/sbin/tcpd   in.ftpd -l -a
   #telnet   stream   tcp   nowait   root   /usr/sbin/tcpd   in.telnetd

then the same test will return ``false`` for ``ftp`` and the entire
test will fail.

**Test if telnet is installed**

::

   describe package('telnetd') do
     it { should_not be_installed }
   end

   describe inetd_conf do
     its('telnet') { should eq nil }
   end


interface
=========

Use the ``interface`` InSpec audit resource to test basic network
adapter properties, such as name, status, state, address, and link
speed (in MB/sec).

* On Linux platforms, ``/sys/class/net/#{iface}`` is used as source

* On the Microsoft Windows platform, the ``Get-NetAdapter`` cmdlet is
  used as source


Syntax
------

An ``interface`` InSpec audit resource block declares network
interface properties to be tested:

::

   describe interface do
     it { should be_up }
     its('speed') { should eq 1000 }
     its('name') { should eq eth0 }
   end


Matchers
--------

This InSpec audit resource has the following matchers.


be_up
~~~~~

The ``be_up`` matcher tests if the network interface is available:

::

   it { should be_up }


name
~~~~

The ``name`` matcher tests if the named network interface exists:

::

   its('name') { should eq eth0 }


speed
~~~~~

The ``speed`` matcher tests the speed of the network interface, in
MB/sec:

::

   its('speed') { should eq 1000 }


iptables
========

Use the ``iptables`` InSpec audit resource to test rules that are
defined in ``iptables``, which maintains tables of IP packet filtering
rules. There may be more than one table. Each table contains one (or
more) chains (both built-in and custom). A chain is a list of rules
that match packets. When the rule matches, the rule defines what
target to assign to the packet.


Syntax
------

A ``iptables`` InSpec audit resource block declares tests for rules in
IP tables:

::

   describe iptables(rule:'name', table:'name', chain: 'name') do
     it { should have_rule('RULE') }
   end

where

* ``iptables()`` may specify any combination of ``rule``, ``table``,
  or ``chain``

* ``rule:'name'`` is the name of a rule that matches a set of packets

* ``table:'name'`` is the packet matching table against which the test
  is run

* ``chain: 'name'`` is the name of a user-defined chain or one of
  ``ACCEPT``, ``DROP``, ``QUEUE``, or ``RETURN``

* ``have_rule('RULE')`` tests that rule in the iptables file


Matchers
--------

This InSpec audit resource has the following matchers.


have_rule
~~~~~~~~~

The ``have_rule`` matcher tests the named rule against the information
in the ``iptables`` file:

::

   it { should have_rule('RULE') }


Examples
--------

The following examples show how to use this InSpec audit resource.

**Test if the IP table allows a packet through**

::

   describe iptables do
     it { should have_rule('-P INPUT ACCEPT') }
   end

**Test if the IP table allows a packet through, for a specific table
and chain**

::

   describe iptables(table:'mangle', chain: 'input') do
     it { should have_rule('-P INPUT ACCEPT') }
   end


json
====

Use the ``json`` InSpec audit resource to test data in a JSON file.


Syntax
------

A ``json`` InSpec audit resource block declares the data to be tested:

::

   describe json do
     its('name') { should eq 'foo' }
   end

where

* ``name`` is a configuration setting in a JSON file

* ``should eq 'foo'`` tests a value of ``name`` as read from a JSON
  file versus the value declared in the test


Matchers
--------

This InSpec audit resource has the following matchers.


name
~~~~

The ``name`` matcher tests the value of ``name`` as read from a JSON
file versus the value declared in the test:

::

   its('name') { should eq 'foo' }


Examples
--------

The following examples show how to use this InSpec audit resource.

**Test a cookbook version in a policyfile.lock.json file**

::

   describe json('policyfile.lock.json') do
     its('cookbook_locks.omnibus.version') { should eq('2.2.0') }
   end


kernel_module
=============

Use the ``kernel_module`` InSpec audit resource to test kernel modules
on Linux platforms. These parameters are located under
``/lib/modules``. Any submodule may be tested using this resource.


Syntax
------

A ``kernel_module`` InSpec audit resource block declares a module
name, and then tests if that module is a loadable kernel module:

::

   describe kernel_module('module_name') do
     it { should be_loaded }
   end

where

* ``'module_name'`` must specify a kernel module, such as ``'bridge'``

* ``{ should be_loaded }`` tests if the module is a loadable kernel
  module


Matchers
--------

This InSpec audit resource has the following matchers.


be_loaded
~~~~~~~~~

The ``be_loaded`` matcher tests if the module is a loadable kernel
module:

::

   it { should be_loaded }


Examples
--------

The following examples show how to use this InSpec audit resource.

**Test if a module is loaded**

::

   describe kernel_module('bridge') do
     it { should be_loaded }
   end


kernel_parameter
================

Use the ``kernel_parameter`` InSpec audit resource to test kernel
parameters on Linux platforms.


Syntax
------

A ``kernel_parameter`` InSpec audit resource block declares a
parameter and then a value to be tested:

::

   describe kernel_parameter('path.to.parameter') do
     its('value') { should eq 0 }
   end

where

* ``'kernel.parameter'`` must specify a kernel parameter, such as
  ``'net.ipv4.conf.all.forwarding'``

* ``{ should eq 0 }`` states the value to be tested


Matchers
--------

This InSpec audit resource has the following matchers.


value
~~~~~

The ``value`` matcher tests the value assigned to the named IP address
versus the value declared in the test:

::

   its('value') { should eq 0 }


Examples
--------

The following examples show how to use this InSpec audit resource.

**Test if global forwarding is enabled for an IPv4 address**

::

   describe kernel_parameter('net.ipv4.conf.all.forwarding') do
     its(:value) { should eq 1 }
   end

**Test if global forwarding is disabled for an IPv6 address**

::

   describe kernel_parameter('net.ipv6.conf.all.forwarding') do
     its(:value) { should eq 0 }
   end

**Test if an IPv6 address accepts redirects**

::

   describe kernel_parameter('net.ipv6.conf.interface.accept_redirects') do
     its(:value) { should eq 'true' }
   end


limits_conf
===========

Use the ``limits_conf`` InSpec audit resource to test configuration
settings in the ``/etc/security/limits.conf`` file. The
``limits.conf`` defines limits for processes (by user and/or group
names) and helps ensure that the system on which those processes are
running remains stable. Each process may be assigned a hard or soft
limit.

* Soft limits are maintained by the shell and defines the number of
  file handles (or open files) available to the user or group after
  login

* Hard limits are maintained by the kernel and defines the maximum
  number of allowed file handles

Entries in the ``limits.conf`` file are similar to:

::

   grantmc     soft   nofile   4096
   grantmc     hard   nofile   63536

   ^^^^^^^^^   ^^^^   ^^^^^^   ^^^^^
   domain      type    item    value


Syntax
------

A ``limits_conf`` InSpec audit resource block declares a domain to be
tested, along with associated type, item, and value:

::

   describe limits_conf('path') do
     its('domain') { should include ['type', 'item', 'value'] }
     its('domain') { should eq ['type', 'item', 'value'] }
   end

where

* ``('path')`` is the non-default path to the ``inetd.conf`` file

* ``'domain'`` is a user or group name, such as ``grantmc``

* ``'type'`` is either ``hard`` or ``soft``

* ``'item'`` is the item for which limits are defined, such as
  ``core``, ``nofile``, ``stack``, ``nproc``, ``priority``, or
  ``maxlogins``

* ``'value'`` is the value associated with the ``item``


Matchers
--------

This InSpec audit resource has the following matchers.


domain
~~~~~~

The ``domain`` matcher tests the domain in the ``limits.conf`` file,
along with associated type, item, and value:

::

   its('domain') { should include ['type', 'item', 'value'] }

For example:

::

   its('grantmc') { should include ['hard', 'nofile', '63536'] }


Examples
--------

The following examples show how to use this InSpec audit resource.

**Test limits**

::

   describe limits_conf('path') do
     its('*') { should include ['soft', 'core', '0'], ['hard', 'rss', '10000'] }
     its('ftp') { should eq ['hard', 'nproc', '0'] }
   end


login_defs
==========

Use the ``login_defs`` InSpec audit resource to test configuration
settings in the ``/etc/login.defs`` file. The ``logins.defs`` file
defines site-specific configuration for the shadow password suite on
Linux and UNIX platforms, such as password expiration ranges,
minimum/maximum values for automatic selection of user and group
identifiers, or the method with which passwords are encrypted.


Syntax
------

A ``login_defs`` InSpec audit resource block declares the
``login.defs`` configuration data to be tested:

::

   describe login_defs do
     its('name') { should include('foo') }
   end

where

* ``name`` is a configuration setting in ``login.defs``

* ``{ should include('foo') }`` tests the value of ``name`` as read
  from ``login.defs`` versus the value declared in the test


Matchers
--------

This InSpec audit resource has the following matchers.


name
~~~~

The ``name`` matcher tests the value of ``name`` as read from
``login.defs`` versus the value declared in the test:

::

   its('name') { should eq 'foo' }


Examples
--------

The following examples show how to use this InSpec audit resource.

**Test password expiration settings**

::

   describe login_defs do
     its('PASS_MAX_DAYS') { should eq '180' }
     its('PASS_MIN_DAYS') { should eq '1' }
     its('PASS_MIN_LEN') { should eq '15' }
     its('PASS_WARN_AGE') { should eq '30' }
   end

**Test the encryption method**

::

   describe login_defs do
     its('ENCRYPT_METHOD') { should eq 'SHA512' }
   end

**Test umask and password expiration**

::

   describe login_def do
     its('UMASK') { should eq '077' }
     its('PASS_MAX_DAYS') { should eq '90' }
   end


mysql_conf
==========

Use the ``mysql_conf`` InSpec audit resource to test the contents of
the configuration file for MySQL, typically located at
``/etc/mysql/my.cnf`` or ``/etc/my.cnf``.


Syntax
------

A ``mysql_conf`` InSpec audit resource block declares one (or more)
settings in the ``my.cnf`` file, and then compares the setting in the
configuration file to the value stated in the test:

::

   describe mysql_conf('path') do
     its('setting') { should eq 'value' }
   end

where

* ``'setting'`` specifies a setting in the ``my.cnf`` file, such as
  ``max_connections``

* ``('path')`` is the non-default path to the ``my.cnf`` file

* ``should eq 'value'`` is the value that is expected


Matchers
--------

This InSpec audit resource has the following matchers.


setting
~~~~~~~

The ``setting`` matcher tests specific, named settings in the
``my.cnf`` file:

::

   its('setting') { should eq 'value' }

Use a ``setting`` matcher for each setting to be tested.


Examples
--------

The following examples show how to use this InSpec audit resource.

**Test the maximum number of allowed connections**

::

   describe mysql_conf do
     its('max_connections') { should eq '505' }
     its('max_user_connections') { should eq '500' }
   end

**Test slow query logging**

::

   describe mysql_conf do
     its('slow_query_log_file') { should eq 'hostname_slow.log' }
     its('slow_query_log') { should eq '0' }
     its('log_queries_not_using_indexes') { should eq '1' }
     its('long_query_time') { should eq '0.5' }
     its('min_examined_row_limit') { should eq '100' }
   end

**Test the port and socket on which MySQL listens**

::

   describe mysql_conf do
     its('port') { should eq '3306' }
     its('socket') { should eq '/var/run/mysqld/mysql.sock' }
   end

**Test connection and thread variables**

::

   describe mysql_conf do
     its('port') { should eq '3306' }
     its('socket') { should eq '/var/run/mysqld/mysql.sock' }
     its('max_allowed_packet') { should eq '12M' }
     its('default_storage_engine') { should eq 'InnoDB' }
     its('character_set_server') { should eq 'utf8' }
     its('collation_server') { should eq 'utf8_general_ci' }
     its('max_connections') { should eq '505' }
     its('max_user_connections') { should eq '500' }
     its('thread_cache_size') { should eq '505' }
   end

**Test the safe-user-create parameter**

::

   describe mysql_conf.params('mysqld') do
     its('safe-user-create') { should eq('1') }
   end


mysql_session
=============

Use the ``mysql_session`` InSpec audit resource to test SQL commands
run against a MySQL database.


Syntax
------

A ``mysql_session`` InSpec audit resource block declares the username
and password to use for the session, and then the command to be run:

::

   describe mysql_session('username', 'password').query('QUERY') do
     its('output') { should eq('') }
   end

where

* ``mysql_session`` declares a username and password with permission
  to run the query

* ``query('QUERY')`` contains the query to be run

* ``its('output') { should eq('') }`` compares the results of the
  query against the expected result in the test


Matchers
--------

This InSpec audit resource has the following matchers.


output
~~~~~~

The ``output`` matcher tests the results of the query:

::

   its('output') { should eq(/^0/) }


Examples
--------

The following examples show how to use this InSpec audit resource.

**Test for matching databases**

::

   sql = mysql_session('my_user','password')

   describe sql.query('show databases like \'test\';') do
     its(:stdout) { should_not match(/test/) }
   end


npm
===

Use the ``npm`` InSpec audit resource to test if a global npm package
is installed. npm is the the package manager for Node.js packages,
such as bower and StatsD.


Syntax
------

A ``npm`` InSpec audit resource block declares a package and
(optionally) a package version:

::

   describe gem('npm_package_name') do
     it { should be_installed }
   end

where

* ``('npm_package_name')`` must specify a npm package, such as
  ``'bower'`` or ``'statsd'``

* ``be_installed`` is a valid matcher for this InSpec audit resource


Matchers
--------

This InSpec audit resource has the following matchers.


be_installed
~~~~~~~~~~~~

The ``be_installed`` matcher tests if the named gem package and
package version (if specified) is installed:

::

   it { should be_installed }


version
~~~~~~~

The ``version`` matcher tests if the named package version is on the
system:

::

   its('version') { should eq '1.2.3' }


Examples
--------

The following examples show how to use this InSpec audit resource.

**Verify that bower is installed, with a specific version**

::

   describe npm('bower') do
     it { should be_installed }
     its('version') { should eq '1.4.1' }
   end

**Verify that statsd is not installed**

::

   describe npm('statsd') do
     it { should_not be_installed }
   end


ntp_conf
========

Use the ``ntp_conf`` InSpec audit resource to test the synchronization
settings defined in the ``ntp.conf`` file. This file is typically
located at ``/etc/ntp.conf``.


Syntax
------

An ``ntp_conf`` InSpec audit resource block declares the
synchronization settings that should be tested:

::

   describe ntp_conf('path') do
     its('setting_name') { should eq 'value' }
   end

where

* ``'setting_name'`` is a synchronization setting defined in the
  ``ntp.conf`` file

* ``('path')`` is the non-default path to the ``ntp.conf`` file

* ``{ should eq 'value' }`` is the value that is expected


Matchers
--------

This InSpec audit resource matches any service that is listed in the
``ntp.conf`` file:

::

   its('server') { should_not eq nil }

or:

::

   its('restrict') { should include '-4 default kod notrap nomodify nopeer noquery'}

For example:

::

   describe ntp_conf do
     its('server') { should_not eq nil }
     its('restrict') { should include '-4 default kod notrap nomodify nopeer noquery'}
   end


Examples
--------

The following examples show how to use this InSpec audit resource.

**Test for clock drift against named servers**

::

   describe ntp_conf do
     its('driftfile') { should eq '/var/lib/ntp/ntp.drift' }
     its('server') { should eq [
       0.ubuntu.pool.ntp.org,
       1.ubuntu.pool.ntp.org,
       2.ubuntu.pool.ntp.org
     ] }
   end


oneget
======

Use the ``oneget`` InSpec audit resource to test if the named package
and/or package version is installed on the system. This resource uses
OneGet, which is part of the Windows Management Framework 5.0 and
Windows 10. This resource uses the ``Get-Package`` cmdlet to return
all of the package names in the OneGet repository.


Syntax
------

A ``oneget`` InSpec audit resource block declares a package and
(optionally) a package version:

::

   describe oneget('name') do
     it { should be_installed }
   end

where

* ``('name')`` must specify the name of a package, such as ``'VLC'``

* ``be_installed`` is a valid matcher for this InSpec audit resource


Matchers
--------

This InSpec audit resource has the following matchers.


be_installed
~~~~~~~~~~~~

The ``be_installed`` matcher tests if the named package is installed
on the system:

::

   it { should be_installed }


version
~~~~~~~

The ``version`` matcher tests if the named package version is on the
system:

::

   its('version') { should eq '1.2.3' }


Examples
--------

The following examples show how to use this InSpec audit resource.

**Test if VLC is installed**

::

   describe oneget('VLC') do
     it { should be_installed }
   end


os
==

Use the ``os`` InSpec audit resource to test the platform on which the
system is running.


Syntax
------

A ``os`` InSpec audit resource block declares the platform to be
tested:

::

   describe os['family'] do
     it { should eq 'platform' }
   end

where

* ``'platform'`` is one of ``bsd``, ``debian``, ``linux``, ``redhat``,
  ``solaris``, ``suse``,  ``unix``, or ``windows``


Matchers
--------

This InSpec audit resource does not have any matchers.


Examples
--------

The following examples show how to use this InSpec audit resource.

**Test for RedHat**

::

   describe os['family'] do
     it { should eq 'redhat' }
   end

**Test for Ubuntu**

::

   describe os['family'] do
     it { should eq 'debian' }
   end

**Test for Microsoft Windows**

::

   describe os['family'] do
     it { should eq 'windows' }
   end


os_env
======

Use the ``os_env`` InSpec audit resource to test the environment
variables for the platform on which the system is running.


Syntax
------

A ``os_env`` InSpec audit resource block declares an environment
variable, and then declares its value:

::

   describe os_env('VARIABLE') do
     its('matcher') { should eq 1 }
   end

where

* ``('VARIABLE')`` must specify an environment variable, such as
  ``PATH``

* ``matcher`` is a valid matcher for this InSpec audit resource


Matchers
--------

This InSpec audit resource has the following matchers.


content
~~~~~~~

The ``content`` matcher return the value of the environment variable:

::

   its('content') { should eq '/usr/local/bin:/usr/local/sbin:/usr/sbin:/usr/bin:/sbin' }


split
~~~~~

The ``split`` splits the content with the ``:``` deliminator:

::

   its('split') { should include ('') }

or:

::

   its('split') { should_not include ('.') }

Use ``-1`` to test for cases where there is a trailing colon (``:``),
such as ``dir1::dir2:``:

::

   its('split') { should include ('-1') }


Examples
--------

The following examples show how to use this InSpec audit resource.

**Test the PATH environment variable**

::

   describe os_env('PATH') do
     its('split') { should_not include('') }
     its('split') { should_not include('.') }
   end


package
=======

Use the ``package`` InSpec audit resource to test if the named package
and/or package version is installed on the system.


Syntax
------

A ``package`` InSpec audit resource block declares a package and
(optionally) a package version:

::

   describe package('name') do
     it { should be_installed }
   end

where

* ``('name')`` must specify the name of a package, such as ``'nginx'``

* ``be_installed`` is a valid matcher for this InSpec audit resource


Matchers
--------

This InSpec audit resource has the following matchers.


be_installed
~~~~~~~~~~~~

The ``be_installed`` matcher tests if the named package is installed
on the system:

::

   it { should be_installed }


version
~~~~~~~

The ``version`` matcher tests if the named package version is on the
system:

::

   its('version) { should eq '1.2.3' }


Examples
--------

The following examples show how to use this InSpec audit resource.

**Test if nginx version 1.9.5 is installed**

::

   describe package('nginx') do
     it { should be_installed }
     its('version') { should eq 1.9.5 }
   end

**Test that a package is not installed**

::

   describe package('some_package') do
     it { should_not be_installed }
   end

**Test if telnet is installed**

::

   describe package('telnetd') do
     it { should_not be_installed }
   end

   describe inetd_conf do
     its('telnet') { should eq nil }
   end

**Test if ClamAV (an antivirus engine) is installed and running**

::

   describe package('clamav') do
     it { should be_installed }
     its('version') { should eq '0.98.7' }
   end

   describe service('clamd') do
     it { should_not be_enabled }
     it { should_not be_installed }
     it { should_not be_running }
   end


parse_config
============

Use the ``parse_config`` InSpec audit resource to test arbitrary
configuration files.


Syntax
------

A ``parse_config`` InSpec audit resource block declares the location
of the configuration setting to be tested, and then what value is to
be tested. Because this InSpec audit resource relies on arbitrary
configuration files, the test itself is often arbitrary and relies on
custom Ruby code:

::

   output = command('some-command').stdout

   describe parse_config(output, { data_config_option: value } ) do
     its('setting') { should eq 1 }
   end

or:

::

   audit = command('/sbin/auditctl -l').stdout
     options = {
       assignment_re: /^\s*([^:]*?)\s*:\s*(.*?)\s*$/,
       multiple_values: true
     }

   describe parse_config(audit, options) do
     its('setting') { should eq 1 }
   end

where each test

* Must declare the location of the configuration file to be tested

* Must declare one (or more) settings to be tested

* May run a command to ``stdout``, and then run the test against that
  output

* May use options to define how configuration data is to be parsed


Options
-------

This InSpec audit resource supports the following options for parsing
configuration data. Use them in an ``options`` block stated outside of
(and immediately before) the actual test:

::

   options = {
       assignment_re: /^\s*([^:]*?)\s*:\s*(.*?)\s*$/,
       multiple_values: true
     }
   describe parse_config(options) do
     its('setting') { should eq 1 }
   end


assignment_re
~~~~~~~~~~~~~

Use ``assignment_re`` to test a key value using a regular expression:

::

   'key = value'

may be tested using the following regular expression, which determines
assignment from key to value:

::

   assignment_re: /^\s*([^=]*?)\s*=\s*(.*?)\s*$/


comment_char
~~~~~~~~~~~~

Use ``comment_char`` to test for comments in a configuration file:

::

   comment_char: '#'


key_vals
~~~~~~~~

Use ``key_vals`` to test how many values a key contains:

::

   key = a b c

contains three values. To test that value to ensure it only contains
one, use:

::

   key_vals: 1


multiple_values
~~~~~~~~~~~~~~~

Use ``multiple_values`` if the source file uses the same key multiple
times. All values will be aggregated in an array:

::

   # # file structure:
   # key = a
   # key = b
   # key2 = c
   params['key'] = ['a', 'b']
   params['key2'] = ['c']

To use plain key value mapping, use ``multiple_values: false``:

::

   # # file structure:
   # key = a
   # key = b
   # key2 = c
   params['key'] = 'b'
   params['key2'] = 'c'


standalone_comments
~~~~~~~~~~~~~~~~~~~

Use ``standalone_comments`` to parse comments as a line, otherwise
inline comments are allowed:

::

   'key = value # comment'
   params['key'] = 'value # comment'

Use ``standalone_comments: false``, to parse the following:

::

   'key = value # comment'
   params['key'] = 'value'


Examples
--------

The following examples show how to use this InSpec audit resource.

**Test the expiration time for new account passwords**

::

   output = command('useradd -D').stdout

   describe parse_config(output) do
     its('INACTIVE') { should eq '35' }
   end

**Test that bob is a user**

::

   describe parse_config(data, { multiple_values: true }) do
     its('users') { should include 'bob'}
   end


parse_config_file
=================

Use the ``parse_config_file`` InSpec audit resource to test arbitrary
configuration files. It works in the same way as ``parse_config``.
Instead of using a command output, this resource works with files.


Syntax
------

A ``parse_config_file`` InSpec audit resource block declares the
location of the configuration file to be tested, and then which
settings in that file are to be tested.

::

   describe parse_config_file('/path/to/file', { data_config_option: value } ) do
     its('setting') { should eq 1 }
   end

or:

::

   options = {
     assignment_re: /^\s*([^:]*?)\s*:\s*(.*?)\s*$/,
     multiple_values: true
   }

   describe parse_config_file('path/to/file', options) do
     its('setting') { should eq 1 }
   end

where each test

* Must declare the location of the configuration file to be tested

* Must declare one (or more) settings to be tested

* May run a command to ``stdout``, and then run the test against that
  output

* May use options to define how configuration data is to be parsed


Options
-------

This InSpec audit resource supports the following options for parsing
configuration data. Use them in an ``options`` block stated outside of
(and immediately before) the actual test:

::

   options = {
       assignment_re: /^\s*([^:]*?)\s*:\s*(.*?)\s*$/,
       multiple_values: true
     }
   describe parse_config_file('path/to/file',  options) do
     its('setting') { should eq 1 }
   end


assignment_re
~~~~~~~~~~~~~

Use ``assignment_re`` to test a key value using a regular expression:

::

   'key = value'

may be tested using the following regular expression, which determines
assignment from key to value:

::

   assignment_re: /^\s*([^=]*?)\s*=\s*(.*?)\s*$/


comment_char
~~~~~~~~~~~~

Use ``comment_char`` to test for comments in a configuration file:

::

   comment_char: '#'


key_vals
~~~~~~~~

Use ``key_vals`` to test how many values a key contains:

::

   key = a b c

contains three values. To test that value to ensure it only contains
one, use:

::

   key_vals: 1


multiple_values
~~~~~~~~~~~~~~~

Use ``multiple_values`` if the source file uses the same key multiple
times. All values will be aggregated in an array:

::

   # # file structure:
   # key = a
   # key = b
   # key2 = c
   params['key'] = ['a', 'b']
   params['key2'] = ['c']

To use plain key value mapping, use ``multiple_values: false``:

::

   # # file structure:
   # key = a
   # key = b
   # key2 = c
   params['key'] = 'b'
   params['key2'] = 'c'


standalone_comments
~~~~~~~~~~~~~~~~~~~

Use ``standalone_comments`` to parse comments as a line, otherwise
inline comments are allowed:

::

   'key = value # comment'
   params['key'] = 'value # comment'

Use ``standalone_comments: false``, to parse the following:

::

   'key = value # comment'
   params['key'] = 'value'


Examples
--------

The following examples show how to use this InSpec audit resource.

**Test a configuration setting**

::

   describe parse_config_file('/path/to/file.conf') do
    its('PARAM_X') { should eq 'Y' }
   end

**Use options, and then test a configuration setting**

::

   describe parse_config_file('/path/to/file.conf', { multiple_values: true }) do
    its('PARAM_X') { should include 'Y' }
   end


passwd
======

Use the ``passwd`` InSpec audit resource to test the contents of
``/etc/passwd``, which contains the following information for users
that may log into the system and/or as users that own running
processes. The format for ``/etc/passwd`` includes:

* A username

* The password for that user (on newer systems passwords should be
  stored in ``/etc/shadow`` )

* The user identifier (UID) assigned to that user

* The group identifier (GID) assigned to that user

* Additional information about that user

* That user's home directory

* That user's default command shell

defined as a colon-delimited row in the file, one row per user:

::

   root:x:1234:5678:additional_info:/home/dir/:/bin/bash


Syntax
------

A ``passwd`` InSpec audit resource block declares one (or more) users
and associated user information to be tested:

::

   describe passwd do
     its('matcher') { should eq 0 }
   end

   describe passwd.uid(filter) do
     its(:username) { should eq 'root' }
     its(:count) { should eq 1 }
   end

where

* ``gids``, ``passwords``, ``uids``, and ``usernames`` are valid
  matchers for ``passwd``

* ``filter`` is a filter for a specific uid

* ``count``, ``uid``, ``username`` are valid matchers for
  ``passwd.uid(userid)``


Matchers for ``passwd``
-----------------------

This InSpec audit resource has the following matchers.


gids
~~~~

The ``gids`` matcher tests if the group indentifiers in the test match
group identifiers in ``/etc/passwd``:

::

   its('gids') { should eq 1234 }


passwords
~~~~~~~~~

The ``passwords`` matcher tests if passwords are

* Encrypted

* Have direct logins disabled, as indicated by an asterisk (``*``)

* In the ``/etc/shadow`` file, as indicated by the letter x (``x``)

For example:

::

   its('passwords') { should eq 'x' }


uids
~~~~

The ``uids`` matcher tests if the user indentifiers in the test match
user identifiers in ``/etc/passwd``:

::

   its('uids') { should eq ['1234', '1235'] }


usernames
~~~~~~~~~

The ``usernames`` matcher tests if the usernames in the test match
usernames in ``/etc/passwd``:

::

   its('usernames') { should eq ['root', 'www-data'] }


Matchers for ``passwd.uid(userid)``
-----------------------------------

This InSpec audit resource has the following matchers.


count
~~~~~

The ``count`` matcher tests the number of times the named user appears
in ``/etc/passwd``:

::

   its('count') { should eq 1 }


uid
~~~

The ``uid`` matcher tests if the user identifier in the test matches a
user identifier in ``/etc/passwd``:

::

   its('uid') { should eq 1234 }


username
~~~~~~~~

The ``username`` matcher tests if the user name in the test matches a
user name in ``/etc/passwd``:

::

   its('username') { should eq 'root' }


Examples
--------

The following examples show how to use this InSpec audit resource.

**Test usernames and UIDs**

::

   describe passwd do
     its('usernames') { should eq ['root', 'www-data'] }
     its('uids') { should eq [0, 33] }
   end

**Select one user and test for multiple occurrences**

::

   describe passwd.uid(0) do
     its('username') { should eq 'root' }
     its('count') { should eq 1 }
   end

   describe passwd.uid(33) do
     its('username') { should eq 'www-data' }
     its('count') { should eq 1 }
   end


pip
===

Use the ``pip`` InSpec audit resource to test packages that are
installed using the pip installer.


Syntax
------

A ``pip`` InSpec audit resource block declares a package and
(optionally) a package version:

::

   describe pip('Jinja2') do
     it { should be_installed }
   end

where

* ``'Jinja2'`` is the name of the package

* ``be_installed`` tests to see if the ``Jinja2`` package is installed


Matchers
--------

This InSpec audit resource has the following matchers.


be_installed
~~~~~~~~~~~~

The ``be_installed`` matcher tests if the named package is installed
on the system:

::

   it { should be_installed }


version
~~~~~~~

The ``version`` matcher tests if the named package version is on the
system:

::

   its('version') { should eq '1.2.3' }


Examples
--------

The following examples show how to use this InSpec audit resource.

**Test if Jinja2 is installed on the system**

::

   describe pip('Jinja2') do
     it { should be_installed }
   end

**Test if Jinja2 2.8 is installed on the system**

::

   describe pip('Jinja2') do
     it { should be_installed }
     its('version') { should eq '2.8' }
   end


port
====

Use the ``port`` InSpec audit resource to test basic port properties,
such as port, process, if it's listening.


Syntax
------

A ``port`` InSpec audit resource block declares a port, and then
depending on what needs to be tested, a process, protocol, process
identifier, and its state (is it listening?):

::

   describe port(514) do
     it { should be_listening }
     its('process') {should eq 'syslog'}
   end

where the ``process`` returns the process listening on port 514.


Matchers
--------

This InSpec audit resource has the following matchers.


be_listening
~~~~~~~~~~~~

The ``be_listening`` matcher tests if the port is listening for
traffic:

::

   it { should be_listening }


pid
~~~

The ``pid`` matcher tests the process identifier (PID):

::

   its('pid') { should eq '27808' }


processes
~~~~~~~~~

The ``process`` matcher tests if the named process is running on the
system:

::

   its('process') { should eq 'syslog' }


protocol
~~~~~~~~

The ``protocol`` matcher tests the Internet protocol: ICMP
(``'icmp'``), TCP (``'tcp'`` or ``'tcp6'``), or UDP (``'udp'`` or
``'udp6'``):

::

   its('protocol') { should eq 'tcp' }

or for the Internet Protocol version 6 (IPv6) protocol:

::

   its('protocol') { should eq 'tcp6' }


Examples
--------

The following examples show how to use this InSpec audit resource.

**Test port 80, listening with the TCP protocol**

::

   describe port(80) do
     it { should be_listening }
     its('protocol') {should eq 'tcp'}
   end

**Test port 80, listening with TCP version IPv6 protocol**

::

   describe port(80) do
     it { should be_listening }
     its('protocol') {should eq 'tcp6'}
   end

**Test that only secure ports accept requests**

::

   describe port(80) do
     it { should_not be_listening }
   end

   describe port(443) do
     it { should be_listening }
     its('protocol') {should eq 'tcp'}
   end


postgres_conf
=============

Use the ``postgres_conf`` InSpec audit resource to test the contents
of the configuration file for PostgreSQL, typically located at
``/etc/postgresql/<version>/main/postgresql.conf`` or
``/var/lib/postgres/data/postgresql.conf``, depending on the platform.


Syntax
------

A ``postgres_conf`` InSpec audit resource block declares one (or more)
settings in the ``postgresql.conf`` file, and then compares the
setting in the configuration file to the value stated in the test:

::

   describe postgres_conf('path') do
     its('setting') { should eq 'value' }
   end

where

* ``'setting'`` specifies a setting in the ``postgresql.conf`` file

* ``('path')`` is the non-default path to the ``postgresql.conf`` file
  (optional)

* ``should eq 'value'`` is the value that is expected


Matchers
--------

This InSpec audit resource has the following matchers.


setting
~~~~~~~

The ``setting`` matcher tests specific, named settings in the
``postgresql.conf`` file:

::

   its('setting') { should eq 'value' }

Use a ``setting`` matcher for each setting to be tested.


Examples
--------

The following examples show how to use this InSpec audit resource.

**Test the maximum number of allowed client connections**

::

   describe postgres_conf do
     its('max_connections') { should eq '5' }
   end

**Test system logging**

::

   describe postgres_conf do
     its('logging_collector') { should eq 'on' }
     its('log_connections') { should eq 'on' }
     its('log_disconnections') { should eq 'on' }
     its('log_duration') { should eq 'on' }
     its('log_hostname') { should eq 'on' }
     its('log_line_prefix') { should eq '%t %u %d %h' }
   end

**Test the port on which PostgreSQL listens**

::

   describe postgres_conf do
     its('port') { should eq '5432' }
   end

**Test the Unix socket settings**

::

   describe postgres_conf do
     its('unix_socket_directories') { should eq '.s.PGSQL.5432' }
     its('unix_socket_group') { should eq nil }
     its('unix_socket_permissions') { should eq '0770' }
   end

where ``unix_socket_group`` is set to the PostgreSQL default setting
(the group to which the server user belongs).


postgres_session
================

Use the ``postgres_session`` InSpec audit resource to test SQL
commands run against a PostgreSQL database.


Syntax
------

A ``postgres_session`` InSpec audit resource block declares the
username and password to use for the session, and then the command to
be run:

::

   sql = postgres_session('username', 'password')

   describe sql.query('SELECT * FROM pg_shadow WHERE passwd IS NULL;') do
     its('output') { should eq('') }
   end

where

* ``sql = postgres_session`` declares a username and password with
  permission to run the query

* ``sql.query('')`` contains the query to be run

* ``its('output') { should eq('') }`` compares the results of the
  query against the expected result in the test


Matchers
--------

This InSpec audit resource has the following matchers.


output
~~~~~~

The ``output`` matcher tests the results of the query:

::

   its('output') { should eq(/^0/) }


Examples
--------

The following examples show how to use this InSpec audit resource.

**Test the PostgreSQL shadow password**

::

   sql = postgres_session('my_user', 'password')

   describe sql.query('SELECT * FROM pg_shadow WHERE passwd IS NULL;') do
     its('output') { should eq('') }
   end

**Test for risky database entries**

::

   describe postgres_session('my_user', 'password').query('SELECT count (*)
                 FROM pg_language
                 WHERE lanpltrusted = 'f'
                 AND lanname!='internal'
                 AND lanname!='c';') do
     its('output') { should eq(/^0/) }
   end


process
=======

Use the ``processes`` InSpec audit resource to test properties for
programs that are running on the system.


Syntax
------

A ``processes`` InSpec audit resource block declares the name of the
process to be tested, and then declares one (or more) property/value
pairs:

::

   describe processes('process_name') do
     its('property_name') { should eq 'property_value' }
   end

where

* ``processes('process_name')`` must specify the name of a process
  that is running on the system

* Multiple properties may be tested; for each property to be tested,
  use an ``its('property_name')`` statement


Matchers
--------

This InSpec audit resource has the following matchers.


property_name
~~~~~~~~~~~~~

The ``property_name`` matcher tests the named property for the
specified value:

::

   its('property_name') { should eq 'property_value' }


Examples
--------

The following examples show how to use this InSpec audit resource.

**Test if the list length for the mysqld process is 1**

::

   describe processes('mysqld') do
     its('list.length') { should eq 1 }
   end

**Test if the init process is owned by the root user**

::

   describe processes('init') do
     its('user') { should eq 'root' }
   end

**Test if a high-priority process is running**

::

   describe processes('some_process') do
     its('state') { should eq 'R<' }
   end


registry_key
============

Use the ``registry_key`` InSpec audit resource to test key values in
the Microsoft Windows registry.


Syntax
------

A ``registry_key`` InSpec audit resource block declares the item in
the Microsoft Windows registry, the path to a setting under that item,
and then one (or more) name/value pairs to be tested:

::

   describe registry_key('registry_item', 'path\to\key') do
     its('name') { should eq 'value' }
   end

or:

::

   describe registry_key('path\to\key') do
     its('name') { should eq 'value' }
   end

where

* ``'registry_item'`` is a key in the Microsoft Windows registry
  (optional)

* ``'path\to\key'`` is the path in the Microsoft Windows registry

* ``('name')`` and ``'value'`` represent the name of the key and the
  value assigned to that key


Registry Key Path Separators
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A Microsoft Windows registry key can be used as a string in Ruby code,
such as when a registry key is used as the name of a recipe. In Ruby,
when a registry key is enclosed in a double-quoted string (``" "``),
the same backslash character (``\``) that is used to define the
registry key path separator is also used in Ruby to define an escape
character. Therefore, the registry key path separators must be escaped
when they are enclosed in a double-quoted string. For example, the
following registry key:

::

   HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Themes

may be encloused in a single-quoted string with a single backslash:

::

   'HKCU\SOFTWARE\path\to\key\Themes'

or may be enclosed in a double-quoted string with an extra backslash
as an escape character:

::

   "HKCU\\SOFTWARE\\path\\to\\key\\Themes"


Matchers
--------

This InSpec audit resource has the following matchers.


name
~~~~

The ``name`` matcher tests the value for the specified registry
setting:

::

   its('name') { should eq 'value' }


Examples
--------

The following examples show how to use this InSpec audit resource.

**Test the start time for the Schedule service**

::

   describe registry_key('Task Scheduler','HKEY_LOCAL_MACHINE\...\Schedule') do
     its('Start') { should eq 2 }
   end

where
``'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\Schedule'`` is
the full path to the setting.


script
======

Use the ``script`` InSpec audit resource to test a Windows PowerShell
script on the Microsoft Windows platform.


Syntax
------

A ``script`` InSpec audit resource block declares a script to be
tested, and then a command that should be part of that script:

::

   script = <<-EOH
     # you powershell script
   EOH

   describe script(script) do
     its('matcher') { should eq 'output' }
   end

where

* ``'script'`` must specify a Powershell script to be run

* ``'matcher'`` is one of ``exit_status``, ``stderr``, or ``stdout``

* ``'output'`` tests the output of the command run on the system
  versus the output value stated in the test


Matchers
--------

This InSpec audit resource has the following matchers.


exit_status
~~~~~~~~~~~

The ``exit_status`` matcher tests the exit status for the command:

::

   its('exit_status') { should eq 123 }


stderr
~~~~~~

The ``stderr`` matcher tests results of the command as returned in
standard error (stderr):

::

   its('stderr') { should eq 'error' }


stdout
~~~~~~

The ``stdout`` matcher tests results of the command as returned in
standard output (stdout):

::

   its('stdout') { should eq '/^1$/' }


Examples
--------

The following examples show how to use this InSpec audit resource.

**Get all groups of Administrator user**

::

   myscript = <<-EOH
     # find user
     $user = Get-WmiObject Win32_UserAccount -filter "Name = 'Administrator'"
     # get related groups
     $groups = $user.GetRelated('Win32_Group') | Select-Object -Property Caption, Domain, Name, LocalAccount, SID, SIDType, Status
     $groups | ConvertTo-Json
   EOH

   describe script(myscript) do
     its('stdout') { should_not eq '' }
   end


security_policy
===============

Use the ``security_policy`` InSpec audit resource to test security
policies on the Microsoft Windows platform.


Syntax
------

A ``security_policy`` InSpec audit resource block declares the name of
a security policy and the value to be tested:

::

   describe security_policy do
     its('policy_name') { should eq 'value' }
   end

where

* ``'policy_name'`` must specify a security policy

* ``{ should eq 'value' }`` tests the value of ``policy_name`` against
  the value declared in the test


Matchers
--------

This InSpec audit resource has the following matchers.


policy_name
~~~~~~~~~~~

The ``policy_name`` matcher must be the name of a security policy:

::

   its('SeNetworkLogonRight') { should eq '*S-1-5-11' }


Examples
--------

The following examples show how to use this InSpec audit resource.

**Verify that only the Administrators group has remote access**

::

   describe security_policy do
     its('SeRemoteInteractiveLogonRight') { should eq '*S-1-5-32-544' }
   end


service
=======

Use the ``service`` InSpec audit resource to test if the named service
is installed, running and/or enabled.


Syntax
------

A ``service`` InSpec audit resource block declares the name of a
service and then one (or more) matchers to test the state of the
service:

::

   describe service('service_name') do
     it { should be_installed }
     it { should be_enabled }
     it { should be_running }
   end

where

* ``('service_name')`` must specify a service name

* ``be_installed``, ``be_enabled``, and ``be_running`` are valid
  matchers for this InSpec audit resource


Matchers
--------

This InSpec audit resource has the following matchers.


be_enabled
~~~~~~~~~~

The ``be_enabled`` matcher tests if the named service is enabled:

::

   it { should be_enabled }


be_installed
~~~~~~~~~~~~

The ``be_installed`` matcher tests if the named service is installed:

::

   it { should be_installed }


be_running
~~~~~~~~~~

The ``be_running`` matcher tests if the named service is running:

::

   it { should be_running }


Examples
--------

The following examples show how to use this InSpec audit resource.

**Test if the postgresql service is both running and enabled**

::

   describe service('postgresql') do
     it { should be_enabled }
     it { should be_running }
   end

**Test if the mysql service is both running and enabled**

::

   describe service('mysqld') do
     it { should be_enabled }
     it { should be_running }
   end

**Test if ClamAV (an antivirus engine) is installed and running**

::

   describe package('clamav') do
     it { should be_installed }
     its('version') { should eq '0.98.7' }
   end

   describe service('clamd') do
     it { should_not be_enabled }
     it { should_not be_installed }
     it { should_not be_running }
   end


ssh_config
==========

Use the ``ssh_config`` InSpec audit resource to test OpenSSH SSH
client configuration data located at ``/etc/ssh/ssh_config`` on Linux
and UNIX platforms.


Syntax
------

A ``ssh_config`` InSpec audit resource block declares the client
OpenSSH configuration data to be tested:

::

   describe ssh_config('path') do
     its('name') { should include('foo') }
   end

where

* ``name`` is a configuration setting in ``ssh_config``

* ``('path')`` is the non-default ``/path/to/ssh_config``

* ``{ should include('foo') }`` tests the value of ``name`` as read
  from ``ssh_config`` versus the value declared in the test


Matchers
--------

This InSpec audit resource has the following matchers.


name
~~~~

The ``name`` matcher tests the value of ``name`` as read from
``ssh_config`` versus the value declared in the test:

::

   its('name') { should eq 'foo' }

or:

::

   its('name') { should include('bar') }


Examples
--------

The following examples show how to use this InSpec audit resource.

**Test SSH configuration settings**

::

   describe ssh_config do
     its('cipher') { should contain '3des' }
     its('port') { should '22' }
     its('hostname') { should include('example.com') }
   end

**Test which variables from the local environment are sent to the
server**

::

   describe ssh_config do
     its('owner') { should eq 'root' }
     its('mode') { should eq 644 }
   end

**Test owner and group permissions**

::

   describe ssh_config do
     its('owner') { should eq 'root' }
     its('mode') { should eq 644 }
   end

**Test SSH configuration**

::

   describe ssh_config do
     its('Host') { should eq '*' }
     its('Tunnel') { should eq nil }
     its('SendEnv') { should eq 'LANG LC_*' }
     its('HashKnownHosts') { should eq 'yes' }
   end


sshd_config
===========

Use the ``sshd_config`` InSpec audit resource to test configuration
data for the OpenSSH daemon located at ``/etc/ssh/sshd_config`` on
Linux and UNIX platforms. sshd---the OpenSSH daemon---listens on
dedicated ports, starts a daemon for each incoming connection, and
then handles encryption, authentication, key exchanges, command
executation, and data exchanges.


Syntax
------

A ``sshd_config`` InSpec audit resource block declares the client
OpenSSH configuration data to be tested:

::

   describe sshd_config('path') do
     its('name') { should include('foo') }
   end

where

* ``name`` is a configuration setting in ``sshd_config``

* ``('path')`` is the non-default ``/path/to/sshd_config``

* ``{ should include('foo') }`` tests the value of ``name`` as read
  from ``sshd_config`` versus the value declared in the test


Matchers
--------

This InSpec audit resource has the following matchers.


name
~~~~

The ``name`` matcher tests the value of ``name`` as read from
``sshd_config`` versus the value declared in the test:

::

   its('name') { should eq 'foo' }

or:

::

   its('name') {should include('bar') }


Examples
--------

The following examples show how to use this InSpec audit resource.

**Test which variables may be sent to the server**

::

   describe sshd_config do
     its('AcceptEnv') { should include('GORDON_SERVER') }
   end

**Test for IPv6-only addresses**

::

   describe sshd_config do
     its('AddressFamily') { should eq 'inet6' }
   end

**Test the Protocol setting**

::

   describe sshd_config do
     its('Protocol') { should eq '2' }
   end

**Test for approved, strong ciphers**

::

   describe sshd_config do
     its('Ciphers') { should eq('chacha20-poly1305@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr') }
   end

**Test SSH protocols**

::

   describe sshd_config do
     its('Port') { should eq '22' }
     its('UsePAM') { should eq 'yes' }
     its('ListenAddress') { should eq nil }
     its('HostKey') { should eq [
         '/etc/ssh/ssh_host_rsa_key',
         '/etc/ssh/ssh_host_dsa_key',
         '/etc/ssh/ssh_host_ecdsa_key',
       ] }
   end


user
====

Use the ``user`` InSpec audit resource to test user profiles,
including the groups to which they belong, the frequency of required
password changes, the directory paths to home and shell.


Syntax
------

A ``user`` InSpec audit resource block declares a user name, and then
one (or more) matchers:

::

   describe user('root') do
     it { should exist }
     its('uid') { should eq 1234 }
     its('gid') { should eq 1234 }
     its('group') { should eq 'root' }
     its('groups') { should eq ['root', 'other']}
     its('home') { should eq '/root' }
     its('shell') { should eq '/bin/bash' }
     its('mindays') { should eq 0 }
     its('maxdays') { should eq 90 }
     its('warndays') { should eq 8 }
   end

where

* ``('root')`` is the user to be tested

* ``it { should exist }`` tests if the user exists

* ``gid``, ``group``, ``groups``, ``home``, ``maxdays``, ``mindays``,
  ``shell``, ``uid``, and ``warndays`` are valid matchers for this
  InSpec audit resource


Matchers
--------

This InSpec audit resource has the following matchers.


exist
~~~~~

The ``exist`` matcher tests if the named user exists:

::

   it { should exist }


gid
~~~

The ``gid`` matcher tests the group identifier:

::

   its('gid') { should eq 1234 } }

where ``1234`` represents the user identifier.


group
~~~~~

The ``group`` matcher tests the group to which the user belongs:

::

   its('group') { should eq 'root' }

where ``root`` represents the group.


groups
~~~~~~

The ``groups`` matcher tests two (or more) groups to which the user
belongs:

::

   its('groups') { should eq ['root', 'other']}


home
~~~~

The ``home`` matcher tests the home directory path for the user:

::

   its('home') { should eq '/root' }


maxdays
~~~~~~~

The ``maxdays`` matcher tests the maximum number of days between
password changes:

::

   its('maxdays') { should eq 99 }

where ``99`` represents the maximum number of days.


mindays
~~~~~~~

The ``mindays`` matcher tests the minimum number of days between
password changes:

::

   its('mindays') { should eq 0 }

where ``0`` represents the maximum number of days.


shell
~~~~~

The ``shell`` matcher tests the path to the default shell for the
user:

::

   its('shell') { should eq '/bin/bash' }


uid
~~~

The ``uid`` matcher tests the user identifier:

::

   its('uid') { should eq 1234 } }

where ``1234`` represents the user identifier.


warndays
~~~~~~~~

The ``warndays`` matcher tests the number of days a user is warned
before a password must be changed:

::

   its('warndays') { should eq 5 }

where ``5`` represents the number of days a user is warned.


Examples
--------

The following examples show how to use this InSpec audit resource.

**Verify available users for the MySQL server**

::

   describe user('root') do
     it { should exist }
     it { should belong_to_group 'root' }
     its('uid') { should eq 0 }
     its('groups') { should eq ['root'] }
   end

   describe user('mysql') do
    it { should_not exist }
   end

**Test users on multiple platforms**

The Nginx user is typically ``www-data``, but on CentOS it's
``nginx``. The following example shows how to test for the Nginx user
with a single test, but accounting for all platforms:

::

   web_user = 'www-data'
   web_user = 'nginx' if os[:family] == 'centos'

   describe user(web_user) do
     it { should exist }
   end


windows_feature
===============

Use the ``windows_feature`` InSpec audit resource to test features on
Microsoft Windows. The ``Get-WindowsFeature`` cmdlet returns the
following values: ``Property Name``, ``DisplayName``, ``Description``,
``Installed``, and ``InstallState``, returned as a JSON object similar
to:

::

   {
     "Name": "XPS-Viewer",
     "DisplayName": "XPS Viewer",
     "Description": "The XPS Viewer reads, sets permissions, and digitally signs XPS documents.",
     "Installed": false,
     "InstallState": 0
   }


Syntax
------

A ``windows_feature`` InSpec audit resource block declares the name of
the Microsoft Windows feature, tests if that feature is installed, and
then returns information about that feature:

::

   describe windows_feature('feature_name') do
     it { should be_installed }
   end

where

* ``('feature_name')`` must specify a Microsoft Windows feature name,
  such as ``DHCP Server`` or ``IIS-Webserver``

* ``be_installed`` is a valid matcher for this InSpec audit resource


Matchers
--------

This InSpec audit resource has the following matchers.


be_installed
~~~~~~~~~~~~

The ``be_installed`` matcher tests if the named Microsoft Windows
feature is installed:

::

   it { should be_installed }


Examples
--------

The following examples show how to use this InSpec audit resource.

**Test the DHCP Server feature**

::

   describe windows_feature('DHCP Server') do
     it{ should be_installed }
   end


yaml
====

Use the ``yaml`` InSpec audit resource to test configuration data in a
YAML file.


Syntax
------

A ``yaml`` InSpec audit resource block declares the configuration data
to be tested:

::

   describe yaml do
     its('name') { should eq 'foo' }
   end

where

* ``name`` is a configuration setting in a YAML file

* ``should eq 'foo'`` tests a value of ``name`` as read from a YAML
  file versus the value declared in the test


Matchers
--------

This InSpec audit resource has the following matchers.


name
~~~~

The ``name`` matcher tests the value of ``name`` as read from a YAML
file versus the value declared in the test:

::

   its('name') { should eq 'foo' }


Examples
--------

The following examples show how to use this InSpec audit resource.

**Test a kitchen.yml file driver**

::

   describe yaml('.kitchen.yaml') do
     its('driver.name') { should eq('vagrant') }
   end


yum
===

Use the ``yum`` InSpec audit resource to test packages in the Yum
repository.


Syntax
------

A ``yum`` InSpec audit resource block declares a package repo, tests
if the package repository is present, and if it that package
repository is a valid package source (i.e. "is enabled"):

::

   describe yum.repo('name') do
     it { should exist }
     it { should be_enabled }
   end

where

* ``repo('name')`` is the (optional) name of a package repo, using
  either a full identifier (``'updates/7/x86_64'``) or a short
  identifier (``'updates'``)


Matchers
--------

This InSpec audit resource has the following matchers.


be_enabled
~~~~~~~~~~

The ``be_enabled`` matcher tests if the package repository is a valid
package source:

::

   it { should be_enabled }


exist
~~~~~

The ``exist`` matcher tests if the package repository exists:

::

   it { should exist }


repo('name')
~~~~~~~~~~~~

The ``repo('name')`` matcher names a specific package repository:

::

   describe yum.repo('epel') do
     ...
   end


repos
~~~~~

The ``repos`` matcher tests if a named repo, using either a full
identifier (``'updates/7/x86_64'``) or a short identifier
(``'updates'``), is included in the Yum repo:

::

   its('repos') { should include 'some_repo' }


Examples
--------

The following examples show how to use this InSpec audit resource.

**Test if the yum repo exists**

::

   describe yum do
     its('repos') { should exist }
   end

**Test if the 'base/7/x86_64' repo exists and is enabled**

::

   describe yum do
     its('repos') { should include 'base/7/x86_64' }
     its('epel') { should exist }
     its('epel') { should be_enabled }
   end

**Test if a specific yum repo exists**

::

   describe yum.repo('epel') do
     it { should exist }
     it { should be_enabled }
   end
