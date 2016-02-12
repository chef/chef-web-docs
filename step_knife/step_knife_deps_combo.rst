.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To find the dependencies for a combination of nodes, cookbooks, roles, and/or environments:

.. code-block:: bash

   $ knife deps cookbooks/git.json cookbooks/github.json roles/base.json environments/desert.json nodes/mynode.json
