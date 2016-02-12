.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``version`` matcher tests if the named package version is on the system:

.. code-block:: ruby

   its('version) { should eq '1.2.3' }
