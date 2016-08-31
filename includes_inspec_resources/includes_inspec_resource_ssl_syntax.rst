.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A ``ssl`` |inspec resource| block declares an SSL port, and then other properties of the test like cipher and/or protocol:

.. code-block:: ruby

   describe ssl(port: #) do
     it { should be_enabled }
   end

or:

   describe ssl(port: #).filter('value') do
     it { should be_enabled }
   end

where

* ``ssl(port: #)`` is the port number, such as ``ssl(port: 443)``
* ``filter`` may take any of the following arguments: ``ciphers``, ``protocols``, and ``handshake``
