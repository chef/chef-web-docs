.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Signed header authentication is used to validate communications between the Chef server and any node that is being managed by the Chef server. An API client manages each authentication request. A public and private key pair is used for the authentication itself. The public key is stored in the database on the Chef server. The private key is stored locally on each node and is kept separate from node data (typically in the ``/etc/chef/client.pem`` directory). Each request to the Chef server by a node must include a request signature in the HTTP headers. This signature is computed from a hash of request content and is encrypted using the private key.
