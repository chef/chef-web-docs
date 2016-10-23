.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A cookbook version can be frozen, which will prevent updates from being made to that version of a cookbook. (A user can always upload a new version of a cookbook.) Using cookbook versions that are frozen within environments is a reliable way to keep a production environment safe from accidental updates while testing changes that are made to a development infrastructure.

For example, to freeze a cookbook version using knife, enter:

.. code-block:: bash

   $ knife cookbook upload redis --freeze

To return:

.. code-block:: bash

   Uploading redis...
   Upload completed

Once a cookbook version is frozen, only by using the ``--force`` option can an update be made. For example:

.. code-block:: bash

   $ knife cookbook upload redis --force

Without the ``--force`` option specified, an error will be returned similar to:

.. code-block:: none

   Version 0.0.0 of cookbook redis is frozen. Use --force to override
