---
title: bash resource
resource: bash
aliases:
- "/resource_bash.html"
menu:
  infra:
    title: bash
    identifier: chef_infra/cookbook_reference/resources/bash bash
    parent: chef_infra/cookbook_reference/resources
resource_reference: true
resource_description_list:
- markdown: 'Use the **bash** resource to execute scripts using the Bash interpreter.

    This resource may also use any of the actions and properties that are

    available to the **execute** resource. Commands that are executed with

    this resource are (by their nature) not idempotent, as they are

    typically unique to the environment in which they are run. Use `not_if`

    and `only_if` to guard this resource for idempotence.'
- note:
    markdown: 'The **bash** script resource (which is based on the **script** resource)

      is different from the **ruby_block** resource because Ruby code that is

      run with this resource is created as a temporary file and executed like

      other script resources, rather than run inline.'
resource_new_in: null
handler_types: false
syntax_description: "A **bash** resource block executes scripts using Bash:\n\n```\
  \ ruby\nbash 'extract_module' do\n  cwd ::File.dirname(src_filepath)\n  code <<-EOH\n\
  \    mkdir -p #{extract_path}\n    tar xzf #{src_filename} -C #{extract_path}\n\
  \    mv #{extract_path}/*/* #{extract_path}/\n    EOH\n  not_if { ::File.exist?(extract_path)\
  \ }\nend\n```"
syntax_code_block: null
syntax_properties_list:
- '`cwd` specifies the directory from which the command is run'
- '`code` specifies the command to run'
syntax_full_code_block: "bash 'name' do\n  code                       String\n  creates\
  \                    String\n  cwd                        String\n  environment\
  \                Hash\n  flags                      String\n  group            \
  \          String, Integer\n  path                       Array\n  returns      \
  \              Integer, Array\n  timeout                    Integer, Float\n  user\
  \                       String, Integer\n  umask                      String, Integer\n\
  \  action                     Symbol # defaults to :run if not specified\nend"
syntax_full_properties_list:
- '`bash` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`code`, `creates`, `cwd`, `environment`, `flags`, `group`, `path`, `returns`, `timeout`,
  `user`, and `umask` are properties of this resource, with the Ruby type shown. See
  "Properties" section below for more information about all of the properties that
  may be used with this resource.'
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :nothing:
    markdown: Prevent a command from running. This action is used to specify that
      a command is run only when another resource notifies it.
  :run:
    markdown: Default. Run a script.
properties_list:
- property: code
  ruby_type: String
  required: true
  default_value:
  new_in:
  description_list:
  - markdown: A quoted (" ") string of code to be executed.
- property: creates
  ruby_type: String
  required: false
  description_list:
  - markdown: Prevent a command from creating a file when that file already exists.
- property: cwd
  ruby_type: String
  required: false
  description_list:
  - markdown: The current working directory from which the command will be run.
- property: environment
  ruby_type: Hash
  required: false
  default_value:
  new_in:
  description_list:
  - markdown: 'A Hash of environment variables in the form of

      `({"ENV_VARIABLE" => "VALUE"})`. (These variables must exist for a

      command to be run successfully.)'
- property: flags
  ruby_type: String
  required: false
  description_list:
  - markdown: One or more command line flags that are passed to the interpreter when
      a command is invoked.
- property: group
  ruby_type: String, Integer
  required: false
  description_list:
  - markdown: 'The group name or group ID that must be changed before running a

      command.'
- property: path
  ruby_type: Array
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'An array of paths to use when searching for a command. These paths

      are not added to the command''s environment \$PATH. The default value

      uses the system path.'
  - warning:
    - - markdown: ''
    - shortcode: resources_common_resource_execute_attribute_path.md
    - - markdown: ''
    - - markdown: Fo
    - - markdown: r
    - - markdown: ex
    - - markdown: am
    - - markdown: pl
    - - markdown: 'e:'
    - - markdown: ''
    - - markdown: '``'
    - - markdown: '`'
    - - markdown: ru
    - - markdown: by
    - - markdown: b
    - - markdown: as
    - - markdown: h
    - - markdown: '''m'
    - - markdown: yc
    - - markdown: om
    - - markdown: ma
    - - markdown: nd
    - - markdown: ''''
    - - markdown: do
    - - markdown: ''
    - - markdown: e
    - - markdown: nv
    - - markdown: ir
    - - markdown: 'on'
    - - markdown: me
    - - markdown: nt
    - - markdown: ''''
    - - markdown: PA
    - - markdown: TH
    - - markdown: ''''
    - - markdown: =>
    - - markdown: '"'
    - - markdown: /m
    - - markdown: y/
    - - markdown: pa
    - - markdown: th
    - - markdown: /t
    - - markdown: o/
    - - markdown: bi
    - - markdown: 'n:'
    - - markdown: '#{'
    - - markdown: EN
    - - markdown: V[
    - - markdown: '''P'
    - - markdown: AT
    - - markdown: H'
    - - markdown: ']}'
    - - markdown: '"'
    - - markdown: en
    - - markdown: d
    - - markdown: '``'
    - - markdown: '`'
    - - markdown: ''
- property: returns
  ruby_type: Integer, Array
  required: false
  default_value: '0'
  new_in: null
  description_list:
  - markdown: 'The return value for a command. This may be an array of accepted

      values. An exception is raised when the return value(s) do not

      match.'
- property: timeout
  ruby_type: Integer, String, Float
  required: false
  default_value: '3600'
  description_list:
  - markdown: The amount of time (in seconds) a command is to wait before timing out.
- property: user
  ruby_type: String, Integer
  required: false
  description_list:
  - markdown: 'The user name or user ID that should be changed before running a

      command.'
- property: umask
  ruby_type: String, Integer
  required: false
  description_list:
  - markdown: The file mode creation mask, or umask.
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
- example_heading: Use a named provider to run a script
  text_blocks:
  - shortcode: resource_script_bash_provider_and_interpreter.md
- example_heading: Install a file from a remote location using bash
  text_blocks:
  - shortcode: resource_remote_file_install_with_bash.md
- example_heading: Install an application from git using bash
  text_blocks:
  - shortcode: resource_scm_use_bash_and_ruby_build.md
- example_heading: Store certain settings
  text_blocks:
  - shortcode: resource_remote_file_store_certain_settings.md

---
