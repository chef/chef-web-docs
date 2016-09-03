.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``wait`` matcher tests how a service handles incoming connections.

For UDP (``dgram``) socket types the ``wait`` matcher should test for ``yes``:

.. code-block:: ruby

   its('socket_types') { should eq 'dgram' }
   its('wait') { should eq 'yes' }

For TCP (``stream``) socket types the ``wait`` matcher should test for ``no``:

.. code-block:: ruby

   its('socket_types') { should eq 'stream' }
   its('wait') { should eq 'no' }
