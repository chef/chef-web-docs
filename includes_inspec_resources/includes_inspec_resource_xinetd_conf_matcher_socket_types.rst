.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``socket_types`` matcher tests if a service listed under ``/etc/xinet.d`` is configured to use the named socket type:

.. code-block:: ruby

   its('socket_types') { should eq 'socket' }

where ``socket`` is one of ``dgram``, ``raw``, or ``stream``. For a UDP-based service:

.. code-block:: ruby

   its('socket_types') { should eq 'dgram' }

For a raw socket (such as a service using a non-standard protocol or a service that requires direct access to IP):

.. code-block:: ruby

   its('socket_types') { should eq 'raw' }

For a TCP-based service:

.. code-block:: ruby

   its('socket_types') { should eq 'stream' }
