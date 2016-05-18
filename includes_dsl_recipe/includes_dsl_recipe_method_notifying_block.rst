.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``notifying_block`` method is similar to the ``notifies`` property, but processes the notification at the end of the block, rather than the end of the |chef client| run.

The syntax for the ``notifying_block`` method is as follows:

.. code-block:: ruby

   notifying_block do
     # some resource block
       notifies :some_notification, :timer
     end

     # some other resource block
       notifies :some_notification, :timer
     end
   end

where:

* ``some resource block`` is a standard |chef| resource block, like ``file 'name' do/end``.
* ``notifies :some_notification, :timer`` is a notification that is processed at the end of the ``notifying_block``.

For example:

.. code-block:: ruby

   cache1 = "#{Chef::Config[:file_cache_path]}/content1"
   cache2 = "#{Chef::Config[:file_cache_path]}/content2"
   
   notifying_block do
     remote_file cache1 do
       source "http://source.url/content1"
       notifies :create, "file[/my/combined/file]", :delayed
     end
   
     remote_file cache2 do
       source "http://source.url/content2"
       notifies :create, "file[/my/combined/file]", :delayed
     end
   
     file "/my/combined/file" do
       action :nothing
       content lazy { IO.read(cache1) + IO.read(cache2) }
     end
   end
