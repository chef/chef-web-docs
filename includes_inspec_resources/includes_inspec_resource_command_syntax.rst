.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A ``command`` |inspec resource| block declares a command to be run, one (or more) expected outputs, and the location to which that output is sent:

.. code-block:: ruby

   describe command('command') do
     it { should exist }
     its('matcher') { should eq 'output' }
   end

where

* ``'command'`` must specify a command to be run
* ``'matcher'`` is one of ``exit_status``, ``stderr``, or ``stdout``
* ``'output'`` tests the output of the command run on the system versus the output value stated in the test
