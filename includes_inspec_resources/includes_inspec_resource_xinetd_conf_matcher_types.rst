.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``types`` matcher tests the service type:

.. code-block:: ruby

   its('type') { should eq 'TYPE' }

where ``'TYPE'`` is ``INTERNAL`` (for a service provided by |xinetd|), ``RPC`` (for a service based on remote procedure call), or ``UNLISTED`` (for services not under ``/etc/services`` or ``/etc/rpc``).
