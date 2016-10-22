.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A deployment happens in four phases:

#. **Checkout**---the chef-client uses the **scm** resource to get the specified application revision, placing a clone or checkout in the sub-directory of the ``deploy`` directory named ``cached-copy``. A copy of the application is then placed in a sub-directory under ``releases``.
#. **Migrate**---If a migration is to be run, the chef-client symlinks the database configuration file into the checkout (``config/database.yml`` by default) and runs the migration command. For a Ruby on Rails application, the ``migration_command`` is usually set to ``rake db:migrate``.
#. **Symlink**---Directories for shared and temporary files are removed from the checkout (``log``, ``tmp/pids``, and ``public/system`` by default). After this step, any needed directories (``tmp``, ``public``, and ``config`` by default) are created if they don't already exist. This step is completed by symlinking shared directories into the current ``release``, ``public/system``, ``tmp/pids``, and ``log`` directories, and then symlinking the ``release`` directory to ``current``.
#. **Restart**---The application is restarted according to the restart command set in the recipe.
