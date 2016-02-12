.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``policy_name`` matcher must be the name of a security policy:

.. code-block:: ruby

   its('SeNetworkLogonRight') { should eq '*S-1-5-11' }
