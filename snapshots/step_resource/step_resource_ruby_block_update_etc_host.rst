.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following example shows how the **ruby_block** resource can be used to update the ``/etc/hosts`` file:

.. code-block:: ruby

   # the following code sample comes from the ``ec2`` recipe
   # in the following cookbook: https://github.com/chef-cookbooks/dynect

   ruby_block 'edit etc hosts' do
     block do
       rc = Chef::Util::FileEdit.new('/etc/hosts')
       rc.search_file_replace_line(/^127\.0\.0\.1 localhost$/, 
          '127.0.0.1 #{new_fqdn} #{new_hostname} localhost')
       rc.write_file
     end
   end
