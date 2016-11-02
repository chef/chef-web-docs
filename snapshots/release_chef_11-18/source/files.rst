

=====================================================
About Files
=====================================================

.. tag resource_cookbook_file_24

Use the **cookbook_file** resource to transfer files from a sub-directory of ``COOKBOOK_NAME/files/`` to a specified path located on a host that is running the chef-client. The file is selected according to file specificity, which allows different source files to be used based on the hostname, host platform (operating system, distro, or as appropriate), or platform version. Files that are located in the ``COOKBOOK_NAME/files/default`` sub-directory may be used on any platform.

.. end_tag

.. tag resource_cookbook_file_transfers

During a chef-client run, the checksum for each local file is calculated and then compared against the checksum for the same file as it currently exists in the cookbook on the Chef server. A file is not transferred when the checksums match. Only files that require an update are transferred from the Chef server to a node.

.. end_tag

File Specificity
=====================================================
.. tag file_cookbook_specificity

A cookbook is frequently designed to work across many platforms and is often required to distribute a specific file to a specific platform. A cookbook can be designed to support the distribution of files across platforms, while ensuring that the correct file ends up on each system.

.. end_tag

.. tag 16_cookbook_specificity_pattern

The pattern for file specificity depends on two things: the lookup path and the source attribute. The first pattern that matches is used:

#. /host-$fqdn/$source
#. /$platform-$platform_version/$source
#. /$platform/$source
#. /default/$source

.. end_tag

.. tag file_cookbook_specificity_example

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

.. end_tag

Host Notation
=====================================================
.. tag file_cookbook_specificity_host_notation

The naming of folders within cookbook directories must literally match the host notation used for file specificity matching. For example, if a host is named ``foo.example.com``, the folder must be named ``host-foo.example.com``.

.. end_tag

