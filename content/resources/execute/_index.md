---
title: execute resource
resource: execute
draft: false
aliases:
- /resource_execute.html
menu:
  infra:
    title: execute
    identifier: chef_infra/cookbooks/resources/execute execute
    parent: chef_infra/cookbooks/resources
    weight: 480
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **execute** resource to execute a single command. Commands that

    are executed with this resource are (by their nature) not idempotent, as

    they are typically unique to the environment in which they are run. Use

    `not_if` and `only_if` to guard this resource for idempotence.'
- note:
    markdown: 'Use the **script** resource to execute a script using a specific

      interpreter (Ruby, Python, Perl, csh, or Bash).'
resource_new_in: null
handler_types: false
syntax_description: "An **execute** resource block typically executes a single command\
  \ that\nis unique to the environment in which a recipe will run. Some\n**execute**\
  \ resource commands are run by themselves, but often they are\nrun in combination\
  \ with other Chef resources. For example, a single\ncommand that is run by itself:\n\
  \n``` ruby\nexecute 'apache_configtest' do\n  command '/usr/sbin/apachectl configtest'\n\
  end\n```"
syntax_code_block: null
syntax_properties_list:
- '`''/usr/sbin/apachectl configtest''` is a command that tests if the

  configuration files for Apache are valid.


  Commands are often run in combination with other Chef resources. The

  following example shows the **template** resource run with the

  **execute** resource to add an entry to a LDAP Directory Interchange

  Format (LDIF) file:


  ``` ruby

  execute ''slapadd'' do command ''slapadd < /tmp/something.ldif'' creates ''/var/lib/slapd/uid.bdb''
  action :nothing

  end


  template ''/tmp/something.ldif'' do source ''something.ldif'' notifies :run, ''execute[slapadd]'',
  :immediately

  end

  ```


  where'
- '`''/tmp/something.ldif''` specifies the location of the file'
- '`''something.ldif''` specifies template file from which `/tmp/something.ldif` is
  created'
- '`''slapadd < /tmp/something.ldif''` is the command that is run'
- '`/var/lib/slapd/uid.bdb` prevents the **execute** resource block from running if
  that file already exists'
syntax_full_code_block: "execute 'name' do\n  command\n  creates          String\n\
  \  cwd              String\n  default_env      true, false # default value: false\n\
  \  domain           String\n  elevated         true, false # default value: false\n\
  \  environment      Hash\n  group            String, Integer\n  live_stream    \
  \  true, false # default value: false\n  password         String\n  returns    \
  \      Integer, Array # default value: 0\n  sensitive        true, false # default\
  \ value: true if the password property is set. False otherwise.\n  timeout     \
  \     Integer, Float\n  umask            String, Integer\n  user             String,\
  \ Integer\n  action           Symbol # defaults to :run if not specified\nend"
syntax_full_properties_list:
- '`execute` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`command`, `creates`, `cwd`, `default_env`, `domain`, `elevated`, `environment`,
  `group`, `live_stream`, `password`, `returns`, `sensitive`, `timeout`, `umask`,
  and `user` are the properties available to this resource.'
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
    markdown: Default. Run a command.
properties_list:
- property: command
  ruby_type: String, Array
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The name of the command to be executed. Default value: the `name` of

      the resource block. See "Syntax" section above for more information.'
  - note:
    - markdown: 'Use the **execute** resource to run a single command. Use multiple

        **execute** resource blocks to run multiple commands.'
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
- property: default_env
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: '14.2'
  description_list:
  - markdown: 'When true this enables ENV magic to add path_sanity to the PATH and

      force the locale to English+UTF-8 for parsing output'
- property: domain
  ruby_type: String
  required: false
  default_value: null
  new_in: '12.21'
  description_list:
  - markdown: 'Windows only: The domain of the user user specified by the user

      property. If not specified, the user name and password specified by

      the user and password properties will be used to resolve that user

      against the domain in which the system running Chef client is

      joined, or if that system is not joined to a domain it will resolve

      the user as a local account on that system. An alternative way to

      specify the domain is to leave this property unspecified and specify

      the domain as part of the user property.'
