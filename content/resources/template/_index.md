---
title: template resource
resource: template
draft: false
aliases:
- /resource_template.html
menu:
  infra:
    title: template
    identifier: chef_infra/cookbook_reference/resources/template template
    parent: chef_infra/cookbook_reference/resources

resource_reference: true
robots: null
resource_description_list:
- shortcode: template.md
- note:
    shortcode: notes_cookbook_template_erubis.md
- markdown: 'Use the **template** resource to manage the contents of a file using
    an

    Embedded Ruby (ERB) template by transferring files from a sub-directory

    of `COOKBOOK_NAME/templates/` to a specified path located on a host that

    is running Chef Infra Client. This resource includes actions and

    properties from the **file** resource. Template files managed by the

    **template** resource follow the same file specificity rules as the

    **remote_file** and **file** resources.'
resource_new_in: null
handler_types: false
syntax_description: "A **template** resource block typically declares the location\
  \ in which a\nfile is to be created, the source template that will be used to create\n\
  the file, and the permissions needed on that file. For example:\n\n``` ruby\ntemplate\
  \ '/etc/motd' do\n  source 'motd.erb'\n  owner 'root'\n  group 'root'\n  mode '0755'\n\
  end\n```"
syntax_code_block: null
syntax_properties_list:
- '`''/etc/motd''` specifies the location in which the file is created'
- '`''motd.erb''` specifies the name of a template that exists in in the `/templates`
  folder of a cookbook'
- '`owner`, `group`, and `mode` define the permissions'
syntax_full_code_block: "template 'name' do\n  atomic_update              true, false\n\
  \  backup                     false, Integer\n  cookbook                   String\n\
  \  force_unlink               true, false\n  group                      String,\
  \ Integer\n  helper(:method)            Method { String } # see Helpers below\n\
  \  helpers(module)            Module # see Helpers below\n  inherits           \
  \        true, false\n  local                      true, false\n  manage_symlink_source\
  \      true, false\n  mode                       String, Integer\n  owner      \
  \                String, Integer\n  path                       String # defaults\
  \ to 'name' if not specified\n  rights                     Hash\n  sensitive   \
  \               true, false\n  source                     String, Array\n  variables\
  \                  Hash\n  verify                     String, Block\n  action  \
  \                   Symbol # defaults to :create if not specified\nend"
syntax_full_properties_list:
- '`template` is the resource'
- '`name` is the name of the resource block, typically the path to the location in
  which a file is created *and also* the name of the file to be managed. For example:
  `/var/www/html/index.html`, where `/var/www/html/` is the fully qualified path to
  the location and `index.html` is the name of the file'
- '`source` is the template file that will be used to create the file on the node,
  for example: `index.html.erb`; the template file is located in the `/templates`
  directory of a cookbook'
- '`action` identifies the steps Chef Infra Client will take to bring the node into
  the desired state'
- '`atomic_update`, `backup`, `cookbook`, `force_unlink`, `group`, `helper`, `helpers`,
  `inherits`, `local`, `manage_symlink_source`, `mode`, `owner`, `path`, `rights`,
  `sensitive`, `source`, `variables`, and `verify` are properties of this resource,
  with the Ruby type shown. See "Properties" section below for more information about
  all of the properties that may be used with this resource.'
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :create:
    markdown: Default. Create a file. If a file already exists (but does not match),
      update that file to match.
  :create_if_missing:
    markdown: Create a file only if the file does not exist. When the file exists,
      nothing happens.
  :delete:
    markdown: Delete a file.
  :nothing:
    shortcode: resources_common_actions_nothing.md
  :touch:
    markdown: Touch a file. This updates the access (atime) and file modification
      (mtime) times for a file. (This action may be used with this resource, but is
      typically only used with the **file** resource.)
properties_list:
- property: atomic_update
  ruby_type: true, false
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Perform atomic file updates on a per-resource basis. Set to `true`

      for atomic file updates. Set to `false` for non-atomic file updates.

      This setting overrides `file_atomic_update`, which is a global

      setting found in the client.rb file.'
- property: backup
  ruby_type: Integer, false
  required: false
  default_value: '5'
  new_in: null
  description_list:
  - markdown: 'The number of backups to be kept in `/var/chef/backup` (for UNIX-

      and Linux-based platforms) or `C:/chef/backup` (for the Microsoft

      Windows platform). Set to `false` to prevent backups from being

      kept.'
