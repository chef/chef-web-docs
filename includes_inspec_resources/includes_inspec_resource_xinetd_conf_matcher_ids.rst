.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``ids`` matcher tests if the named service is located under ``/etc/xinet.d``:

.. code-block:: ruby

   its('ids') { should include 'service_name' }

For example:

.. code-block:: ruby

   its('ids') { should include 'chargen-stream chargen-dgram'}
