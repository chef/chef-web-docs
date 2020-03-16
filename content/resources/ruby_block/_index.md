---
title: ruby_block resource
resource: ruby_block
draft: false
aliases:
- /resource_ruby_block.html
menu:
  infra:
    title: ruby_block
    identifier: chef_infra/cookbook_reference/resources/ruby_block ruby_block
    parent: chef_infra/cookbook_reference/resources
    weight: 1060
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **ruby_block** resource to execute Ruby code during a Chef

    Infra Client run. Ruby code in the `ruby_block` resource is evaluated

    with other resources during convergence, whereas Ruby code outside of a

    `ruby_block` resource is evaluated before other resources, as the recipe

    is compiled.'
resource_new_in: null
handler_types: false
syntax_description: "A **ruby_block** resource block executes a block of arbitrary\
  \ Ruby\ncode. For example, to reload the client.rb file during a Chef Infra\nClient\
  \ run:\n\n``` ruby\nruby_block 'reload_client_config' do\n  block do\n    Chef::Config.from_file(\"\
  /etc/chef/client.rb\")\n  end\n  action :run\nend\n```"
syntax_code_block: null
syntax_properties_list: null
syntax_full_code_block: "ruby_block 'name' do\n  block                      Block\n\
  \  block_name                 String # defaults to 'name' if not specified\n  action\
  \                     Symbol # defaults to :run if not specified\nend"
syntax_full_properties_list:
- '`ruby_block` is the resource.'
- '`name` is the name given to the resource block.'
- '`block` is the block of Ruby code to be executed.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`block` and `block_name` are properties of this resource, with the Ruby type shown.
  See "Properties" section below for more information about all of the properties
  that may be used with this resource.'
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :create:
    markdown: The same as `:run`.
  :nothing:
    shortcode: resources_common_actions_nothing.md
  :run:
    markdown: Default. Run a Ruby block.
properties_list:
- property: block
  ruby_type: Block
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: A block of Ruby code.
- property: block_name
  ruby_type: String
  required: false
  default_value: The resource block's name
  new_in: null
  description_list:
  - markdown: 'The name of the Ruby block. Default value: the `name` of the

      resource block. See "Syntax" section above for more information.'
- property: ignore_failure
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: Continue running a recipe if a resource fails for any reason.
- property: notifies
  ruby_type: Symbol, Chef::Resource\[String\]
  required: false
  default_value: null
  new_in: null
  description_list:
  - shortcode: resources_common_notification_notifies.md
  - markdown: ''
  - shortcode: resources_common_notification_timers.md
  - markdown: ''
  - shortcode: resources_common_notification_notifies_syntax.md
- property: retries
  ruby_type: Integer
  required: false
  default_value: '0'
  new_in: null
  description_list:
  - markdown: The number of attempts to catch exceptions and retry the resource.
- property: retry_delay
  ruby_type: Integer
  required: false
  default_value: '2'
  new_in: null
  description_list:
  - markdown: The retry delay (in seconds).
- property: subscribes
  ruby_type: Symbol, Chef::Resource\[String\]
  required: false
  default_value: null
  new_in: null
  description_list:
  - shortcode: resources_common_notification_subscribes.md
  - markdown: ''
  - shortcode: resources_common_notification_timers.md
  - markdown: ''
  - shortcode: resources_common_notification_subscribes_syntax.md
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
resources_common_properties: false
resources_common_notification: false
resources_common_guards: false
common_resource_functionality_multiple_packages: false
resources_common_guard_interpreter: false
remote_directory_recursive_directories: false
common_resource_functionality_resources_common_windows_security: false
handler_custom: false
cookbook_file_specificity: false
unit_file_verification: false
examples_list:
- example_heading: Re-read configuration data
  text_blocks:
  - code_block: "ruby_block 'reload_client_config' do\n  block do\n    Chef::Config.from_file('/etc/chef/client.rb')\n\
      \  end\n  action :run\nend"
- example_heading: 'Install repositories from a file, trigger a command, and force
    the

    internal cache to reload'
  text_blocks:
  - shortcode: resource_package_install_yum_repo_from_file.md
