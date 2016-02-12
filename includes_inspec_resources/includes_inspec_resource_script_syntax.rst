.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A ``script`` |inspec resource| block declares a script to be tested, and then a command that should be part of that script:

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
