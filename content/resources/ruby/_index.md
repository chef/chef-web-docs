---
title: ruby resource
resource: ruby
draft: false
aliases:
- /resource_ruby.html
menu:
  infra:
    title: ruby
    identifier: chef_infra/cookbook_reference/resources/ruby ruby
    parent: chef_infra/cookbook_reference/resources
    weight: 1050
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **ruby** resource to execute scripts using the Ruby interpreter.

    This resource may also use any of the actions and properties that are

    available to the **execute** resource. Commands that are executed with

    this resource are (by their nature) not idempotent, as they are

    typically unique to the environment in which they are run. Use `not_if`

    and `only_if` to guard this resource for idempotence.'
- note:
    markdown: 'The **ruby** script resource (which is based on the **script** resource)

      is different from the **ruby_block** resource because Ruby code that is

      run with this resource is created as a temporary file and executed like

      other script resources, rather than run inline.'
resource_new_in: null
handler_types: false
syntax_description: "A **ruby** resource block executes scripts using Ruby:\n\n```\
  \ ruby\nruby 'extract_module' do\n  cwd ::File.dirname(src_filepath)\n  code <<-EOH\n\
  \    mkdir -p #{extract_path}\n    tar xzf #{src_filename} -C #{extract_path}\n\
  \    mv #{extract_path}/*/* #{extract_path}/\n    EOH\n  not_if { ::File.exist?(extract_path)\
  \ }\nend\n```"
syntax_code_block: null
syntax_properties_list:
- '`cwd` specifies the directory from which the command is run'
- '`code` specifies the command to run'
syntax_full_code_block: "ruby 'name' do\n  code                       String\n  creates\
  \                    String\n  cwd                        String\n  environment\
  \                Hash\n  flags                      String\n  group            \
  \          String, Integer\n  path                       Array\n  returns      \
  \              Integer, Array\n  timeout                    Integer, Float\n  user\
  \                       String, Integer\n  umask                      String, Integer\n\
  \  action                     Symbol # defaults to :run if not specified\nend"
syntax_full_properties_list:
- '`ruby` is the resource.'
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
    shortcode: resources_common_actions_nothing.md
  :run:
    markdown: Default. Run a script.
properties_list:
- property: code
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: A quoted (" ") string of code to be executed.
- property: creates
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Prevent a command from creating a file when that file already

      exists.'
- property: cwd
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The current working directory.
- property: environment
  ruby_type: Hash
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'A Hash of environment variables in the form of

      `({"ENV_VARIABLE" => "VALUE"})`. (These variables must exist for a

      command to be run successfully.)'
- property: flags
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'One or more command line flags that are passed to the interpreter

      when a command is invoked.'
- property: group
  ruby_type: String, Integer
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The group name or group ID that must be changed before running a

      command.'
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
    - - markdown: r
    - - markdown: ub
    - - markdown: y
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
- property: returns
  ruby_type: Integer, Array
  required: false
  default_value: '0'
  new_in: null
  description_list:
  - markdown: 'The return value for a command. This may be an array of accepted

      values. An exception is raised when the return value(s) do not

      match.'
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
- property: timeout
  ruby_type: Integer, Float
  required: false
  default_value: '3600'
  new_in: null
  description_list:
  - markdown: 'The amount of time (in seconds) a command is to wait before timing

      out.'
- property: user
  ruby_type: String, Integer
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The user name or user ID that should be changed before running a

      command.'
- property: umask
  ruby_type: String, Integer
  required: false
  default_value: null
  new_in: null
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
resources_common_properties: false
resources_common_notification: false
resources_common_guards: true
common_resource_functionality_multiple_packages: false
resources_common_guard_interpreter: false
remote_directory_recursive_directories: false
common_resource_functionality_resources_common_windows_security: false
handler_custom: false
cookbook_file_specificity: false
unit_file_verification: false
examples_list:
- example_heading: null
  text_blocks:
  - markdown: None.

---
