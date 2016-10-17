.. THIS PAGE DOCUMENTS chef-client version 11.10

=====================================================
Cookbook Directories and Metadata
=====================================================

.. include:: ../../includes_chef_repo/includes_chef_repo_directory_cookbooks.rst

.. include:: ../../step_chef_repo/step_chef_repo_cookbooks_configure_settings.rst

Work with Cookbooks
=====================================================
Use the following |knife| subcommands to create, install, and/or download cookbooks.

Create
-----------------------------------------------------
.. include:: ../../step_knife/step_knife_cookbook_create.rst

Install
-----------------------------------------------------
.. include:: ../../step_knife/step_knife_cookbook_site_install.rst

Download
-----------------------------------------------------
.. include:: ../../step_knife/step_knife_cookbook_site_download.rst

About Cookbook Metadata
=====================================================

.. include:: ../../includes_cookbooks/includes_cookbooks_metadata.rst

Error Messages
-----------------------------------------------------
.. include:: ../../includes_cookbooks/includes_cookbooks_metadata_error_messages.rst

metadata.rb
-----------------------------------------------------
.. include:: ../../includes_cookbooks/includes_cookbooks_metadata.rst

.. include:: ../../includes_config/includes_config_rb_metadata.rst

Settings
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This configuration file has the following settings:

``attribute``
   |metadata attributes|

   .. include:: ../../includes_cookbooks/includes_cookbooks_metadata_settting_attribute.rst

``depends``
   |metadata rb depends|

   .. include:: ../../includes_cookbooks/includes_cookbooks_metadata_settting_depends.rst

``description``
   |description cookbook|

   .. include:: ../../includes_cookbooks/includes_cookbooks_metadata_settting_description.rst

``license``
   |license metadata_rb|

   .. include:: ../../includes_cookbooks/includes_cookbooks_metadata_settting_license.rst

``long_description``
   |long description| 

   .. include:: ../../includes_cookbooks/includes_cookbooks_metadata_settting_long_description.rst

``maintainer``
   |maintainer|

   .. include:: ../../includes_cookbooks/includes_cookbooks_metadata_settting_maintainer.rst

``maintainer_email``
   |maintainer email|

   .. include:: ../../includes_cookbooks/includes_cookbooks_metadata_settting_maintainer_email.rst

``name``
   Required. |name cookbook|

   .. include:: ../../includes_cookbooks/includes_cookbooks_metadata_settting_name.rst

``provides``
   |metadata rb provides|

   .. include:: ../../includes_cookbooks/includes_cookbooks_metadata_settting_provides.rst

``recipe``
   |description recipe|

   .. include:: ../../includes_cookbooks/includes_cookbooks_metadata_settting_recipe.rst

``supports``
   |metadata rb supports|

   .. include:: ../../includes_cookbooks/includes_cookbooks_metadata_settting_supports.rst

``version``
   |version cookbook|

   .. include:: ../../includes_cookbooks/includes_cookbooks_metadata_settting_version.rst
