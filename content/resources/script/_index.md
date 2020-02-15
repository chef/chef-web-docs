---
title: script resource
resource: script
draft: false
aliases:
- /resource_script.html
menu:
  docs:
    title: script
    identifier: chef_infra/cookbook_reference/resources/resource_script.md script
    parent: chef_infra/cookbook_reference/resources
    weight: 940
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **script** resource to execute scripts using a specified

    interpreter, such as Bash, csh, Perl, Python, or Ruby. This resource may

    also use any of the actions and properties that are available to the

    **execute** resource. Commands that are executed with this resource are

    (by their nature) not idempotent, as they are typically unique to the

    environment in which they are run. Use `not_if` and `only_if` to guard

    this resource for idempotence.'
- note:
    markdown: 'The **script** resource is different from the **ruby_block** resource

      because Ruby code that is run with this resource is created as a

      temporary file and executed like other script resources, rather than run

      inline.'
- markdown: 'This resource is the base resource for several other resources used for

    scripting on specific platforms. For more information about specific

    resources for specific platforms, see the following topics:


    -   [bash](/resources/bash/)

    -   [csh](/resources/csh/)

    -   [ksh](/resources/ksh/)

    -   [perl](/resources/perl/)

    -   [python](/resources/python/)

    -   [ruby](/resources/ruby/)


    Changed in 12.19 to support windows alternate user identity in execute

    resources'
resource_new_in: null
handler_types: false
syntax_description: "A **script** resource block typically executes scripts using\
  \ a specified\ninterpreter, such as Bash, csh, Perl, Python, or Ruby:\n\n``` ruby\n\
  script 'extract_module' do\n  interpreter \"bash\"\n  cwd ::File.dirname(src_filepath)\n\
  \  code <<-EOH\n    mkdir -p #{extract_path}\n    tar xzf #{src_filename} -C #{extract_path}\n\
  \    mv #{extract_path}/*/* #{extract_path}/\n    EOH\n  not_if { ::File.exist?(extract_path)\
  \ }\nend\n```"
syntax_code_block: null
syntax_properties_list:
- '`interpreter` specifies the command shell to use'
- '`cwd` specifies the directory from which the command is run'
- '`code` specifies the command to run


  It is more common to use the **script**-based resource that is specific

  to the command shell. Chef has shell-specific resources for Bash, csh,

  Perl, Python, and Ruby.


  The same command as above, but run using the **bash** resource:


  ``` ruby

  bash ''extract_module'' do cwd ::File.dirname(src_filepath) code <<-EOH mkdir -p
  #{extract_path} tar xzf #{src_filename} -C #{extract_path} mv #{extract_path}/*/*
  #{extract_path}/ EOH not_if { ::File.exist?(extract_path) }

  end

  ```'
syntax_full_code_block: "script 'name' do\n  code                       String\n \
  \ creates                    String\n  cwd                        String\n  environment\
  \                Hash\n  flags                      String\n  group            \
  \          String, Integer\n  interpreter                String\n  path        \
  \               Array\n  returns                    Integer, Array\n  timeout  \
  \                  Integer, Float\n  user                       String\n  password\
  \                   String\n  domain                     String\n  umask       \
  \               String, Integer\n  action                     Symbol # defaults\
  \ to :run if not specified\nend"
syntax_full_properties_list:
- '`script` is the resource'
- '`name` is the name of the resource block'
- '`cwd` is the location from which the command is run'
- '`action` identifies the steps Chef Infra Client will take to bring the node into
  the desired state'
- '`code`, `creates`, `cwd`, `environment`, `flags`, `group`, `interpreter`, `path`,
  `returns`, `timeout`, `user`, `password`, `domain` and `umask` are properties of
  this resource, with the Ruby type shown. See "Properties" section below for more
  information about all of the properties that may be used with this resource.'
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
  - markdown: The current working directory from which the command will be run.
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
- property: interpreter
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The script interpreter to use during code execution.
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
    - - markdown: s
    - - markdown: cr
    - - markdown: ip
    - - markdown: t
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
  ruby_type: Integer, Float
  required: false
  default_value: '3600'
  new_in: null
  description_list:
  - markdown: 'The amount of time (in seconds) a command is to wait before timing

      out.'
- property: user
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The user name of the user identity with which to launch the new

      process. Default value: <span class="title-ref">nil</span>. The user

      name may optionally be specified with a domain, i.e. <span

      class="title-ref">domainuser</span> or <span

      class="title-ref">user@my.dns.domain.com</span> via Universal

      Principal Name (UPN)format. It can also be specified without a

      domain simply as user if the domain is instead specified using the

      <span class="title-ref">domain</span> attribute. On Windows only, if

      this property is specified, the <span

      class="title-ref">password</span> property must be specified.'
- property: password
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: '*Windows only*: The password of the user specified by the <span

      class="title-ref">user</span> property. Default value: <span

      class="title-ref">nil</span>. This property is mandatory if <span

      class="title-ref">user</span> is specified on Windows and may only

      be specified if <span class="title-ref">user</span> is specified.

      The <span class="title-ref">sensitive</span> property for this

      resource will automatically be set to true if password is specified.'
