.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following example shows how to get the contents of a data bag item named ``impossible_things``, create a .pem file located at ``some/directory/path/``, and then use the ``content`` attribute to update the contents of that file with the value of the ``impossible_things`` data bag item:

.. code-block:: ruby

   private_key = data_bag_item('impossible_things', private_key_name)['private_key']
   
   file "some/directory/path/#{private_key_name}.pem" do
     content private_key
     owner 'root'
     group 'group'
     mode '0755'
   end
