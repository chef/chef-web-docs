

=====================================================
Cookbook Directories and Metadata
=====================================================

.. tag chef_repo_directory_cookbooks

The ``cookbooks/`` directory is used to store the cookbooks that are used by the chef-client when configuring the various systems in the organization. This directory contains the cookbooks that are used to configure systems in the infrastructure. Each cookbook can be configured to contain cookbook-specific copyright, email, and license data.

.. end_tag

.. tag chef_repo_cookbooks_configure_settings

To configure cookbook-specific copyright, email, and license data, add the following to the knife.rb file in the chef-repo:

.. code-block:: bash

   cookbook_copyright "Example, Com."
   cookbook_email     "cookbooks@example.com"
   cookbook_license   "apachev2"

where the ``cookbook_copyright`` and ``cookbook_email`` are specific to the organization and ``cookbook_license`` is either ``apachev2`` or ``none``. These settings will be used in the default recipe and in corresponding values in the metadata.rb file, but can be modified in those locations as well (if they should be different from the default values contained in the knife.rb file.)

.. end_tag

Work with Cookbooks
=====================================================
Use the following knife subcommands to create, install, and/or download cookbooks.

Create
-----------------------------------------------------
.. tag knife_cookbook_create_summary

To create a cookbook (including all default components), run the following command:

.. code-block:: bash

   $ knife cookbook create COOKBOOK_NAME

where ``COOKBOOK_NAME`` is the name of the cookbook that will be created. Any unneeded directory components can be left unused or deleted, if preferred.

.. end_tag

Install
-----------------------------------------------------
.. tag knife_cookbook_site_install

To download a cookbook when git is used for version source control, run the following command:

.. code-block:: bash

   $ knife cookbook site install COOKBOOK_NAME

where ``COOKBOOK_NAME`` is the name of a cookbook on |url community|. This will start a process that:

   * downloads the cookbook from |url community| as a tar.gz archive
   * ensures that its using the git master branch, and then checks out the cookbook from a vendor branch (creating a new vendor branch, if required)
   * removes the old (existing) version
   * expands the tar.gz archive and adds the expanded files to the git index and commits
   * creates a tag for the version that was downloaded
   * checks out the master branch
   * merges the cookbook into the master (to ensure that any local changes or modifications are preserved)

.. end_tag

Download
-----------------------------------------------------
.. tag knife_cookbook_site_download

To download a cookbook when git is not used for version source control, run the following command:

.. code-block:: bash

   $ knife cookbook site download COOKBOOK_NAME

where ``COOKBOOK_NAME`` is the name of a cookbook on |url community|. This will download the tar.gz file associated with the cookbook and will create a file named ``COOKBOOK_NAME.tar.gz`` in the current directory (e.g., ``~/chef-repo``). Once downloaded, using a version source control system is recommended.

.. end_tag

About Cookbook Metadata
=====================================================

.. tag cookbooks_metadata

Every cookbook requires a small amount of metadata. A file named metadata.rb is located at the top of every cookbook directory structure. The contents of the metadata.rb file provides hints to the Chef server to help ensure that cookbooks are deployed to each node correctly.

.. end_tag

Error Messages
-----------------------------------------------------
.. tag cookbooks_metadata_error_messages

The Chef server will only try to distribute the cookbooks that are needed to configure an individual node. This is determined by identifying the roles and recipes that are assigned directly to that system, and then to expand the list of dependencies, and then to deliver that entire set to the node. In some cases, if the dependency is not specified in the cookbook's metadata, the Chef server may not treat that dependency as a requirement, which will result in an error message. If an error message is received from the Chef server about cookbook distribution, verify the ``depends`` entries in the metadata.rb file, and then try again.

.. end_tag

metadata.rb
-----------------------------------------------------
.. tag cookbooks_metadata

Every cookbook requires a small amount of metadata. A file named metadata.rb is located at the top of every cookbook directory structure. The contents of the metadata.rb file provides hints to the Chef server to help ensure that cookbooks are deployed to each node correctly.

.. end_tag

.. tag config_rb_metadata_25

