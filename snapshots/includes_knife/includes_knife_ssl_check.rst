.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``knife ssl check`` subcommand to verify the SSL configuration for the Chef server or a location specified by a URL or URI. Invalid certificates will not be used by OpenSSL.

When this command is run, the certificate files (``*.crt`` and/or ``*.pem``) that are located in the ``/.chef/trusted_certs`` directory are checked to see if they have valid X.509 certificate properties. A warning is returned when certificates do not have valid X.509 certificate properties or if the ``/.chef/trusted_certs`` directory does not contain any certificates.

.. warning:: When verification of a remote server's SSL certificate is disabled, the chef-client will issue a warning similar to "SSL validation of HTTPS requests is disabled. HTTPS connections are still encrypted, but the chef-client is not able to detect forged replies or man-in-the-middle attacks." To configure SSL for the chef-client, set ``ssl_verify_mode`` to ``:verify_peer`` (recommended) **or** ``verify_api_cert`` to ``true`` in the client.rb file.
