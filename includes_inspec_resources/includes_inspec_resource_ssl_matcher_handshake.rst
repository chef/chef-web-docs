.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``handshake`` matcher tests the handshake message type:

.. code-block:: ruby

   its('handshake') { should eq 'handshake_type }

where ``handshake_type`` is one of:

* ``HelloRequest``
* ``ClientHello``
* ``ServerHello``
* ``NewSessionTicket``
* ``Certificate``
* ``ServerKeyExchange``
* ``CertificateRequest``
* ``ServerHelloDone``
* ``CertificateVerify``
* ``ClientKeyExchange``
* ``Finished``