A metadata.rb file is:

* Located at the top level of a cookbook's directory structure
* Compiled whenever a cookbook is uploaded to the Chef server or when the ``knife cookbook metadata`` subcommand is run, and then stored as JSON data
* Created automatically by knife whenever the ``knife cookbook create`` subcommand is run
* Edited using a text editor, and then re-uploaded to the Chef server as part of a cookbook upload

.. end_tag

Settings
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This configuration file has the following settings:

``attribute``
   The list of attributes that are required to configure a cookbook. An attribute name is required, followed by any of these options: ``display_name`` (the name that appears in the user interface), ``description`` (a short description), ``choice`` (an array of choices that are presented to a user), ``calculated`` (the default value is calculated by the recipe), ``type`` (the type of value, either ``string``, ``array``, or ``hash``), ``required`` (the level of user input, either ``required``, ``recommended``, or ``optional``), ``recipes`` (an array of recipes), or ``default`` (the attribute's default value).

   .. tag cookbooks_metadata_settting_attribute

   For example:

   .. code-block:: ruby

      attribute 'pets/cat/name',
        :display_name => 'Cat Name',
        :description => 'The name of your cat',
        :choice => \[
          'kitty kitty',
          'peanut',
          'einstein',
          'honey' \],
        :type => 'string',
        :required => 'recommended',
        :recipes => \[ 'cats::eat' \],
        :default => 'kitty kitty'

   .. end_tag

``depends``
   Show that a cookbook has a dependency on another cookbook. Use a version constraint to define dependencies for cookbook versions: ``<`` (less than), ``<=`` (less than or equal to), ``=`` (equal to), ``>=`` (greater than or equal to; also known as "optimistically greater than", or "optimistic"), ``~>`` (approximately greater than; also known as "pessimistically greater than", or "pessimistic"), or ``>`` (greater than). This field requires that a cookbook with a matching name and version exists on the Chef server. When the match exists, the Chef server includes the dependency as part of the set of cookbooks that are sent to the node when the chef-client runs. It is very important that the ``depends`` field contain accurate data. If a dependency statement is inaccurate, the chef-client may not be able to complete the configuration of the system.

   .. tag cookbooks_metadata_settting_depends

   For example, to set a dependency a cookbook named ``cats``:

   .. code-block:: ruby

      depends 'cats'

   or, to set a dependency on the same cookbook, but only when the version is less than 1.0:

   .. code-block:: ruby

      depends 'cats', '< 1.0'

   .. end_tag

``description``
   A short description of a cookbook and its functionality.

   .. tag cookbooks_metadata_settting_description

   For example:

   .. code-block:: ruby

      description 'A fancy cookbook that manages a herd of cats!'

   .. end_tag

``issues_url``
   The URL for the location in which a cookbook's issue tracking is maintained. This setting is also used by Chef Supermarket. In Chef Supermarket, this value is used to define the destination for the "View Issues" link.

   .. tag cookbooks_metadata_settting_issues_url

   For example:

   .. code-block:: ruby

      issues_url 'https://github.com/chef-cookbooks/chef-client/issues'

   .. end_tag

``license``
   The type of license under which a cookbook is distributed: ``Apache v2.0``, ``GPL v2``, ``GPL v3``, ``MIT``, or ``license 'Proprietary - All Rights Reserved`` (default). Please be aware of the licenses for files inside of a cookbook and be sure to follow any restrictions they describe.

   .. tag cookbooks_metadata_settting_license

   For example:

   .. code-block:: ruby

      license 'Apache v2.0'

   or:

   .. code-block:: ruby

      license 'GPL v3'

   or:

   .. code-block:: ruby

      license 'MIT'

   or:

   .. code-block:: ruby

      license 'Proprietary - All Rights Reserved'

   .. end_tag

``long_description``
   A longer description that ideally contains full instructions on the proper use of a cookbook, including definitions, libraries, dependencies, and so on. There are two ways to use this field: with the contents embedded in the field itself or with the contents pulled from a file at a specified path, such as a README.rdoc located at the top of a cookbook directory.

   .. tag cookbooks_metadata_settting_long_description

   For example, to embed the long description within the field itself:

   .. code-block:: ruby

      long_description <<-EOH
      = DESCRIPTION:

      Complete Debian/Ubuntu style Apache2 configuration.

      = REQUIREMENTS:

      Debian or Ubuntu preferred.

      Red Hat/CentOS and Fedora can be used but will be converted to
      a Debian/Ubuntu style Apache as it's far easier to manage
      with Chef.

      = ATTRIBUTES:

      The file attributes/apache.rb contains the following attribute
      types:

      * platform specific locations and settings.
      * general settings
      * pre-fork attributes
      * worker attributes

      General settings and pre-fork/worker attributes are tunable.
      EOH

   Or to read the contents from a specified file:

   .. code-block:: ruby

      long_description IO.read(File.join
        (File.dirname(__FILE__), 'README.rdoc')
      )

   .. end_tag

``maintainer``
   The name of the person responsible for maintaining a cookbook, either an individual or an organization.

   .. tag cookbooks_metadata_settting_maintainer

   For example:

   .. code-block:: ruby

      maintainer 'Adam Jacob'

   .. end_tag

``maintainer_email``
   The email address for the person responsible for maintaining a cookbook. Only one email can be listed here, so if this needs to be forwarded to multiple people consider using an email address that is already setup for mail forwarding.

   .. tag cookbooks_metadata_settting_maintainer_email

   For example:

   .. code-block:: ruby

      maintainer_email 'adam@example.com'

   .. end_tag

``name``
   Required. The name of the cookbook.

   .. tag cookbooks_metadata_settting_name

   For example:

   .. code-block:: ruby

      name 'cats'

   .. end_tag

``privacy``
   Specify that a cookbook is private.

``provides``
   Add a recipe, definition, or resource that is provided by this cookbook, should the auto-populated list be insufficient.

   .. tag cookbooks_metadata_settting_provides

   For example, for recipes:

   .. code-block:: ruby

      provides 'cats::sleep'
      provides 'cats::eat'

   For definitions:

   .. code-block:: ruby

      provides 'here(:kitty, :time_to_eat)'

   And for resources:

   .. code-block:: ruby

      provides 'service[snuggle]'

   .. end_tag

``recipe``
   A description for a recipe, mostly for cosmetic value within the Chef server user interface.

   .. tag cookbooks_metadata_settting_recipe

   For example:

   .. code-block:: ruby

      recipe 'cats::sleep', 'For a crazy 20 hours a day.'

   or:

   .. code-block:: ruby

      recipe 'cats::eat', 'When they are not sleeping.'

   .. end_tag

``source_url``
   The URL for the location in which a cookbook's source code is maintained. This setting is also used by Chef Supermarket. In Chef Supermarket, this value is used to define the destination for the "View Source" link.

   .. tag cookbooks_metadata_settting_source_url

   For example:

   .. code-block:: ruby

      source_url 'https://github.com/chef-cookbooks/chef-client'

   .. end_tag

``supports``
   Show that a cookbook has a supported platform. Use a version constraint to define dependencies for platform versions: ``<`` (less than), ``<=`` (less than or equal to), ``=`` (equal to), ``>=`` (greater than or equal to), ``~>`` (approximately greater than), or ``>`` (greater than). To specify more than one platform, use more than one ``supports`` field, once for each platform.

   .. tag cookbooks_metadata_settting_supports

   For example, to support every version of Ubuntu:

   .. code-block:: ruby

      supports 'ubuntu'

   or, to support versions of Ubuntu greater than or equal to 12.04:

   .. code-block:: ruby

      supports 'ubuntu', '>= 12.04'

   or, to support only Ubuntu 14.10:

   .. code-block:: ruby

      supports 'ubuntu', '= 14.10'

   .. end_tag

``version``
   The current version of a cookbook. Version numbers always follow a simple three-number version sequence.

   .. tag cookbooks_metadata_settting_version

   For example:

   .. code-block:: ruby

      version '2.0.0'

   .. end_tag

