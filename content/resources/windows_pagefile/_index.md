---
title: windows_pagefile resource
resource: windows_pagefile
draft: false
aliases:
- /resource_windows_pagefile.html
menu:
  infra:
    title: windows_pagefile
    identifier: chef_infra/cookbook_reference/resources/windows_pagefile windows_pagefile
    parent: chef_infra/cookbook_reference/resources
    weight: 1300
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **windows_pagefile** resource to configure pagefile settings
    on

    Windows.'
resource_new_in: '14.0'
handler_types: false
syntax_description: "The windows_pagefile resource has the following syntax:\n\n```\
  \ ruby\nwindows_pagefile 'name' do\n  automatic_managed      true, false # default\
  \ value: false\n  initial_size           Integer\n  maximum_size           Integer\n\
  \  path                   String # default value: 'name' unless specified\n  system_managed\
  \         true, false\n  action                 Symbol # defaults to :set if not\
  \ specified\nend\n```"
syntax_code_block: null
syntax_properties_list:
- '`windows_pagefile` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`automatic_managed`, `initial_size`, `maximum_size`, `path`, and `system_managed`
  are the properties available to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :delete:
    markdown: Deletes the specified pagefile.
  :set:
    markdown: Default. Configures the default pagefile, creating it if it doesn't
      exist.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: automatic_managed
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: 'Enable automatic management of pagefile initial and maximum size.

      Setting this to true ignores ''initial_size'' and ''maximum_size''

      properties.'
- property: initial_size
  ruby_type: Integer
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: Initial size of the pagefile in megabytes.
- property: maximum_size
  ruby_type: Integer
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: Maximum size of the pagefile in megabytes.
- property: path
  ruby_type: String
  required: false
  default_value: The resource block's name
  new_in: null
  description_list:
  - markdown: 'An optional property to set the pagefile name if it differs from the

      resource block''s name.'
- property: system_managed
  ruby_type: true, false
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: Configures whether the system manages the pagefile size.
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
- example_heading: Set the system to manage pagefiles
  text_blocks:
  - code_block: "windows_pagefile 'Enable automatic management of pagefiles' do\n\
      \  automatic_managed true\nend"
- example_heading: Delete a pagefile
  text_blocks:
  - code_block: "windows_pagefile 'Delete the pagefile' do\n  path 'C:\\pagefile.sys'\n\
      \  action :delete\nend"
- example_heading: Create a pagefile with an initial and maximum size
  text_blocks:
  - code_block: "windows_pagefile 'create the pagefile' do\n  path 'C:\\pagefile.sys'\n\
      \  initial_size 100\n  maximum_size 200\nend"

---
