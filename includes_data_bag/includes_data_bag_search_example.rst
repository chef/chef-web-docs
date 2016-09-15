.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following example shows how to use the search index to find all of the items in a data bag (called ``admins`` that stores the user data for each system administrator), add each data bag item to an array, ensure that each data bag item exists as a user resource, and then to create a security group to which each of the data bag items belongs.

.. code-block:: ruby

   # An empty array to which we'll add the admins' logins as we go.
   admins = []
   
   # search for all items in the 'admins' data bag and loop over them
   search(:admins, '*:*') do |admin|
     # Set `login` to the id of the data bag item
     login = admin['id']
    
     # build up the list of the admins logins
     admins << login
    
     home = '/home/#{login}'
   
     # for each admin in the data bag, make a user resource
     # to ensure they exist
     user(login) do
       uid admin['uid']
       gid admin['gid']
       shell admin['shell']
       comment admin['comment']
       
       home home
       manage_home true
     end
   
   end
   
   # Create an "admins" group on the system
   # You might use this group in the /etc/sudoers file
   # to provide sudo access to the admins
   group 'admins' do
     gid '999'
     members 'admins'
   end
