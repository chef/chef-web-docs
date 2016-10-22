.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following example shows how to use the ``data_bag`` and ``data_bag_item`` methods in a recipe, also using a data bag named ``sea-power``):

.. code-block:: ruby

   package 'sea-power' do
     action :install
   end
   
   directory node['sea-power']['base_path'] do
     # attributes for owner, group, mode
   end
   
   gale_warnings = data_bag('sea-power').map do |viking_north|
     data_bag_item('sea-power', viking_north)['source']
   end
   
   template '/etc/seattle/power.list' do
     source 'seattle-power.erb'
     # attributes for owner, group, mode
     variables(
       :base_path => node['sea-power']['base_path'],
       # more variables
       :repo_location => gale_warnings
     )
   end

For a more complete version of the previous example, see the default recipe in the https://github.com/hw-cookbooks/apt-mirror community cookbook.
