.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Configuration of SSL for the Chef server using certificate authority-verified certificates is done by placing the certificate and private key file obtained from the certifying authority in the correct files after the initial configuration of Chef server.

Initial configuration of the Chef server is done automatically using a self-signed certificate to create the certificate and private key files for Nginx.

The locations of the certificate and private key files are 

* ``/var/opt/opscode/nginx/ca/FQDN.crt``
* ``/var/opt/opscode/nginx/ca/FQDN.key``

Because the FQDN has already been configured, do the following:

#. Replace the contents of ``/var/opt/opscode/nginx/ca/FQDN.crt`` and ``/var/opt/opscode/nginx/ca/FQDN.key`` with the certifying authority's files.
#. Reconfigure the Chef server:

   .. code-block:: bash

      $ chef-server-ctl reconfigure

#. Restart the Nginx service to load the new key and certificate:

   .. code-block:: bash

      $ chef-server-ctl restart nginx
