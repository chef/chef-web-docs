=====================================================
chef-solo
=====================================================

.. include:: ../../includes_chef_solo/includes_chef_solo.rst

Cookbooks
=====================================================
.. include:: ../../includes_chef_solo/includes_chef_solo_cookbooks.rst

Nodes
=====================================================
Unlike chef-client, where the node object is stored on the Chef server, chef-solo stores its node objects as JSON files on disk. By default, chef-solo stores these files in a ``nodes`` folder in the same directory as your ``cookbooks`` directory. You can control the location of this directory via the ``node_path`` value in your configuration file.

Attributes
=====================================================
.. include:: ../../includes_chef_solo/includes_chef_solo_attributes.rst

Data Bags
=====================================================
.. include:: ../../includes_chef_solo/includes_chef_solo_data_bags.rst

Roles
=====================================================
.. include:: ../../includes_chef_solo/includes_chef_solo_roles.rst

Environments
=====================================================
.. include:: ../../includes_chef_solo/includes_chef_solo_environments.rst

chef-solo (executable)
=====================================================
.. include:: ../../includes_ctl_chef_solo/includes_ctl_chef_solo.rst

Options
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_solo/includes_ctl_chef_solo_options.rst

Examples
-----------------------------------------------------

**Run chef-solo using solo.rb settings**

.. include:: ../../step_ctl_chef_solo/step_ctl_chef_solo_use_solo_rb.rst

**Use a URL**

.. include:: ../../step_ctl_chef_solo/step_ctl_chef_solo_use_url.rst

**Use a directory**

.. include:: ../../step_ctl_chef_solo/step_ctl_chef_solo_use_directory.rst

**Use a URL for cookbook and JSON data**

.. include:: ../../step_ctl_chef_solo/step_ctl_chef_solo_url_for_cookbook_and_json.rst
