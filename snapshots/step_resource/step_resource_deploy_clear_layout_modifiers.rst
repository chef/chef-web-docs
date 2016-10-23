.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Using the default property values for the various resources is the recommended starting point when working with recipes. Then, depending on what each node requires, these default values can be overridden with node-, role-, environment-, and cookbook-specific values. The **deploy** resource has four layout modifiers: ``create_dirs_before_symlink``, ``purge_before_symlink``, ``symlink_before_migrate``, and ``symlinks``. Each of these is a Hash that behaves as a property of the **deploy** resource. When these layout modifiers are used in a recipe, they appear similar to the following:

.. code-block:: ruby

   deploy 'name' do
     ...
     symlink_before_migrate       {'config/database.yml' => 'config/database.yml'}
     create_dirs_before_symlink   %w{tmp public config}
     purge_before_symlink         %w{log tmp/pids public/system}
     symlinks                     { 'system' => 'public/system', 
                                    'pids' => 'tmp/pids', 
                                    'log' => 'log'
                                  }
     ...
   end

and then what these layout modifiers look like if they were empty:

.. code-block:: ruby

   deploy 'name' do
     ...
     symlink_before_migrate       nil
     create_dirs_before_symlink   []
     purge_before_symlink         []
     symlinks                     nil
     ...
   end

In most cases, using the empty values for the layout modifiers will prevent the chef-client from passing symbolic linking information to a node during the chef-client run. However, in some cases, it may be preferable to ensure that one (or more) of these layout modifiers do not pass any symbolic linking information to a node during the chef-client run at all. Because each of these layout modifiers are a Hash, the ``clear`` instance method can be used to clear out these values.

To clear the default values for a layout modifier:

.. code-block:: ruby

   deploy 'name' do
     ...
     symlink_before_migrate.clear
     create_dirs_before_symlink.clear
     purge_before_symlink.clear
     symlinks.clear
     ...
   end

In general, use this approach carefully and only after it is determined that nil or empty values won't provide the expected result.
