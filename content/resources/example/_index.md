---
######## Page Data ########
title: example resource
resource: example
draft: false

# redirect from old sphinx url
aliases: /example.html

menu:
  docs:
    title: example resource
    identifier: chef_infra/cookbook_reference/resources/example.html example 
    parent: chef_infra/cookbook_reference/resources
    weight: 15


######## Basic Resource Data ########

resource_description: Id velit magna veniam cillum.
resource_note: Non tempor commodo Lorem fugiat reprehenderit aliqua ad dolore magna veniam laboris adipisicing. Duis sit sit cillum aute deserunt commodo qui enim ullamco. Incididunt aliqua ad non culpa excepteur exercitation labore excepteur aliquip sunt nulla. Fugiat ea nulla et magna do reprehenderit id ad fugiat anim. Excepteur ad voluptate adipisicing dolor occaecat irure amet sint. Duis ex mollit aliqua ut. In consectetur voluptate ipsum est.
resource_new_in: x.y 


######## Handler Types ########
handler_types: true


######## Package Resource ########
package_resource: true


######## Syntax ########

## Resource Block: For example, under Syntax in batch_resource
resource_block_description: 'A batch resource block executes a batch script using the cmd.exe interpreter:'

resource_block_codeblock: |
  batch 'echo some env vars' do
  code <<-EOH
    echo %TEMP%
    echo %SYSTEMDRIVE%
    echo %PATH%
    echo %WINDIR%
    EOH
  end
  
resource_block_list:
    /etc/apache2: 'specifies the directory'
    source: "specifies a directory in the current cookbook (use the ``cookbook`` property to specify a file that is in a different cookbook)"
    owner: "defines the permissions"
    group: "defines the permissions"
    mode: "defines the permissions"

syntax_codeblock: |
  batch 'name' do
    architecture               Symbol
    code                       String
    command                    String, Array
    creates                    String
    cwd                        String
    flags                      String
    group                      String, Integer
    guard_interpreter          Symbol
    interpreter                String
    returns                    Integer, Array
    timeout                    Integer, Float
    user                       String
    password                   String
    domain                     String
    action                     Symbol # defaults to :run if not specified
  end
  
syntax_property_list: 
    - example
    - name 
    - action
    - default_release 
    - options 
    - overwrite_config_files
    - package_name
    - response_file
    - response_file_variables
    - source
    - timeout
    - version


##Activates the Registry Key Path Separators and Recipe DSL Methods in registry_key resource
registry_key: true


######## Nameless ########

##Activates the Nameless section in apt_update resource
nameless: true


######## Gem Package Options ########

## Activates Gem Package Options in gem_package resource
resource_package_options: true


########Actions ########

actions_list:
  ':install': Default. Install a package. If a version is specified, install the specified version of the package.
  ':lock': Locks the apt package to a specific version.
  ':nothing': This resource block does not act unless notified by another resource to take action. Once notified, this resource block either runs immediately or is queued up to run at the end of a Chef Infra Client run.


########Properties ########

properties_list:
  - property: 'default_release'
    ruby_type: 'String '
    default_value:
    description: 'The default release. For example: stable.'
    new_in:

  - property: 'overwrite_config_files'
    ruby_type: 'true, false'
    default_value: 'false'
    description: 'Overwrite existing configuration files with those supplied by the package, if prompted by APT.'
    new_in: 14 

## Multiple Packages in Properties section from, for example, dnf_package resource
properties_multiple_packages: true

## Recursive Directories from remote_directory resource and directory resource
resource_directory_recursive_directories: true

## Atomic File Updates in the Properties Section of, for example, cookbook_file resource
resources_common_atomic_update: true 

## Windows File Security in the Properties section of, for example, cookbook_file resource
properties_resources_common_windows_security: true 

## Prevent Re-downloads from remote_file resource
remote_file_prevent_re_downloads: true 

## Access a remote UNC path on Windows from remote_file resource
remote_file_unc_path: true 

## ps_credential Helper from dsc_script resource
ps_credential_helper: true


######## Chef::Log Entries ########

##Chef::Log Entries from log resource
ruby_style_basics_chef_log: true


######## Debug Recipes with chef-shell ########

## Debug Recipes with chef-shell from breakpoint resource 
debug_recipes_chef_shell: true


######## Using Templates ########

## Using Templates in template resource
template_requirements: true


########Common Resource Functionality ########

## Common Properties in, for example, apt_package resource 
resources_common_properties: true

## Notifications in, for example, apt_package resource 
resources_common_notification: true

## Guards in, for example, apt_package resource  
resources_common_guards: true

## Multiple Packages in, for example, apt_package resource   
common_resource_functionality_multiple_packages: true

## Guard Interpreters in, for example, common resource
resources_common_guard_interpreter: true

## Recursive Directories in, for example,  remote_directory resource
remote_directory_recursive_directories: true

## Windows File Security under Common Resource Functionality in, for example, remote_directory resource
common_resource_functionality_resources_common_windows_security: true 


########Custom Handlers ########

## Custom Handlers in chef_handler resource
handler_custom: true 


########File Specificity ########

## File Specificity in cookbook_file resource
cookbook_file_specificity: true 


########Examples ########
examples_list:
  - example:
    heading: 'Install a package using package manager'
    description: 
    codeblock: | 
      apt_package 'name of package' do
          action :install
      end

  - example:
    heading: 'Install without using recommend packages as a dependency'
    description:
    codeblock: | 
      package 'apache2' do
        options '--no-install-recommends'
      end


---