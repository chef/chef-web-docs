=====================================================
InSpec Reference
=====================================================

.. include:: ../../includes_inspec/includes_inspec.rst

See below for more information about each InSpec audit resource, its related matchers, and examples of how to use it in a recipe.


Custom Audit Resources
=====================================================
InSpec provides a mechanism for defining custom audit resources. These become available with their respective names and provide a simple way to extend functionality in compliance profiles.

Cookbook Location
-----------------------------------------------------
Resources may be added to profiles in the ``/libraries`` directory in a cookbook::

   ...
   ├── libraries
   │   └── gordon_config.rb

Syntax
-----------------------------------------------------
A custom audit resource takes the following form:

.. code-block:: ruby

   class Tiny < Inspec.resource(1)
     name 'tiny'
   end

Custom audit resources are written as a regular Ruby ``class`` which inherits from ``Inspec.resource``. The number (``1``) specifies the version of InSpec this custom audit resource targets. As InSpec evolves, this interface may change and may require a higher version number.

Properties
-----------------------------------------------------
A custom audit resource has the following properties:

``name``
   Required. The identifier of the custom audit resource.

``desc``
   Optional. A description of the custom audit resource.

``example``
   Optional. An example usage of the custom audit resource.

Methods
-----------------------------------------------------
A custom audit resource has the following methods are available:

``inspec``
   Contains a registry of all other resources to interact with the operating system or target in general.

``skip_resource``
   A resource may call this method to indicate that requirements aren't met. All tests that use this resource will be marked as ``skipped``.

Example
-----------------------------------------------------
The following example shows a full resource using attributes and methods to provide simple access to a configuration file:

.. code-block:: ruby

   class GordonConfig < Inspec.resource(1)
     name 'gordon_config'
   
     desc '
       Resource description ...
     '
   
     example '
       describe gordon_config do
         its("signal") { should eq "on" }
       end
     '
   
     # Load the configuration file on initialization
     def initialize(path = nil)
       @path = path || '/etc/gordon.conf'
       @params = SimpleConfig.new( read_content )
     end
   
     # Expose all parameters of the configuration file.
     def method_missing(name)
       @params[name]
     end
   
     private
   
     def read_content
       f = inspec.file(@path)
       # Test if the path exist and that it's a file
       if f.file?
         # Retrieve the file's contents
         f.content
       else
         # If the file doesn't exist, skip all tests that use gordon_config
         skip_resource "Can't read config from #{@path}."
       end
     end
   end



About the InSpec DSL
=====================================================
The InSpec DSL is a Ruby-based DSL for writing audit controls, which includes audit resources that you can invoke. Core and custom resources are written as regular Ruby classes which inherit from ``Inspec.resource``.

Assuming the following JSON file exists on a node and needs to be tested:

.. code-block:: json

    {
      "keys":[
        {"username":"john", "key":"/opt/keys/johnd.key"},
        {"username":"jane", "key":"/opt/keys/janed.key"},
        {"username":"sunny ", "key":"/opt/keys/sunnym.key"}
      ]
    }

The following example shows how to use pure Ruby code (variables, loops, conditionals, regular expressions, etc.) to run a few tests against the above JSON file:

.. code-block:: ruby

    control 'check-interns' do
      # use the json inspec resource to get the file
      json_obj = json('/opt/keys/interns.json')
      describe json_obj do
        its('keys') { should_not eq nil }
      end
      if json_obj['keys']
        # loop over the keys array
        json_obj['keys'].each do |intern|
          username = intern['username'].strip
          # check for white spaces chars in usernames
          describe username do
            it { should_not match(/\s/) }
          end
          # check key file owners and permissions
          describe file(intern['key']) do
            it { should be_owned_by username }
            its('mode') { should cmp '0600' }
          end
        end
      end
    end

Ruby Execution
-----------------------------------------------------
Ruby code used in custom audit resources and controls is executed on the system that runs InSpec. This allows InSpec to work without requiring Ruby and RubyGems on a remote target. For example, using ``ls`` or ``system('ls')`` will result in the ``ls`` command being run locally and not on the target(remote) system. In order to process the output of ``ls`` executed on the target system, use ``command('ls')`` or ``powershell('ls')``.

Similarly, use ``file(PATH)`` to access files or directories from remote systems in your tests.

Debug Controls
-----------------------------------------------------
The following example shows an InSpec control that uses Ruby variables to instantiate an InSpec resource once, and then use that content in multipLe tests:

.. code-block:: ruby

    control 'check-perl' do
      impact 0.3
      title 'Check perl compiled options and permissions'
      perl_out = command('perl -V')
      #require 'pry'; binding.pry;
      describe perl_out do
        its('exit_status') { should eq 0 }
        its('stdout') { should match (/USE_64_BIT_ALL/) }
        its('stdout') { should match (/useposix=true/) }
        its('stdout') { should match (/-fstack-protector/) }
      end

      # extract an array of include directories
      perl_inc = perl_out.stdout.partition('@INC:').last.strip.split("\n")
      # ensure include directories are only writable by 'owner'
      perl_inc.each do |path|
        describe directory(path.strip) do
          it { should_not be_writable.by('group') }
          it { should_not be_writable.by('other') }
        end
      end
    end

Use Pry
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The previous example comments out the ``require 'pry'; binding.pry;`` line. Remove the ``#`` prefix, and then re-run the control. The execution of the control will stop at that line and open a Pry shell from which troubleshooting, printing variables, viewing available methods, etc. may be one. For example:

