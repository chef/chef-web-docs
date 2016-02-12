.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To provision a medium-sized |centos| machine configured as a web server in the ``West US`` data center, while reusing existing hosted service and storage accounts, enter something like:

.. code-block:: bash

   $ knife azure server create -r "role[webserver]" --service-location "West US" 
     --hosted-service-name webservers --storage-account webservers-storage --ssh-user foo 
     --ssh--password password --role-name web-apache-0001 --host-name web-apache 
     --tcp-endpoints 80:80,8080:8080 --source-image name_of_source_image --role-size Medium
