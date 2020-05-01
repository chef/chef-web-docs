---
title: kernel_module resource
resource: kernel_module
draft: false
aliases:
- /resource_kernel_module.html
menu:
  infra:
    title: kernel_module
    identifier: chef_infra/cookbook_reference/resources/kernel_module kernel_module
    parent: chef_infra/cookbook_reference/resources

resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **kernel_module** resource to manage kernel modules on Linux

    systems. This resource can load, unload, blacklist, disable, install,

    and uninstall modules.'
resource_new_in: '14.3'
handler_types: false
syntax_description: "The kernel_module resource has the following syntax:\n\n``` ruby\n\
  kernel_module 'name' do\n  load_dir        String # default value: \"/etc/modules-load.d\"\
  \n  modname         String # default value: 'name' unless specified\n  options \
  \        Array\n  unload_dir      String # default value: \"/etc/modprobe.d\"\n\
  \  action          Symbol # defaults to :install if not specified\nend\n```"
syntax_code_block: null
syntax_properties_list:
- '`kernel_module` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`load_dir`, `modname`, `options`, and `unload_dir` are the properties available
  to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :blacklist:
    markdown: Blacklist a kernel module.
  :disable:
    markdown: 'Disable a kernel module


      **New in Chef Client 15.2.**'
  :install:
    markdown: Default. Load kernel module, and ensure it loads on reboot.
  :load:
    markdown: Load a kernel module.
  :uninstall:
    markdown: Unload a kernel module and remove module config, so it doesn't load
      on reboot.
  :unload:
    markdown: Unload kernel module.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: load_dir
  ruby_type: String
  required: false
  default_value: '"/etc/modules-load.d"'
  new_in: null
  description_list:
  - markdown: The directory to load modules from.
- property: modname
  ruby_type: String
  required: false
  default_value: The resource block's name
  new_in: null
  description_list:
  - markdown: 'An optional property to set the kernel module name if it differs

      from the resource block''s name.'
- property: options
  ruby_type: Array
  required: false
  default_value: null
  new_in: '15.4'
  description_list:
  - markdown: An optional property to set options for the kernel module.
- property: unload_dir
  ruby_type: String
  required: false
  default_value: '"/etc/modprobe.d"'
  new_in: null
  description_list:
  - markdown: The modprobe.d directory.
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
examples: "\"Install and load a kernel module and ensure it loads on reboot.\\n\\\
  n``` ruby\\nkernel_module\\\n  \\ 'loop'\\n```\\n\\nInstall and load a kernel with\
  \ a specific set of options and ensure\\\n  \\ it\\nloads on reboot.\\n\\nConsult\
  \ kernel module documentation for specific options\\\n  \\ that are\\nsupported.\\\
  n\\n``` ruby\\nkernel_module 'loop' do\\n  options [ 'max_loop=4',\\\n  \\ 'max_part=8'\
  \ ]\\nend\\n```\\n\\nLoad a kernel module.\\n\\n``` ruby\\nkernel_module 'loop'\\\
  \n  \\ do\\n  action :load\\nend\\n```\\n\\n**Unload a kernel module and remove\
  \ module config\\\n  \\ so it doesn\\u2019t load on\\nreboot.**\\n\\n``` ruby\\\
  nkernel_module 'loop' do\\n \\\n  \\ action :uninstall\\nend\\n```\\n\\nUnload kernel\
  \ module.\\n\\n``` ruby\\nkernel_module\\\n  \\ 'loop' do\\n  action :unload\\nend\\\
  n```\\n\\nBlacklist a module from loading.\\n\\n\\\n  ``` ruby\\nkernel_module 'loop'\
  \ do\\n  action :blacklist\\nend\\n```\\n\\nDisable a kernel\\\n  \\ module.\\n\\\
  n``` ruby\\nkernel_module 'loop' do\\n  action :disable\\nend\\n```\"\n"

---
