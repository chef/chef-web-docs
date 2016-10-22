.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``SSL_CERT_FILE`` environment variable to specify the location for the SSL certificate authority (CA) bundle that is used by the chef-client.

A value for ``SSL_CERT_FILE`` is not set by default. Unless updated, the locations in which Chef will look for SSL certificates are:

* chef-client: ``/opt/chef/embedded/ssl/certs/cacert.pem``
* Chef development kit: ``/opt/chefdk/embedded/ssl/certs/cacert.pem``

Keeping the default behavior is recommended. To use a custom CA bundle, update the environment variable to specify the path to the custom CA bundle. If (for some reason) SSL certificate verification stops working, ensure the correct value is specified for ``SSL_CERT_FILE``.
