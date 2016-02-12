.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To copy the certificates, move the certificate files located in ``/var/opt/chef-server/nginx/ca`` to ``/var/opt/opscode/nginx/ca``, and then restart the |service nginx| service:

   .. code-block:: bash

      $ chef-server-ctl restart nginx
