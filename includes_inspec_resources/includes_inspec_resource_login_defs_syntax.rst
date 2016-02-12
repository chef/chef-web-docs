.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A ``login_defs`` |inspec resource| block declares the ``login.defs`` configuration data to be tested:

.. code-block:: ruby

   describe login_defs do
     its('name') { should include('foo') }
   end

where

* ``name`` is a configuration setting in ``login.defs``
* ``{ should include('foo') }`` tests the value of ``name`` as read from ``login.defs`` versus the value declared in the test
