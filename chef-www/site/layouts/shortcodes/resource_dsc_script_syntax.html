A **dsc_script** resource block embeds the code that defines a DSC
configuration directly within a Chef recipe:

``` ruby
dsc_script 'get-dsc-resource-kit' do
  code <<-EOH
    Archive reskit
    {
      ensure = 'Present'
      path = "#{Chef::Config[:file_cache_path]}\\DSCResourceKit620082014.zip"
      destination = "#{ENV['PROGRAMW6432']}\\WindowsPowerShell\\Modules"
    }
  EOH
end
```

where the **remote_file** resource is first used to download the
`DSCResourceKit620082014.zip` file.

The full syntax for all of the properties that are available to the
**dsc_script** resource is:

``` ruby
dsc_script 'name' do
  code                       String
  command                    String
  configuration_data         String
  configuration_data_script  String
  configuration_name         String
  cwd                        String
  environment                Hash
  flags                      Hash
  imports                    Array
  timeout                    Integer
  action                     Symbol # defaults to :run if not specified
end
```

where:

-   `dsc_script` is the resource.
-   `name` is the name given to the resource block.
-   `action` identifies which steps Chef Infra Client will take to bring
    the node into the desired state.
-   `code`, `command`, `configuration_data`,
    `configuration_data_script`, `configuration_name`, `cwd`,
    `environment`, `flags`, `imports`, and `timeout` are properties of
    this resource, with the Ruby type shown. See "Properties" section
    below for more information about all of the properties that may be
    used with this resource.