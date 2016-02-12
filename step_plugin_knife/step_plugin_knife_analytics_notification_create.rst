.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

To create a notification, run the following command:

.. code-block:: bash

   $ knife notification create FILE_NAME.json

where the ``FILE_NAME.json`` is similar to:

.. code-block:: javascript

   {
     "name": "chef-splunk-example",
     "notification_type": "Splunk",
     "modified_by": "admin",
     "delivery_options": {
       "hostname": "splunk.chef.inc.com",
       "port": 8089,
       "username": "username",
       "password": "password",
       "index": "chef-analytics",
       "sourcetype": "chef-analytics-data"
     }
   }