- example_heading: Use an if statement with the platform recipe DSL method
  text_blocks:
  - shortcode: resource_ruby_block_if_statement_use_with_platform.md
- example_heading: Stash a file in a data bag
  text_blocks:
  - shortcode: resource_ruby_block_stash_file_in_data_bag.md
  - markdown: '**Update the /etc/hosts file**


      The following example shows how the **ruby_block** resource can be used

      to update the `/etc/hosts` file:'
  - code_block: "# the following code sample comes from the ``ec2`` recipe\n# in the\
      \ following cookbook: https://github.com/chef-cookbooks/dynect\n\nruby_block\
      \ 'edit etc hosts' do\n  block do\n    rc = Chef::Util::FileEdit.new('/etc/hosts')\n\
      \    rc.search_file_replace_line(/^127\\.0\\.0\\.1 localhost$/,\n       '127.0.0.1\
      \ #{new_fqdn} #{new_hostname} localhost')\n    rc.write_file\n  end\nend"
- example_heading: Set environment variables
  text_blocks:
  - markdown: 'The following example shows how to use variables within a Ruby block
      to

      set environment variables using rbenv.'
  - code_block: "node.override[:rbenv][:root] = rbenv_root\nnode.override[:ruby_build][:bin_path]\
      \ = rbenv_binary_path\n\nruby_block 'initialize' do\n  block do\n    ENV['RBENV_ROOT']\
      \ = node[:rbenv][:root]\n    ENV['PATH'] = \"#{node[:rbenv][:root]}/bin:#{node[:ruby_build][:bin_path]}:#{ENV['PATH']}\"\
      \n  end\nend"
- example_heading: Set JAVA_HOME
  text_blocks:
  - markdown: 'The following example shows how to use a variable within a Ruby block
      to

      set the `java_home` environment variable:'
  - code_block: "ruby_block 'set-env-java-home' do\n  block do\n    ENV['JAVA_HOME']\
      \ = java_home\n  end\nend"
- example_heading: Run specific blocks of Ruby code on specific platforms
  text_blocks:
  - markdown: 'The following example shows how the `platform?` method and an if

      statement can be used in a recipe along with the `ruby_block` resource

      to run certain blocks of Ruby code on certain platforms:'
  - code_block: "if platform_family?('debian', 'rhel', 'fedora', 'amazon')\n  ruby_block\
      \ 'update-java-alternatives' do\n    block do\n      if platform?('ubuntu',\
      \ 'debian') and version == 6\n        run_context = Chef::RunContext.new(node,\
      \ {})\n        r = Chef::Resource::Execute.new('update-java-alternatives', run_context)\n\
      \        r.command 'update-java-alternatives -s java-6-openjdk'\n        r.returns\
      \ [0,2]\n        r.run_action(:create)\n      else\n\n        require 'fileutils'\n\
      \        arch = node['kernel']['machine'] =~ /x86_64/ ? 'x86_64' : 'i386'\n\
      \        Chef::Log.debug(\"glob is #{java_home_parent}/java*#{version}*openjdk*\"\
      )\n        jdk_home = Dir.glob(\"#{java_home_parent}/java*#{version}*openjdk{,[-\\\
      .]#{arch}}\")[0]\n        Chef::Log.debug(\"jdk_home is #{jdk_home}\")\n\n \
      \       if File.exist? java_home\n          FileUtils.rm_f java_home\n     \
      \   end\n        FileUtils.ln_sf jdk_home, java_home\n\n        cmd = Chef::ShellOut.new(\n\
      \              %Q[ update-alternatives --install /usr/bin/java java #{java_home}/bin/java\
      \ 1;\n              update-alternatives --set java #{java_home}/bin/java ]\n\
      \              ).run_command\n           unless cmd.exitstatus == 0 or cmd.exitstatus\
      \ == 2\n          Chef::Application.fatal!('Failed to update-alternatives for\
      \ openjdk!')\n        end\n      end\n    end\n    action :nothing\n  end\n\
      end"
- example_heading: Reload the configuration
  text_blocks:
  - shortcode: resource_ruby_block_reload_configuration.md

---
