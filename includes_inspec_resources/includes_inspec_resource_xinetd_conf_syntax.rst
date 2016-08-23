.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

An ``xinetd_conf`` |inspec resource| block declares a service in the ``xinetd.conf`` file and then tests configuration settings related to that service:

.. code-block:: ruby

   describe xinetd_conf('service_name') do
     its('matcher') { should eq 'value' }
   end

where

* ``'service_name'`` is a service located under ``/etc/xinet.d``
* ``('matcher')`` is a setting in the ``xinetd.conf`` file
* ``should eq 'value'`` is the value that is expected
