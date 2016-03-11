.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings:

``attribute``
   |metadata attributes| For example:

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
   |metadata rb chef_version|

   .. include:: ../../includes_config/includes_config_rb_metadata_settings_example_chef_version.rst

   .. note:: This setting is not visible in |supermarket|.

``conflicts``
   For information only; not used outside this file. |metadata rb conflicts| For example, if a cookbook conflicts with another cookbook named ``dogs``:

   .. code-block:: ruby

      conflicts 'dogs'

   Or if the cookbook conflicted with a cookbook named ``dogs`` and greater than version 1.0:

   .. code-block:: ruby

      conflicts 'dogs', '> 1.0'

``depends``
   |metadata rb depends| For example, to set a dependency a cookbook named ``cats``:

   .. code-block:: ruby

      depends 'cats'

   Or, to set a dependency on the same cookbook, but only when the version is less than 1.0:

   .. code-block:: ruby

      depends 'cats', '< 1.0'

``description``
   |description cookbook| For example:

   .. code-block:: ruby

      description 'A fancy cookbook that manages a herd of cats!'

``grouping``
   |grouping| For example:

   .. code-block:: ruby

      grouping 'pets/cat',
       :title => 'Cat Options',
       :description => 'Describe your cat using the options below'

``issues_url``
   |url cookbook_issues| In |supermarket|, this value is used to define the destination for the "View Issues" link. For example:

   .. code-block:: ruby

      issues_url 'https://github.com/chef-cookbooks/chef-client/issues'

``license``
   |license metadata_rb| For example:

   .. code-block:: ruby

      license 'Apache v2.0'

   Or:

   .. code-block:: ruby

      license 'GPL v3'

   Or:

   .. code-block:: ruby

      license 'MIT'

   Or:

   .. code-block:: ruby

      license 'Proprietary - All Rights Reserved'

``long_description``
   |long description| For example, to embed the long description within the field itself:

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
   |maintainer| For example:

   .. code-block:: ruby

      maintainer 'Adam Jacob'

``maintainer_email``
   |maintainer email| For example:

   .. code-block:: ruby

      maintainer_email 'adam@example.com'

``name``
   Required. |name cookbook| For example:

   .. code-block:: ruby

      name 'cats'

``ohai_version``
   |metadata rb chef_version|

   .. include:: ../../includes_config/includes_config_rb_metadata_settings_example_ohai_version.rst

   .. note:: This setting is not visible in |supermarket|.

``privacy``
   Use to specify if a cookbook is private.

``provides``
   |metadata rb provides| For example, for recipes:

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
   |description recipe| For example:

   .. code-block:: ruby

      recipe 'cats::sleep', 'For a crazy 20 hours a day.'

   Or:

   .. code-block:: ruby

      recipe 'cats::eat', 'When they are not sleeping.'

``recommends``
   For information only; not used outside this file. |metadata rb recommends|

   .. note:: When running automated tests using |foodcritic|, this setting will trigger FC053.

   For example:

   .. code-block:: ruby

      recommends 'dogs'

   Or, to recommend a cookbook named ``dogs`` and for version 1.0 (or higher):

   .. code-block:: ruby

      recommends 'dogs', '> 1.0'

``replaces``
   For information only; not used outside this file. |metadata rb replaces| For example, to replace a cookbook named ``dogs`` with this cookbook:

   .. code-block:: ruby

      replaces 'dogs'

   Or to replace a cookbook named ``dogs``, but only for versions prior to 4.0:

   .. code-block:: ruby

      replaces 'dogs', '< 4.0'

``source_url``
   |url cookbook_source| In |supermarket|, this value is used to define the destination for the "View Source" link. For example:

   .. code-block:: ruby

      source_url 'https://github.com/chef-cookbooks/chef-client'

``suggests``
   For information only; not used outside this file. |metadata rb suggests|

   .. note:: When running automated tests using |foodcritic|, this setting will trigger FC052.

   For example:

   .. code-block:: ruby

      suggests 'cats'

   Or, to suggest a cookbook named ``cats``, but only for versions 1.0 and higher:

   .. code-block:: ruby

      suggests 'cats', '> 1.0'

``supports``
   |metadata rb supports| For example, to support every version of |ubuntu|:

   .. code-block:: ruby

      supports 'ubuntu'

   Or, to support versions of |ubuntu| greater than or equal to 8.04:

   .. code-block:: ruby

      supports 'ubuntu', '>= 8.04'

   Or, to support only |ubuntu| 9.10:

   .. code-block:: ruby

      supports 'ubuntu', '= 9.10'

``version``
   |version cookbook| For example:

   .. code-block:: ruby

      version '1.9.0'
