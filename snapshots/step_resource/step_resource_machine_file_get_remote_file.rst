.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A deployment process requires more than just setting up machines. For example, files may need to be copied to machines from remote locations. The following example shows how to use the **remote_file** resource to grab a tarball from a URL, create a machine, copy that tarball to the machine, and then get that machine running by using a recipe that installs and configures that tarball on the machine:

.. code-block:: ruby

   remote_file 'mytarball.tgz' do
     url 'https://myserver.com/mytarball.tgz'
   end

   machine 'x'
     action :allocate
   end

   machine_file '/tmp/mytarball.tgz' do
     machine 'x'
     local_path 'mytarball.tgz'
     action :upload
   end

   machine 'x' do
     recipe 'untarthatthing'
     action :converge
   end