- property: cookbook
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The cookbook in which a file is located (if it is not located in the

      current cookbook). The default value is the current cookbook.'
- property: force_unlink
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: 'How Chef Infra Client handles certain situations when the target

      file turns out not to be a file. For example, when a target file is

      actually a symlink. Set to `true` for Chef Infra Client delete the

      non-file target and replace it with the specified file. Set to

      `false` for Chef Infra Client to raise an error.'
- property: group
  ruby_type: Integer, String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'A string or ID that identifies the group owner by group name,

      including fully qualified group names such as `domain\group` or

      `group@domain`. If this value is not specified, existing groups

      remain unchanged and new group assignments use the default `POSIX`

      group (if available).'
- property: helper
  ruby_type: Method
  required: false
  default_value: '{}'
  new_in: null
  description_list:
  - markdown: 'Define a helper method inline. For example:

      `helper(:hello_world) { "hello world" }` or

      `helper(:app) { node["app"] }` or

      `helper(:app_conf) { |setting| node["app"][setting] }`.'
- property: helpers
  ruby_type: Module
  required: false
  default_value: '[]'
  new_in: null
  description_list:
  - markdown: 'Define a helper module inline or in a library. For example, an

      inline module: `helpers do`, which is then followed by a block of

      Ruby code. And for a library module: `helpers(MyHelperModule)`.'
- property: inherits
  ruby_type: true, false
  required: false
  default_value: 'true'
  new_in: null
  description_list:
  - markdown: 'Microsoft Windows only. Whether a file inherits rights from its

      parent directory.'
- property: local
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: 'Load a template from a local path. By default, Chef Infra Client

      loads templates from a cookbook''s `/templates` directory. When this

      property is set to `true`, use the `source` property to specify the

      path to a template on the local node.'
- property: manage_symlink_source
  ruby_type: true, false
  required: false
  default_value: 'true'
  new_in: null
  description_list:
  - markdown: '(with

      warning)


      Change the behavior of the file resource if it is pointed at a

      symlink. When this value is set to `true`, Chef Infra Client will

      manage the symlink''s permissions or will replace the symlink with a

      normal file if the resource has content. When this value is set to

      `false`, Chef will follow the symlink and will manage the

      permissions and content of the symlink''s target file.


      The default behavior is `true` but emits a warning that the default

      value will be changed to `false` in a future version; setting this

      explicitly to `true` or `false` suppresses this warning.'
- property: mode
  ruby_type: Integer, String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'A quoted 3-5 character string that defines the octal mode. For

      example: `''755''`, `''0755''`, or `00755`. If `mode` is not specified

      and if the file already exists, the existing mode on the file is

      used. If `mode` is not specified, the file does not exist, and the

      `:create` action is specified, Chef Infra Client assumes a mask

      value of `''0777''` and then applies the umask for the system on which

      the file is to be created to the `mask` value. For example, if the

      umask on a system is `''022''`, Chef Infra Client uses the default

      value of `''0755''`.


      The behavior is different depending on the platform.


      UNIX- and Linux-based systems: A quoted 3-5 character string that

      defines the octal mode that is passed to chmod. For example:

      `''755''`, `''0755''`, or `00755`. If the value is specified as a quoted

      string, it works exactly as if the `chmod` command was passed. If

      the value is specified as an integer, prepend a zero (`0`) to the

      value to ensure that it is interpreted as an octal number. For

      example, to assign read, write, and execute rights for all users,

      use `''0777''` or `''777''`; for the same rights, plus the sticky bit,

      use `01777` or `''1777''`.


      Microsoft Windows: A quoted 3-5 character string that defines the

      octal mode that is translated into rights for Microsoft Windows

      security. For example: `''755''`, `''0755''`, or `00755`. Values up to

      `''0777''` are allowed (no sticky bits) and mean the same in Microsoft

      Windows as they do in UNIX, where `4` equals `GENERIC_READ`, `2`

      equals `GENERIC_WRITE`, and `1` equals `GENERIC_EXECUTE`. This

      property cannot be used to set `:full_control`. This property has no

      effect if not specified, but when it and `rights` are both

      specified, the effects are cumulative.'
