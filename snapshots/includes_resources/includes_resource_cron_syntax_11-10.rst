.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A **cron** resource block manage cron entries. For example, to get a weekly cookbook report from the Chef Supermarket:

.. code-block:: ruby

   cron 'cookbooks_report' do
     action node.tags.include?('cookbooks-report') ? :create : :delete
     minute '0'
     hour '0'
     weekday '1'
     user 'getchef'
     mailto 'sysadmin@example.com'
     home '/srv/supermarket/shared/system'
     command %W{
       cd /srv/supermarket/current &&
       env RUBYLIB="/srv/supermarket/current/lib"
       RAILS_ASSET_ID=`git rev-parse HEAD` RAILS_ENV="#{rails_env}"
       bundle exec rake cookbooks_report
     }.join(' ')
   end

The full syntax for all of the properties that are available to the **cron** resource is:

.. code-block:: ruby

   cron 'name' do
     command                    String
     day                        String
     home                       String
     hour                       String
     mailto                     String
     minute                     String
     month                      String
     notifies                   # see description
     path                       String
     provider                   Chef::Provider::Cron
     shell                      String
     subscribes                 # see description
     time                       Symbol
     user                       String
     weekday                    String, Symbol
     action                     Symbol # defaults to :create if not specified
   end

where 

* ``cron`` is the resource
* ``name`` is the name of the resource block
* ``command`` is the command to be run
* ``:action`` identifies the steps the chef-client will take to bring the node into the desired state
* ``command``, ``day``, ``home``, ``hour``, ``mailto``, ``minute``, ``month``, ``path``, ``provider``, ``shell``, ``time``, ``user``, and ``weekday`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.