- property: elevated
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: '13.3'
  description_list:
  - markdown: "Determines whether the script will run with elevated permissions to\n\
      circumvent User Access Control (UAC) interactively blocking the\nprocess. This\
      \ will cause the process to be run under a batch login\ninstead of an interactive\
      \ login. The user running Chef needs the\n\u201CReplace a process level token\u201D\
      \ and \u201CAdjust Memory Quotas for a\nprocess\u201D permissions. The user\
      \ that is running the command needs the\n\u201CLog on as a batch job\u201D permission\
      \ because of this requires a login,\nthe user and password properties are required."
- property: environment
  ruby_type: Hash
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'A Hash of environment variables in the form of

      `({"ENV_VARIABLE" => "VALUE"})`. (These variables must exist for a

      command to be run successfully.)'
- property: group
  ruby_type: String, Integer
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The group name or group ID that must be changed before running a

      command.'
- property: live_stream
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: 'Send the output of the command run by this **execute** resource

      block to Chef Infra Client event stream.'
- property: password
  ruby_type: String
  required: false
  default_value: null
  new_in: '12.21'
  description_list:
  - markdown: 'Windows only: The password of the user specified by the user

      property. This property is mandatory if user is specified on Windows

      and may only be specified if user is specified. The sensitive

      property for this resource will automatically be set to true if

      password is specified.'
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
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The amount of time (in seconds) a command is to wait before timing

      out. Default value: `3600`.'
- property: umask
  ruby_type: String, Integer
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The file mode creation mask, or umask.
- property: user
  ruby_type: String, Integer
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The user name of the user identity with which to launch the new

      process. The user name may optionally be specifed with a domain,

      i.e. domainuser or <user@my.dns.domain.com> via Universal Principal

      Name (UPN)format. It can also be specified without a domain simply

      as user if the domain is instead specified using the domain

      property. On Windows only, if this property is specified, the

      password property must be specified.'
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
- example_heading: Run a command upon notification
  text_blocks:
  - code_block: "execute 'slapadd' do\n  command 'slapadd < /tmp/something.ldif'\n\
      \  creates '/var/lib/slapd/uid.bdb'\n  action :nothing\nend\n\ntemplate '/tmp/something.ldif'\
      \ do\n  source 'something.ldif'\n  notifies :run, 'execute[slapadd]', :immediately\n\
      end"
- example_heading: Run a touch file only once while running a command
  text_blocks:
  - code_block: "execute 'upgrade script' do\n  command 'php upgrade-application.php\
      \ && touch /var/application/.upgraded'\n  creates '/var/application/.upgraded'\n\
      \  action :run\nend"
- example_heading: Run a command which requires an environment variable
  text_blocks:
  - code_block: "execute 'slapadd' do\n  command 'slapadd < /tmp/something.ldif'\n\
      \  creates '/var/lib/slapd/uid.bdb'\n  action :run\n  environment ({'HOME' =>\
      \ '/home/myhome'})\nend"
- example_heading: Delete a repository using yum to scrub the cache
  text_blocks:
  - shortcode: resource_yum_package_delete_repo_use_yum_to_scrub_cache.md
- example_heading: 'Install repositories from a file, trigger a command, and force
    the

    internal cache to reload'
  text_blocks:
  - shortcode: resource_package_install_yum_repo_from_file.md
- example_heading: Prevent restart and reconfigure if configuration is broken
  text_blocks:
  - shortcode: resource_execute_subscribes_prevent_restart_and_reconfigure.md
- example_heading: Notify in a specific order
  text_blocks:
  - shortcode: resource_execute_notifies_specific_order.md
- example_heading: Execute a command using a template
  text_blocks:
  - shortcode: resource_execute_command_from_template.md
- example_heading: Add a rule to an IP table
  text_blocks:
  - shortcode: resource_execute_add_rule_to_iptable.md
