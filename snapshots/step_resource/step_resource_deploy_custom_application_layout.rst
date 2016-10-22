.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The layout of the **deploy** resource matches a Ruby on Rails app by default, but this can be customized. To customize the layout, do something like the following:

.. code-block:: ruby

   deploy '/my/apps/dir/deploy' do
     # Use a local repo if you prefer
     repo '/path/to/gitrepo/typo/'
     environment 'RAILS_ENV' => 'production'
     revision 'HEAD'
     action :deploy
     migration_command 'rake db:migrate --trace'
     migrate true
     restart_command 'touch tmp/restart.txt'
     create_dirs_before_symlink  %w{tmp public config deploy}
     
     # You can use this to customize if your app has extra configuration files 
     # such as amqp.yml or app_config.yml
     symlink_before_migrate  'config/database.yml' => 'config/database.yml'
      
     # If your app has extra files in the shared folder, specify them here
     symlinks  'system' => 'public/system', 
               'pids' => 'tmp/pids', 
               'log' => 'log',
               'deploy/before_migrate.rb' => 'deploy/before_migrate.rb',
               'deploy/before_symlink.rb' => 'deploy/before_symlink.rb',
               'deploy/before_restart.rb' => 'deploy/before_restart.rb',
               'deploy/after_restart.rb' => 'deploy/after_restart.rb'
   end
