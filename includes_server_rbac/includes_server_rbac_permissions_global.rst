.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The |chef server| includes the following global permissions:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Permission
     - Description
   * - **Create**
     - |permission create| This permission is required for any user who uses the ``knife [object] create`` argument to interact with objects on the |chef server|.
   * - **List**
     - |permission list| This permission is required for any user who uses the ``knife [object] list`` argument to interact with objects on the |chef server|.

These permissions set the default permissions for the following |chef server| object types: clients, cookbooks, data bags, environments, groups, nodes, roles, and sandboxes.
