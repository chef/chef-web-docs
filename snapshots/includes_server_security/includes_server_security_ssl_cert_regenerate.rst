.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


SSL certificates should be regenerated periodically. This is an important part of protecting the Chef server from vulnerabilities and helps to prevent the information stored on the Chef server from being compromised.

To regenerate SSL certificates:

#. Run the following command:

   .. code-block:: bash
   
      $ chef-server-ctl stop

#. The Chef server can regenerate them. These certificates will be located in ``/var/opt/opscode/nginx/ca/`` and will be named after the FQDN for the Chef server. To determine the FQDN for the server, run the following command:

   .. code-block:: bash

      $ hostname -f

   Please delete the files found in the ca directory with names like this ``$FQDN.crt`` and ``$FQDN.key``.

#. If your organization has provided custom SSL certificates to the Chef server, the locations of that custom certificate and private key are defined in ``/etc/opscode/chef-server.rb`` as values for the ``nginx['ssl_certificate']`` and ``nginx['ssl_certificate_key']`` settings. Delete the files referenced in those two settings and regenerate new keys using the same authority.

#. Run the following command, Chef server-generated SSL certificates will automatically be created if necessary:

   .. code-block:: bash

      $ chef-server-ctl reconfigure

#. Run the following command:

   .. code-block:: bash

      $ chef-server-ctl start


