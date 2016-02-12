.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``create`` argument to create a user. This process will generate an RSA key pair for the named user. The public key will be stored on the |chef server| and the private key will be displayed on ``STDOUT`` or written to a named file.

* For the user, the private key should be copied to the system as |path chef private key|.
* For |knife|, the private key is typically copied to |path chef private key admin| and referenced in the |knife rb| configuration file.

