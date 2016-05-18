.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The previous example comments out the ``require 'pry'; binding.pry;`` line. Remove the ``#`` prefix, and then re-run the control. The execution of the control will stop at that line and open a |pry| shell from which troubleshooting, printing variables, viewing available methods, etc. may be one. For example:

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
