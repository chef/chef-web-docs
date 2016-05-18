.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use |pry| inside both the controls and resources. Similarly, for development and testing, use ``inspec shell`` which is based on |pry|, for example:

.. code-block:: ruby

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
