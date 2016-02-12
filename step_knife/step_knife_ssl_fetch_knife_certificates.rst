.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


.. code-block:: bash

   $ knife ssl fetch

The response is similar to:

.. code-block:: bash

   WARNING: Certificates from <chef_server_url> will be fetched and placed in your trusted_cert
   directory (/Users/grantmc/chef-repo/.chef/trusted_certs).
   
   Knife has no means to verify these are the correct certificates. You should
   verify the authenticity of these certificates after downloading.
   
   Adding certificate for <chef_server_url> in /Users/grantmc/chef-repo/.chef/trusted_certs/grantmc.crt
   Adding certificate for DigiCert Secure Server CA in /Users/grantmc/chef-repo/.chef/trusted_certs/DigiCert_Secure_Server_CA.crt
