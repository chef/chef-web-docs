.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

To search for nodes assigned the role ``webapp``, and where 90% of those nodes must be available, run the following command:

.. code-block:: bash

   $ knife job start --quorum 90% 'chef-client' --search 'role:webapp'