- property: domain
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: '*Windows only*: The domain of the user user specified by the <span

      class="title-ref">user</span> property. Default value: <span

      class="title-ref">nil</span>. If not specified, the user name and

      password specified by the <span class="title-ref">user</span> and

      <span class="title-ref">password</span> properties will be used to

      resolve that user against the domain in which the system running

      Chef client is joined, or if that system is not joined to a domain

      it will resolve the user as a local account on that system. An

      alternative way to specify the domain is to leave this property

      unspecified and specify the domain as part of the <span

      class="title-ref">user</span> property.'
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
resources_common_properties: true
resources_common_notification: true
resources_common_guards: true
common_resource_functionality_multiple_packages: false
resources_common_guard_interpreter: true
remote_directory_recursive_directories: false
common_resource_functionality_resources_common_windows_security: false
handler_custom: false
cookbook_file_specificity: false
unit_file_verification: false
examples_list:
- example_heading: Use a named provider to run a script
  text_blocks:
  - shortcode: resource_script_bash_provider_and_interpreter.md
- example_heading: Run a script
  text_blocks:
  - code_block: "script 'install_something' do\n  interpreter 'bash'\n  user 'root'\n\
      \  cwd '/tmp'\n  code <<-EOH\n  wget http://www.example.com/tarball.tar.gz\n\
      \  tar -zxf tarball.tar.gz\n  cd tarball\n  ./configure\n  make\n  make install\n\
      \  EOH\nend"
  - markdown: 'or something like:'
  - code_block: "bash 'openvpn-server-key' do\n  environment('KEY_CN' => 'server')\n\
      \  code <<-EOF\n    openssl req -batch -days #{node['openvpn']['key']['expire']}\
      \ \\\n      -nodes -new -newkey rsa:#{key_size} -keyout #{key_dir}/server.key\
      \ \\\n      -out #{key_dir}/server.csr -extensions server \\\n      -config\
      \ #{key_dir}/openssl.cnf\n  EOF\n  not_if { File.exist?('#{key_dir}/server.crt')\
      \ }\nend"
  - markdown: 'where `code` contains the OpenSSL command to be run. The `not_if`

      property tells Chef Infra Client not to run the command if the file

      already exists.'
- example_heading: Install a file from a remote location using bash
  text_blocks:
  - shortcode: resource_remote_file_install_with_bash.md
- example_heading: Install an application from git using bash
  text_blocks:
  - shortcode: resource_scm_use_bash_and_ruby_build.md
- example_heading: Store certain settings
  text_blocks:
  - shortcode: resource_remote_file_store_certain_settings.md
- example_heading: Run a command as an alternate user
  text_blocks:
  - markdown: '*Note*: When Chef is running as a service, this feature requires that

      the user that Chef runs as has ''SeAssignPrimaryTokenPrivilege'' (aka

      ''SE_ASSIGNPRIMARYTOKEN_NAME'') user right. By default only LocalSystem

      and NetworkService have this right when running as a service. This is

      necessary even if the user is an Administrator.


      This right can be added and checked in a recipe using this example:'
  - code_block: '# Add ''SeAssignPrimaryTokenPrivilege'' for the user

      Chef::ReservedNames::Win32::Security.add_account_right(''<user>'', ''SeAssignPrimaryTokenPrivilege'')


      # Check if the user has ''SeAssignPrimaryTokenPrivilege'' rights

      Chef::ReservedNames::Win32::Security.get_account_right(''<user>'').include?(''SeAssignPrimaryTokenPrivilege'')'
  - markdown: 'The following example shows how to run `mkdir test_dir` from a Chef

      Infra Client run as an alternate user.'
  - code_block: "# Passing only username and password\nscript 'mkdir test_dir' do\n\
      \ interpreter \"bash\"\n code  \"mkdir test_dir\"\n cwd Chef::Config[:file_cache_path]\n\
      \ user \"username\"\n password \"password\"\nend\n\n# Passing username and domain\n\
      script 'mkdir test_dir' do\n interpreter \"bash\"\n code  \"mkdir test_dir\"\
      \n cwd Chef::Config[:file_cache_path]\n domain \"domain-name\"\n user \"username\"\
      \n password \"password\"\nend\n\n# Passing username = 'domain-name\\\\username'.\
      \ No domain is passed\nscript 'mkdir test_dir' do\n interpreter \"bash\"\n code\
      \  \"mkdir test_dir\"\n cwd Chef::Config[:file_cache_path]\n user \"domain-name\\\
      \\username\"\n password \"password\"\nend\n\n# Passing username = 'username@domain-name'.\
      \ No domain is passed\nscript 'mkdir test_dir' do\n interpreter \"bash\"\n code\
      \  \"mkdir test_dir\"\n cwd Chef::Config[:file_cache_path]\n user \"username@domain-name\"\
      \n password \"password\"\nend"

---
