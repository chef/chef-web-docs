.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To run the chef-client at periodic intervals (so that it can check in with the Chef server automatically), configure the chef-client to run as a service or as a scheduled task. This can be done via the MSI, by selecting the **Chef Client Service** option on the **Custom Setup** page or by running the following command after the chef-client is installed:

.. code-block:: bash
   
   $ chef-service-manager -a install

and then start the chef-client as a service:

.. code-block:: bash
   
   $ chef-service-manager -a start

After the chef-client is configured to run as a service, the default file path is: ``c:\chef\chef-client.log``. 
