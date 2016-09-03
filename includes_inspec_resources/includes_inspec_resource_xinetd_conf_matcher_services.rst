.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``services`` matcher tests if the named service is listed under ``/etc/xinet.d``:

.. code-block:: ruby

   its('services') { should include 'service_name' }
