.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

If you only want certain people to have access to this key, consider adding it to an encrypted data bag. Other options include adding it to the |chef repo|, using ``deploy_to`` property and the |resource deploy| resource, and so on.

To add a private key to a node:

.. code-block:: javascript

   {
     "id": "app",
     "repository": "git@github.com:acctname/private-repo.git",
     "deploy_key": "-----BEGIN RSA PRIVATE KEY-----\n
                    MIIEogIBAAKCAQEAoEN9TWqCSMvdfjke\n
                    ...truncated...",
     "deploy_to": "/tmp/private_code"
   }

Convert new lines in the private key to ``\n`` when copying it to the data bag. Then use the |resource file| resource within the recipe to add it to the node:

.. code-block:: ruby

   app = Chef::EncryptedDataBagItem.load('deploytest', 'app')
   
   file '/tmp/private_code/.ssh/id_deploy' do
     content app['deploy_key']
     owner 'ubuntu'
     mode '0755'
   end
