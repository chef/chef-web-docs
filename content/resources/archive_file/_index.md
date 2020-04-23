---
title: archive_file resource
resource: archive_file
draft: false
aliases:
- /resource_archive_file.html
menu:
  infra:
    title: archive_file
    identifier: chef_infra/cookbooks/resources/archive_file archive_file
    parent: chef_infra/cookbooks/resources
    weight: 110
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **archive_file** resource to extract archive files to disk.

    This resource uses the libarchive library to extract multiple archive

    formats including tar, gzip, bzip, and zip formats.'
resource_new_in: '15.0'
handler_types: false
syntax_description: "The archive_file resource has the following syntax:\n\n``` ruby\n\
  archive_file 'name' do\n  destination      String\n  group            String\n \
  \ mode             String, Integer # default value: \"755\"\n  options         \
  \ Array, Symbol\n  overwrite        true, false, auto # default value: false\n \
  \ owner            String\n  path             String # default value: 'name' unless\
  \ specified\n  action           Symbol # defaults to :extract if not specified\n\
  end\n```"
syntax_code_block: null
syntax_properties_list:
- '`archive_file` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`destination`, `group`, `mode`, `options`, `overwrite`, `owner`, and `path` are
  the properties available to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :extract:
    markdown: Extract and archive file.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: destination
  ruby_type: String
  required: true
  default_value: null
  new_in: null
  description_list:
  - markdown: The file path to extract the archive file to.
- property: group
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The group of the extracted files.
- property: mode
  ruby_type: String, Integer
  required: false
  default_value: '"755"'
  new_in: null
  description_list:
  - markdown: The mode of the extracted files.
- property: options
  ruby_type: Array, Symbol
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'An array of symbols representing extraction flags. Example:

      `:no_overwrite` to prevent overwriting files on disk. By default,

      this properly sets `:time`, which preserves the modification

      timestamps of files in the archive when writing them to disk.'
- property: overwrite
  ruby_type: true, false, auto
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: 'Should the resource overwrite the destination file contents if they

      already exist? If set to `:auto`, the date stamp of files within the

      archive will be compared to those on disk, and disk contents will be

      overwritten if they differ. This may cause unintended consequences

      if disk date stamps are changed between runs, which will result in

      the files being overwritten during each client run. Make sure to

      properly test any change to this property.'
- property: owner
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The owner of the extracted files.
- property: path
  ruby_type: String
  required: false
  default_value: The resource block's name
  new_in: null
  description_list:
  - markdown: 'An optional property to set the file path to the archive to extract

      if it differs from the resource block''s name.'
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
- example_heading: Extract a zip file to a specified directory
  text_blocks:
  - code_block: "archive_file 'Precompiled.zip' do\n  path '/tmp/Precompiled.zip'\n\
      \  destination '/srv/files'\nend"

---
