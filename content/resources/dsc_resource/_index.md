---
title: dsc_resource resource
resource: dsc_resource
draft: false
aliases: /resource_dsc_resource.html
menu:
  docs:
    title: dsc_resource
    identifier: chef_infra/cookbook_reference/resources/resource_dsc_resource.md dsc_resource
    parent: chef_infra/cookbook_reference/resources
    weight: 330
resource_reference: true
robots: null
resource_description_list:
- shortcode: resources_common_powershell.md
- shortcode: resources_common_powershell_dsc.md
- markdown: 'The **dsc_resource** resource allows any DSC resource to be used in a

    Chef recipe, as well as any custom resources that have been added to

    your Windows PowerShell environment. Microsoft [frequently adds new

    resources](https://github.com/powershell/DscResources) to the DSC

    resource collection.'
- warning:
    markdown: "Using the **dsc_resource** has the following requirements:\n\n-   Windows\
      \ Management Framework (WMF) 5.0 February Preview (or higher),\n    which includes\
      \ Windows PowerShell 5.0.10018.0 (or higher).\n\n-   The `RefreshMode` configuration\
      \ setting in the Local Configuration\n    Manager must be set to `Disabled`.\n\
      \n    **NOTE:** Starting with the Chef Client 12.6 release, this\n    requirement\
      \ applies only for versions of Windows PowerShell earlier\n    than 5.0.10586.0.\
      \ The latest version of Windows Management Framework\n    (WMF) 5 has relaxed\
      \ the limitation that prevented Chef Infra Client\n    from running in non-disabled\
      \ refresh mode.\n\n-   The **dsc_script** resource may not be used in the same\
      \ run-list\n    with the **dsc_resource**. This is because the **dsc_script**\n\
      \    resource requires that `RefreshMode` in the Local Configuration\n    Manager\
      \ be set to `Push`, whereas the **dsc_resource** resource\n    requires it to\
      \ be set to `Disabled`.\n\n    **NOTE:** Starting with the Chef Client 12.6\
      \ release, this\n    requirement applies only for versions of Windows PowerShell\
      \ earlier\n    than 5.0.10586.0. The latest version of Windows Management Framework\n\
      \    (WMF) 5 has relaxed the limitation that prevented Chef Infra Client\n \
      \   from running in non-disabled refresh mode, which allows the Local\n    Configuration\
      \ Manager to be set to `Push`.\n\n-   The **dsc_resource** resource can only\
      \ use binary- or script-based\n    resources. Composite DSC resources may not\
      \ be used.\n\n    This is because composite resources aren't \"real\" resources\
      \ from the\n    perspective of the Local Configuration Manager (LCM). Composite\n\
      \    resources are used by the \"configuration\" keyword from the\n    `PSDesiredStateConfiguration`\
      \ module, and then evaluated in that\n    context. When using DSC to create\
      \ the configuration document (the\n    Managed Object Framework (MOF) file)\
      \ from the configuration command,\n    the composite resource is evaluated.\
      \ Any individual resources from\n    that composite resource are written into\
      \ the Managed Object\n    Framework (MOF) document. As far as the Local Configuration\
      \ Manager\n    (LCM) is concerned, there is no such thing as a composite resource.\n\
      \    Unless that changes, the **dsc_resource** resource and/or\n    `Invoke-DscResource`\
      \ command cannot directly use them."
resource_new_in: null
handler_types: false
syntax_description: 'A **dsc_resource** resource block allows DSC resources to be
  used in a Chef recipe. For example, the DSC `Archive` resource:  ``` powershell
  Archive ExampleArchive { Ensure = "Present" Path = "C:\Users\Public\Documents\example.zip"
  Destination = "C:\Users\Public\Documents\ExtractionPath" } ```  and then the same
  **dsc_resource** with Chef:'
syntax_code_block: "dsc_resource 'example' do\n   resource :archive\n   property :ensure,\
  \ 'Present'\n   property :path, \"C:\\Users\\Public\\Documents\\example.zip\"\n\
  \   property :destination, \"C:\\Users\\Public\\Documents\\ExtractionPath\"\n end"
syntax_properties_list: null
syntax_full_code_block: "dsc_resource 'name' do\n  module_name                String\n\
  \  module_version             String\n  property                   Symbol\n  reboot_action\
  \              Symbol # default value: :nothing\n  resource                   Symbol\n\
  \  timeout                    Integer\n  action                     Symbol # defaults\
  \ to :run if not specified\nend"
syntax_full_properties_list:
- '`dsc_resource` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`property` is zero (or more) properties in the DSC resource, where each property
  is entered on a separate line, `:dsc_property_name` is the case'
- insensitive name of that property, and `"property_value"` is a Ruby value to be
  applied by Chef Infra Client
- '`module_name`, `module_version`, `property`, `reboot_action`, `resource`, and `timeout`
  are properties of this resource, with the Ruby type shown. See "Properties" section
  below for more information about all of the properties that may be used with this
  resource.'
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :nothing:
    markdown: '> {{% resources_common_actions_nothing %}}'
  :run:
    markdown: Default. Use to run the DSC configuration defined as defined in this
      resource.
properties_list:
- property: module_name
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The name of the module from which a DSC resource originates. If this

      property is not specified, it will be inferred.'
- property: module_version
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The version number of the module to use. PowerShell 5.0.10018.0 (or

      higher) supports having multiple versions of a module installed.

      This should be specified along with the `module_name`.'
- property: property
  ruby_type: Symbol
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'A property from a Desired State Configuration (DSC) resource. Use

      this property multiple times, one for each property in the Desired

      State Configuration (DSC) resource. The format for this property

      must follow `property :dsc_property_name, "property_value"` for each

      DSC property added to the resource block.


      The `:dsc_property_name` must be a symbol.


      Use the following Ruby types to define `property_value`:


      <table>

      <colgroup>

      <col style="width: 50%" />

      <col style="width: 50%" />

      </colgroup>

      <thead>

      <tr class="header">

      <th>Ruby</th>

      <th>Windows PowerShell</th>

      </tr>

      </thead>

      <tbody>

      <tr class="odd">

      <td><code>Array</code></td>

      <td><code>Object[]</code></td>

      </tr>

      <tr class="even">

      <td><code>Chef::Util::Powershell:PSCredential</code></td>

      <td><code>PSCredential</code></td>

      </tr>

      <tr class="odd">

      <td><code>False</code></td>

      <td><code>bool($false)</code></td>

      </tr>

      <tr class="even">

      <td><code>Fixnum</code></td>

      <td><code>Integer</code></td>

      </tr>

      <tr class="odd">

      <td><code>Float</code></td>

      <td><code>Double</code></td>

      </tr>

      <tr class="even">

      <td><code>Hash</code></td>

      <td><code>Hashtable</code></td>

      </tr>

      <tr class="odd">

      <td><code>True</code></td>

      <td><code>bool($true)</code></td>

      </tr>

      </tbody>

      </table>


      These are converted into the corresponding Windows PowerShell type

      during a Chef Infra Client run.'
- property: reboot_action
  ruby_type: Symbol
  required: false
  default_value: :nothing
  new_in: null
  description_list:
  - markdown: 'Use to request an immediate reboot or to queue a reboot using the

      :reboot_now (immediate reboot) or :request_reboot (queued reboot)

      actions built into the reboot resource.'
- property: resource
  ruby_type: Symbol
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The name of the DSC resource. This value is case-insensitive and

      must be a symbol that matches the name of the DSC resource.


      For built-in DSC resources, use the following values:


      <table>

      <colgroup>

      <col style="width: 50%" />

      <col style="width: 50%" />

      </colgroup>

      <thead>

      <tr class="header">

      <th>Value</th>

      <th>Description</th>

      </tr>

      </thead>

      <tbody>

      <tr class="odd">

      <td><code>:archive</code></td>

      <td>Use to <a href="https://msdn.microsoft.com/en-us/powershell/dsc/archiveresource">unpack
      archive (.zip) files</a>.</td>

      </tr>

      <tr class="even">

      <td><code>:environment</code></td>

      <td>Use to <a href="https://msdn.microsoft.com/en-us/powershell/dsc/environmentresource">manage
      system environment variables</a>.</td>

      </tr>

      <tr class="odd">

      <td><code>:file</code></td>

      <td>Use to <a href="https://msdn.microsoft.com/en-us/powershell/dsc/fileresource">manage
      files and directories</a>.</td>

      </tr>

      <tr class="even">

      <td><code>:group</code></td>

      <td>Use to <a href="https://msdn.microsoft.com/en-us/powershell/dsc/groupresource">manage
      local groups</a>.</td>

      </tr>

      <tr class="odd">

      <td><code>:log</code></td>

      <td>Use to <a href="https://msdn.microsoft.com/en-us/powershell/dsc/logresource">log
      configuration messages</a>.</td>

      </tr>

      <tr class="even">

      <td><code>:package</code></td>

      <td>Use to <a href="https://msdn.microsoft.com/en-us/powershell/dsc/packageresource">install
      and manage packages</a>.</td>

      </tr>

      <tr class="odd">

      <td><code>:registry</code></td>

      <td>Use to <a href="https://msdn.microsoft.com/en-us/powershell/dsc/registryresource">manage
      registry keys and registry key values</a>.</td>

      </tr>

      <tr class="even">

      <td><code>:script</code></td>

      <td>Use to <a href="https://msdn.microsoft.com/en-us/powershell/dsc/scriptresource">run
      PowerShell script blocks</a>.</td>

      </tr>

      <tr class="odd">

      <td><code>:service</code></td>

      <td>Use to <a href="https://msdn.microsoft.com/en-us/powershell/dsc/serviceresource">manage
      services</a>.</td>

      </tr>

      <tr class="even">

      <td><code>:user</code></td>

      <td>Use to <a href="https://msdn.microsoft.com/en-us/powershell/dsc/userresource">manage
      local user accounts</a>.</td>

      </tr>

      <tr class="odd">

      <td><code>:windowsfeature</code></td>

      <td>Use to <a href="https://msdn.microsoft.com/en-us/powershell/dsc/windowsfeatureresource">add
      or remove Windows features and roles</a>.</td>

      </tr>

      <tr class="even">

      <td><code>:windowsoptionalfeature</code></td>

      <td>Use to configure Microsoft Windows optional features.</td>

      </tr>

      <tr class="odd">

      <td><code>:windowsprocess</code></td>

      <td>Use to <a href="https://msdn.microsoft.com/en-us/powershell/dsc/windowsprocessresource">configure
      Windows processes</a>.</td>

      </tr>

      </tbody>

      </table>


      Any DSC resource may be used in a Chef recipe. For example, the DSC

      Resource Kit contains resources for [configuring Active Directory

      components](http://www.powershellgallery.com/packages/xActiveDirectory/2.8.0.0),

      such as `xADDomain`, `xADDomainController`, and `xADUser`. Assuming

      that these resources are available to Chef Infra Client, the

      corresponding values for the `resource` attribute would be:

      `:xADDomain`, `:xADDomainController`, and `xADUser`.'
- property: timeout
  ruby_type: Integer
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The amount of time (in seconds) a command is to wait before timing

      out.'
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
directory_recursive_directories: false
common_resource_functionality_resources_common_windows_security: false
handler_custom: false
cookbook_file_specificity: false
unit_file_verification: false
examples_list:
- example_heading: Open a Zip file
  text_blocks:
  - code_block: "dsc_resource 'example' do\n   resource :archive\n   property :ensure,\
      \ 'Present'\n   property :path, 'C:\\Users\\Public\\Documents\\example.zip'\n\
      \   property :destination, 'C:\\Users\\Public\\Documents\\ExtractionPath'\n\
      \ end"
- example_heading: Manage users and groups
  text_blocks:
  - code_block: "dsc_resource 'demogroupadd' do\n  resource :group\n  property :groupname,\
      \ 'demo1'\n  property :ensure, 'present'\nend\n\ndsc_resource 'useradd' do\n\
      \  resource :user\n  property :username, 'Foobar1'\n  property :fullname, 'Foobar1'\n\
      \  property :password, ps_credential('P@assword!')\n  property :ensure, 'present'\n\
      end\n\ndsc_resource 'AddFoobar1ToUsers' do\n  resource :Group\n  property :GroupName,\
      \ 'demo1'\n  property :MembersToInclude, ['Foobar1']\nend"
- example_heading: Create and register a windows service
  text_blocks:
  - markdown: 'The following example creates a windows service, defines it''s execution

      path, and prevents windows from starting the service in case the

      executable is not at the defined location:'
  - code_block: "dsc_resource 'NAME' do\n  resource :service\n  property :name, 'NAME'\n\
      \  property :startuptype, 'Disabled'\n  property :path, 'D:\\\\Sites\\\\Site_name\\\
      file_to_run.exe'\n  property :ensure, 'Present'\n  property :state, 'Stopped'\n\
      end"
- example_heading: Create a test message queue
  text_blocks:
  - markdown: 'The following example creates a file on a node (based on one that is

      located in a cookbook), unpacks the `MessageQueue.zip` Windows

      PowerShell module, and then uses the **dsc_resource** to ensure that

      Message Queuing (MSMQ) sub-features are installed, a test queue is

      created, and that permissions are set on the test queue:'
  - code_block: "cookbook_file 'cMessageQueue.zip' do\n  path \"#{Chef::Config[:file_cache_path]}\\\
      \\MessageQueue.zip\"\n  action :create_if_missing\nend\n\nwindows_zipfile \"\
      #{ENV['PROGRAMW6432']}\\\\WindowsPowerShell\\\\Modules\" do\n  source \"#{Chef::Config[:file_cache_path]}\\\
      \\MessageQueue.zip\"\n  action :unzip\nend\n\ndsc_resource 'install-sub-features'\
      \ do\n  resource :windowsfeature\n  property :ensure, 'Present'\n  property\
      \ :name, 'msmq'\n  property :IncludeAllSubFeature, true\nend\n\ndsc_resource\
      \ 'create-test-queue' do\n  resource :cPrivateMsmqQueue\n  property :ensure,\
      \ 'Present'\n  property :name, 'Test_Queue'\nend\n\ndsc_resource 'set-permissions'\
      \ do\n  resource :cPrivateMsmqQueuePermissions\n  property :ensure, 'Present'\n\
      \  property :name, 'Test_Queue_Permissions'\n  property :QueueNames, 'Test_Queue'\n\
      \  property :ReadUsers, node['msmq']['read_user']\nend"
- example_heading: Example to show usage of module properties
  text_blocks:
  - code_block: "dsc_resource 'test-cluster' do\n  resource :xCluster\n  module_name\
      \ 'xFailOverCluster'\n  module_version '1.6.0.0'\n  property :name, 'TestCluster'\n\
      \  property :staticipaddress, '10.0.0.3'\n  property :domainadministratorcredential,\
      \ ps_credential('abcd')\nend"

---
