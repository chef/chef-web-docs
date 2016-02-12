.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This |inspec resource| matches any service that is listed in the |apache| configuration file:

.. code-block:: ruby

   its('PidFile') { should_not eq '/var/run/httpd.pid' }

or:

.. code-block:: ruby

   its('Timeout') { should eq 300 }

For example:

.. code-block:: ruby

   describe apache_conf do
     its('MaxClients') { should eq 100 }
     its('Listen') { should eq '443'}
   end
