.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The **deploy** resource is modeled after Capistrano, a utility and framework for executing commands in parallel on multiple remote machines via SSH. The **deploy** resource is designed to behave in a way that is similar to the ``deploy`` and ``deploy:migration`` tasks in Capistrano.

.. Kept, but commented out.
.. .. list-table::
..    :widths: 200 300
..    :header-rows: 1
.. 
..    * - Task
..      - Description
..    * - ``deploy``
..      - The ``deploy`` task is used to deploy a project. This task first calls ``update``, which calls ``update_code`` to copy the project to its deployed location, which calls ``finalize_update`` to touch up the released code. After ``update`` is finished, ``create_symlink`` is called to update symlinks. And then ``restart`` is called to restart the application. 
..    * - ``deploy:migrations``
..      - The ``deploy:migrations`` task is used to deploy and run migrations. This task is similar to the ``deploy`` task, but with the ``migrate`` task running between ``update_code`` and ``create_symlink``.
..  
.. .. note:: In Capistrano, the ``deploy:cleanup`` task is used to define the cleanup steps; in Chef, cleanup is handled automatically.


