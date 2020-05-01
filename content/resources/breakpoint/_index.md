---
title: breakpoint resource
resource: breakpoint
draft: false
aliases:
- /resource_breakpoint.html
menu:
  infra:
    title: breakpoint
    identifier: chef_infra/cookbook_reference/resources/breakpoint breakpoint
    parent: chef_infra/cookbook_reference/resources

resource_reference: true
robots: null
resource_description_list:
- shortcode: resource_breakpoint_summary.md
resource_new_in: null
handler_types: false
syntax_description: ''
syntax_code_block: null
syntax_properties_list: null
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: resource_breakpoint_syntax.md
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list: {}
properties_list: []
properties_shortcode: resource_breakpoint_properties.md
properties_multiple_packages: false
resource_directory_recursive_directories: false
resources_common_atomic_update: false
properties_resources_common_windows_security: false
remote_file_prevent_re_downloads: false
remote_file_unc_path: false
ps_credential_helper: false
ruby_style_basics_chef_log: false
debug_recipes_chef_shell: true
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
examples: "
  A recipe without a breakpoint\n\n  ``` ruby\n  yum_key node['yum']['elrepo']['key']\
  \ do\n    url  node['yum']['elrepo']['key_url']\n    action :add\n  end\n\n  yum_repository\
  \ 'elrepo' do\n    description 'ELRepo.org Community Enterprise Linux Extras Repository'\n\
  \    key node['yum']['elrepo']['key']\n    mirrorlist node['yum']['elrepo']['url']\n\
  \    includepkgs node['yum']['elrepo']['includepkgs']\n    exclude node['yum']['elrepo']['exclude']\n\
  \    action :create\n  end\n  ```\n\n  The same recipe with breakpoints\n\n  ```\
  \ ruby\n  breakpoint \"before yum_key node['yum']['repo_name']['key']\" do\n   \
  \ action :break\n  end\n\n  yum_key node['yum']['repo_name']['key'] do\n    url\
  \  node['yum']['repo_name']['key_url']\n    action :add\n  end\n\n  breakpoint \"\
  after yum_key node['yum']['repo_name']['key']\" do\n    action :break\n  end\n\n\
  \  breakpoint \"before yum_repository 'repo_name'\" do\n    action :break\n  end\n\
  \n  yum_repository 'repo_name' do\n    description 'description'\n    key node['yum']['repo_name']['key']\n\
  \    mirrorlist node['yum']['repo_name']['url']\n    includepkgs node['yum']['repo_name']['includepkgs']\n\
  \    exclude node['yum']['repo_name']['exclude']\n    action :create\n  end\n\n\
  \  breakpoint \"after yum_repository 'repo_name'\" do\n    action :break\n  end\n\
  \  ```\n\n  where the name of each breakpoint is an arbitrary string. In the\n \
  \ previous examples, the names are used to indicate if the breakpoint is\n  before\
  \ or after a resource, and then also to specify which resource.\n"

---
