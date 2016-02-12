.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Before a bootstrap operation can be run on a node, |ssh| keys must be set up correctly. In |google compute engine| |ssh| keys are stored in project metadata that is copied over to new servers and placed in a user's ``~/.ssh/authorized_keys`` file.

.. note:: If the |ssh| keys are not already set up, they can be created using the ``ssh-keygen`` program. 

Add the |ssh| key using the **Metadata** page in the |google compute engine| console. Paste the |ssh| key in the user's ``~/.ssh/id_rsa.pub`` file, ensuring to prefix the |ssh| key with the same user name that would be specified when using the ``--ssh-user`` option used by the ``knife server create`` command. 

For example:

.. code-block:: bash

   user_name:ssh-rsa AYAAB3Nwejwejjfjawlwl990sefjsfC5lPulcP4eZB+z1zcMF
   76gTV4vojT/SWXymTfGpBL2KHTmF4jnGfEKPwjHIiLrZNHM2ISMi/atlKjOoUCVT
   AvUyjqqp3z2KVXSP9P50Kgf8JYWjjXKApiZHkJOHJZ8GGf7aTnRU9NEGLbQK6Q1k
   4UHbVG4ps4kSLWsJ7eVcu981GvlwP3ooiJ6YWcOX9PS58d4SNtq41/XaoLibKt/Y
   Wzd/4tjYwMRVcxJdAy1T2474vkU/Qr7ibFinKeJymgouoQpEGhF64cF2pncCcmR7
   zRk7CzL3mhcma8Zvwj234-2f3/+234/AR#@R#y1EEFsbzGbxOJfEVSTgJfvY7KYp
   329df/2348sd3ARTx99 mymail@myhost

where ``user_name:`` is the prefix added to the |ssh| key.