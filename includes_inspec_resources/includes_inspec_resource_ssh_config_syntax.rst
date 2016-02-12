.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A ``ssh_config`` |inspec resource| block declares the client |open ssh| configuration data to be tested:

.. code-block:: ruby

   describe ssh_config('path') do
     its('name') { should include('foo') }
   end

where

* ``name`` is a configuration setting in ``ssh_config``
* ``('path')`` is the non-default ``/path/to/ssh_config``
* ``{ should include('foo') }`` tests the value of ``name`` as read from ``ssh_config`` versus the value declared in the test
