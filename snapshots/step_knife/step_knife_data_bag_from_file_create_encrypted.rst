.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

To create a data bag named "devops_data" that contains encrypted data, enter:

.. code-block:: bash

   $ knife data bag from file devops_data --secret-file "path to decryption file"


