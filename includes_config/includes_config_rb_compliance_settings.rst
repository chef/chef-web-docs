.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This configuration file has the following settings:

``verify_tls``
   Verify the TLS certificate when |chef compliance| connects locally to get the refresh token. Default value: ``false``.

``core.licensed_node_count``
   The number of node licenses. Default value: ``25``.

``ssl.certificate``
   Full path to the ssl certificate file to use by the |chef compliance| web interface. Default value: ``/var/opt/chef-compliance/ssl/ca/HOSTNAME.crt``.

``ssl.certificate_key``
   Full path to the ssl certificate key file to use by the |chef compliance| web interface. Default value: ``/var/opt/chef-compliance/ssl/ca/HOSTNAME.key``.


You can see all available settings along with their default value in ``/etc/chef-compliance/chef-compliance-running.json``
