.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``interfaces`` matcher tests if the named secondary interfaces are available:

.. code-block:: ruby

   its('interfaces') { should eq ['eth0', 'eth1', ...] }