.. code-block:: ruby

    [1] pry> perl_out.exit_status
    => 0
    [2] pry> perl_out.stderr
    => ""
    [3] pry> ls perl_out
    Inspec::Plugins::Resource#methods: inspect
    Inspec::Resources::Cmd#methods: command  exist?  exit_status  result  stderr  stdout  to_s
    Inspec::Plugins::ResourceCommon#methods: resource_skipped  skip_resource
    Inspec::Resource::Registry::Command#methods: inspec
    instance variables: @__backend_runner__  @__resource_name__  @command  @result
    [4] pry> perl_out.stdout.partition('@INC:').last.strip.split("\n")
    => ["/Library/Perl/5.18/darwin-thread-multi-2level",
     "    /Library/Perl/5.18",
    ...REDACTED...
    [5] pry> exit    # or abort

Use inspec shell
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Use Pry inside both the controls and resources. Similarly, for development and testing, use ``inspec shell`` which is based on Pry, for example:

.. code-block:: none

    $ inspec shell
    Welcome to the interactive InSpec Shell
    To find out how to use it, type: help

    inspec> command('ls /home/gordon/git/inspec/docs').stdout
    => "ctl_inspec.rst\ndsl_inspec.rst\ndsl_resource.rst\n"
    inspec> command('ls').stdout.split("\n")
    => ["ctl_inspec.rst", "dsl_inspec.rst", "dsl_resource.rst"]

    inspec> help command
    Name: command

    Description:
    Use the command InSpec audit resource to test an arbitrary command that is run on the system.

    Example:
    describe command('ls -al /') do
      it { should exist }
      its('stdout') { should match /bin/ }
      its('stderr') { should eq '' }
      its('exit_status') { should eq 0 }
    end


Common Matchers
=====================================================
InSpec uses matchers to help compare resource values to expectations. The following matchers are available for every InSpec audit resource:

* ``be``
* ``cmp``
* ``eq``
* ``include``
* ``match``


be
-----------------------------------------------------
Use the ``be`` matcher to use a comparison operator---``=`` (equal to), ``>`` (greater than), ``<`` (less than), ``>=`` (greater than or equal to), and ``<=`` (less than or equal to)---to compare two values: ``its('value') { should be >= value }``, ``its('value') { should be < value }``, and so on.

cmp
-----------------------------------------------------
Use the ``cmp`` matcher compare two values, such as comparing strings to numbers, comparing a single value to an array of values, comparing an array of strings to a regular expression, improving the printing of octal values, and comparing while ignoring case sensitivity.

**Compare single value to array**

Single value vs. array:

.. code-block:: ruby

   describe passwd.uids(0) do
     its('users') { should cmp 'root' }
     its('users') { should cmp ['root'] }
   end

**Compare strings and regular expressions**

String vs. regular expression:

.. code-block:: ruby

   describe auditd_conf do
     its('log_format') { should cmp /raw/i }
   end


**Compare strings and numbers**

Strings vs. numbers:

.. code-block:: ruby

   describe sshd_config do
     its('Protocol') { should eq '2' }
   end

vs:

.. code-block:: ruby

   describe sshd_config do
     its('Protocol') { should cmp '2' }
     its('Protocol') { should cmp 2 }
   end


**Ignoring case sensitivity**

Ignore case sensitivity:

.. code-block:: ruby

   describe auditd_conf do
     its('log_format') { should cmp 'raw' }
     its('log_format') { should cmp 'RAW' }
   end

**Printing octals**

Improve printing of octal values:

.. code-block:: ruby

   describe file('/proc/cpuinfo') do
     its('mode') { should cmp '0345' }
   end

prints something similar to:

.. code-block:: bash

   expected: 0345
   got: 0444


eq
-----------------------------------------------------
Use the ``eq`` matcher to test the equality of two values: ``its('Port') { should eq '22' }``.

.. note:: ``its('Port') { should eq 22 }`` will fail because ``22`` is not a string value! Use the ``cmp`` matcher for less restrictive value comparisons.

include
-----------------------------------------------------
Use the ``include`` matcher to verify that a string value is included in a list: ``its('list') { should include 'string' }``.

match
-----------------------------------------------------
Use the ``match`` matcher to check if a string matches a regular expression: ``its('string') { should_not match /regex/ }``.


os[:family] Symbols
=====================================================
Use ``os[:family]`` to enable more granular testing of platforms, platform names, architectures, and releases.

Use any of the following platform-specific symbols to test for specific platforms:

* ``:aix``
* ``:bsd`` For platforms that are part of the BSD family: ``:darwin``, ``:freebsd``, ``:netbsd``, and ``:openbsd``.
* ``:debian``
* ``:hpux``
* ``:linux``. For platforms that are part of the Linux family: ``:alpine``, ``:amazon``, ``:arch``, ``:coreos``, ``:exherbo``, ``:fedora``, ``:gentoo``, and ``:slackware``.
* ``:redhat``
* ``:solaris``. For platforms that are part of the Solaris family: ``:nexentacore``, ``:omnios``, ``:openindiana``, ``:opensolaris``, and ``:smartos``.
* ``:suse``
* ``:unix``
* ``:windows``

For example, both of the following tests should have the same result:

.. code-block:: ruby

   if os[:family] == 'debian'
     describe port(69) do
       its('processes') { should include 'in.tftpd' }
     end
   elsif os[:family] == 'rhel'
     describe port(69) do
       its('processes') { should include 'xinetd' }
     end
   end

.. code-block:: ruby

   if os[:debian]
     describe port(69) do
       its('processes') { should include 'in.tftpd' }
     end
   elsif os[:rhel]
     describe port(69) do
       its('processes') { should include 'xinetd' }
     end
   end


apache_conf
=====================================================
Use the ``apache_conf`` InSpec audit resource to test the configuration settings for Apache. This file is typically located under ``/etc/apache2`` on the Debian and Ubuntu platforms and under ``/etc/httpd`` on the Fedora, CentOS, Red Hat Enterprise Linux, and Arch Linux platforms. The configuration settings may vary significantly from platform to platform.

Syntax
-----------------------------------------------------
An ``apache_conf`` InSpec audit resource block declares configuration settings that should be tested:

.. code-block:: ruby

   describe apache_conf('path') do
     its('setting_name') { should eq 'value' }
   end

where

* ``'setting_name'`` is a configuration setting defined in the Apache configuration file
* ``('path')`` is the non-default path to the Apache configuration file
* ``{ should eq 'value' }`` is the value that is expected

Matchers
-----------------------------------------------------
This InSpec audit resource matches any service that is listed in the Apache configuration file:

.. code-block:: ruby

   its('PidFile') { should_not eq '/var/run/httpd.pid' }

or:

.. code-block:: ruby

   its('Timeout') { should eq 300 }

For example:

.. code-block:: ruby

   describe apache_conf do
     its('MaxClients') { should eq 100 }
     its('Listen') { should eq '443'}
   end

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test for blocking .htaccess files on CentOS**

.. To test for blocking .htaccess files on CentOS:

.. code-block:: ruby

   describe apache_conf do
     its('AllowOverride') { should eq 'None' }
   end

**Test ports for SSL**

.. To test ports for SSL:

.. code-block:: ruby

   describe apache_conf do
     its('Listen') { should eq '443'}
   end


apt
=====================================================
Use the ``apt`` InSpec audit resource to verify Apt repositories on the Debian and Ubuntu platforms, and also PPA repositories on the Ubuntu platform.

Syntax
-----------------------------------------------------
An ``apt`` InSpec audit resource block tests the contents of Apt and PPA repositories:

.. code-block:: ruby

   describe apt('path') do
     it { should exist }
     it { should be_enabled }
   end

where

* ``apt('path')`` must specify an Apt or PPA repository
* ``('path')`` may be an ``http://`` address, a ``ppa:`` address, or a short ``repo-name/ppa`` address
* ``exist`` and ``be_enabled`` are a valid matchers for this InSpec audit resource

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

be_enabled
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``be_enabled`` matcher tests if a package exists in the repository:

.. code-block:: ruby

   it { should be_enabled }

exist
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``exist`` matcher tests if a package exists on the system:

.. code-block:: ruby

   it { should exist }

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test if apt repository exists and is enabled**

.. To verify that a repository exists and is enabled:

.. code-block:: ruby

   describe apt('http://ppa.launchpad.net/juju/stable/ubuntu') do
     it { should exist }
     it { should be_enabled }
   end

**Verify that a PPA repository exists and is enabled**

.. To test if a PPA repository exists and is enabled:

.. code-block:: ruby

   describe apt('ppa:nginx/stable') do
     it { should exist }
     it { should be_enabled }
   end

**Verify that a repository is not present**

.. To verify that a repository is not present:

.. code-block:: ruby

   describe apt('ubuntu-wine/ppa') do
     it { should_not exist }
     it { should_not be_enabled }
   end


audit_policy
=====================================================
Use the ``audit_policy`` InSpec audit resource to test auditing policies on the Microsoft Windows platform. An auditing policy is a category of security-related events to be audited. Auditing is disabled by default and may be enabled for categories like account management, logon events, policy changes, process tracking, privilege use, system events, or object access. For each auditing category property that is enabled, the auditing level may be set to ``No Auditing``, ``Not Specified``, ``Success``, ``Success and Failure``, or ``Failure``.

Syntax
-----------------------------------------------------
An ``audit_policy`` InSpec audit resource block declares a parameter that belongs to an audit policy category or subcategory:

.. code-block:: ruby

   describe audit_policy do
     its('parameter') { should eq 'value' }
   end

where

* ``'parameter'`` must specify a parameter 
* ``'value'`` must be one of ``No Auditing``, ``Not Specified``, ``Success``, ``Success and Failure``, or ``Failure``

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_no_matchers.rst

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test that a parameter is not set to "No Auditing"**

.. To test that a parameter is not set to "No Auditing":

.. code-block:: ruby

   describe audit_policy do
     its('Other Account Logon Events') { should_not eq 'No Auditing' }
   end

**Test that a parameter is set to "Success"**

.. To test that a parameter is set to "Success":

.. code-block:: ruby

   describe audit_policy do
     its('User Account Management') { should eq 'Success' }
   end


auditd_conf
=====================================================
Use the ``auditd_conf`` InSpec audit resource to test the configuration settings for the audit daemon. This file is typically located under ``/etc/audit/auditd.conf'`` on UNIX and Linux platforms.

Syntax
-----------------------------------------------------
A ``auditd_conf`` InSpec audit resource block declares configuration settings that should be tested:

.. code-block:: ruby

   describe auditd_conf('path') do
     its('keyword') { should cmp 'value' }
   end

where

* ``'keyword'`` is a configuration setting defined in the ``auditd.conf`` configuration file
* ``('path')`` is the non-default path to the ``auditd.conf`` configuration file
* ``{ should cmp 'value' }`` is the value that is expected

Matchers
-----------------------------------------------------
This InSpec audit resource matches any keyword that is listed in the ``auditd.conf`` configuration file. Option names and values are case-insensitive:

.. code-block:: ruby

   its('log_format') { should cmp 'raw' }

or:

.. code-block:: ruby

   its('max_log_file') { should cmp 6 }

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test the auditd.conf file**

.. To test the auditd.conf file:

.. code-block:: ruby

   describe auditd_conf do
     its('log_file') { should cmp '/full/path/to/file' }
     its('log_format') { should cmp 'raw' }
     its('flush') { should cmp 'none' }
     its('freq') { should cmp 1 }
     its('num_logs') { should cmp 0 }
     its('max_log_file') { should cmp 6 }
     its('max_log_file_action') { should cmp 'email' }
     its('space_left') { should cmp 2 }
     its('action_mail_acct') { should cmp 'root' }
     its('space_left_action') { should cmp 'email' }
     its('admin_space_left') { should cmp 1 }
     its('admin_space_left_action') { should cmp 'halt' }
     its('disk_full_action') { should cmp 'halt' }
     its('disk_error_action') { should cmp 'halt' }
   end


auditd_rules
=====================================================
Use the ``auditd_rules`` InSpec audit resource to test the rules for logging that exist on the system. The ``audit.rules`` file is typically located under ``/etc/audit/`` and contains the list of rules that define what is captured in log files.

.. note:: This resource uses ``auditctl`` to query the run-time ``auditd`` rules setup, which may be different from ``audit.rules``.

Syntax
-----------------------------------------------------
An ``auditd_rules`` InSpec audit resource block declares one (or more) rules to be tested, and then what that rule should do. The syntax depends on the version of ``audit``:


For ``audit`` >= 2.3:

.. code-block:: ruby

   describe auditd_rules do
     its('lines') { should contain_match(rule) }
   end

For ``audit`` < 2.3:

.. code-block:: ruby

   describe audit_daemon_rules do
     its("LIST_RULES") {
       rule
     }
   end

For example:

.. code-block:: ruby

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

.. code-block:: ruby

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
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test if a rule contains a matching element that is identified by a regular expression**

.. To test if a rule contains a matching element that is identified by a regular expression:


For ``audit`` >= 2.3:

.. code-block:: ruby

   describe auditd_rules do
     its('lines') { should contain_match(%r{-w /etc/ssh/sshd_config/}) }
   end

For ``audit`` < 2.3:

.. code-block:: ruby

   describe audit_daemon_rules do
     its("LIST_RULES") {
       should contain_match(/^exit,always arch=.*\
       key=time-change\
       syscall=adjtimex,settimeofday/)
     }
   end

**Query the audit daemon status**

.. To query the audit daemon status:

.. code-block:: ruby

   describe auditd_rules.status('backlog') do
     it { should cmp 0 }
   end

**Query properties of rules targeting specific syscalls or files**

.. To query properties of rules targeting specific syscalls or files:

.. code-block:: ruby

   describe auditd_rules.syscall('open').action do
     it { should eq(['always']) }
   end

   describe auditd_rules.key('sshd_config') do
     its('permissions') { should contain_match(/x/) }
   end

Filters may be chained. For example:

.. code-block:: ruby

   describe auditd_rules.syscall('open').action('always').list do
     it { should eq(['exit']) }
   end


bash
=====================================================

Use the ``bash`` InSpec audit resource to test an arbitrary command that is run on the system using a Bash script.

Syntax
-----------------------------------------------------
A ``command`` InSpec audit resource block declares a command to be run, one (or more) expected outputs, and the location to which that output is sent:

.. code-block:: ruby

   describe bash('command') do
     it { should exist }
     its('matcher') { should eq 'output' }
   end

where

* ``'command'`` must specify a command to be run
* ``'matcher'`` is one of ``exit_status``, ``stderr``, or ``stdout``
* ``'output'`` tests the output of the command run on the system versus the output value stated in the test

For example:

.. code-block:: ruby

   describe bash('ls -al /') do
     its('stdout') { should match /bin/ }
     its('stderr') { should eq '' }
     its('exit_status') { should eq 0 }
   end

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

exist
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``exist`` matcher tests if a command may be run on the system:

.. code-block:: ruby

   it { should exist }

exit_status
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``exit_status`` matcher tests the exit status for the command:

.. code-block:: ruby

   its('exit_status') { should eq 0 }

stderr
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``stderr`` matcher tests results of the command as returned in standard error (stderr):

.. code-block:: ruby

   its('stderr') { should eq '' }

stdout
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``stdout`` matcher tests results of the command as returned in standard output (stdout).

.. code-block:: ruby

   its('stdout') { should match /bin/ }

Examples
-----------------------------------------------------
None.


bond
=====================================================
Use the ``bond`` InSpec audit resource to test a logical, bonded network interface (i.e. "two or more network interfaces aggregated into a single, logical network interface"). On Linux platforms, any value in the ``/proc/net/bonding`` directory may be tested.

Syntax
-----------------------------------------------------
A ``bond`` InSpec audit resource block declares a bonded network interface, and then specifies the properties of that bonded network interface to be tested:

.. code-block:: ruby

   describe bond('name') do
     it { should exist }
   end

where

* ``'name'`` is the name of the bonded network interface
* ``{ should exist }`` is a valid matcher for this InSpec audit resource

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

content
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``content`` matcher tests if contents in the file that defines the bonded network interface match the value specified in the test. The values of the ``content`` matcher are arbitrary:

.. code-block:: ruby

   its('content') { should match('value') }

exist
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``exist`` matcher tests if the bonded network interface is available:

.. code-block:: ruby

   it { should exist }

have_interface
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``have_interface`` matcher tests if the bonded network interface has one (or more) secondary interfaces:

.. code-block:: ruby

   it { should have_interface }

interfaces
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``interfaces`` matcher tests if the named secondary interfaces are available:

.. code-block:: ruby

   its('interfaces') { should eq ['eth0', 'eth1', ...] }

params
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``params`` matcher tests arbitrary parameters for the bonded network interface:

.. code-block:: ruby

   its('params') { should eq 'value' }

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test if eth0 is a secondary interface for bond0**

.. To test if eth0 is a secondary interface for bond0:

.. code-block:: ruby

   describe bond('bond0') do
     it { should exist }
     it { should have_interface 'eth0' }
   end

**Test parameters for bond0**

.. To test parameters for bond0:

.. code-block:: ruby

   describe bond('bond0') do
     its('Bonding Mode') { should eq 'IEEE 802.3ad Dynamic link aggregation' }
     its('Transmit Hash Policy') { should eq 'layer3+4 (1)' }
     its('MII Status') { should eq 'up' }
     its('MII Polling Interval (ms)') { should eq '100' }
     its('Up Delay (ms)') { should eq '0' }
     its('Down Delay (ms)') { should eq '0' }
   end


bridge
=====================================================
Use the ``bridge`` InSpec audit resource to test basic network bridge properties, such as name, if an interface is defined, and the associations for any defined interface.

* On Linux platforms, any value in the ``/sys/class/net/{interface}/bridge`` directory may be tested
* On the Microsoft Windows platform, the ``Get-NetAdapter`` cmdlet is associated with the ``Get-NetAdapterBinding`` cmdlet and returns the ``ComponentID ms_bridge`` value as a JSON object

Syntax
-----------------------------------------------------
A ``bridge`` InSpec audit resource block declares the bridge to be tested and what interface it should be associated with:

.. code-block:: ruby

   describe bridge('br0') do
     it { should exist }
     it { should have_interface 'eth0' }
   end

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

exist
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``exist`` matcher tests if the network bridge is available:

.. code-block:: ruby

   it { should exist }

have_interface
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``have_interface`` matcher tests if the named interface is defined for the network bridge:

.. code-block:: ruby

   it { should have_interface 'eth0' }

interfaces
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``interfaces`` matcher tests if the named interface is present:

.. code-block:: ruby

   its('interfaces') { should eq 'foo' }
   its('interfaces') { should eq 'bar' }
   its('interfaces') { should include('foo') }

.. 
.. Examples
.. -----------------------------------------------------
.. The following examples show how to use this InSpec resource.
.. 
.. **xxxxx** 
.. 
.. xxxxx
.. 
.. **xxxxx** 
.. 
.. xxxxx
.. 


command
=====================================================
Use the ``command`` InSpec audit resource to test an arbitrary command that is run on the system.

Syntax
-----------------------------------------------------
A ``command`` InSpec audit resource block declares a command to be run, one (or more) expected outputs, and the location to which that output is sent:

.. code-block:: ruby

   describe command('command') do
     it { should exist }
     its('matcher') { should eq 'output' }
   end

where

* ``'command'`` must specify a command to be run
* ``'matcher'`` is one of ``exit_status``, ``stderr``, or ``stdout``
* ``'output'`` tests the output of the command run on the system versus the output value stated in the test

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

exist
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``exist`` matcher tests if a command may be run on the system:

.. code-block:: ruby

   it { should exist }

exit_status
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``exit_status`` matcher tests the exit status for the command:

.. code-block:: ruby

   its('exit_status') { should eq 123 }

stderr
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``stderr`` matcher tests results of the command as returned in standard error (stderr):

.. code-block:: ruby

   its('stderr') { should eq 'error' }

stdout
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``stdout`` matcher tests results of the command as returned in standard output (stdout). The following example shows matching output using a regular expression:

.. code-block:: ruby

   describe command('echo 1') do
      its('stdout') { should match (/[0-9]/) }
   end

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test for PostgreSQL database running a RC, development, or beta release**

.. To test for PostgreSQL database running a RC, development, or beta release:

.. code-block:: ruby

   describe command('psql -V') do
     its('stdout') { should eq '/RC/' }
     its('stdout') { should_not eq '/DEVEL/' }
     its('stdout') { should_not eq '/BETA/' }
   end

**Test standard output (stdout)**

.. To test standard output (stdout):

.. code-block:: ruby

   describe command('echo hello') do
     its('stdout') { should eq 'hello\n' }
     its('stderr') { should eq '' }
     its('exit_status') { should eq 0 }
   end

**Test standard error (stderr)**

.. To test standard error (stderr):

.. code-block:: ruby

   describe command('>&2 echo error') do
     its('stdout') { should eq '' }
     its('stderr') { should eq 'error\n' }
     its('exit_status') { should eq 0 }
   end

**Test an exit status code**

.. To test an exit status code:

.. code-block:: ruby

   describe command('exit 123') do
     its('stdout') { should eq '' }
     its('stderr') { should eq '' }
     its('exit_status') { should eq 123 }
   end

**Test if the command shell exists**

.. To test if the command shell exists:

.. code-block:: ruby

   describe command('/bin/sh').exist? do
     it { should eq true }
   end

**Test for a command that should not exist**

.. To test for a command that should not exist:

.. code-block:: ruby

   describe command('this is not existing').exist? do
     it { should eq false }
   end

**Verify NTP**

.. include:: ../../step_inspec/step_inspec_command_verify_ntp.rst

**Verify WiX**

.. include:: ../../step_inspec/step_inspec_file_verify_wix.rst

csv
=====================================================
Use the ``csv`` InSpec audit resource to test configuration data in a CSV file.

Syntax
-----------------------------------------------------
A ``csv`` InSpec audit resource block declares the configuration data to be tested:

.. code-block:: ruby

   describe csv('file') do
     its('name') { should eq 'foo' }
   end

where

* ``'file'`` is the path to a CSV file
* ``name`` is a configuration setting in a CSV file
* ``should eq 'foo'`` tests a value of ``name`` as read from a CSV file versus the value declared in the test

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

name
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``name`` matcher tests the value of ``name`` as read from a CSV file versus the value declared in the test:

.. code-block:: ruby

   its('name') { should eq 'foo' }

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test a CSV file**

.. To test a CSV file:

.. code-block:: ruby

   describe csv('some_file.csv') do
     its('setting') { should eq 1 }
   end


directory
=====================================================
Use the ``directory`` InSpec audit resource to test if the file type is a directory. This is equivalent to using the ``file`` InSpec audit resource and the ``be_directory`` matcher, but provides a simpler and more direct way to test directories. All of the matchers available to ``file`` may be used with ``directory``.

Syntax
-----------------------------------------------------
A ``directory`` InSpec audit resource block declares the location of the directory to be tested, and then one (or more) matchers:

.. code-block:: ruby

   describe directory('path') do
     it { should MATCHER 'value' }
   end

Matchers
-----------------------------------------------------
This InSpec audit resource may use any of the matchers available to the ``file`` resource that may be useful when testing a directory.

.. 
.. Examples
.. -----------------------------------------------------
.. The following examples show how to use this InSpec resource.
.. 
.. **xxxxx** 
.. 
.. xxxxx
.. 
.. **xxxxx** 
.. 
.. xxxxx
.. 


etc_group
=====================================================
Use the ``etc_group`` InSpec audit resource to test groups that are defined on Linux and UNIX platforms. The ``/etc/group`` file stores details about each group---group name, password, group identifier, along with a comma-separate list of users that belong to the group.

Syntax
-----------------------------------------------------
A ``etc_group`` InSpec audit resource block declares a collection of properties to be tested:

.. code-block:: ruby

   describe etc_group('path') do
     its('matcher') { should eq 'some_value' }
   end

or:

.. code-block:: ruby

   describe etc_group.where(item: 'value', item: 'value') do
     its('gids') { should_not contain_duplicates }
     its('groups') { should include 'user_name' }
     its('users') { should include 'user_name' }
   end

where

* ``('path')`` is the non-default path to the ``inetd.conf`` file
* ``.where()`` may specify a specific item and value, to which the matchers are compared
* ``'gids'``, ``'groups'``, and ``'users'`` are valid matchers for this InSpec audit resource

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

gids
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``gids`` matcher tests if the named group identifier is present or if it contains duplicates:

.. code-block:: ruby

   its('gids') { should_not contain_duplicates }

groups
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``groups`` matcher tests all groups for the named user:

.. code-block:: ruby

   its('groups') { should include 'my_group' }

users
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``users`` matcher tests all groups for the named user:

.. code-block:: ruby

   its('users') { should include 'my_user' }

where
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``where`` matcher allows the test to be focused to one (or more) specific items:

.. code-block:: ruby

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
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test group identifiers (GIDs) for duplicates**

.. To test group identifiers (GIDs) for duplicates:

.. code-block:: ruby

   describe etc_group do
     its('gids') { should_not contain_duplicates }
   end

**Test all groups to see if a specific user belongs to one (or more) groups**

.. To filter a list of groups for a specific user:

.. code-block:: ruby

   describe etc_group.where(name: 'my_group') do
     its('users') { should include 'my_user' }
   end

**Test all groups for a specific user name**

.. To test all groups for a specific user name:

.. code-block:: ruby

   describe etc_group do
     its('users') { should include 'my_user' }
   end

**Filter a list of groups for a specific user**

.. To test all groups to see if a specific user belongs to one (or more) groups:

.. code-block:: ruby

   describe etc_group do
     its('groups') { should include 'my_group' }
   end


file
=====================================================
Use the ``file`` InSpec audit resource to test all system file types, including files, directories, symbolic links, named pipes, sockets, character devices, block devices, and doors.

Syntax
-----------------------------------------------------
A ``file`` InSpec audit resource block declares the location of the file type to be tested, what type that file should be (if required), and then one (or more) matchers:

.. code-block:: ruby

   describe file('path') do
     it { should MATCHER 'value' }
   end

where

* ``('path')`` is the name of the file and/or the path to the file
* ``MATCHER`` is a valid matcher for this InSpec audit resource
* ``'value'`` is the value to be tested

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

be_block_device
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``be_block_device`` matcher tests if the file exists as a block device, such as ``/dev/disk0`` or ``/dev/disk0s9``:

.. code-block:: ruby

   it { should be_block_device }

be_character_device
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``be_character_device`` matcher tests if the file exists as a character device (that corresponds to a block device), such as ``/dev/rdisk0`` or ``/dev/rdisk0s9``:

.. code-block:: ruby

   it { should be_character_device }

be_directory
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``be_directory`` matcher tests if the file exists as a directory, such as ``/etc/passwd``, ``/etc/shadow``, or ``/var/log/httpd``:

.. code-block:: ruby

   it { should be_directory }

be_executable
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``be_executable`` matcher tests if the file exists as an executable:

.. code-block:: ruby

   it { should be_executable }

The ``be_executable`` matcher may also test if the file is executable by a specific owner, group, or user. For example, a group:

.. code-block:: ruby

   it { should be_executable.by('group') }

an owner:

.. code-block:: ruby

   it { should be_executable.by('owner') }

a user:

.. code-block:: ruby

   it { should be_executable.by_user('user') }

be_file
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``be_file`` matcher tests if the file exists as a file. This can be useful with configuration files like ``/etc/passwd`` where there typically is not an associated file extension---``passwd.txt``:

.. code-block:: ruby

   it { should be_file }

be_grouped_into
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``be_grouped_into`` matcher tests if the file exists as part of the named group:

.. code-block:: ruby

   it { should be_grouped_into 'group' }

be_immutable
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``be_immutable`` matcher tests if the file is immutable, i.e. "cannot be changed":

.. code-block:: ruby

   it { should be_immutable }

be_linked_to
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``be_linked_to`` matcher tests if the file is linked to the named target:

.. code-block:: ruby

   it { should be_linked_to '/etc/target-file' }

be_mounted
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``be_mounted`` matcher tests if the file is accessible from the file system:

.. code-block:: ruby

   it { should be_mounted }

be_owned_by
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``be_owned_by`` matcher tests if the file is owned by the named user, such as ``root``:

.. code-block:: ruby

   it { should be_owned_by 'root' }

be_pipe
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``be_pipe`` matcher tests if the file exists as first-in, first-out special file (``.fifo``) that is typically used to define a named pipe, such as ``/var/log/nginx/access.log.fifo``:

.. code-block:: ruby

   it { should be_pipe }

be_readable
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``be_readable`` matcher tests if the file is readable:

.. code-block:: ruby

   it { should be_readable }

The ``be_readable`` matcher may also test if the file is readable by a specific owner, group, or user. For example, a group:

.. code-block:: ruby

   it { should be_readable.by('group') }

an owner:

.. code-block:: ruby

   it { should be_readable.by('owner') }

a user:

.. code-block:: ruby

   it { should be_readable.by_user('user') }

be_socket
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``be_socket`` matcher tests if the file exists as socket (``.sock``), such as ``/var/run/php-fpm.sock``:

.. code-block:: ruby

   it { should be_socket }

be_symlink
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``be_symlink`` matcher tests if the file exists as a symbolic, or soft link that contains an absolute or relative path reference to another file:

.. code-block:: ruby

   it { should be_symlink }

be_version
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``be_version`` matcher tests the version of the file:

.. code-block:: ruby

   it { should be_version '1.2.3' }

be_writable
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``be_writable`` matcher tests if the file is writable:

.. code-block:: ruby

   it { should be_writable }

The ``be_writable`` matcher may also test if the file is writable by a specific owner, group, or user. For example, a group:

.. code-block:: ruby

   it { should be_writable.by('group') }

an owner:

.. code-block:: ruby

   it { should be_writable.by('owner') }

a user:

.. code-block:: ruby

   it { should be_writable.by_user('user') }

content
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``content`` matcher tests if contents in the file match the value specified in a regular expression. The values of the ``content`` matcher are arbitrary and depend on the file type being tested and also the type of information that is expected to be in that file:

.. code-block:: ruby

   its('content') { should match REGEX }

The following complete example tests the ``pg_hba.conf`` file in PostgreSQL for MD5 requirements.  The tests look at all ``host`` and ``local`` settings in that file, and then compare the MD5 checksums against the values in the test:

.. code-block:: bash

   describe file(hba_config_file) do
     its('content') { should match(%r{local\s.*?all\s.*?all\s.*?md5}) }
     its('content') { should match(%r{host\s.*?all\s.*?all\s.*?127.0.0.1\/32\s.*?md5}) }
     its('content') { should match(%r{host\s.*?all\s.*?all\s.*?::1\/128\s.*?md5})
   end

exist
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``exist`` matcher tests if the named file exists:

.. code-block:: ruby

   it { should exist }

file_version
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``file_version`` matcher tests if the file's version matches the specified value. The difference between a file's "file version" and "product version" is that the file version is the version number of the file itself, whereas the product version is the version number associated with the application from which that file originates:

.. code-block:: ruby

   its('file_version') { should eq '1.2.3' }

group
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``group`` matcher tests if the group to which a file belongs matches the specified value:

.. code-block:: ruby

   its('group') { should eq 'admins' }

have_mode
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``have_mode`` matcher tests if a file has a mode assigned to it:

.. code-block:: ruby

   it { should have_mode }

link_path
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``link_path`` matcher tests if the file exists at the specified path:

.. code-block:: ruby

   its('link_path') { should eq '/some/path/to/file' }

link_target
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``link_target`` matcher tests if a file that is linked to this file exists at the specified path:

.. code-block:: ruby

   its('link_target') { should eq '/some/path/to/file' }

md5sum
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``md5sum`` matcher tests if the MD5 checksum for a file matches the specified value:

.. code-block:: ruby

   its('md5sum') { should eq '3329x3hf9130gjs9jlasf2305mx91s4j' }

mode
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``mode`` matcher tests if the mode assigned to the file matches the specified value:

.. code-block:: ruby

   its('mode') { should cmp '0644' }

mtime
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``mtime`` matcher tests if the file modification time for the file matches the specified value:

.. code-block:: ruby

   its('mtime') { should eq 'October 31 2015 12:10:45' }

or:

.. code-block:: bash

   describe file('/').mtime.to_i do
     it { should <= Time.now.to_i }
     it { should >= Time.now.to_i - 1000}
   end

owner
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``owner`` matcher tests if the owner of the file matches the specified value:

.. code-block:: ruby

   its('owner') { should eq 'root' }

product_version
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``product_version`` matcher tests if the file's product version matches the specified value. The difference between a file's "file version" and "product version" is that the file version is the version number of the file itself, whereas the product version is the version number associated with the application from which that file originates:

.. code-block:: ruby

   its('product_version') { should eq 2.3.4 }

selinux_label
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``selinux_label`` matcher tests if the SELinux label for a file matches the specified value:

.. code-block:: ruby

   its('selinux_label') { should eq 'system_u:system_r:httpd_t:s0' }

sha256sum
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``sha256sum`` matcher tests if the SHA-256 checksum for a file matches the specified value:

.. code-block:: ruby

   its('sha256sum') { should eq 'b837ch38lh19bb8eaopl8jvxwd2e4g58jn9lkho1w3ed9jbkeicalplaad9k0pjn' }
   
size
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``size`` matcher tests if a file's size matches, is greater than, or is less than the specified value. For example, equal:

.. code-block:: ruby

   its('size') { should eq 32375 }

Greater than:

.. code-block:: ruby

   its('size') { should > 64 }

Less than:

.. code-block:: ruby

   its('size') { should < 10240 }

type
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``type`` matcher tests if the first letter of the file's mode string contains one of the following characters:

* ``-`` or ``f`` (the file is a file); use ``'file`` to test for this file type
* ``d`` (the file is a directory); use ``'directory`` to test for this file type
* ``l`` (the file is a symbolic link); use ``'link`` to test for this file type
* ``p`` (the file is a named pipe); use ``'pipe`` to test for this file type
* ``s`` (the file is a socket); use ``'socket`` to test for this file type
* ``c`` (the file is a character device); use ``'character`` to test for this file type
* ``b`` (the file is a block device); use ``'block`` to test for this file type
* ``D`` (the file is a door); use ``'door`` to test for this file type

For example:

.. code-block:: ruby

   its('type') { should eq 'file' }

or:

.. code-block:: ruby

   its('type') { should eq 'socket' }

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test the contents of a file for MD5 requirements**

.. To test the contents of a file for MD5 requirements:

.. code-block:: ruby

   describe file(hba_config_file) do
     its('content') { should match /local\s.*?all\s.*?all\s.*?md5/ }
     its('content') { should match %r{/host\s.*?all\s.*?all\s.*?127.0.0.1\/32\s.*?md5/} }
     its('content') { should match %r{/host\s.*?all\s.*?all\s.*?::1\/128\s.*?md5/} }
   end

**Test if a file exists**

.. To test if a file exists:

.. code-block:: ruby

   describe file('/tmp') do
    it { should exist }
   end

**Test that a file does not exist**

.. To test that a file does not exist:

.. code-block:: ruby

   describe file('/tmpest') do
    it { should_not exist }
   end

**Test if a path is a directory**

.. To test if a path is a directory:

.. code-block:: ruby

   describe file('/tmp') do
    its('type') { should eq :directory }
    it { should be_directory }
   end

**Test if a path is a file and not a directory**

.. To test if a path is a file and not a directory:

.. code-block:: ruby

   describe file('/proc/version') do
     its('type') { should eq 'file' }
     it { should be_file }
     it { should_not be_directory }
   end

**Test if a file is a symbolic link**

.. To test if a file is a symbolic link:

.. code-block:: ruby

   describe file('/dev/stdout') do
     its('type') { should eq 'symlink' }
     it { should be_symlink }
     it { should_not be_file }
     it { should_not be_directory }
   end

**Test if a file is a character device**

.. To test if a file is a character device:

.. code-block:: ruby

   describe file('/dev/zero') do
     its('type') { should eq 'character' }
     it { should be_character_device }
     it { should_not be_file }
     it { should_not be_directory }
   end

**Test if a file is a block device**

.. To test if a file is a block device:

.. code-block:: ruby

   describe file('/dev/zero') do
     its('type') { should eq 'block' }
     it { should be_character_device }
     it { should_not be_file }
     it { should_not be_directory }
   end

**Test the mode for a file**

.. To test the mode for a file:

.. code-block:: ruby

   describe file('/dev') do
    its('mode') { should cmp '00755' }
   end

**Test the owner of a file**

.. To test the owner of a file:

.. code-block:: ruby

   describe file('/root') do
     its('owner') { should eq 'root' }
   end

**Test if a file is owned by the root user**

.. To test if a file is owned by the root user:

.. code-block:: ruby

   describe file('/dev') do
     it { should be_owned_by 'root' }
   end

**Test the mtime for a file**

.. To test the mtime for a file:

.. code-block:: ruby

   describe file('/').mtime.to_i do
     it { should <= Time.now.to_i }
     it { should >= Time.now.to_i - 1000}
   end

**Test that a file's size is between 64 and 10240**

.. To test that a file's size is between 64 and 10240:

.. code-block:: ruby

   describe file('/') do
     its('size') { should be > 64 }
     its('size') { should be < 10240 }
   end

**Test that a file's size is zero**

.. To test that a file's size is zero:

.. code-block:: ruby

   describe file('/proc/cpuinfo') do
     its('size') { should be 0 }
   end

**Test that a file is not mounted**

.. To test that a file is not mounted:

.. code-block:: ruby

   describe file('/proc/cpuinfo') do
     it { should_not be_mounted }
   end

**Test an MD5 checksum**

.. To test an MD5 checksum:

.. code-block:: ruby

   require 'digest'
   cpuinfo = file('/proc/cpuinfo').content
   
   md5sum = Digest::MD5.hexdigest(cpuinfo)
   
   describe file('/proc/cpuinfo') do
     its('md5sum') { should eq md5sum }
   end

**Test an SHA-256 checksum**

.. To test an SHA-256 checksum:

.. code-block:: ruby

   require 'digest'
   cpuinfo = file('/proc/cpuinfo').content
   
   sha256sum = Digest::SHA256.hexdigest(cpuinfo)
   
   describe file('/proc/cpuinfo') do
     its('sha256sum') { should eq sha256sum }
   end

**Verify NTP**

.. include:: ../../step_inspec/step_inspec_command_verify_ntp.rst

**Verify WiX**

.. include:: ../../step_inspec/step_inspec_file_verify_wix.rst

gem
=====================================================
Use the ``gem`` InSpec audit resource to test if a global gem package is installed.

Syntax
-----------------------------------------------------
A ``gem`` InSpec audit resource block declares a package and (optionally) a package version:

.. code-block:: ruby

   describe gem('gem_package_name') do
     it { should be_installed }
   end

where

* ``('gem_package_name')`` must specify a gem package, such as ``'rubocop'``
* ``be_installed`` is a valid matcher for this InSpec audit resource

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

be_installed
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``be_installed`` matcher tests if the named gem package is installed:

.. code-block:: ruby

   it { should be_installed }

version
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``version`` matcher tests if the named package version is on the system:

.. code-block:: ruby

   its('version') { should eq '0.33.0' }

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Verify that a gem package is installed, with a specific version**

.. To verify that a gem package is installed, with a specific version:

.. code-block:: ruby

   describe gem('rubocop') do
     it { should be_installed }
     its('version') { should eq '0.33.0' }
   end

**Verify that a gem package is not installed**

.. To verify that a gem package is not installed:

.. code-block:: ruby

   describe gem('rubocop') do
     it { should_not be_installed }
   end


group
=====================================================
Use the ``group`` InSpec audit resource to test groups on the system.

Syntax
-----------------------------------------------------
A ``group`` InSpec audit resource block declares a group, and then the details to be tested, such as if the group is a local group, the group identifier, or if the group exists:

.. code-block:: ruby

   describe group('group_name') do
     it { should exist }
     its('gid') { should eq 0 }
   end

where

* ``'group_name'`` must specify the name of a group on the system
* ``exist`` and ``'gid'`` are valid matchers for this InSpec audit resource

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

be_local
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``be_local`` matcher tests if the group is a local group:

.. code-block:: ruby

   it { should be_local }

exist
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``exist`` matcher tests if the named user exists:

.. code-block:: ruby

   it { should exist }

gid
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``gid`` matcher tests the named group identifier:

.. code-block:: ruby

   its('gid') { should eq 1234 }

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test the group identifier for the root group**

.. To test the group identifier for the root group:

.. code-block:: ruby

   describe group('root') do
     it { should exist }
     its('gid') { should eq 0 }
   end


host
=====================================================
Use the ``host`` InSpec audit resource to test the name used to refer to a specific host and its availability, including the Internet protocols and ports over which that host name should be available.

Syntax
-----------------------------------------------------
A ``host`` InSpec audit resource block declares a host name, and then (depending on what is to be tested) a port and/or a protocol:

.. code-block:: ruby

   describe host('example.com', port: 80, proto: 'tcp') do
     it { should be_reachable }
   end

where

* ``host()`` must specify a host name and may specify a port number and/or a protocol
* ``'example.com'`` is the host name
* ``port:`` is the port number
* ``proto: 'name'`` is the Internet protocol: TCP (``proto: 'tcp'``), UDP (``proto: 'udp'`` or  ICMP (``proto: 'icmp'``))
* ``be_reachable`` is a valid matcher for this InSpec audit resource

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

be_reachable
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``be_reachable`` matcher tests if the host name is available:

.. code-block:: ruby

   it { should be_reachable }

be_resolvable
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``be_resolvable`` matcher tests for host name resolution, i.e. "resolvable to an IP address":

.. code-block:: ruby

   it { should be_resolvable }

ipaddress
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``ipaddress`` matcher tests if a host name is resolvable to a specific IP address:

.. code-block:: ruby

   its('ipaddress') { should include '93.184.216.34' }

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Verify host name is reachable over a specific protocol and port number**

.. To verify host name is reachable over a specific protocol and port number:

.. code-block:: ruby

   describe host('example.com', port: 53, proto: 'udp') do
     it { should be_reachable }
   end

**Verify that a specific IP address can be resolved**

.. To verify that a specific IP address can be resolved:

.. code-block:: ruby

   describe host('example.com', port: 80, proto: 'tcp') do
     it { should be_resolvable }
     its('ipaddress') { should include '192.168.1.1' }
   end


inetd_conf
=====================================================
Use the ``inetd_conf`` InSpec audit resource to test if a service is listed in the ``inetd.conf`` file on Linux and UNIX platforms. inetd---the Internet service daemon---listens on dedicated ports, and then loads the appropriate program based on a request. The ``inetd.conf`` file is typically located at ``/etc/inetd.conf`` and contains a list of Internet services associated to the ports on which that service will listen. Only enabled services may handle a request; only services that are required by the system should be enabled.

Syntax
-----------------------------------------------------
An ``inetd_conf`` InSpec audit resource block declares the list of services that are enabled in the ``inetd.conf`` file:

.. code-block:: ruby

   describe inetd_conf('path') do
     its('service_name') { should eq 'value' }
   end

where

* ``'service_name'`` is a service listed in the ``inetd.conf`` file
* ``('path')`` is the non-default path to the ``inetd.conf`` file
* ``should eq 'value'`` is the value that is expected

Matchers
-----------------------------------------------------
This InSpec audit resource matches any service that is listed in the ``inetd.conf`` file. You may want to ensure that specific services do not listen via ``inetd.conf``:

.. code-block:: ruby

   its('shell') { should eq nil }

or:

.. code-block:: ruby

   its('netstat') { should eq nil }

or:

.. code-block:: ruby

   its('systat') { should eq nil }

For example:

.. code-block:: ruby

   describe inetd_conf do
     its('shell') { should eq nil }
     its('login') { should eq nil }
     its('exec') { should eq nil }
   end

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Verify that FTP is disabled**

.. To verify that FTP is disabled:

The contents if the ``inetd.conf`` file contain the following:

.. code-block:: text

   #ftp      stream   tcp   nowait   root   /usr/sbin/tcpd   in.ftpd -l -a
   #telnet   stream   tcp   nowait   root   /usr/sbin/tcpd   in.telnetd

and the following test is defined:

.. code-block:: ruby

   describe inetd_conf do
     its('ftp') { should eq nil }
     its('telnet') { should eq nil }
   end

Because both the ``ftp`` and ``telnet`` Internet services are commented out (``#``), both services are disabled. Consequently, both tests will return ``true``. However, if the ``inetd.conf`` file is set as follows:

.. code-block:: text

   ftp       stream   tcp   nowait   root   /usr/sbin/tcpd   in.ftpd -l -a
   #telnet   stream   tcp   nowait   root   /usr/sbin/tcpd   in.telnetd

then the same test will return ``false`` for ``ftp`` and the entire test will fail.

**Test if telnet is installed**

.. To test if telnet is installed:

.. code-block:: ruby

   describe package('telnetd') do
     it { should_not be_installed }
   end

   describe inetd_conf do
     its('telnet') { should eq nil }
   end



interface
=====================================================
Use the ``interface`` InSpec audit resource to test basic network adapter properties, such as name, status, state, address, and link speed (in MB/sec).

* On Linux platforms, ``/sys/class/net/#{iface}`` is used as source
* On the Microsoft Windows platform, the ``Get-NetAdapter`` cmdlet is used as source

Syntax
-----------------------------------------------------
An ``interface`` InSpec audit resource block declares network interface properties to be tested:

.. code-block:: ruby

   describe interface do
     it { should be_up }
     its('speed') { should eq 1000 }
     its('name') { should eq eth0 }
   end

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

be_up
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``be_up`` matcher tests if the network interface is available:

.. code-block:: ruby

   it { should be_up }

name
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``name`` matcher tests if the named network interface exists:

.. code-block:: ruby

   its('name') { should eq eth0 }

speed
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``speed`` matcher tests the speed of the network interface, in MB/sec:

.. code-block:: ruby

   its('speed') { should eq 1000 }

..
.. Examples
.. -----------------------------------------------------
.. The following examples show how to use this InSpec audit resource.
..
.. **xxxxx**
..
.. xxxxx
..
.. **xxxxx**
..
.. xxxxx
..


iptables
=====================================================
Use the ``iptables`` InSpec audit resource to test rules that are defined in ``iptables``, which maintains tables of IP packet filtering rules. There may be more than one table. Each table contains one (or more) chains (both built-in and custom). A chain is a list of rules that match packets. When the rule matches, the rule defines what target to assign to the packet.

Syntax
-----------------------------------------------------
A ``iptables`` InSpec audit resource block declares tests for rules in IP tables:

.. code-block:: ruby

   describe iptables(rule:'name', table:'name', chain: 'name') do
     it { should have_rule('RULE') }
   end

where

* ``iptables()`` may specify any combination of ``rule``, ``table``, or ``chain``
* ``rule:'name'`` is the name of a rule that matches a set of packets
* ``table:'name'`` is the packet matching table against which the test is run
* ``chain: 'name'`` is the name of a user-defined chain or one of ``ACCEPT``, ``DROP``, ``QUEUE``, or ``RETURN``
* ``have_rule('RULE')`` tests that rule in the iptables file

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

have_rule
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``have_rule`` matcher tests the named rule against the information in the ``iptables`` file:

.. code-block:: ruby

   it { should have_rule('RULE') }

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test if the IP table allows a packet through**

.. To test if the IP table allows a packet through:

.. code-block:: ruby

   describe iptables do
     it { should have_rule('-P INPUT ACCEPT') }
   end

**Test if the IP table allows a packet through, for a specific table and chain**

.. To test if the IP table allows a packet through, for a specific table and chain:

.. code-block:: ruby

   describe iptables(table:'mangle', chain: 'input') do
     it { should have_rule('-P INPUT ACCEPT') }
   end


json
=====================================================
Use the ``json`` InSpec audit resource to test data in a JSON file.

Syntax
-----------------------------------------------------
A ``json`` InSpec audit resource block declares the data to be tested. Assume the following JSON file:

.. code-block:: javascript

   {
     "name" : "hello",
     "meta" : {
       "creator" : "John Doe"
     },
     "array": [
       "zero",
       "one"
     ]
   }

This file can be queried using:

.. code-block:: ruby

   describe json('/paht/to/name.json') do
     its('name') { should eq 'hello' }
     its(['meta','creator']) { should eq 'John Doe' }
     its(['array', 1]) { should eq 'one' }
   end

where

* ``name`` is a configuration setting in a JSON file
* ``should eq 'foo'`` tests a value of ``name`` as read from a JSON file versus the value declared in the test

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

name
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``name`` matcher tests the value of ``name`` as read from a JSON file versus the value declared in the test:

.. code-block:: ruby

   its('name') { should eq 'foo' }

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test a cookbook version in a policyfile.lock.json file**

.. To test a cookbook version in a policyfile.lock.json file:

.. code-block:: ruby

   describe json('policyfile.lock.json') do
     its(['cookbook_locks', 'omnibus', 'version']) { should eq('2.2.0') }
   end


kernel_module
=====================================================
Use the ``kernel_module`` InSpec audit resource to test kernel modules on Linux platforms. These parameters are located under ``/lib/modules``. Any submodule may be tested using this resource.

Syntax
-----------------------------------------------------
A ``kernel_module`` InSpec audit resource block declares a module name, and then tests if that module is a loadable kernel module:

.. code-block:: ruby

   describe kernel_module('module_name') do
     it { should be_loaded }
   end

where

* ``'module_name'`` must specify a kernel module, such as ``'bridge'``
* ``{ should be_loaded }`` tests if the module is a loadable kernel module

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

be_loaded
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``be_loaded`` matcher tests if the module is a loadable kernel module:

.. code-block:: ruby

   it { should be_loaded }

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test if a module is loaded**

.. To test if a module is loaded:

.. code-block:: ruby

   describe kernel_module('bridge') do
     it { should be_loaded }
   end


kernel_parameter
=====================================================
Use the ``kernel_parameter`` InSpec audit resource to test kernel parameters on Linux platforms.

Syntax
-----------------------------------------------------
A ``kernel_parameter`` InSpec audit resource block declares a parameter and then a value to be tested:

.. code-block:: ruby

   describe kernel_parameter('path.to.parameter') do
     its('value') { should eq 0 }
   end

where

* ``'kernel.parameter'`` must specify a kernel parameter, such as ``'net.ipv4.conf.all.forwarding'``
* ``{ should eq 0 }`` states the value to be tested

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

value
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``value`` matcher tests the value assigned to the named IP address versus the value declared in the test:

.. code-block:: ruby

   its('value') { should eq 0 }
   
Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test if global forwarding is enabled for an IPv4 address**

.. To test if global forwarding is enabled for an IPv4 address:

.. code-block:: ruby

   describe kernel_parameter('net.ipv4.conf.all.forwarding') do
     its('value') { should eq 1 }
   end

**Test if global forwarding is disabled for an IPv6 address**

.. To test if global forwarding is disabled for an IPv6 address:

.. code-block:: ruby

   describe kernel_parameter('net.ipv6.conf.all.forwarding') do
     its('value') { should eq 0 }
   end

**Test if an IPv6 address accepts redirects**

.. To test if an IPv6 address accepts redirects:

.. code-block:: ruby

   describe kernel_parameter('net.ipv6.conf.interface.accept_redirects') do
     its('value') { should eq 'true' }
   end


limits_conf
=====================================================
Use the ``limits_conf`` InSpec audit resource to test configuration settings in the ``/etc/security/limits.conf`` file. The ``limits.conf`` defines limits for processes (by user and/or group names) and helps ensure that the system on which those processes are running remains stable. Each process may be assigned a hard or soft limit.

* Soft limits are maintained by the shell and defines the number of file handles (or open files) available to the user or group after login
* Hard limits are maintained by the kernel and defines the maximum number of allowed file handles

Entries in the ``limits.conf`` file are similar to:

.. code-block:: bash

   grantmc     soft   nofile   4096
   grantmc     hard   nofile   63536

   ^^^^^^^^^   ^^^^   ^^^^^^   ^^^^^
   domain      type    item    value

Syntax
-----------------------------------------------------
A ``limits_conf`` InSpec audit resource block declares a domain to be tested, along with associated type, item, and value:

.. code-block:: ruby

   describe limits_conf('path') do
     its('domain') { should include ['type', 'item', 'value'] }
     its('domain') { should eq ['type', 'item', 'value'] }
   end

where

* ``('path')`` is the non-default path to the ``inetd.conf`` file
* ``'domain'`` is a user or group name, such as ``grantmc``
* ``'type'`` is either ``hard`` or ``soft``
* ``'item'`` is the item for which limits are defined, such as ``core``, ``nofile``, ``stack``, ``nproc``, ``priority``, or ``maxlogins``
* ``'value'`` is the value associated with the ``item``

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

domain
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``domain`` matcher tests the domain in the ``limits.conf`` file, along with associated type, item, and value:

.. code-block:: ruby

   its('domain') { should include ['type', 'item', 'value'] }

For example:

.. code-block:: ruby

   its('grantmc') { should include ['hard', 'nofile', '63536'] }

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test limits**

.. To test limits:

.. code-block:: ruby

   describe limits_conf('path') do
     its('*') { should include ['soft', 'core', '0'], ['hard', 'rss', '10000'] }
     its('ftp') { should eq ['hard', 'nproc', '0'] }
   end


login_defs
=====================================================
Use the ``login_defs`` InSpec audit resource to test configuration settings in the ``/etc/login.defs`` file. The ``logins.defs`` file defines site-specific configuration for the shadow password suite on Linux and UNIX platforms, such as password expiration ranges, minimum/maximum values for automatic selection of user and group identifiers, or the method with which passwords are encrypted.

Syntax
-----------------------------------------------------
A ``login_defs`` InSpec audit resource block declares the ``login.defs`` configuration data to be tested:

.. code-block:: ruby

   describe login_defs do
     its('name') { should include('foo') }
   end

where

* ``name`` is a configuration setting in ``login.defs``
* ``{ should include('foo') }`` tests the value of ``name`` as read from ``login.defs`` versus the value declared in the test

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

name
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``name`` matcher tests the value of ``name`` as read from ``login.defs`` versus the value declared in the test:

.. code-block:: ruby

   its('name') { should eq 'foo' }

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test password expiration settings**

.. To test password expiration settings:

.. code-block:: ruby

   describe login_defs do
     its('PASS_MAX_DAYS') { should eq '180' }
     its('PASS_MIN_DAYS') { should eq '1' }
     its('PASS_MIN_LEN') { should eq '15' }
     its('PASS_WARN_AGE') { should eq '30' }
   end

**Test the encryption method**

.. To test the encryption method:

.. code-block:: ruby

   describe login_defs do
     its('ENCRYPT_METHOD') { should eq 'SHA512' }
   end

**Test umask and password expiration**

.. To test umask settings:

.. code-block:: ruby

   describe login_def do
     its('UMASK') { should eq '077' }
     its('PASS_MAX_DAYS') { should eq '90' }
   end



mount
=====================================================
Use the ``mount`` InSpec audit resource to test the mount points on Linux systems.

Syntax
-----------------------------------------------------
An ``mount`` InSpec audit resource block declares the synchronization settings that should be tested:

.. code-block:: ruby

   describe mount('path') do
     it { should MATCHER 'value' }
   end

where

* ``('path')`` is the path to the mounted directory
* ``MATCHER`` is a valid matcher for this InSpec audit resource
* ``'value'`` is the value to be tested

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

be_mounted
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``be_mounted`` matcher tests if the file is accessible from the file system:

.. code-block:: ruby

   it { should be_mounted }

device
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``device`` matcher tests the device from the ``fstab`` table:

.. code-block:: ruby

   its('device') { should eq  '/dev/mapper/VolGroup-lv_root' }

options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``options`` matcher tests the mount options for the file system from the ``fstab`` table:

.. code-block:: ruby

  its('options') { should eq ['rw', 'mode=620'] }

type
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``type`` matcher tests the file system type:

.. code-block:: ruby

   its('type') { should eq  'ext4' }

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test a the mount point on '/'**

.. To test a mount point on '/':

.. code-block:: ruby

   describe mount('/') do
     it { should be_mounted }
     its('device') { should eq  '/dev/mapper/VolGroup-lv_root' }
     its('type') { should eq  'ext4' }
     its('options') { should eq ['rw', 'mode=620'] }
   end



mysql_conf
=====================================================
Use the ``mysql_conf`` InSpec audit resource to test the contents of the configuration file for MySQL, typically located at ``/etc/mysql/my.cnf`` or ``/etc/my.cnf``.

Syntax
-----------------------------------------------------
A ``mysql_conf`` InSpec audit resource block declares one (or more) settings in the ``my.cnf`` file, and then compares the setting in the configuration file to the value stated in the test:

.. code-block:: ruby

   describe mysql_conf('path') do
     its('setting') { should eq 'value' }
   end

where

* ``'setting'`` specifies a setting in the ``my.cnf`` file, such as ``max_connections``
* ``('path')`` is the non-default path to the ``my.cnf`` file
* ``should eq 'value'`` is the value that is expected

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

setting
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``setting`` matcher tests specific, named settings in the ``my.cnf`` file:

.. code-block:: ruby

   its('setting') { should eq 'value' }

Use a ``setting`` matcher for each setting to be tested.

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test the maximum number of allowed connections**

.. To test the maximum number of allowed connections:

.. code-block:: ruby

   describe mysql_conf do
     its('max_connections') { should eq '505' }
     its('max_user_connections') { should eq '500' }
   end

**Test slow query logging**

.. To test slow query logging:

.. code-block:: ruby

   describe mysql_conf do
     its('slow_query_log_file') { should eq 'hostname_slow.log' }
     its('slow_query_log') { should eq '0' }
     its('log_queries_not_using_indexes') { should eq '1' }
     its('long_query_time') { should eq '0.5' }
     its('min_examined_row_limit') { should eq '100' }
   end

**Test the port and socket on which MySQL listens**

.. To test the port and socket on which MySQL listens:

.. code-block:: ruby

   describe mysql_conf do
     its('port') { should eq '3306' }
     its('socket') { should eq '/var/run/mysqld/mysql.sock' }
   end

**Test connection and thread variables**

.. To test connection and thread variables:

.. code-block:: ruby

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

.. To test the safe-user-create parameter:

.. code-block:: ruby

   describe mysql_conf.params('mysqld') do
     its('safe-user-create') { should eq('1') }
   end
  

mysql_session
=====================================================
Use the ``mysql_session`` InSpec audit resource to test SQL commands run against a MySQL database.

Syntax
-----------------------------------------------------
A ``mysql_session`` InSpec audit resource block declares the username and password to use for the session, and then the command to be run:

.. code-block:: ruby

   describe mysql_session('username', 'password').query('QUERY') do
     its('output') { should eq('') }
   end

where

* ``mysql_session`` declares a username and password with permission to run the query
* ``query('QUERY')`` contains the query to be run
* ``its('output') { should eq('') }`` compares the results of the query against the expected result in the test

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

output
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``output`` matcher tests the results of the query:

.. code-block:: ruby

   its('output') { should eq(/^0/) }

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test for matching databases**

.. To test for matching databases:

.. code-block:: ruby

   sql = mysql_session('my_user','password')
   
   describe sql.query('show databases like \'test\';') do
     its('stdout') { should_not match(/test/) }
   end


npm
=====================================================
Use the ``npm`` InSpec audit resource to test if a global npm package is installed. npm is the `the package manager for Node.js packages <https://docs.npmjs.com>`__, such as bower and StatsD.

Syntax
-----------------------------------------------------
A ``npm`` InSpec audit resource block declares a package and (optionally) a package version:

.. code-block:: ruby

   describe gem('npm_package_name') do
     it { should be_installed }
   end

where

* ``('npm_package_name')`` must specify a npm package, such as ``'bower'`` or ``'statsd'``
* ``be_installed`` is a valid matcher for this InSpec audit resource

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

be_installed
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``be_installed`` matcher tests if the named gem package and package version (if specified) is installed:

.. code-block:: ruby

   it { should be_installed }

version
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``version`` matcher tests if the named package version is on the system:

.. code-block:: ruby

   its('version') { should eq '1.2.3' }

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Verify that bower is installed, with a specific version**

.. To verify that bower is installed, with a specific version:

.. code-block:: ruby

   describe npm('bower') do
     it { should be_installed }
     its('version') { should eq '1.4.1' }
   end

**Verify that statsd is not installed**

.. To verify that statsd is not installed:

.. code-block:: ruby

   describe npm('statsd') do
     it { should_not be_installed }
   end


ntp_conf
=====================================================
Use the ``ntp_conf`` InSpec audit resource to test the synchronization settings defined in the ``ntp.conf`` file. This file is typically located at ``/etc/ntp.conf``.

Syntax
-----------------------------------------------------
An ``ntp_conf`` InSpec audit resource block declares the synchronization settings that should be tested:

.. code-block:: ruby

   describe ntp_conf('path') do
     its('setting_name') { should eq 'value' }
   end

where

* ``'setting_name'`` is a synchronization setting defined in the ``ntp.conf`` file
* ``('path')`` is the non-default path to the ``ntp.conf`` file
* ``{ should eq 'value' }`` is the value that is expected

Matchers
-----------------------------------------------------
This InSpec audit resource matches any service that is listed in the ``ntp.conf`` file:

.. code-block:: ruby

   its('server') { should_not eq nil }

or:

.. code-block:: ruby

   its('restrict') { should include '-4 default kod notrap nomodify nopeer noquery'}

For example:

.. code-block:: ruby

   describe ntp_conf do
     its('server') { should_not eq nil }
     its('restrict') { should include '-4 default kod notrap nomodify nopeer noquery'}
   end

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test for clock drift against named servers**

.. To test for clock drift against named servers:

.. code-block:: ruby

   describe ntp_conf do
     its('driftfile') { should eq '/var/lib/ntp/ntp.drift' }
     its('server') { should eq [
       0.ubuntu.pool.ntp.org,
       1.ubuntu.pool.ntp.org,
       2.ubuntu.pool.ntp.org
     ] }
   end


oneget
=====================================================
Use the ``oneget`` InSpec audit resource to test if the named package and/or package version is installed on the system. This resource uses OneGet, which is `part of the Windows Management Framework 5.0 and Windows 10 <https://github.com/OneGet/oneget>`__. This resource uses the ``Get-Package`` cmdlet to return all of the package names in the OneGet repository.

Syntax
-----------------------------------------------------
A ``oneget`` InSpec audit resource block declares a package and (optionally) a package version:

.. code-block:: ruby

   describe oneget('name') do
     it { should be_installed }
   end

where

* ``('name')`` must specify the name of a package, such as ``'VLC'``
* ``be_installed`` is a valid matcher for this InSpec audit resource

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

be_installed
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``be_installed`` matcher tests if the named package is installed on the system:

.. code-block:: ruby

   it { should be_installed }

version
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``version`` matcher tests if the named package version is on the system:

.. code-block:: ruby

   its('version') { should eq '1.2.3' }

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test if VLC is installed**

.. To test if VLC is installed:

.. code-block:: ruby

   describe oneget('VLC') do
     it { should be_installed }
   end


os
=====================================================
Use the ``os`` InSpec audit resource to test the platform on which the system is running.

Syntax
-----------------------------------------------------
A ``os`` InSpec audit resource block declares the platform to be tested. The platform may specified via matcher or control block name. For example, using a matcher:

.. code-block:: ruby

   describe os[:family] do
     it { should eq 'platform_name' }
   end

or using the block name:

.. code-block:: ruby

   describe os[:family_name] do
     ...
   end

* ``'platform_name'`` (a string) or ``:family_name`` (a symbol) is one of ``aix``, ``bsd``, ``darwin``, ``debian``, ``hpux``, ``linux``, ``redhat``, ``solaris``, ``suse``,  ``unix``, or ``windows``

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_no_matchers.rst

os.family? Helpers
-----------------------------------------------------
The ``os`` audit resource includes a collection of helpers that enable more granular testing of platforms, platform names, architectures, and releases.

Use any of the following platform-specific helpers to test for specific platforms:

* ``aix?``
* ``bsd?`` (including Darwin, FreeBSD, NetBSD, and OpenBSD)
* ``darwin?``
* ``debian?``
* ``hpux?``
* ``linux?`` (including Alpine Linux, Amazon Linux, Arch Linux, CoreOS, Exherbo, Fedora, Gentoo, and Slackware)
* ``redhat?``
* ``solaris?`` (including Nexenta Core, OmniOS, Open Indiana, OpenSolaris, and SmartOS)
* ``suse?``
* ``unix?``
* ``windows?``

For example, to test for Darwin use:

.. code-block:: ruby

   describe os.bsd? do
      it { should eq true }
   end

To test for Microsoft Windows use:

.. code-block:: ruby

   describe os.windows? do
      it { should eq true }
   end

and to test for Red Hat use:

.. code-block:: ruby

   describe os.redhat? do
      it { should eq true }
   end

Use the following helpers to test for operating system names, releases, and architectures:

.. code-block:: ruby

   describe os.name do
      it { should eq 'foo' }
   end

.. code-block:: ruby

   describe os.release do
      it { should eq 'foo' }
   end

.. code-block:: ruby

   describe os.arch do
      it { should eq 'foo' }
   end

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test for RedHat**

.. To test for RedHat:

.. code-block:: ruby

   describe os[:family] do
     it { should eq 'redhat' }
   end

**Test for Ubuntu**

.. To test for Ubuntu:

.. code-block:: ruby

   describe os[:family] do
     it { should eq 'debian' }
   end

**Test for Microsoft Windows**

.. To test for Microsoft Windows:

.. code-block:: ruby

   describe os[:family] do
     it { should eq 'windows' }
   end


os_env
=====================================================
Use the ``os_env`` InSpec audit resource to test the environment variables for the platform on which the system is running.

Syntax
-----------------------------------------------------
A ``os_env`` InSpec audit resource block declares an environment variable, and then declares its value:

.. code-block:: ruby

   describe os_env('VARIABLE') do
     its('matcher') { should eq 1 }
   end

where

* ``('VARIABLE')`` must specify an environment variable, such as ``PATH``
* ``matcher`` is a valid matcher for this InSpec audit resource

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

content
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``content`` matcher return the value of the environment variable:

.. code-block:: ruby

   its('content') { should eq '/usr/local/bin:/usr/local/sbin:/usr/sbin:/usr/bin:/sbin' }

split
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``split`` splits the content with the ``:``` deliminator:

.. code-block:: ruby

   its('split') { should include ('') }

or:

.. code-block:: ruby

   its('split') { should_not include ('.') }

Use ``-1`` to test for cases where there is a trailing colon (``:``), such as ``dir1::dir2:``:

.. code-block:: ruby

   its('split') { should include ('-1') }

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test the PATH environment variable**

.. To test the PATH environment variable:

.. code-block:: ruby

   describe os_env('PATH') do
     its('split') { should_not include('') }
     its('split') { should_not include('.') }
   end

**Test Habitat environment variables**

.. To test Habitat environment variables:

Habitat uses the ``os_env`` resource to `test environment variables <https://github.com/habitat-sh/habitat/blob/master/test/hab_inspec/controls/clean_env.rb>`_. The environment variables are first defined in a whitespace array, after which each environment variable is tested:

.. code-block:: ruby

   hab_env_vars = %w(HAB_AUTH_TOKEN
                     HAB_CACHE_KEY_PATH
                     HAB_DEPOT_URL
                     HAB_ORG
                     HAB_ORIGIN
                     HAB_ORIGIN_KEYS
                     HAB_RING
                     HAB_RING_KEY
                     HAB_STUDIOS_HOME
                     HAB_STUDIO_ROOT
                     HAB_USER)

   hab_env_vars.each do |e|
     describe os_env(e) do
       its('content') { should eq nil }
     end
   end

package
=====================================================
Use the ``package`` InSpec audit resource to test if the named package and/or package version is installed on the system.

Syntax
-----------------------------------------------------
A ``package`` InSpec audit resource block declares a package and (optionally) a package version:

.. code-block:: ruby

   describe package('name') do
     it { should be_installed }
   end

where

* ``('name')`` must specify the name of a package, such as ``'nginx'``
* ``be_installed`` is a valid matcher for this InSpec audit resource

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

be_installed
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``be_installed`` matcher tests if the named package is installed on the system:

.. code-block:: ruby

   it { should be_installed }

version
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``version`` matcher tests if the named package version is on the system:

.. code-block:: ruby

   its('version') { should eq '1.2.3' }

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test if nginx version 1.9.5 is installed**

.. To test if nginx version 1.9.5 is installed:

.. code-block:: ruby

   describe package('nginx') do
     it { should be_installed }
     its('version') { should eq 1.9.5 }
   end

**Test that a package is not installed**

.. To test that a package is not installed:

.. code-block:: ruby

   describe package('some_package') do
     it { should_not be_installed }
   end

**Test if telnet is installed**

.. To test if telnet is installed:

.. code-block:: ruby

   describe package('telnetd') do
     it { should_not be_installed }
   end

   describe inetd_conf do
     its('telnet') { should eq nil }
   end

**Test if ClamAV (an antivirus engine) is installed and running**

.. To test if ClamAV (an antivirus engine) is installed and running:

.. code-block:: ruby

   describe package('clamav') do
     it { should be_installed }
     its('version') { should eq '0.98.7' }
   end

   describe service('clamd') do
     it { should_not be_enabled }
     it { should_not be_installed }
     it { should_not be_running }
   end

**Verify if Memcached is installed, enabled, and running** 

.. include:: ../../step_inspec/step_inspec_service_memcached.rst

parse_config
=====================================================
Use the ``parse_config`` InSpec audit resource to test arbitrary configuration files.

Syntax
-----------------------------------------------------
A ``parse_config`` InSpec audit resource block declares the location of the configuration setting to be tested, and then what value is to be tested. Because this InSpec audit resource relies on arbitrary configuration files, the test itself is often arbitrary and relies on custom Ruby code:

.. code-block:: ruby

   output = command('some-command').stdout

   describe parse_config(output, { data_config_option: value } ) do
     its('setting') { should eq 1 }
   end

or:

.. code-block:: ruby

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
* May run a command to ``stdout``, and then run the test against that output
* May use options to define how configuration data is to be parsed

Options
-----------------------------------------------------
This InSpec audit resource supports the following options for parsing configuration data. Use them in an ``options`` block stated outside of (and immediately before) the actual test:

.. code-block:: ruby

   options = {
       assignment_re: /^\s*([^:]*?)\s*:\s*(.*?)\s*$/,
       multiple_values: true
     }
   describe parse_config(options) do
     its('setting') { should eq 1 }
   end

assignment_re
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_options_assign_regex.rst

comment_char
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_options_comment_char.rst

key_vals
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_options_key_values.rst

multiple_values
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_options_multiple_values.rst

standalone_comments
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_options_standalone.rst

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test the expiration time for new account passwords**

.. To test the expiration time for new account passwords:

.. code-block:: ruby

   output = command('useradd -D').stdout

   describe parse_config(output) do
     its('INACTIVE') { should eq '35' }
   end

**Test that bob is a user**

.. To test that bob is a user:

.. code-block:: ruby

   describe parse_config(data, { multiple_values: true }) do
     its('users') { should include 'bob'}
   end


parse_config_file
=====================================================
Use the ``parse_config_file`` InSpec audit resource to test arbitrary configuration files. It works in the same way as ``parse_config``. Instead of using a command output, this resource works with files.

Syntax
-----------------------------------------------------
A ``parse_config_file`` InSpec audit resource block declares the location of the configuration file to be tested, and then which settings in that file are to be tested.

.. code-block:: ruby

   describe parse_config_file('/path/to/file', { data_config_option: value } ) do
     its('setting') { should eq 1 }
   end

or:

.. code-block:: ruby

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
* May run a command to ``stdout``, and then run the test against that output
* May use options to define how configuration data is to be parsed

Options
-----------------------------------------------------
This InSpec audit resource supports the following options for parsing configuration data. Use them in an ``options`` block stated outside of (and immediately before) the actual test:

.. code-block:: ruby

   options = {
       assignment_re: /^\s*([^:]*?)\s*:\s*(.*?)\s*$/,
       multiple_values: true
     }
   describe parse_config_file('path/to/file',  options) do
     its('setting') { should eq 1 }
   end

assignment_re
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_options_assign_regex.rst

comment_char
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_options_comment_char.rst

key_vals
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_options_key_values.rst

multiple_values
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_options_multiple_values.rst

standalone_comments
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_options_standalone.rst

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test a configuration setting**

.. To test a configuration setting:

.. code-block:: ruby

   describe parse_config_file('/path/to/file.conf') do
    its('PARAM_X') { should eq 'Y' }
   end

**Use options, and then test a configuration setting**

.. To use options, and then test a configuration setting:

.. code-block:: ruby

   describe parse_config_file('/path/to/file.conf', { multiple_values: true }) do
    its('PARAM_X') { should include 'Y' }
   end


passwd
=====================================================
Use the ``passwd`` InSpec audit resource to test the contents of ``/etc/passwd``, which contains the following information for users that may log into the system and/or as users that own running processes. The format for ``/etc/passwd`` includes:

* A username
* The password for that user (on newer systems passwords should be stored in ``/etc/shadow`` )
* The user identifier (UID) assigned to that user
* The group identifier (GID) assigned to that user
* Additional information about that user
* That user's home directory
* That user's default command shell

These entries are defined as a colon-delimited row in the file, one row per user:

.. code-block:: bash

   root:x:1234:5678:additional_info:/home/dir/:/bin/bash

Syntax
-----------------------------------------------------
A ``passwd`` InSpec audit resource block declares one (or more) users and associated user information to be tested:

.. code-block:: ruby

   describe passwd do
     its('users') { should_not include 'forbidden_user' }
   end

   describe passwd.uid(filter) do
     its('users') { should cmp 'root' }
     its('count') { should eq 1 }
   end

where

* ``homes``, ``gids``, ``passwords``, ``shells``, ``uids``, and ``users`` are valid accessors for ``passwd``
* ``filter`` one (or more) arguments, for example: ``passwd.users(/name/)`` used to define filtering
* ``filter`` may take any of the following arguments: ``count`` (retrieves the number of entries), ``lines`` (provides raw ``passwd`` lines), and ``params`` (returns an array of maps for all entries)

Matchers for passwd
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

gids
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``gids`` matcher tests if the group indentifiers in the test match group identifiers in ``/etc/passwd``:

.. code-block:: ruby

   its('gids') { should include 1234 }
   its('gids') { should cmp 0 }

homes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``homes`` matcher tests the absolute path to a user's home directory:

.. code-block:: ruby

   its('home') { should eq '/' }

length
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``length`` matcher tests the length of a password that appears in ``/etc/passwd``:

.. code-block:: ruby

   its('length') { should be <= 32 }

.. note:: This matcher is best used in conjunction with filters. For example:

   .. code-block:: ruby

      describe passwd.users('highlander') do
         its('length') { should_not be < 16 }
      end

passwords
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``passwords`` matcher tests if passwords are

* Encrypted
* Have direct logins disabled, as indicated by an asterisk (``*``)
* In the ``/etc/shadow`` file, as indicated by the letter x (``x``)

For example:

.. code-block:: ruby

   its('passwords') { should eq ['x'] }
   its('passwords') { should cmp '*' }

shells
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``shells`` matcher tests the absolute path of a shell (or command) to which a user has access:

.. code-block:: ruby

   its('shells') { should_not include 'user' }

or to find all users with the nologin shell:

.. code-block:: ruby

   describe passwd.shells(/nologin/) do
     its('users') { should_not include 'my_login_user' }
   end

uids
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``uids`` matcher tests if the user indentifiers in the test match user identifiers in ``/etc/passwd``:

.. code-block:: ruby

   its('uids') { should eq ['1234', '1235'] }

or:

.. code-block:: ruby

   describe passwd.uids(0) do
     its('users') { should cmp 'root' }
     its('count') { should eq 1 }
   end

users
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``users`` matcher tests if the user names in the test match user names in ``/etc/passwd``:

.. code-block:: ruby

   its('users') { should eq ['root', 'www-data'] }

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test usernames and UIDs**

.. To test usernames and UIDs:

.. code-block:: ruby

   describe passwd do
     its('users') { should eq ['root', 'www-data'] }
     its('uids') { should eq [0, 33] }
   end

**Select one user and test for multiple occurrences**

.. To test for multiple root users:

.. code-block:: ruby

   describe passwd.uids(0) do
     its('users') { should cmp 'root' }
     its('count') { should eq 1 }
   end

   describe passwd.filter(user: 'www-data') do
     its('uids') { should cmp 33 }
     its('count') { should eq 1 }
   end


pip
=====================================================
Use the ``pip`` InSpec audit resource to test packages that are installed using the pip installer.

Syntax
-----------------------------------------------------
A ``pip`` InSpec audit resource block declares a package and (optionally) a package version:

.. code-block:: ruby

   describe pip('Jinja2') do
     it { should be_installed }
   end

where

* ``'Jinja2'`` is the name of the package
* ``be_installed`` tests to see if the ``Jinja2`` package is installed

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

be_installed
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``be_installed`` matcher tests if the named package is installed on the system:

.. code-block:: ruby

   it { should be_installed }

version
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``version`` matcher tests if the named package version is on the system:

.. code-block:: ruby

   its('version') { should eq '1.2.3' }

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test if Jinja2 is installed on the system**

.. To test if Jinja2 is installed on the system:

.. code-block:: ruby

   describe pip('Jinja2') do
     it { should be_installed }
   end

**Test if Jinja2 2.8 is installed on the system**

.. To test if Jinja2 2.8 is installed on the system:

.. code-block:: ruby

   describe pip('Jinja2') do
     it { should be_installed }
     its('version') { should eq '2.8' }
   end

port
=====================================================
Use the ``port`` InSpec audit resource to test basic port properties, such as port, process, if it's listening.

Syntax
-----------------------------------------------------
A ``port`` InSpec audit resource block declares a port, and then depending on what needs to be tested, a process, protocol, process identifier, and its state (is it listening?):

.. code-block:: ruby

   describe port(514) do
     it { should be_listening }
     its('processes') {should include 'syslog'}
   end

where the ``processes`` returns the processes listening on port 514.

A filter may specify an attribute:

.. code-block:: ruby

   describe port.where { protocol =~ /tcp/ && port > 22 && port < 80 } do
     it { should_not be_listening }
   end

where

* ``.where{}`` specifies a block in which one (or more) attributes---``port``, ``address``, ``protocol``, ``process``, ``pid``, or ``listening?``----scope the test to ports that match those attributes

For example, to test if the SSH daemon is available on a Linux machine via the default port (22):

.. code-block:: ruby

   describe port(22) do
     its('processes') { should include 'sshd' }
     its('protocols') { should include 'tcp' }
     its('addresses') { should include '0.0.0.0' }
   end

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

address
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``addresses`` matcher tests if the specified address is associated with a port:

.. code-block:: ruby

   its('addresses') { should include '0.0.0.0' }

be_listening
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``be_listening`` matcher tests if the port is listening for traffic:

.. code-block:: ruby

   it { should be_listening }

pid
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``pids`` matcher tests the process identifiers (PIDs):

.. code-block:: ruby

   its('pids') { should eq ['27808'] }

processes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``processes`` matcher tests if the named process is running on the system:

.. code-block:: ruby

   its('processes') { should eq ['syslog'] }

protocol
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``protocols`` matcher tests the Internet protocol: ICMP (``'icmp'``), TCP (``'tcp'`` or ``'tcp6'``), or UDP (``'udp'`` or ``'udp6'``):

.. code-block:: ruby

   its('protocols') { should include 'tcp' }

or for the Internet Protocol version 6 (IPv6) protocol:

.. code-block:: ruby

   its('protocols') { should include 'tcp6' }

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test port 80, listening with the TCP protocol**

.. To test port 80, listening with the TCP protocol:

.. code-block:: ruby

   describe port(80) do
     it { should be_listening }
     its('protocols') {should eq ['tcp']}
   end

**Test port 80, on a specific address**

.. To test port 80, on a specific address:

A specific port address may be checked using either of the following examples:

.. code-block:: ruby

   describe port(80) do
     it { should be_listening }
     its('addresses') {should include '0.0.0.0'}
   end

or:

.. code-block:: ruby

   describe port('0.0.0.0', 80) do
     it { should be_listening }
   end

**Test port 80, listening with TCP version IPv6 protocol**

.. To test port 80, listening with TCP version IPv6 protocol:

.. code-block:: ruby

   describe port(80) do
     it { should be_listening }
     its('protocols') {should eq ['tcp6']}
   end

**Test that only secure ports accept requests**

.. include:: ../../step_inspec/step_inspec_port_listen_on_secure_ports.rst

**Verify if Memcached is installed, enabled, and running** 

.. include:: ../../step_inspec/step_inspec_service_memcached.rst

**Verify port 65432 is not listening** 

.. To test that port 22 is listening and that 65432 is not listening:

.. code-block:: ruby

   describe port(22) do
     it { should be_listening }
     its('protocols') { should include('tcp') }
     its('protocols') { should_not include('udp') }
   end
   
   describe port(65432) do
     it { should_not be_listening }
   end


postgres_conf
=====================================================
Use the ``postgres_conf`` InSpec audit resource to test the contents of the configuration file for PostgreSQL, typically located at ``/etc/postgresql/<version>/main/postgresql.conf`` or ``/var/lib/postgres/data/postgresql.conf``, depending on the platform.

Syntax
-----------------------------------------------------
A ``postgres_conf`` InSpec audit resource block declares one (or more) settings in the ``postgresql.conf`` file, and then compares the setting in the configuration file to the value stated in the test:

.. code-block:: ruby

   describe postgres_conf('path') do
     its('setting') { should eq 'value' }
   end

where

* ``'setting'`` specifies a setting in the ``postgresql.conf`` file
* ``('path')`` is the non-default path to the ``postgresql.conf`` file (optional)
* ``should eq 'value'`` is the value that is expected

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

setting
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``setting`` matcher tests specific, named settings in the ``postgresql.conf`` file:

.. code-block:: ruby

   its('setting') { should eq 'value' }

Use a ``setting`` matcher for each setting to be tested.

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test the maximum number of allowed client connections**

.. To test the maximum number of allowed client connections:

.. code-block:: ruby

   describe postgres_conf do
     its('max_connections') { should eq '5' }
   end

**Test system logging**

.. To test system logging:

.. code-block:: ruby

   describe postgres_conf do
     its('logging_collector') { should eq 'on' }
     its('log_connections') { should eq 'on' }
     its('log_disconnections') { should eq 'on' }
     its('log_duration') { should eq 'on' }
     its('log_hostname') { should eq 'on' }
     its('log_line_prefix') { should eq '%t %u %d %h' }
   end

**Test the port on which PostgreSQL listens**

.. To test the port on which PostgreSQL listens:

.. code-block:: ruby

   describe postgres_conf do
     its('port') { should eq '5432' }
   end

**Test the Unix socket settings**

.. To test the Unix socket settings:

.. code-block:: ruby

   describe postgres_conf do
     its('unix_socket_directories') { should eq '.s.PGSQL.5432' }
     its('unix_socket_group') { should eq nil }
     its('unix_socket_permissions') { should eq '0770' }
   end

where ``unix_socket_group`` is set to the PostgreSQL default setting (the group to which the server user belongs).


postgres_session
=====================================================
Use the ``postgres_session`` InSpec audit resource to test SQL commands run against a PostgreSQL database.

Syntax
-----------------------------------------------------
A ``postgres_session`` InSpec audit resource block declares the username and password to use for the session, and then the command to be run:

.. code-block:: ruby

   sql = postgres_session('username', 'password')

   describe sql.query('SELECT * FROM pg_shadow WHERE passwd IS NULL;') do
     its('output') { should eq('') }
   end

where

* ``sql = postgres_session`` declares a username and password with permission to run the query
* ``sql.query('')`` contains the query to be run
* ``its('output') { should eq('') }`` compares the results of the query against the expected result in the test

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

output
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``output`` matcher tests the results of the query:

.. code-block:: ruby

   its('output') { should eq(/^0/) }

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test the PostgreSQL shadow password**

.. To test the PostgreSQL shadow password:

.. code-block:: ruby

   sql = postgres_session('my_user', 'password')

   describe sql.query('SELECT * FROM pg_shadow WHERE passwd IS NULL;') do
     its('output') { should eq('') }
   end

**Test for risky database entries**

.. To test for risky database entries:

.. code-block:: ruby

   describe postgres_session('my_user', 'password').query('SELECT count (*)
                 FROM pg_language
                 WHERE lanpltrusted = \'f\'
                 AND lanname!=\'internal\'
                 AND lanname!=\'c\';') do
     its('output') { should eq '0' }
   end



process
=====================================================
Use the ``processes`` InSpec audit resource to test properties for programs that are running on the system.

Syntax
-----------------------------------------------------
A ``processes`` InSpec audit resource block declares the name of the process to be tested, and then declares one (or more) property/value pairs:

.. code-block:: ruby

   describe processes('process_name') do
     its('property_name') { should eq ['property_value'] }
   end

where

* ``processes('process_name')`` must specify the name of a process that is running on the system
* ``property_name`` may be used to test user (``its('users')``) and state properties (``its('states')``) 

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

property_name
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``property_name`` matcher tests the named property for the specified value:

.. code-block:: ruby

   its('property_name') { should eq ['property_value'] }

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test if the list length for the mysqld process is 1**

.. To test if the list length for the mysqld process is 1:

.. code-block:: ruby

   describe processes('mysqld') do
     its('list.length') { should eq 1 }
   end

**Test if the init process is owned by the root user**

.. To test if the init process is owned by the root user: 

.. code-block:: ruby

   describe processes('init') do
     its('users') { should eq ['root'] }
   end

**Test if a high-priority process is running**

.. To test if a high-priority process is running:

.. code-block:: ruby

   describe processes('some_process') do
     its('states') { should eq ['R<'] }
   end


registry_key
=====================================================
Use the ``registry_key`` InSpec audit resource to test key values in the Microsoft Windows registry.

Syntax
-----------------------------------------------------
A ``registry_key`` InSpec audit resource block declares the item in the Microsoft Windows registry, the path to a setting under that item, and then one (or more) name/value pairs to be tested.

Use a registry key name and path:

.. code-block:: ruby

   describe registry_key('Task Scheduler','HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\Schedule') do
     its('Start') { should eq 2 }
   end

Use only a registry key path:

.. code-block:: ruby

   describe registry_key('Task Scheduler','HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\Schedule') do
     its('Start') { should eq 2 }
   end

Or use a Hash:

.. code-block:: ruby

   describe registry_key({
     name: 'Task Scheduler',
     hive: 'HKEY_LOCAL_MACHINE',
     key: '\SYSTEM\CurrentControlSet\services\Schedule'
   }) do
     its('Start') { should eq 2 }
   end


Registry Key Path Separators
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_windows/includes_windows_registry_key_backslashes.rst

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

children
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``children`` matcher return all of the child items of a registry key. A regular expression may be used to filter child items:

.. code-block:: ruby

   describe registry_key('Key Name', '\path\to\key').children(regex)
     ...
   end

For example, to get all child items for a registry key:

.. code-block:: ruby

   describe registry_key('Task Scheduler','HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet').children do
     it { should_not eq [] }
   end

The following example shows how find a property that may exist against multiple registry keys, and then test that property for every registry key in which that property is located:

.. code-block:: ruby

   describe registry_key({
     hive: HKEY_USERS
   }).children(/^S-1-5-21-[0-9]+-[0-9]+-[0-9]+-[0-9]{3,}\\Software\\Policies\\Microsoft\\Windows\\Installer/).each
     { |key|
       describe registry_key(key) do
         its('AlwaysInstallElevated') { should eq 'value' }
       end
     }

exists
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``exist`` matcher tests if the registry key is present:

.. code-block:: ruby

   it { should exist }

have_property
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``have_property`` matcher tests if a property exists for a registry key:

.. code-block:: ruby

   it { should have_property 'value' }

have_property_value
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``have_property_value`` matcher tests if a property value exists for a registry key:

.. code-block:: ruby

   it { should have_property_value 'value' }

have_value
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``have_value`` matcher tests if a value exists for a registry key:

.. code-block:: ruby

   it { should have_value 'value' }

name
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``name`` matcher tests the value for the specified registry setting:

.. code-block:: ruby

   its('name') { should eq 'value' }

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test the start time for the Schedule service**

.. To test the start time for the Schedule service: 

.. code-block:: ruby

   describe registry_key('Task Scheduler','HKEY_LOCAL_MACHINE\...\Schedule') do
     its('Start') { should eq 2 }
   end

where ``'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\Schedule'`` is the full path to the setting.

**Use a regular expression in responses**

.. To use a regular expression in the response: 

.. code-block:: ruby

   describe registry_key({
     hive: 'HKEY_LOCAL_MACHINE',
     key: 'SOFTWARE\Microsoft\Windows NT\CurrentVersion'
   }) do
     its('ProductName') { should match /^[a-zA-Z0-9\(\)\s]*2012\s[rR]2[a-zA-Z0-9\(\)\s]*$/ }
   end

script
=====================================================
Use the ``script`` InSpec audit resource to test a Windows PowerShell script on the Microsoft Windows platform.


Syntax
-----------------------------------------------------
A ``script`` InSpec audit resource block declares a script to be tested, and then a command that should be part of that script:

.. code-block:: ruby

   script = <<-EOH
     # you powershell script
   EOH

   describe script(script) do
     its('matcher') { should eq 'output' }
   end


where

* ``'script'`` must specify a Powershell script to be run
* ``'matcher'`` is one of ``exit_status``, ``stderr``, or ``stdout``
* ``'output'`` tests the output of the command run on the system versus the output value stated in the test

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

exit_status
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``exit_status`` matcher tests the exit status for the command:

.. code-block:: ruby

   its('exit_status') { should eq 123 }

stderr
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``stderr`` matcher tests results of the command as returned in standard error (stderr):

.. code-block:: ruby

   its('stderr') { should eq 'error' }

stdout
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``stdout`` matcher tests results of the command as returned in standard output (stdout):

.. code-block:: ruby

   its('stdout') { should eq '/^1$/' }

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Get all groups of Administrator user**

.. To get all groups of Administrator user: 

.. code-block:: ruby

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
=====================================================
Use the ``security_policy`` InSpec audit resource to test security policies on the Microsoft Windows platform.

Syntax
-----------------------------------------------------
A ``security_policy`` InSpec audit resource block declares the name of a security policy and the value to be tested:

.. code-block:: ruby

   describe security_policy do
     its('policy_name') { should eq 'value' }
   end

where

* ``'policy_name'`` must specify a security policy
* ``{ should eq 'value' }`` tests the value of ``policy_name`` against the value declared in the test

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

policy_name
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``policy_name`` matcher must be the name of a security policy:

.. code-block:: ruby

   its('SeNetworkLogonRight') { should eq '*S-1-5-11' }

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Verify that only the Administrators group has remote access**

.. To verify that only the Administrators group has remote access:

.. code-block:: ruby

   describe security_policy do
     its('SeRemoteInteractiveLogonRight') { should eq '*S-1-5-32-544' }
   end


service
=====================================================
Use the ``service`` InSpec audit resource to test if the named service is installed, running and/or enabled.

Syntax
-----------------------------------------------------
A ``service`` InSpec audit resource block declares the name of a service and then one (or more) matchers to test the state of the service:

.. code-block:: ruby

   describe service('service_name') do
     it { should be_installed }
     it { should be_enabled }
     it { should be_running }
   end

where

* ``('service_name')`` must specify a service name
* ``be_installed``, ``be_enabled``, and ``be_running`` are valid matchers for this InSpec audit resource

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

be_enabled
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``be_enabled`` matcher tests if the named service is enabled:

.. code-block:: ruby

   it { should be_enabled }

be_installed
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``be_installed`` matcher tests if the named service is installed:

.. code-block:: ruby

   it { should be_installed }

be_running
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``be_running`` matcher tests if the named service is running:

.. code-block:: ruby

   it { should be_running }

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test if the postgresql service is both running and enabled**

.. To test if the postgresql service is both running and enabled:

.. code-block:: ruby

   describe service('postgresql') do
     it { should be_enabled }
     it { should be_running }
   end

**Test if the mysql service is both running and enabled**

.. To test if the mysql service is both running and enabled:

.. code-block:: ruby

   describe service('mysqld') do
     it { should be_enabled }
     it { should be_running }
   end

**Test if ClamAV (an antivirus engine) is installed and running**

.. To test if ClamAV (an antivirus engine) is installed and running:

.. code-block:: ruby

   describe package('clamav') do
     it { should be_installed }
     its('version') { should eq '0.98.7' }
   end

   describe service('clamd') do
     it { should_not be_enabled }
     it { should_not be_installed }
     it { should_not be_running }
   end

**Test Unix System V run levels**

.. To test Unix System V services:

On targets that are using System V services, the existing run levels can also be checked:

.. code-block:: ruby

   describe service('sshd').runlevels do
     its('keys') { should include(2) }
   end

   describe service('sshd').runlevels(2,4) do
     it { should be_enabled }
   end

**Override the service manager**

.. To override the service manager:

Under some circumstances, it may be required to override the logic in place to select the right service manager. For example, to check a service managed by Upstart:

.. code-block:: ruby

   describe upstart_service('service') do
     it { should_not be_enabled }
     it { should be_installed }
     it { should be_running }
   end

This is also possible with ``systemd_service``, ``runit_service``, ``sysv_service``, ``bsd_service``, and ``launchd_service``. Provide the control command when it is not to be found at the default location.
For example, if the ``sv`` command for services managed by runit is not in the ``PATH``:

.. code-block:: ruby

   describe runit_service('service', '/opt/chef/embedded/sbin/sv') do
     it { should be_enabled }
     it { should be_installed }
     it { should be_running }
   end

**Verify if Memcached is installed, enabled, and running** 

.. include:: ../../step_inspec/step_inspec_service_memcached.rst

ssh_config
=====================================================
Use the ``ssh_config`` InSpec audit resource to test OpenSSH SSH client configuration data located at ``/etc/ssh/ssh_config`` on Linux and UNIX platforms.

Syntax
-----------------------------------------------------
A ``ssh_config`` InSpec audit resource block declares the client OpenSSH configuration data to be tested:

.. code-block:: ruby

   describe ssh_config('path') do
     its('name') { should include('foo') }
   end

where

* ``name`` is a configuration setting in ``ssh_config``
* ``('path')`` is the non-default ``/path/to/ssh_config``
* ``{ should include('foo') }`` tests the value of ``name`` as read from ``ssh_config`` versus the value declared in the test

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

name
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``name`` matcher tests the value of ``name`` as read from ``ssh_config`` versus the value declared in the test:

.. code-block:: ruby

   its('name') { should eq 'foo' }

or:

.. code-block:: ruby

   its('name') { should include('bar') }

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test SSH configuration settings**

.. To test SSH configuration settings:

.. code-block:: ruby

   describe ssh_config do
     its('cipher') { should contain '3des' }
     its('port') { should eq '22' }
     its('hostname') { should include('example.com') }
   end

**Test which variables from the local environment are sent to the server**

.. include:: ../../step_inspec/step_inspec_ssh_config_owner_and_group.rst

**Test owner and group permissions**

.. include:: ../../step_inspec/step_inspec_ssh_config_owner_and_group.rst

**Test SSH configuration**

.. To test SSH configuration:

.. code-block:: ruby

  describe ssh_config do
    its('Host') { should eq '*' }
    its('Tunnel') { should eq nil }
    its('SendEnv') { should eq 'LANG LC_*' }
    its('HashKnownHosts') { should eq 'yes' }
  end


sshd_config
=====================================================
Use the ``sshd_config`` InSpec audit resource to test configuration data for the OpenSSH daemon located at ``/etc/ssh/sshd_config`` on Linux and UNIX platforms. sshd---the OpenSSH daemon---listens on dedicated ports, starts a daemon for each incoming connection, and then handles encryption, authentication, key exchanges, command executation, and data exchanges.

Syntax
-----------------------------------------------------
A ``sshd_config`` InSpec audit resource block declares the client OpenSSH configuration data to be tested:

.. code-block:: ruby

   describe sshd_config('path') do
     its('name') { should include('foo') }
   end

where

* ``name`` is a configuration setting in ``sshd_config``
* ``('path')`` is the non-default ``/path/to/sshd_config``
* ``{ should include('foo') }`` tests the value of ``name`` as read from ``sshd_config`` versus the value declared in the test

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

name
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``name`` matcher tests the value of ``name`` as read from ``sshd_config`` versus the value declared in the test:

.. code-block:: ruby

   its('name') { should cmp 'foo' }

or:

.. code-block:: ruby

   its('name') {should include('bar') }

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test which variables may be sent to the server**

.. To test which variables may be sent to the server:

.. code-block:: ruby

   describe sshd_config do
     its('AcceptEnv') { should include('GORDON_SERVER') }
   end

**Test for IPv6-only addresses**

.. To test for IPv6-only addresses:

.. code-block:: ruby

   describe sshd_config do
     its('AddressFamily') { should cmp 'inet6' }
   end

**Test the Protocol setting**

.. To test the Protocol setting:

.. code-block:: ruby

   describe sshd_config do
     its('Protocol') { should cmp 2 }
   end

**Test for approved, strong ciphers**

.. include:: ../../step_inspec/step_inspec_sshd_conf_use_strong_ciphers.rst

**Test SSH protocols**

.. To test SSH protocols:

.. code-block:: ruby

  describe sshd_config do
    its('Port') { should cmp  22 }
    its('UsePAM') { should eq 'yes' }
    its('ListenAddress') { should eq nil }
    its('HostKey') { should eq [
        '/etc/ssh/ssh_host_rsa_key',
        '/etc/ssh/ssh_host_dsa_key',
        '/etc/ssh/ssh_host_ecdsa_key',
      ] }
  end


user
=====================================================
Use the ``user`` InSpec audit resource to test user profiles for a single, known/expected local user, including the groups to which that user belongs, the frequency of required password changes, and the directory paths to home and shell.

Syntax
-----------------------------------------------------
A ``user`` InSpec audit resource block declares a user name, and then one (or more) matchers:

.. code-block:: ruby

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
* ``gid``, ``group``, ``groups``, ``home``, ``maxdays``, ``mindays``, ``shell``, ``uid``, and ``warndays`` are valid matchers for this InSpec audit resource

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

exist
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``exist`` matcher tests if the named user exists:

.. code-block:: ruby

   it { should exist }

gid
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``gid`` matcher tests the group identifier:

.. code-block:: ruby

   its('gid') { should eq 1234 } }

where ``1234`` represents the user identifier.

group
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``group`` matcher tests the group to which the user belongs:

.. code-block:: ruby

   its('group') { should eq 'root' }

where ``root`` represents the group.

groups
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``groups`` matcher tests two (or more) groups to which the user belongs:

.. code-block:: ruby

   its('groups') { should eq ['root', 'other']}

home
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``home`` matcher tests the home directory path for the user:

.. code-block:: ruby

   its('home') { should eq '/root' }

maxdays
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``maxdays`` matcher tests the maximum number of days between password changes:

.. code-block:: ruby

   its('maxdays') { should eq 99 }

where ``99`` represents the maximum number of days.

mindays
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``mindays`` matcher tests the minimum number of days between password changes:

.. code-block:: ruby

   its('mindays') { should eq 0 }

where ``0`` represents the maximum number of days.

shell
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``shell`` matcher tests the path to the default shell for the user:

.. code-block:: ruby

   its('shell') { should eq '/bin/bash' }

uid
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``uid`` matcher tests the user identifier:

.. code-block:: ruby

   its('uid') { should eq 1234 } }

where ``1234`` represents the user identifier.

warndays
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``warndays`` matcher tests the number of days a user is warned before a password must be changed:

.. code-block:: ruby

   its('warndays') { should eq 5 }

where ``5`` represents the number of days a user is warned.

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Verify available users for the MySQL server**

.. To verify available users for the MySQL server:

.. code-block:: ruby

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

.. To test users on multiple platforms:

The Nginx user is typically ``www-data``, but on CentOS it's ``nginx``. The following example shows how to test for the Nginx user with a single test, but accounting for all platforms:

.. code-block:: ruby

   web_user = 'www-data'
   web_user = 'nginx' if os[:family] == 'centos'

   describe user(web_user) do
     it { should exist }
   end


windows_feature
=====================================================
Use the ``windows_feature`` InSpec audit resource to test features on Microsoft Windows via the ``Get-WindowsFeature`` cmdlet.

Syntax
-----------------------------------------------------
A ``windows_feature`` InSpec audit resource block declares the name of the Microsoft Windows feature, tests if that feature is installed, and then returns information about that feature:

.. code-block:: ruby

   describe windows_feature('feature_name') do
     it { should be_installed }
   end

where

* ``('feature_name')`` must specify a Microsoft Windows feature name, such as ``DHCP Server`` or ``IIS-Webserver``
* ``be_installed`` is a valid matcher for this InSpec audit resource

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

be_installed
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``be_installed`` matcher tests if the named Microsoft Windows feature is installed:

.. code-block:: ruby

   it { should be_installed }

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test the DHCP Server feature**

.. To test the DHCP Server feature:

.. code-block:: ruby

   describe windows_feature('DHCP Server') do
     it{ should be_installed }
   end


yaml
=====================================================
Use the ``yaml`` InSpec audit resource to test configuration data in a YAML file.

Syntax
-----------------------------------------------------
A ``yaml`` InSpec audit resource block declares the configuration data to be tested Assume the following YAML file:

.. code-block:: yaml

   name: foo
   array:
     - zero
     - one

This file can be queried using:

.. code-block:: ruby

   describe yaml do
     its('name') { should eq 'foo' }
     its(['array', 1]) { should eq 'one' }
   end

where

* ``name`` is a configuration setting in a YAML file
* ``should eq 'foo'`` tests a value of ``name`` as read from a YAML file versus the value declared in the test

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

name
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``name`` matcher tests the value of ``name`` as read from a YAML file versus the value declared in the test:

.. code-block:: ruby

   its('name') { should eq 'foo' }

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test a kitchen.yml file driver**

.. include:: ../../step_inspec/step_inspec_yaml_kitchen_driver.rst


yum
=====================================================
Use the ``yum`` InSpec audit resource to test packages in the Yum repository.

Syntax
-----------------------------------------------------
A ``yum`` InSpec audit resource block declares a package repo, tests if the package repository is present, and if it that package repository is a valid package source (i.e. "is enabled"):

.. code-block:: ruby

   describe yum.repo('name') do
     it { should exist }
     it { should be_enabled }
   end

where

* ``repo('name')`` is the (optional) name of a package repo, using either a full identifier (``'updates/7/x86_64'``) or a short identifier (``'updates'``)

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

be_enabled
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``be_enabled`` matcher tests if the package repository is a valid package source:

.. code-block:: ruby

   it { should be_enabled }

exist
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``exist`` matcher tests if the package repository exists:

.. code-block:: ruby

   it { should exist }

repo('name')
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``repo('name')`` matcher names a specific package repository:

.. code-block:: ruby

   describe yum.repo('epel') do
     ...
   end

repos
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``repos`` matcher tests if a named repo, using either a full identifier (``'updates/7/x86_64'``) or a short identifier (``'updates'``), is included in the Yum repo:

.. code-block:: ruby

   its('repos') { should include 'some_repo' }

shortname
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``shortname`` matcher names a specific package repository's group identifier. For example, if a repository's group name is "Directory Server", the corresponding group idenfier is typically "directory-server":

.. code-block:: ruby

   describe yum.repo('Directory Server') do
     its('shortname') { should eq 'directory-server' }
   end

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test if the yum repo exists**

.. To test if the yum repo exists:

.. code-block:: ruby

   describe yum do
     its('repos') { should exist }
   end

**Test if the 'base/7/x86_64' repo exists and is enabled**

.. To test if the 'base/7/x86_64' repo exists and is enabled:

.. code-block:: ruby

   describe yum do
     its('repos') { should include 'base/7/x86_64' }
     its('epel') { should exist }
     its('epel') { should be_enabled }
   end

**Test if a specific yum repo exists**

.. To test if a specific yum repo exists:

.. code-block:: ruby

   describe yum.repo('epel') do
     it { should exist }
     it { should be_enabled }
   end
