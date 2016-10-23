.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use this option to set the ``chef_environment`` value for a node.

.. note:: Any environment specified for ``chef_environment`` by a JSON file will take precedence over an environment specified by the ``--environment`` option when both options are part of the same command.

For example, run the following:

.. code-block:: bash

   $ chef-client -j /path/to/file.json

where ``/path/to/file.json`` is similar to:

.. code-block:: javascript

   {
     "chef_environment": "pre-production"
   }

This will set the environment for the node to ``pre-production``.
