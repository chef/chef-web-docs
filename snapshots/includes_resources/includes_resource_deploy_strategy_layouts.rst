.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The **deploy** resource expects an application to be structured like a Ruby on Rails application, but the layout can be modified to meet custom requirements as needed. Use the following attributes within a recipe to modify the layout of a recipe that is using the **deploy** resource:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Layout Modifiers
     - Description
   * - ``create_dirs_before_symlink``
     - Create directories in the release directory before symbolic links are created. This property runs after ``purge_before_symlink`` and before ``symlink``.
   * - ``purge_before_symlink``
     - An array of directories (relative to the application root) to be removed from a checkout before symbolic links are created. This attribute runs before ``create_dirs_before_symlink`` and before ``symlink``. 
   * - ``symlink_before_migrate``
     - Map files in a shared directory to the current release directory. The symbolic links for these files are created before any migration is run. Use parentheses ``( )`` around curly braces ``{ }`` to ensure the contents within the curly braces are interpreted as a block and not as an empty Hash. Set to ``symlink_before_migrate({})`` to prevent the creation of symbolic links.
   * - ``symlinks``
     - Map files in a shared directory to their paths in the current release directory. This property runs after ``create_dirs_before_symlink`` and ``purge_before_symlink``. 

