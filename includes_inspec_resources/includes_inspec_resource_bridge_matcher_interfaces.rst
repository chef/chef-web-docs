.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``interfaces`` matcher tests if the named interface is present:

.. code-block:: ruby

   its('interfaces') { should eq 'foo' }
   its('interfaces') { should eq 'bar' }
   its('interfaces') { should include('foo') }
