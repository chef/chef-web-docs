.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A cookbook may have a ``/files`` directory structure like this::

   files/
      host-foo.example.com
      ubuntu-10.04
      ubuntu-10
      ubuntu
      redhat-5.8
      redhat-6.4
      ...
      default

and a resource that looks something like the following:

.. code-block:: ruby

   cookbook_file '/usr/local/bin/apache2_module_conf_generate.pl' do
     source 'apache2_module_conf_generate.pl'
     mode '0755'
     owner 'root'
     group 'root'
   end

This resource is matched in the same order as the ``/files`` directory structure. For a node that is running Ubuntu 10.04, the second item would be the matching item and the location to which the file identified in the **cookbook_file** resource would be distributed:

.. code-block:: ruby

   host-foo.example.com/apache2_module_conf_generate.pl
   ubuntu-10.04/apache2_module_conf_generate.pl
   ubuntu-10/apache2_module_conf_generate.pl
   ubuntu/apache2_module_conf_generate.pl
   default/apache2_module_conf_generate.pl

If the ``apache2_module_conf_generate.pl`` file was located in the cookbook directory under ``files/host-foo.example.com/``, the specified file(s) would only be copied to the machine with the domain name foo.example.com.
