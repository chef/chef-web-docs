.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The |chef server| includes the following object permissions:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Permission
     - Description
   * - **Delete**
     - |permission delete| This permission is required for any user who uses the ``knife [object] delete [object_name]`` argument to interact with objects on the |chef server|.
   * - **Grant**
     - |permission grant| This permission is required for any user who configures permissions using the **Administration** tab in the |chef manage|.
   * - **Read**
     - |permission read| This permission is required for any user who uses the ``knife [object] show [object_name]`` argument to interact with objects on the |chef server|.
   * - **Update**
     - |permission update| This permission is required for any user who uses the ``knife [object] edit [object_name]`` argument to interact with objects on the |chef server| and for any |chef client| to save node data to the |chef server| at the conclusion of a |chef client| run.
