.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A case statement can be used to compare an expression, and then execute the code that matches.

To select a package name based on platform:

.. code-block:: ruby

   package "apache2" do
     case node[:platform]
     when "centos","redhat","fedora","suse"
       package_name "httpd"
     when "debian","ubuntu"
       package_name "apache2"
     when "arch"
       package_name "apache"
     end 
     action :install
   end