- example_heading: Stop a service, do stuff, and then restart it
  text_blocks:
  - shortcode: resource_service_stop_do_stuff_start.md
  - markdown: '**Use the platform_family? method**'
  - shortcode: resource_remote_file_use_platform_family.md
- example_heading: Control a service using the execute resource
  text_blocks:
  - shortcode: resource_execute_control_a_service.md
- example_heading: Use the search recipe DSL method to find users
  text_blocks:
  - shortcode: resource_execute_use_search_dsl_method.md
- example_heading: Enable remote login for macOS
  text_blocks:
  - code_block: "execute 'enable ssh' do\n  command '/usr/sbin/systemsetup -setremotelogin\
      \ on'\n  not_if '/usr/sbin/systemsetup -getremotelogin | /usr/bin/grep On'\n\
      \  action :run\nend"
- example_heading: Execute code immediately, based on the template resource
  text_blocks:
  - shortcode: resource_template_notifies_run_immediately.md
- example_heading: Sourcing a file
  text_blocks:
  - markdown: 'The **execute** resource cannot be used to source a file (e.g.

      `command ''source filename''`). The following example will fail because

      `source` is not an executable:'
  - code_block: "execute 'foo' do\n  command 'source /tmp/foo.sh'\nend"
  - markdown: 'Instead, use the **script** resource or one of the **script**-based

      resources (**bash**, **csh**, **perl**, **python**, or **ruby**). For

      example:'
  - code_block: "bash 'foo' do\n  code 'source /tmp/foo.sh'\nend"
- example_heading: Run a Knife command
  text_blocks:
  - code_block: "execute 'create_user' do\n  command <<-EOM.gsub(/\\s+/, ' ').strip!\n\
      \    knife user create #{user}\n      --admin\n      --password password\n \
      \     --disable-editing\n      --file /home/vagrant/.chef/user.pem\n      --config\
      \ /tmp/knife-admin.rb\n    EOM\nend"
- example_heading: Run install command into virtual environment
  text_blocks:
  - markdown: 'The following example shows how to install a lightweight JavaScript

      framework into Vagrant:'
  - code_block: "execute \"install q and zombiejs\" do\n  cwd \"/home/vagrant\"\n\
      \  user \"vagrant\"\n  environment ({'HOME' => '/home/vagrant', 'USER' => 'vagrant'})\n\
      \  command \"npm install -g q zombie should mocha coffee-script\"\n  action\
      \ :run\nend"
- example_heading: Run a command as a named user
  text_blocks:
  - markdown: 'The following example shows how to run `bundle install` from a Chef

      Infra Client run as a specific user. This will put the gem into the path

      of the user (`vagrant`) instead of the root user (under which the Chef

      Infra Client runs):'
  - code_block: "execute '/opt/chefdk/embedded/bin/bundle install' do\n  cwd node['chef_workstation']['bundler_path']\n\
      \  user node['chef_workstation']['user']\n  environment ({\n    'HOME' => \"\
      /home/#{node['chef_workstation']['user']}\",\n    'USER' => node['chef_workstation']['user']\n\
      \  })\n  not_if 'bundle check'\nend"
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
  - code_block: "# Passing only username and password\nexecute 'mkdir test_dir' do\n\
      \ cwd Chef::Config[:file_cache_path]\n user \"username\"\n password \"password\"\
      \nend\n\n# Passing username and domain\nexecute 'mkdir test_dir' do\n cwd Chef::Config[:file_cache_path]\n\
      \ domain \"domain-name\"\n user \"user\"\n password \"password\"\nend\n\n# Passing\
      \ username = 'domain-name\\\\username'. No domain is passed\nexecute 'mkdir\
      \ test_dir' do\n cwd Chef::Config[:file_cache_path]\n user \"domain-name\\\\\
      username\"\n password \"password\"\nend\n\n# Passing username = 'username@domain-name'.\
      \ No domain is passed\nexecute 'mkdir test_dir' do\n cwd Chef::Config[:file_cache_path]\n\
      \ user \"username@domain-name\"\n password \"password\"\nend"

---
