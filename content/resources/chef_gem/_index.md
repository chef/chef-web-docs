---
title: chef_gem resource
resource: chef_gem
draft: false
aliases:
- "/resource_chef_gem.html"
menu:
  infra:
    title: chef_gem
    identifier: chef_infra/cookbook_reference/resources/chef_gem chef_gem
    parent: chef_infra/cookbook_reference/resources

resource_reference: true
robots: null
resource_description_list:
- warning:
    shortcode: notes_chef_gem_vs_gem_package.md
- markdown: "Use the **chef_gem** resource to install a gem only for the instance\
    \ of\nRuby that is dedicated to Chef Infra Client. When a gem is installed\nfrom\
    \ a local file, it must be added to the node using the\n**remote_file** or **cookbook_file**\
    \ resources.\n\nThe **chef_gem** resource works with all of the same properties\
    \ and\noptions as the **gem_package** resource, but does not accept the\n`gem_binary`\
    \ property because it always uses the `CurrentGemEnvironment`\nunder which Chef\
    \ Infra Client is running. In addition to performing\nactions similar to the **gem_package**\
    \ resource, the **chef_gem**\nresource does the following:\n\n-   Runs its actions\
    \ immediately, before convergence, allowing a gem to\n    be used in a recipe\
    \ immediately after it is installed\n-   Runs `Gem.clear_paths` after the action,\
    \ ensuring that gem is aware\n    of changes so that it can be required immediately\
    \ after it is\n    installed"
resource_new_in: null
handler_types: false
syntax_description: 'A **chef_gem** resource block manages a package on a node, typically
  by

  installing it. The simplest use of the **chef_gem** resource is:


  ``` ruby

  chef_gem ''package_name''

  ```


  which will install the named gem using all of the default options and

  the default action (`:install`).'
syntax_code_block: null
syntax_properties_list: null
syntax_full_code_block: "chef_gem 'name' do\n  clear_sources              true, false\n\
  \  compile_time               true, false\n  gem_binary                 String\n\
  \  include_default_source     true, false\n  options                    String\n\
  \  package_name               String\n  source                     String, Array\n\
  \  timeout                    String, Integer\n  version                    String\n\
  \  action                     Symbol # defaults to :install if not specified\nend"
syntax_full_properties_list:
- '`chef_gem` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`clear_sources`, `compile_time`, `gem_binary`, `include_default_source`, `options`,
  `package_name`, `source`, `timeout`, and `version` are the properties available
  to this resource.'
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :install:
    markdown: Default. Install a gem. If a version is specified, install the specified
      version of the gem.
  :nothing:
    shortcode: resources_common_actions_nothing.md
  :purge:
    markdown: Purge a gem. This action typically removes the configuration files as
      well as the gem.
  :reconfig:
    markdown: Reconfigure a gem. This action requires a response file.
  :remove:
    markdown: Remove a gem.
  :upgrade:
    markdown: Install a gem and/or ensure that a gem is the latest version.
properties_list:
- property: clear_sources
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: 'Set to `true` to download a gem from the path specified by the

      `source` property (and not from RubyGems).'
  - note:
    - markdown: "Another approach is to use the **gem_package** resource, and then\n\
        specify the `gem_binary` location to the RubyGems directory that is\nused\
        \ by Chef. For example:\n\n``` ruby\ngem_package 'gem_name' do\n  gem_binary\
        \ Chef::Util::PathHelper.join(Chef::Config.embedded_dir,'bin','gem')\n  action\
        \ :install\nend\n```"
- property: compile_time
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: 'Controls the phase during which a gem is installed on a node. Set to

      `true` to install a gem while the resource collection is being built

      (the "compile phase"). Set to `false` to install a gem while Chef

      Infra Client is configuring the node (the "converge phase").

      Recommended value: `false`.'
- property: gem_binary
  ruby_type: String
  required: false
  default_value: Chef's built-in gem binary
  new_in: null
  description_list:
  - markdown: 'The path of a gem binary to use for the installation. By default,

      the same version of Ruby that is used by Chef Infra Client will be

      installed.'
- property: include_default_source
  ruby_type: true, false
  required: false
  default_value: 'true'
  new_in: '13.0'
  description_list:
  - markdown: 'Set to `false` to not include `Chef::Config[:rubygems_url]` in the

      sources.'
- property: options
  ruby_type: String, Hash, Array,
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Options for the gem install, either a Hash or a String. When a hash

      is given, the options are passed to Gem::DependencyInstaller.new,

      and the gem will be installed via the gems API. When a String is

      given, the gem will be installed by shelling out to the gem command.

      Using a Hash of options with an explicit gem_binary will result in

      undefined behavior.'
- property: package_name
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'An optional property to set the gem name if it differs from the

      resource block''s name.'
- property: source
  ruby_type: String, Array
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Optional. The URL, or list of URLs, at which the gem package is

      located. This list is added to the source configured in

      `Chef::Config[:rubygems_url]` (see also include_default_source) to

      construct the complete list of rubygems sources. Users in an

      ''airgapped'' environment should set `Chef::Config[:rubygems_url]` to

      their local RubyGems mirror.'
- property: timeout
  ruby_type: String, Integer
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The amount of time (in seconds) to wait before timing out.
- property: version
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The version of a gem to be installed or upgraded.
properties_shortcode: null
properties_multiple_packages: false
resource_directory_recursive_directories: false
resources_common_atomic_update: false
properties_resources_common_windows_security: false
remote_file_prevent_re_downloads: false
remote_file_unc_path: false
ps_credential_helper: false
ruby_style_basics_chef_log: false
debug_recipes_chef_shell: false
template_requirements: false
resources_common_properties: true
resources_common_notification: true
resources_common_guards: true
common_resource_functionality_multiple_packages: false
resources_common_guard_interpreter: false
remote_directory_recursive_directories: false
common_resource_functionality_resources_common_windows_security: false
handler_custom: false
cookbook_file_specificity: false
unit_file_verification: false
examples_list:
- example_heading: Compile time vs. converge time installation of gems
  text_blocks:
  - markdown: "To install a gem while Chef Infra Client is configuring the node (the\n\
      \u201Cconverge phase\u201D), set the `compile_time` property to `false`:"
  - code_block: "chef_gem 'right_aws' do\n  compile_time false\n  action :install\n\
      end"
  - markdown: "To install a gem while the resource collection is being built (the\n\
      \u201Ccompile phase\u201D), set the `compile_time` property to `true`:"
  - code_block: "chef_gem 'right_aws' do\n  compile_time true\n  action :install\n\
      end"
- example_heading: Install MySQL for Chef
  text_blocks:
  - code_block: "apt_update\n\nbuild_essential 'install compilation tools' do\n  compile_time\
      \ true\nend\n\nchef_gem 'mysql'"

---
