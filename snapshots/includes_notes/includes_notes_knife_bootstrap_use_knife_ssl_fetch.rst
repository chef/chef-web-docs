.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Starting with chef-client 12.0, use the `knife ssl_fetch <https://docs.chef.io/knife_ssl_fetch.html>`_ command to pull down the SSL certificates from the on-premises Chef server and add them to the ``/trusted_certs_dir`` on the workstation. This certificates is used during a knife bootstrap operation.
