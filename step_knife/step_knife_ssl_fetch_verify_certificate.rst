.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The |ssl| certificate that is downloaded to the |path trusted_certs| directory should be verified to ensure that it is, in fact, the same certificate as the one located on the |chef server|. This can be done by comparing the |sha256| checksums.

#. View the checksum on the |chef server|:

   .. code-block:: bash

      $ ssh ubuntu@chef-server.example.com sudo sha256sum /var/opt/opscode/nginx/ca/chef-server.example.com.crt

   The response is similar to:

   .. code-block:: bash

      <ABC123checksum>  /var/opt/opscode/nginx/ca/chef-server.example.com.crt

#. View the checksum on the workstation:

   .. code-block:: bash

      $ gsha256sum .chef/trusted_certs/chef-server.example.com.crt

   The response is similar to:

   .. code-block:: bash

      <ABC123checksum>  .chef/trusted_certs/chef-server.example.com.crt

#. Verify that the checksum values are identical.