- property: owner
  ruby_type: Integer, String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'A string or ID that identifies the group owner by user name,

      including fully qualified user names such as `domain\user` or

      `user@domain`. If this value is not specified, existing owners

      remain unchanged and new owner assignments use the current user

      (when necessary).'
- property: path
  ruby_type: String
  required: false
  default_value: The resource block's name
  new_in: null
  description_list:
  - markdown: 'The full path to the file, including the file name and its

      extension.


      Microsoft Windows: A path that begins with a forward slash (`/`)

      will point to the root of the current working directory of Chef

      Infra Client process. This path can vary from system to system.

      Therefore, using a path that begins with a forward slash (`/`) is

      not recommended.'
- property: rights
  ruby_type: Integer, String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Microsoft Windows only. The permissions for users and groups in a

      Microsoft Windows environment. For example:

      `rights <permissions>, <principal>, <options>` where `<permissions>`

      specifies the rights granted to the principal, `<principal>` is the

      group or user name, and `<options>` is a Hash with one (or more)

      advanced rights options.'
- property: source
  ruby_type: String, Array
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The location of a template file. By default, Chef Infra Client looks

      for a template file in the `/templates` directory of a cookbook.

      When the `local` property is set to `true`, use to specify the path

      to a template on the local node. This property may also be used to

      distribute specific files to specific platforms. See "File

      Specificity" below for more information. Default value: the `name`

      of the resource block. See "Syntax" section above for more

      information.'
- property: variables
  ruby_type: Hash
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: A Hash of variables that are passed into a Ruby template file.
  - shortcode: template_partials_variables_attribute.md
- property: verify
  ruby_type: String, Block
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: "A block or a string that returns `true` or `false`. A string, when\n\
      `true` is executed as a system command.\n\nA block is arbitrary Ruby defined\
      \ within the resource block by using\nthe `verify` property. When a block is\
      \ `true`, Chef Infra Client\nwill continue to update the file as appropriate.\n\
      \nFor example, this should return `true`:\n\n``` ruby\ntemplate '/tmp/baz' do\n\
      \  verify { 1 == 1 }\nend\n```\n\nThis should return `true`:\n\n``` ruby\ntemplate\
      \ '/etc/nginx.conf' do\n  verify 'nginx -t -c %{path}'\nend\n```"
  - warning:
    - markdown: "For releases of Chef Infra Client prior to 12.5 (chef-client 12.4\n\
        and earlier) the correct syntax is:\n\n``` ruby\ntemplate '/etc/nginx.conf'\
        \ do\n  verify 'nginx -t -c %{file}'\nend\n```\n\nSee GitHub issues <https://github.com/chef/chef/issues/3232>\
        \ and\n<https://github.com/chef/chef/pull/3693> for more information about\n\
        these differences."
  - markdown: "This should return `true`:\n\n``` ruby\ntemplate '/tmp/bar' do\n  verify\
      \ { 1 == 1}\nend\n```\n\nAnd this should return `true`:\n\n``` ruby\ntemplate\
      \ '/tmp/foo' do\n  verify do |path|\n    true\n  end\nend\n```\n\nWhereas, this\
      \ should return `false`:\n\n``` ruby\ntemplate '/tmp/turtle' do\n  verify '/usr/bin/false'\n\
      end\n```\n\nIf a string or a block return `false`, the Chef Infra Client run\n\
      will stop and an error is returned."
properties_shortcode: null
properties_multiple_packages: false
resource_directory_recursive_directories: false
resources_common_atomic_update: true
properties_resources_common_windows_security: true
remote_file_prevent_re_downloads: false
remote_file_unc_path: false
ps_credential_helper: false
ruby_style_basics_chef_log: false
debug_recipes_chef_shell: false
template_requirements: true
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
- example_heading: Configure a file from a template
  text_blocks:
  - code_block: "template '/tmp/config.conf' do\n  source 'config.conf.erb'\nend"
- example_heading: Configure a file from a local template
  text_blocks:
  - code_block: "template '/tmp/config.conf' do\n  local true\n  source '/tmp/config.conf.erb'\n\
      end"
