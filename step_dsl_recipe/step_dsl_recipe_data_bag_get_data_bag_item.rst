.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following example shows how to get data bag items from a data bag named ``get_credentials``. Each data bag item will be used as a variable, and then a recipe named ``foo_user`` will use these variables to change the admin password.

.. code-block:: ruby

   data_bag_item = Chef::Cookbook.get_credentials_data_bag
     credentials_default = data_bag_item['default_admin']
     credentials_updated = data_bag_item['updated_admin']

   foo_user 'admin' do
     action :change_password
     password_old credentials_default['12#$abCD']
     password_new credentials_updated['56&*efGH']
   end
