.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

To generate a certificate for a monitoring server:

#. Run the following command:

   .. code-block:: bash

      $ rake ssl_cert FQDN=monitoring.example.com

#. Once the certificates are generated, copy them into each cookbook that will use them. For example:

   .. code-block:: bash

      $ cp certificates/monitoring.example.com* cookbooks/COOKBOOK_NAME/files/default

   where ``COOKBOOK_NAME`` is the name of the cookbook that will use the certificate.

#. And then in the recipe for each cookbook, create a ``cookbook_file`` resource to configure a resource that puts them in place on the destination server:

   .. code-block:: javascript
   
      cookbook_file '/etc/apache2/ssl/monitoring.example.com.pem'
        owner 'root'
        group 'root'
        mode 0600
      end
