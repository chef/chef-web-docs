.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A ``powershell`` |inspec resource| block declares a |windows powershell| script to be tested, and then compares the output of that command to the matcher in the test:

.. code-block:: ruby

   script = <<-EOH
     # a PowerShell script
   EOH

   describe script(script) do
     its('matcher') { should eq 'output' }
   end


where

* ``'script'`` must specify a Powershell script to be run
* ``'matcher'`` is one of ``exit_status``, ``stderr``, or ``stdout``
* ``'output'`` tests the output of the command run on the system versus the output value stated in the test