- example_heading: Configure a file using a variable map
  text_blocks:
  - code_block: "template '/tmp/config.conf' do\n  source 'config.conf.erb'\n  variables(\n\
      \    :config_var => node['configs']['config_var']\n  )\nend"
- example_heading: Use the not_if condition
  text_blocks:
  - shortcode: resource_template_add_file_not_if_attribute_has_value.md
  - shortcode: resource_template_add_file_not_if_ruby.md
  - shortcode: resource_template_add_file_not_if_ruby_with_curly_braces.md
  - shortcode: resource_template_add_file_not_if_string.md
- example_heading: Use the only_if condition
  text_blocks:
  - shortcode: resource_template_add_file_only_if_attribute_has_value.md
  - shortcode: resource_template_add_file_only_if_ruby.md
  - shortcode: resource_template_add_file_only_if_string.md
- example_heading: Use a whitespace array (%w)
  text_blocks:
  - markdown: 'The following example shows how to use a Ruby whitespace array to define

      a list of configuration tools, and then use that list of tools within

      the **template** resource to ensure that all of these configuration

      tools are using the same RSA key:'
  - code_block: "%w{openssl.cnf pkitool vars Rakefile}.each do |f|\n  template \"\
      /etc/openvpn/easy-rsa/#{f}\" do\n    source \"#{f}.erb\"\n    owner 'root'\n\
      \    group 'root'\n    mode '0755'\n  end\nend"
- example_heading: Use a relative path
  text_blocks:
  - shortcode: resource_template_use_relative_paths.md
- example_heading: Delay notifications
  text_blocks:
  - shortcode: resource_template_notifies_delay.md
- example_heading: Notify immediately
  text_blocks:
  - shortcode: resource_template_notifies_run_immediately.md
- example_heading: Notify multiple resources
  text_blocks:
  - shortcode: resource_template_notifies_multiple_resources.md
- example_heading: Reload a service
  text_blocks:
  - shortcode: resource_template_notifies_reload_service.md
- example_heading: Restart a service when a template is modified
  text_blocks:
  - shortcode: resource_template_notifies_restart_service_when_template_modified.md
- example_heading: Send notifications to multiple resources
  text_blocks:
  - shortcode: resource_template_notifies_send_notifications_to_multiple_resources.md
- example_heading: Execute a command using a template
  text_blocks:
  - shortcode: resource_execute_command_from_template.md
- example_heading: Set an IP address using variables and a template
  text_blocks:
  - shortcode: resource_template_set_ip_address_with_variables_and_template.md
- example_heading: Add a rule to an IP table
  text_blocks:
  - shortcode: resource_execute_add_rule_to_iptable.md
- example_heading: Apply proxy settings consistently across a Chef organization
  text_blocks:
  - markdown: 'The following example shows how a template can be used to apply

      consistent proxy settings for all nodes of the same type:'
  - code_block: "template \"#{node['matching_node']['dir']}/sites-available/site_proxy.conf\"\
      \ do\n  source 'site_proxy.matching_node.conf.erb'\n  owner 'root'\n  group\
      \ 'root'\n  mode '0755'\n  variables(\n    :ssl_certificate =>    \"#{node['matching_node']['dir']}/shared/certificates/site_proxy.crt\"\
      ,\n    :ssl_key =>            \"#{node['matching_node']['dir']}/shared/certificates/site_proxy.key\"\
      ,\n    :listen_port =>        node['site']['matching_node_proxy']['listen_port'],\n\
      \    :server_name =>        node['site']['matching_node_proxy']['server_name'],\n\
      \    :fqdn =>               node['fqdn'],\n    :server_options =>     node[:site]['matching_node']['server']['options'],\n\
      \    :proxy_options =>      node[:site]['matching_node']['proxy']['options']\n\
      \  )\nend"
  - markdown: 'where `matching_node` represents a type of node (like Nginx) and

      `site_proxy` represents the type of proxy being used for that type of

      node (like Nexus).'
