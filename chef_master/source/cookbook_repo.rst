=====================================================
Cookbook Directories and Metadata
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/cookbook_repo.rst>`__

The ``cookbooks/`` directory is used to store the cookbooks that Chef Infra Client uses in configuring the various systems in the organization. This directory contains the cookbooks that are used to configure systems in the infrastructure. Each cookbook can be configured to contain cookbook-specific copyright, email, and license data.

To configure cookbook-specific copyright, email, and license data, add the following to the config.rb file in the chef-repo:

.. code-block:: bash

   cookbook_copyright "Example, Com."
   cookbook_email     "cookbooks@example.com"
   cookbook_license   "apachev2"

where the ``cookbook_copyright`` and ``cookbook_email`` are specific to the organization and ``cookbook_license`` is either ``apachev2`` or ``none``. These settings will be used in the default recipe and in corresponding values in the metadata.rb file, but can be modified in those locations as well (if they should be different from the default values contained in the config.rb file.)

Work with Cookbooks
=====================================================
Use the following knife subcommands to create, install, and/or download cookbooks.

Create
-----------------------------------------------------
To create a cookbook (including all default components), run the following command:

.. code-block:: bash

   $ chef generate cookbook COOKBOOK_NAME

where ``COOKBOOK_NAME`` is the name of the cookbook that will be created. Any unneeded directory components can be left unused or deleted, if preferred.

Install
-----------------------------------------------------
To download a cookbook when git is used for version source control, run the following command:

.. code-block:: bash

   $ knife supermarket install COOKBOOK_NAME

where ``COOKBOOK_NAME`` is the name of a cookbook on `Chef Supermarket <https://supermarket.chef.io/>`__. This will start a process that:

   * downloads the cookbook from `Chef Supermarket <https://supermarket.chef.io/>`__ as a tar.gz archive
   * ensures that its using the git master branch, and then checks out the cookbook from a vendor branch (creating a new vendor branch, if required)
   * removes the old (existing) version
   * expands the tar.gz archive and adds the expanded files to the git index and commits
   * creates a tag for the version that was downloaded
   * checks out the master branch
   * merges the cookbook into the master (to ensure that any local changes or modifications are preserved)

Download
-----------------------------------------------------
To download a cookbook when git is not used for version source control, run the following command:

.. code-block:: bash

   $ knife supermarket download COOKBOOK_NAME

where ``COOKBOOK_NAME`` is the name of a cookbook on `Chef Supermarket <https://supermarket.chef.io/>`__. This will download the tar.gz file associated with the cookbook and will create a file named ``COOKBOOK_NAME.tar.gz`` in the current directory (e.g., ``~/chef-repo``). Once downloaded, using a version source control system is recommended.

Cookbook Metadata
=====================================================

.. tag cookbooks_metadata

Every cookbook requires a small amount of metadata. A file named metadata.rb is located at the top of every cookbook directory structure. The contents of the metadata.rb file provides information that helps Chef Infra Client and Server correctly deploy cookbooks to each node.

.. end_tag

A metadata.rb file is:

* Located at the top level of a cookbook's directory structure.
* Compiled whenever a cookbook is uploaded to the Chef Infra Server or when the ``knife cookbook metadata`` subcommand is run, and then stored as JSON data.
* Created automatically by knife whenever the ``knife cookbook create`` subcommand is run.
* Edited using a text editor, and then re-uploaded to the Chef Infra Server as part of a cookbook upload.

Metadata Settings
-----------------------------------------------------

For a full explanation of working with cookbook metadata, see `metadata.rb </config_rb_metadata.html>`__.
