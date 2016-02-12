.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The authentication process ensures the |chef server| responds only to requests made by trusted users. Public key encryption is used by the |chef server|. When a node and/or a workstation is configured to run the |chef client|, both public and private keys are created. The public key is stored on the |chef server|, while the private key is returned to the user for safe keeping. (The private key is a .pem file located in the ``.chef`` directory or in ``/etc/chef``.) 

Both the |chef client| and |knife| use the |api chef server| when communicating with the |chef server|. The |chef validator| uses the |api chef server|, but only during the first |chef client| run on a node.

Each request to the |chef server| from those executables sign a special group of HTTP headers with the private key. The |chef server| then uses the public key to verify the headers and verify the contents.
