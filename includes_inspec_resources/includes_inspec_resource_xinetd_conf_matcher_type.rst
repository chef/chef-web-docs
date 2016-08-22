.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The type of service: ``INTERNAL`` (a service provided by |xinetd|), ``RPC`` (an RPC-based service), ``TCPMUX`` (a service that is started on a well-known TPCMUX port), or ``UNLISTED`` (a service that is not listed in a standard system file location).

.. code-block:: ruby

   describe xinetd_conf.services('service_name') do
      its('type') { should include 'RPC' }
   end
