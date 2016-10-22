=====================================================
metadata.rb
=====================================================

.. tag cookbooks_metadata

Every cookbook requires a small amount of metadata. A file named metadata.rb is located at the top of every cookbook directory structure. The contents of the metadata.rb file provides hints to the Chef server to help ensure that cookbooks are deployed to each node correctly.

.. end_tag

.. tag config_rb_metadata_summary

A metadata.rb file is:

* Located at the top level of a cookbook's directory structure
* Compiled whenever a cookbook is uploaded to the Chef server or when the ``knife cookbook metadata`` subcommand is run, and then stored as JSON data
* Created automatically by knife whenever the ``knife cookbook create`` subcommand is run
* Edited using a text editor, and then re-uploaded to the Chef server as part of a cookbook upload

.. end_tag

.. note:: A metadata.json file can be edited directly, should temporary changes be required. Any subsequent upload or action that generates metadata will cause the existing metadata.json file to be overwritten with the newly generated metadata. Therefore, any permanent changes to cookbook metadata should be done in the metadata.rb file, and then re-uploaded to the Chef server.

Settings
==========================================================================
.. tag config_rb_metadata_settings

This configuration file has the following settings:

``attribute``
   The list of attributes that are required to configure a cookbook. An attribute name is required, followed by any of these options: ``display_name`` (the name that appears in the user interface), ``description`` (a short description), ``choice`` (an array of choices that are presented to a user), ``calculated`` (the default value is calculated by the recipe), ``type`` (the type of value, either ``string``, ``array``, or ``hash``), ``required`` (the level of user input, either ``required``, ``recommended``, or ``optional``), ``recipes`` (an array of recipes), or ``default`` (the attribute's default value).

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

``chef_version``
   A range of chef-client versions that are supported by this cookbook.

   .. tag config_rb_metadata_settings_example_chef_version

   For example, to match any 12.x version of the chef-client, but not 11.x or 13.x:

   .. code-block:: ruby

      chef_version "~> 12"

   Or matches any 12.x (or higher) version of the chef-client:

   .. code-block:: ruby

      chef_version ">= 12"

   Or matches any version of the chef-client greater than 12.5.1, any 13.x version, but no 14.x versions:

   .. code-block:: ruby

      chef_version ">= 12.5.1", "< 14.0"

   Or matches any version of the chef-client greater than or equal to 11.18.4 and less than 12.0 and also any version of the chef-client greater than or equal to 12.5.1, but less than 13.0:

   .. code-block:: ruby

      chef_version ">= 11.18.12", "< 12.0"
      chef_version ">= 12.5.1", "< 13.0"

   .. end_tag

   .. note:: This setting is not visible in Chef Supermarket.

``depends``
   Show that a cookbook has a dependency on another cookbook. Use a version constraint to define dependencies for cookbook versions: ``<`` (less than), ``<=`` (less than or equal to), ``=`` (equal to), ``>=`` (greater than or equal to; also known as "optimistically greater than", or "optimistic"), ``~>`` (approximately greater than; also known as "pessimistically greater than", or "pessimistic"), or ``>`` (greater than). This field requires that a cookbook with a matching name and version exists on the Chef server. When the match exists, the Chef server includes the dependency as part of the set of cookbooks that are sent to the node when the chef-client runs. It is very important that the ``depends`` field contain accurate data. If a dependency statement is inaccurate, the chef-client may not be able to complete the configuration of the system.

   For example, to set a dependency a cookbook named ``cats``:

   .. code-block:: ruby

      depends 'cats'

   or, to set a dependency on the same cookbook, but only when the version is less than 1.0:

   .. code-block:: ruby

      depends 'cats', '< 1.0'

``description``
   A short description of a cookbook and its functionality.

   For example:

   .. code-block:: ruby

      description 'A fancy cookbook that manages a herd of cats!'

``gem``
   .. tag config_rb_metadata_settings_gem

   Specifies a gem dependency to be installed via the **chef_gem** resource after all cookbooks are synchronized, but before any other cookbook loading is done. Use this attribute once per gem dependency. For example:

   .. code-block:: ruby

      gem "poise"
      gem "chef-sugar"
      gem "chef-provisioning"

   .. end_tag

``issues_url``
   The URL for the location in which a cookbook's issue tracking is maintained. This setting is also used by Chef Supermarket. In Chef Supermarket, this value is used to define the destination for the "View Issues" link.

   For example:

   .. code-block:: ruby

      issues_url 'https://github.com/chef-cookbooks/chef-client/issues'

``license``
   The type of license under which a cookbook is distributed: ``Apache v2.0``, ``GPL v2``, ``GPL v3``, ``MIT``, or ``license 'Proprietary - All Rights Reserved`` (default). Please be aware of the licenses for files inside of a cookbook and be sure to follow any restrictions they describe.

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

``long_description``
   A longer description that ideally contains full instructions on the proper use of a cookbook, including definitions, libraries, dependencies, and so on. There are two ways to use this field: with the contents embedded in the field itself or with the contents pulled from a file at a specified path, such as a README.rdoc located at the top of a cookbook directory.

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

``maintainer``
   The name of the person responsible for maintaining a cookbook, either an individual or an organization.

   For example:

   .. code-block:: ruby

      maintainer 'Adam Jacob'

``maintainer_email``
   The email address for the person responsible for maintaining a cookbook. Only one email can be listed here, so if this needs to be forwarded to multiple people consider using an email address that is already setup for mail forwarding.

   For example:

   .. code-block:: ruby

      maintainer_email 'adam@example.com'

``name``
   Required. The name of the cookbook.

   For example:

   .. code-block:: ruby

      name 'cats'

``ohai_version``
   A range of chef-client versions that are supported by this cookbook.

   .. tag config_rb_metadata_settings_example_ohai_version

   For example, to match any 8.x version of Ohai, but not 7.x or 9.x:

   .. code-block:: ruby

      ohai_version "~> 8"

   Or matches any 8.x (or higher) version of Ohai:

   .. code-block:: ruby

      ohai_version ">= 8"

   .. end_tag

   .. note:: This setting is not visible in Chef Supermarket.

``privacy``
   Specify that a cookbook is private.

``provides``
   Add a recipe, definition, or resource that is provided by this cookbook, should the auto-populated list be insufficient.

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

``recipe``
   A description for a recipe, mostly for cosmetic value within the Chef server user interface.

   For example:

   .. code-block:: ruby

      recipe 'cats::sleep', 'For a crazy 20 hours a day.'

   or:

   .. code-block:: ruby

      recipe 'cats::eat', 'When they are not sleeping.'

``source_url``
   The URL for the location in which a cookbook's source code is maintained. This setting is also used by Chef Supermarket. In Chef Supermarket, this value is used to define the destination for the "View Source" link.

   For example:

   .. code-block:: ruby

      source_url 'https://github.com/chef-cookbooks/chef-client'

``supports``
   Show that a cookbook has a supported platform. Use a version constraint to define dependencies for platform versions: ``<`` (less than), ``<=`` (less than or equal to), ``=`` (equal to), ``>=`` (greater than or equal to), ``~>`` (approximately greater than), or ``>`` (greater than). To specify more than one platform, use more than one ``supports`` field, once for each platform.

   For example, to support every version of Ubuntu:

   .. code-block:: ruby

      supports 'ubuntu'

   or, to support versions of Ubuntu greater than or equal to 12.04:

   .. code-block:: ruby

      supports 'ubuntu', '>= 12.04'

   or, to support only Ubuntu 14.10:

   .. code-block:: ruby

      supports 'ubuntu', '= 14.10'

``version``
   The current version of a cookbook. Version numbers always follow a simple three-number version sequence.

   For example:

   .. code-block:: ruby

      version '2.0.0'

.. end_tag

