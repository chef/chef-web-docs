.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``cron_d`` custom provider (found in the `cron <https://github.com/chef-cookbooks/cron>`_ cookbook) is used to tell the chef-client what to do whenever the ``cron_d`` custom resource is used in a recipe:

.. code-block:: ruby

   action :delete do
     file '/etc/cron.d/#{new_resource.name}' do
       action :delete
     end
   end
   
   action :create do
     t = template '/etc/cron.d/#{new_resource.name}' do
       cookbook new_resource.cookbook
       source 'cron.d.erb'
       mode '0644'
       variables({
           :name => new_resource.name, 
           :minute => new_resource.minute,
           :hour => new_resource.hour,
           :day => new_resource.day,
           :month => new_resource.month,
           :weekday => new_resource.weekday,
           :command => new_resource.command,
           :user => new_resource.user,
           :mailto => new_resource.mailto,
           :path => new_resource.path,
           :home => new_resource.home,
           :shell => new_resource.shell
         })
       action :create
     end
     new_resource.updated_by_last_action(t.updated_by_last_action?)
   end


where:

* two ``action`` blocks are defined, one for the ``:create`` action and one for the ``:delete`` action
* the ``:delete`` action block calls the **file** resource (and it's ``:delete`` action) to delete a file in the ``/etc/cron.d`` folder
* the ``:create`` action block creates a new entry in the ``/etc/cron.d`` folder. 

For example, if a recipe used the ``cron_d`` custom resource similar to the following:

.. code-block:: ruby

   cron_d 'daily-usage-report' do
     minute '0'
     hour '23'
     command '/srv/app/scripts/daily_report'
     user 'appuser'
   end

this tells the chef-client to use the ``cron_d`` custom provider and the credentials for a user named ``appuser`` to create a crontab entry named "daily-usage-report". This crontab entry executes a command located in the ``/srv/app/scripts/daily_report`` directory at a specified interval (defined by the ``minute`` and ``hour`` attributes). Any of the attributes that are not specified in the recipe (such as ``mailto``, ``weekday``, and ``day``) just use the default attribute values defined by the custom resource.
