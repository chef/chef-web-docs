.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To search for a cookbook, use a command similar to:

.. code-block:: bash

   $ knife supermarket search mysql

where ``mysql`` is the search term. This will return something similar to:

   mysql:
     cookbook:             http://cookbooks.opscode.com/api/v1/cookbooks/mysql
     cookbook_description: Provides mysql_service, mysql_config, and mysql_client resources
     cookbook_maintainer:  chef
     cookbook_name:        mysql
   mysql-apt-config:
     cookbook:             http://cookbooks.opscode.com/api/v1/cookbooks/mysql-apt-config
     cookbook_description: Installs/Configures mysql-apt-config
     cookbook_maintainer:  tata
     cookbook_name:        mysql-apt-config
   mysql-multi:
     cookbook:             http://cookbooks.opscode.com/api/v1/cookbooks/mysql-multi
     cookbook_description: MySQL replication wrapper cookbook
     cookbook_maintainer:  rackops
     cookbook_name:        mysql-multi
