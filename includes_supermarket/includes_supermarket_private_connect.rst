.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To reach the newly spun up private |supermarket|, the hostname must be resolvable from a workstation. For production use, the hostname should have a DNS entry in an appropriate domain that is trusted by each user's workstation.

#. Visit the |supermarket| hostname in the browser. A private |supermarket| will generate and use a self-signed certificate, if a certificate is not supplied as part of the installation process (via the wrapper cookbook).
#. If an |ssl| notice is shown while connecting to |supermarket| via a web browser, accept the |ssl| certificate. A trusted SSL certificate should be used for  private |supermarket| that is used in production.
#. After opening |supermarket| in a web browser, click the **Create Account** link. A prompt to log in to the |chef server| is shown, but only if the user is not already logged in. Authorize the |supermarket| to use the |chef server| account for authentication.
