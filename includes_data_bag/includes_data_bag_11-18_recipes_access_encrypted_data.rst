.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A recipe can access encrypted data bag items as long as the recipe is running on a node that has access to the shared-key that is required to decrypt the data. A secret can be specified by using the ``Chef::EncryptedDataBagItem.load`` method. For example:

.. code-block:: ruby

   mysql_creds = Chef::EncryptedDataBagItem.load('passwords', 'mysql', secret_key)
   mysql_creds['pass'] # will be decrypted

where ``secret_key`` is the argument that specifies the location of the file that contains the encryption key.

An encryption key can be stored in a file on the nodes that need it and then configured so that the |chef client| knows where to look using the ``Chef::Config[:encrypted_data_bag_secret]`` method, which defaults to |path encrypted data bag secret|. When the default location is used, the argument that specifies the secret key file location is assumed to be the default and does not need to be explicitly specified in the recipe. For example:

.. code-block:: ruby

   mysql_creds = Chef::EncryptedDataBagItem.load('passwords', 'mysql') # no secret_key
   mysql_creds['pass'] # will be decrypted
