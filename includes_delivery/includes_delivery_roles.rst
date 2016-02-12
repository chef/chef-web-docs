.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


|chef delivery| has a standard users and roles permissions scheme. Roles are sets of permissions defined by |chef delivery|. Users can be assigned multiple roles.  

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Role
     - Permissions
   * - **Admin**
     - All of the permissions plus all administrative permissions, including user management. Can create and delete users and restore passwords. Also, can create, delete, or modify organizations, projects, and pipelines. Can modify, delete, or add recipes in a phase (at the source code level); and can read and write comments.
   * - **Committer**
     - Can commit a change to |chef delivery|. Also, can modify, delete, or add recipes in a phase (at the source code level); and can read and write comments.
   * - **Observer**
     - Can observe the actions and results of the pipeline as the change progresses through the stages. Cannot take any action.
   * - **Reviewer**
     - Can approve the successful completion of the **Verify** stage. Once approved, the change automatically moves to the **Build** stage. Also, can read and write comments. 
   * - **Shipper**
     - Can ship a change from the **Acceptance** stage into the shared pipeline stages, **Union** **Rehearsal** and **Delivered**.
