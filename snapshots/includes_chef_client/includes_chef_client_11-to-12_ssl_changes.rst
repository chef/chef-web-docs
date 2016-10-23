.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following changes were made during certain chef-client release prior to the chef-client 12 release:

* In the chef-client 11.8 release, the ``verify_api_cert`` setting was added to the client.rb file with a default value of ``false``. 
* In the chef-client 11.12 release, the ``local_key_generation`` setting was added to the client.rb file.

  The ``ssl_verify_mode`` continued to default to ``:verify_none``, but now returned a warning: ``SSL validation of HTTPS requests is disabled...``, followed by steps for how to configure SSL certificate validation for the chef-client.

  Two knife commands---``knife ssl check`` and ``knife ssl fetch`` were added.

  A new directory in the chef-repo---``/.chef/trusted_certs``---was added.

  These new settings and tools enabled users who wanted to use stronger SSL settings to generate the private/public key pair from the chef-client, verify HTTPS requests, verify SSL certificates, and pull the SSL certificate from the Chef server down to the ``/.chef/trusted_certs`` directory.
* In the chef-client 12 release, the default value for ``local_key_generation`` was changed to ``true`` and the default value for ``ssl_verify_mode`` was changed to ``:verify_peer``.

Starting with chef-client 12, SSL certificate validation is enabled by default and the ``knife ssl fetch`` is a necessary `part of the setup process <https://docs.chef.io/install_dk.html#get-ssl-certificates>`__ for every workstation.
