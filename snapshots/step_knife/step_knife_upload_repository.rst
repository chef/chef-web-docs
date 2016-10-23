.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Browse to the top level of the chef-repo and enter:

.. code-block:: bash

   $ knife upload .

or from anywhere in the chef-repo, enter:

.. code-block:: bash

   $ knife upload /

to upload all cookbooks and data bags, plus all roles and enviroments that are stored as JSON data. (Roles and environments stored as Ruby data will not be uploaded.)
