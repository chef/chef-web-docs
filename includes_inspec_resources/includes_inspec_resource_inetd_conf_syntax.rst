.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

An ``inetd_conf`` |inspec resource| block declares the list of services that are enabled in the ``inetd.conf`` file:

.. code-block:: ruby

   describe inetd_conf('path') do
     its('service_name') { should eq 'value' }
   end

where

* ``'service_name'`` is a service listed in the ``inetd.conf`` file
* ``('path')`` is the non-default path to the ``inetd.conf`` file
* ``should eq 'value'`` is the value that is expected
