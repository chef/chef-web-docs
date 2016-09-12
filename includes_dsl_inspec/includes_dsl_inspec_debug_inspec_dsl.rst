.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The |inspec| shell will automatically evaluate the result of every command as if it were a test file. Use any |inspec| audit resource (and its matchers) in the shell. First open the shell:

.. code-block:: bash

   $ inspec shell
   Welcome to the interactive InSpec Shell
   To find out how to use it, type: help

then run some resources:

.. code-block:: bash
 
   inspec> file('/Users/ksubramanian').directory?
   => true
   inspec> os_env('HOME')
   => Environment variable HOME
   inspec> os_env('HOME').content
   => /Users/ksubramanian
   inspec> exit

|inspec| tests are executed immediately:

.. code-block:: bash
 
   inspec> describe file('/Users')     # Empty test.
   Summary: 0 successful, 0 failures, 0 skipped
   inspec> describe file('/Users') do  # Test with one check.
   inspec>   it { should exist }
   inspec> end
     ✔  File /Users should exist
   
   Summary: 1 successful, 0 failures, 0 skipped

All tests in a control are immediately executed as well. If a control is redefined in the shell, the old control's tests are destroyed and replaced with the redefinition and the control is re-run:

.. code-block:: bash
 
   inspec> control 'my_control' do
   inspec>   describe os_env('HOME') do
   inspec>     its('content') { should eq '/Users/ksubramanian' }
   inspec>   end
   inspec> end
     ✔  my_control: Environment variable HOME content should eq "/Users/ksubramanian"
   
     Summary: 1 successful, 0 failures, 0 skipped

Syntax errors are illegal tests are also detected and reported:

.. code-block:: bash
 
   inspec> control 'foo' do
   inspec>   thisisnonsense
   inspec> end
   NameError: undefined local variable or method 'thisisnonsense' for #<#<Class:0x007fd63b571f98>:0x007fd639825cc8>
   from /usr/local/lib/ruby/gems/2.3.0/gems/rspec-expectations-3.5.0/lib/rspec/matchers.rb:967:in 'method_missing'
   inspec> control 'foo' do
   inspec>   describe file('wut') do
   inspec>     its('thismakesnosense') { should cmp 'fail' }
   inspec>   end
   inspec> end
     ✖  foo: File wut thismakesnosense  (undefined method 'thismakesnosense' for File wut:Inspec::Resource::Registry::File)
   
     Summary: 0 successful, 1 failures, 0 skipped
