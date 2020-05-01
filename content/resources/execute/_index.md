---
title: execute resource
resource: execute
draft: false
aliases:
- /resource_execute.html
menu:
  infra:
    title: execute
    identifier: chef_infra/cookbook_reference/resources/execute execute
    parent: chef_infra/cookbook_reference/resources

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
examples: "
  Run a command upon notification\n\n  ``` ruby\n  execute 'slapadd'\
  \ do\n    command 'slapadd < /tmp/something.ldif'\n    creates '/var/lib/slapd/uid.bdb'\n\
  \    action :nothing\n  end\n\n  template '/tmp/something.ldif' do\n    source 'something.ldif'\n\
  \    notifies :run, 'execute[slapadd]', :immediately\n  end\n  ```\n\n  Run a touch\
  \ file only once while running a command\n\n  ``` ruby\n  execute 'upgrade script'\
  \ do\n    command 'php upgrade-application.php && touch /var/application/.upgraded'\n\
  \    creates '/var/application/.upgraded'\n    action :run\n  end\n  ```\n\n  Run\
  \ a command which requires an environment variable\n\n  ``` ruby\n  execute 'slapadd'\
  \ do\n    command 'slapadd < /tmp/something.ldif'\n    creates '/var/lib/slapd/uid.bdb'\n\
  \    action :run\n    environment ({'HOME' => '/home/myhome'})\n  end\n  ```\n\n\
  \  Delete a repository using yum to scrub the cache\n\n  ``` ruby\n  # the following\
  \ code sample thanks to gaffneyc @ https://gist.github.com/918711\n\n  execute 'clean-yum-cache'\
  \ do\n    command 'yum clean all'\n    action :nothing\n  end\n\n  file '/etc/yum.repos.d/bad.repo'\
  \ do\n    action :delete\n    notifies :run, 'execute[clean-yum-cache]', :immediately\n\
  \    notifies :create, 'ruby_block[reload-internal-yum-cache]', :immediately\n \
  \ end\n  ```\n\n  Install repositories from a file, trigger a command, and force\
  \ the\n  internal cache to reload\n\n  The following example shows how to install\
  \ new Yum repositories from a\n  file, where the installation of the repository\
  \ triggers a creation of\n  the Yum cache that forces the internal cache for Chef\
  \ Infra Client to\n  reload:\n\n  ``` ruby\n  execute 'create-yum-cache' do\n  \
  \ command 'yum -q makecache'\n   action :nothing\n  end\n\n  ruby_block 'reload-internal-yum-cache'\
  \ do\n    block do\n      Chef::Provider::Package::Yum::YumCache.instance.reload\n\
  \    end\n    action :nothing\n  end\n\n  cookbook_file '/etc/yum.repos.d/custom.repo'\
  \ do\n    source 'custom'\n    mode '0755'\n    notifies :run, 'execute[create-yum-cache]',\
  \ :immediately\n    notifies :create, 'ruby_block[reload-internal-yum-cache]', :immediately\n\
  \  end\n  ```\n\n  Prevent restart and reconfigure if configuration is broken\n\n\
  \  Use the `:nothing` action (common to all resources) to prevent the test\n  from\
  \ starting automatically, and then use the `subscribes` notification\n  to run a\
  \ configuration test when a change to the template is detected:\n\n  ``` ruby\n\
  \  execute 'test-nagios-config' do\n    command 'nagios3 --verify-config'\n    action\
  \ :nothing\n    subscribes :run, 'template[/etc/nagios3/configures-nagios.conf]',\
  \ :immediately\n  end\n  ```\n\n  Notify in a specific order\n\n  To notify multiple\
  \ resources, and then have these resources run in a\n  certain order, do something\
  \ like the following:\n\n  ``` ruby\n  execute 'foo' do\n    command '...'\n   \
  \ notifies :create, 'template[baz]', :immediately\n    notifies :install, 'package[bar]',\
  \ :immediately\n    notifies :run, 'execute[final]', :immediately\n  end\n\n  template\
  \ 'baz' do\n    ...\n    notifies :run, 'execute[restart_baz]', :immediately\n \
  \ end\n\n  package 'bar'\n\n  execute 'restart_baz'\n\n  execute 'final' do\n  \
  \  command '...'\n  end\n  ```\n\n  where the sequencing will be in the same order\
  \ as the resources are\n  listed in the recipe: `execute 'foo'`, `template 'baz'`,\n\
  \  `execute [restart_baz]`, `package 'bar'`, and `execute 'final'`.\n\n  Execute\
  \ a command using a template\n\n  The following example shows how to set up IPv4\
  \ packet forwarding using\n  the **execute** resource to run a command named `forward_ipv4`\
  \ that uses\n  a template defined by the **template** resource:\n\n  ``` ruby\n\
  \  execute 'forward_ipv4' do\n    command 'echo > /proc/.../ipv4/ip_forward'\n \
  \   action :nothing\n  end\n\n  template '/etc/file_name.conf' do\n    source 'routing/file_name.conf.erb'\n\
  \    notifies :run, 'execute[forward_ipv4]', :delayed\n  end\n  ```\n\n  where the\
  \ `command` property for the **execute** resource contains the\n  command that is\
  \ to be run and the `source` property for the **template**\n  resource specifies\
  \ which template to use. The `notifies` property for\n  the **template** specifies\
  \ that the `execute[forward_ipv4]` (which is\n  defined by the **execute** resource)\
  \ should be queued up and run at the\n  end of a Chef Infra Client run.\n\n  Add\
  \ a rule to an IP table\n\n  The following example shows how to add a rule named\
  \ `test_rule` to an IP\n  table using the **execute** resource to run a command\
  \ using a template\n  that is defined by the **template** resource:\n\n  ``` ruby\n\
  \  execute 'test_rule' do\n    command 'command_to_run\n      --option value\n \
  \     ...\n      --option value\n      --source #{node[:name_of_node][:ipsec][:local][:subnet]}\n\
  \      -j test_rule'\n    action :nothing\n  end\n\n  template '/etc/file_name.local'\
  \ do\n    source 'routing/file_name.local.erb'\n    notifies :run, 'execute[test_rule]',\
  \ :delayed\n  end\n  ```\n\n  where the `command` property for the **execute** resource\
  \ contains the\n  command that is to be run and the `source` property for the **template**\n\
  \  resource specifies which template to use. The `notifies` property for\n  the\
  \ **template** specifies that the `execute[test_rule]` (which is\n  defined by the\
  \ **execute** resource) should be queued up and run at the\n  end of a Chef Infra\
  \ Client run.\n\n  Stop a service, do stuff, and then restart it\n\n  The following\
  \ example shows how to use the **execute**, **service**, and\n  **mount** resources\
  \ together to ensure that a node running on Amazon EC2\n  is running MySQL. This\
  \ example does the following:\n\n  -   Checks to see if the Amazon EC2 node has\
  \ MySQL\n  -   If the node has MySQL, stops MySQL\n  -   Installs MySQL\n  -   Mounts\
  \ the node\n  -   Restarts MySQL\n\n  <!-- -->\n\n  ``` ruby\n  # the following\
  \ code sample comes from the ``server_ec2``\n  # recipe in the following cookbook:\n\
  \  # https://github.com/chef-cookbooks/mysql\n\n  if (node.attribute?('ec2') &&\
  \ ! FileTest.directory?(node['mysql']['ec2_path']))\n\n    service 'mysql' do\n\
  \      action :stop\n    end\n\n    execute 'install-mysql' do\n      command \"\
  mv #{node['mysql']['data_dir']} #{node['mysql']['ec2_path']}\"\n      not_if do\
  \ FileTest.directory?(node['mysql']['ec2_path']) end\n    end\n\n    [node['mysql']['ec2_path'],\
  \ node['mysql']['data_dir']].each do |dir|\n      directory dir do\n        owner\
  \ 'mysql'\n        group 'mysql'\n      end\n    end\n\n    mount node['mysql']['data_dir']\
  \ do\n      device node['mysql']['ec2_path']\n      fstype 'none'\n      options\
  \ 'bind,rw'\n      action [:mount, :enable]\n    end\n\n    service 'mysql' do\n\
  \      action :start\n    end\n\n  end\n  ```\n\n  where\n\n  -   the two **service**\
  \ resources are used to stop, and then restart the\n      MySQL service\n  -   the\
  \ **execute** resource is used to install MySQL\n  -   the **mount** resource is\
  \ used to mount the node and enable MySQL\n\n  **Use the platform_family? method**\n\
  \n  The following is an example of using the `platform_family?` method in\n  the\
  \ Recipe DSL to create a variable that can be used with other\n  resources in the\
  \ same recipe. In this example, `platform_family?` is\n  being used to ensure that\
  \ a specific binary is used for a specific\n  platform before using the **remote_file**\
  \ resource to download a file\n  from a remote location, and then using the **execute**\
  \ resource to\n  install that file by running a command.\n\n  ``` ruby\n  if platform_family?('rhel')\n\
  \    pip_binary = '/usr/bin/pip'\n  else\n    pip_binary = '/usr/local/bin/pip'\n\
  \  end\n\n  remote_file \"#{Chef::Config[:file_cache_path]}/distribute_setup.py\"\
  \ do\n    source 'http://python-distribute.org/distribute_setup.py'\n    mode '0755'\n\
  \    not_if { File.exist?(pip_binary) }\n  end\n\n  execute 'install-pip' do\n \
  \   cwd Chef::Config[:file_cache_path]\n    command <<-EOF\n      # command for\
  \ installing Python goes here\n      EOF\n    not_if { File.exist?(pip_binary) }\n\
  \  end\n  ```\n\n  where a command for installing Python might look something like:\n\
  \n  ``` ruby\n  #{node['python']['binary']} distribute_setup.py\n  #{::File.dirname(pip_binary)}/easy_install\
  \ pip\n  ```\n\n  Control a service using the execute resource\n\n  <div class=\"\
  admonition-warning\"><p class=\"admonition-warning-title\">Warning</p><div class=\"\
  admonition-warning-text\">\n\n  This is an example of something that should NOT\
  \ be done. Use the\n  **service** resource to control a service, not the **execute**\
  \ resource.\n\n  </div></div>\n\n  Do something like this:\n\n  ``` ruby\n  service\
  \ 'tomcat' do\n    action :start\n  end\n  ```\n\n  and NOT something like this:\n\
  \n  ``` ruby\n  execute 'start-tomcat' do\n    command '/etc/init.d/tomcat6 start'\n\
  \    action :run\n  end\n  ```\n\n  There is no reason to use the **execute** resource\
  \ to control a service\n  because the **service** resource exposes the `start_command`\
  \ property\n  directly, which gives a recipe full control over the command issued\
  \ in a\n  much cleaner, more direct manner.\n\n  Use the search recipe DSL method\
  \ to find users\n\n  The following example shows how to use the `search` method\
  \ in the Recipe\n  DSL to search for users:\n\n  ``` ruby\n  #  the following code\
  \ sample comes from the openvpn cookbook: https://github.com/chef-cookbooks/openvpn\n\
  \n  search(\"users\", \"*:*\") do |u|\n    execute \"generate-openvpn-#{u['id']}\"\
  \ do\n      command \"./pkitool #{u['id']}\"\n      cwd '/etc/openvpn/easy-rsa'\n\
  \      environment(\n        'EASY_RSA' => '/etc/openvpn/easy-rsa',\n        'KEY_CONFIG'\
  \ => '/etc/openvpn/easy-rsa/openssl.cnf',\n        'KEY_DIR' => node['openvpn']['key_dir'],\n\
  \        'CA_EXPIRE' => node['openvpn']['key']['ca_expire'].to_s,\n        'KEY_EXPIRE'\
  \ => node['openvpn']['key']['expire'].to_s,\n        'KEY_SIZE' => node['openvpn']['key']['size'].to_s,\n\
  \        'KEY_COUNTRY' => node['openvpn']['key']['country'],\n        'KEY_PROVINCE'\
  \ => node['openvpn']['key']['province'],\n        'KEY_CITY' => node['openvpn']['key']['city'],\n\
  \        'KEY_ORG' => node['openvpn']['key']['org'],\n        'KEY_EMAIL' => node['openvpn']['key']['email']\n\
  \      )\n      not_if { File.exist?(\"#{node['openvpn']['key_dir']}/#{u['id']}.crt\"\
  ) }\n    end\n\n    %w{ conf ovpn }.each do |ext|\n      template \"#{node['openvpn']['key_dir']}/#{u['id']}.#{ext}\"\
  \ do\n        source 'client.conf.erb'\n        variables :username => u['id']\n\
  \      end\n    end\n\n    execute \"create-openvpn-tar-#{u['id']}\" do\n      cwd\
  \ node['openvpn']['key_dir']\n      command <<-EOH\n        tar zcf #{u['id']}.tar.gz\
  \ \\\n        ca.crt #{u['id']}.crt #{u['id']}.key \\\n        #{u['id']}.conf #{u['id']}.ovpn\
  \ \\\n      EOH\n      not_if { File.exist?(\"#{node['openvpn']['key_dir']}/#{u['id']}.tar.gz\"\
  ) }\n    end\n  end\n  ```\n\n  where\n\n  -   the search will use both of the **execute**\
  \ resources, unless the\n      condition specified by the `not_if` commands are\
  \ met\n  -   the `environments` property in the first **execute** resource is\n\
  \      being used to define values that appear as variables in the OpenVPN\n   \
  \   configuration\n  -   the **template** resource tells Chef Infra Client which\
  \ template to\n      use\n\n  Enable remote login for macOS\n\n  ``` ruby\n  execute\
  \ 'enable ssh' do\n    command '/usr/sbin/systemsetup -setremotelogin on'\n    not_if\
  \ '/usr/sbin/systemsetup -getremotelogin | /usr/bin/grep On'\n    action :run\n\
  \  end\n  ```\n\n  Execute code immediately, based on the template resource\n\n\
  \  By default, notifications are `:delayed`, that is they are queued up as\n  they\
  \ are triggered, and then executed at the very end of a Chef Infra\n  Client run.\
  \ To run an action immediately, use `:immediately`:\n\n  ``` ruby\n  template '/etc/nagios3/configures-nagios.conf'\
  \ do\n    # other parameters\n    notifies :run, 'execute[test-nagios-config]',\
  \ :immediately\n  end\n  ```\n\n  and then Chef Infra Client would immediately run\
  \ the following:\n\n  ``` ruby\n  execute 'test-nagios-config' do\n    command 'nagios3\
  \ --verify-config'\n    action :nothing\n  end\n  ```\n\n  Sourcing a file\n\n \
  \ The **execute** resource cannot be used to source a file (e.g.\n  `command 'source\
  \ filename'`). The following example will fail because\n  `source` is not an executable:\n\
  \n  ``` ruby\n  execute 'foo' do\n    command 'source /tmp/foo.sh'\n  end\n  ```\n\
  \n  Instead, use the **script** resource or one of the **script**-based\n  resources\
  \ (**bash**, **csh**, **perl**, **python**, or **ruby**). For\n  example:\n\n  ```\
  \ ruby\n  bash 'foo' do\n    code 'source /tmp/foo.sh'\n  end\n  ```\n\n  Run a\
  \ Knife command\n\n  ``` ruby\n  execute 'create_user' do\n    command <<-EOM.gsub(/\\\
  s+/, ' ').strip!\n      knife user create #{user}\n        --admin\n        --password\
  \ password\n        --disable-editing\n        --file /home/vagrant/.chef/user.pem\n\
  \        --config /tmp/knife-admin.rb\n      EOM\n  end\n  ```\n\n  Run install\
  \ command into virtual environment\n\n  The following example shows how to install\
  \ a lightweight JavaScript\n  framework into Vagrant:\n\n  ``` ruby\n  execute \"\
  install q and zombiejs\" do\n    cwd \"/home/vagrant\"\n    user \"vagrant\"\n \
  \   environment ({'HOME' => '/home/vagrant', 'USER' => 'vagrant'})\n    command\
  \ \"npm install -g q zombie should mocha coffee-script\"\n    action :run\n  end\n\
  \  ```\n\n  Run a command as a named user\n\n  The following example shows how to\
  \ run `bundle install` from a Chef\n  Infra Client run as a specific user. This\
  \ will put the gem into the path\n  of the user (`vagrant`) instead of the root\
  \ user (under which the Chef\n  Infra Client runs):\n\n  ``` ruby\n  execute '/opt/chefdk/embedded/bin/bundle\
  \ install' do\n    cwd node['chef_workstation']['bundler_path']\n    user node['chef_workstation']['user']\n\
  \    environment ({\n      'HOME' => \"/home/#{node['chef_workstation']['user']}\"\
  ,\n      'USER' => node['chef_workstation']['user']\n    })\n    not_if 'bundle\
  \ check'\n  end\n  ```\n\n  Run a command as an alternate user\n\n  *Note*: When\
  \ Chef is running as a service, this feature requires that\n  the user that Chef\
  \ runs as has 'SeAssignPrimaryTokenPrivilege' (aka\n  'SE_ASSIGNPRIMARYTOKEN_NAME')\
  \ user right. By default only LocalSystem\n  and NetworkService have this right\
  \ when running as a service. This is\n  necessary even if the user is an Administrator.\n\
  \n  This right can be added and checked in a recipe using this example:\n\n  ```\
  \ ruby\n  # Add 'SeAssignPrimaryTokenPrivilege' for the user\n  Chef::ReservedNames::Win32::Security.add_account_right('<user>',\
  \ 'SeAssignPrimaryTokenPrivilege')\n\n  # Check if the user has 'SeAssignPrimaryTokenPrivilege'\
  \ rights\n  Chef::ReservedNames::Win32::Security.get_account_right('<user>').include?('SeAssignPrimaryTokenPrivilege')\n\
  \  ```\n\n  The following example shows how to run `mkdir test_dir` from a Chef\n\
  \  Infra Client run as an alternate user.\n\n  ``` ruby\n  # Passing only username\
  \ and password\n  execute 'mkdir test_dir' do\n   cwd Chef::Config[:file_cache_path]\n\
  \   user \"username\"\n   password \"password\"\n  end\n\n  # Passing username and\
  \ domain\n  execute 'mkdir test_dir' do\n   cwd Chef::Config[:file_cache_path]\n\
  \   domain \"domain-name\"\n   user \"user\"\n   password \"password\"\n  end\n\n\
  \  # Passing username = 'domain-name\\\\username'. No domain is passed\n  execute\
  \ 'mkdir test_dir' do\n   cwd Chef::Config[:file_cache_path]\n   user \"domain-name\\\
  \\username\"\n   password \"password\"\n  end\n\n  # Passing username = 'username@domain-name'.\
  \ No domain is passed\n  execute 'mkdir test_dir' do\n   cwd Chef::Config[:file_cache_path]\n\
  \   user \"username@domain-name\"\n   password \"password\"\n  end\n  ```\n"

---
