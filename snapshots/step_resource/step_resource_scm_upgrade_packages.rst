.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following example uses the **git** resource to upgrade packages:

.. code-block:: ruby

   # the following code sample comes from the ``source`` recipe
   # in the ``libvpx-cookbook`` cookbook:
   # https://github.com/enmasse-entertainment/libvpx-cookbook

   git "#{Chef::Config[:file_cache_path]}/libvpx" do
     repository node[:libvpx][:git_repository]
     revision node[:libvpx][:git_revision]
     action :sync
     notifies :run, 'bash[compile_libvpx]', :immediately
   end
