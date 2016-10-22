.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

To edit an item named "charlie" that is contained in a data bag named "admins", enter:

.. code-block:: bash

   $ knife data bag edit admins charlie

to open the $EDITOR. Once opened, you can update the data before saving it to the Chef server. For example, by changing:

.. code-block:: javascript

   {
      "id": "charlie"
   }

to:

.. code-block:: javascript

   {
      "id": "charlie",
      "uid": 1005,
      "gid": "ops",
      "shell": "/bin/zsh",
      "comment": "Crazy Charlie"
   }