- example_heading: Get template settings from a local file
  text_blocks:
  - markdown: "The **template** resource can be used to render a template based on\n\
      settings contained in a local file on disk or to get the settings from a\ntemplate\
      \ in a cookbook. Most of the time, the settings are retrieved\nfrom a template\
      \ in a cookbook. The following example shows how the\n**template** resource\
      \ can be used to retrieve these settings from a\nlocal file.\n\nThe following\
      \ example is based on a few assumptions:\n\n-   The environment is a Ruby on\
      \ Rails application that needs render a\n    file named `database.yml`\n-  \
      \ Information about the application---the user, their password, the\n    server---is\
      \ stored in a data bag on the Chef server\n-   The application is already deployed\
      \ to the system and that only\n    requirement in this example is to render\
      \ the `database.yml` file\n\nThe application source tree looks something like:\n\
      \n    myapp/\n    -> config/\n       -> database.yml.erb"
  - note: 'There should not be a file named `database.yml` (without the `.erb`), as

      the `database.yml` file is what will be rendered using the **template**

      resource.'
  - markdown: 'The deployment of the app will end up in `/srv`, so the full path to

      this template would be something like

      `/srv/myapp/current/config/database.yml.erb`.


      The content of the template itself may look like this:'
  - code_block: "<%= @rails_env %>:\n   adapter: <%= @adapter %>\n   host: <%= @host\
      \ %>\n   database: <%= @database %>\n   username: <%= @username %>\n   password:\
      \ <%= @password %>\n   encoding: 'utf8'\n   reconnect: true"
  - markdown: 'The recipe will be similar to the following:'
  - code_block: "results = search(:node, \"role:myapp_database_master AND chef_environment:#{node.chef_environment}\"\
      )\ndb_master = results[0]\n\ntemplate '/srv/myapp/shared/database.yml' do\n\
      \  source '/srv/myapp/current/config/database.yml.erb'\n  local true\n  variables(\n\
      \    :rails_env => node.chef_environment,\n    :adapter => db_master['myapp']['db_adapter'],\n\
      \    :host => db_master['fqdn'],\n    :database => \"myapp_#{node.chef_environment}\"\
      ,\n    :username => \"myapp\",\n    :password => \"SUPERSECRET\",\n  )\nend"
  - markdown: "where:\n\n-   the `search` method in the Recipe DSL is used to find\
      \ the first node\n    that is the database master (of which there should only\
      \ be one)\n-   the `:adapter` variable property may also require an attribute\
      \ to\n    have been set on a role, which then determines the correct adapter\n\
      \nThe template will render similar to the following:"
  - code_block: "production:\n  adapter: mysql\n  host: domU-12-31-39-14-F1-C3.compute-1.internal\n\
      \  database: myapp_production\n  username: myapp\n  password: SUPERSECRET\n\
      \  encoding: utf8\n  reconnect: true"
  - markdown: 'This example showed how to use the **template** resource to render
      a

      template based on settings contained in a local file. Some other issues

      that should be considered when using this type of approach include:


      -   Should the `database.yml` file be in a `.gitignore` file?

      -   How do developers run the application locally?

      -   Does this work with chef-solo?'
- example_heading: Pass values from recipe to template
  text_blocks:
  - markdown: 'The following example shows how pass a value to a template using the

      `variables` property in the **template** resource. The template file is

      similar to:'
  - code_block: '[tcpout]

      defaultGroup = splunk_indexers_<%= node[''splunk''][''receiver_port''] %>

      disabled=false


      [tcpout:splunk_indexers_<%= node[''splunk''][''receiver_port''] %>]

      server=<% @splunk_servers.map do |s| -%><%= s[''ipaddress''] %>:<%= s[''splunk''][''receiver_port'']
      %> <% end.join('', '') -%>

      <% @outputs_conf.each_pair do |name, value| -%>

      <%= name %> = <%= value %>

      <% end -%>'
  - markdown: 'The recipe then uses the `variables` attribute to find the values for

      `splunk_servers` and `outputs_conf`, before passing them into the

      template:'
  - code_block: "template \"#{splunk_dir}/etc/system/local/outputs.conf\" do\n  source\
      \ 'outputs.conf.erb'\n  mode '0755'\n  variables :splunk_servers => splunk_servers,\
      \ :outputs_conf => node['splunk']['outputs_conf']\n  notifies :restart, 'service[splunk]'\n\
      end"
  - markdown: 'This example can be found in the `client.rb` recipe and the

      `outputs.conf.erb` template files that are located in the [chef-splunk

      cookbook](https://github.com/chef-cookbooks/chef-splunk/) that is

      maintained by Chef.'

---
