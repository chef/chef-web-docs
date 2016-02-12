.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

To upload a single directory in the |chef repo| to the |chef server|, browse to the top level of the |chef repo| and enter:

.. code-block:: bash

   $ knife upload name_of_directory

or from anywhere in the |chef repo|, enter:

.. code-block:: bash

   $ knife upload /name_of_directory

where ``name_of_directory`` is the name of a directory in the |chef repo|, such as ``roles``, ``environments``, or ``cookbooks``. (Roles and environments stored as |ruby| data will not be uploaded.)
