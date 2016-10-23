.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``create`` argument to create a new API client. This process will generate an RSA key pair for the named API client. The public key will be stored on the Chef server and the private key will be displayed on ``STDOUT`` or written to a named file.

* For the chef-client, the private key should be copied to the system as ``/etc/chef/client.pem``.
* For knife, the private key is typically copied to ``~/.chef/client_name.pem`` and referenced in the knife.rb configuration file.

