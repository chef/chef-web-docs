A **powershell_script** resource block executes a batch script using
the Windows PowerShell interpreter. For example, writing to an
interpolated path:

``` ruby
powershell_script 'write-to-interpolated-path' do
  code <<-EOH
  $stream = [System.IO.StreamWriter] "#{Chef::Config[:file_cache_path]}/powershell-test.txt"
  $stream.WriteLine("In #{Chef::Config[:file_cache_path]}...word.")
  $stream.close()
  EOH
end
```

The full syntax for all of the properties that are available to the
**powershell_script** resource is:

``` ruby
powershell_script 'name' do
  architecture               Symbol
  code                       String
  command                    String, Array
  convert_boolean_return     true, false
  creates                    String
  cwd                        String
  environment                Hash
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
  elevated                   true, false
end
```

where:

-   `powershell_script` is the resource.
-   `name` is the name given to the resource block.
-   `command` is the command to be run and `cwd` is the location from
    which the command is run.
-   `action` identifies which steps Chef Infra Client will take to bring
    the node into the desired state.
-   `architecture`, `code`, `command`, `convert_boolean_return`,
    `creates`, `cwd`, `environment`, `flags`, `group`,
    `guard_interpreter`, `interpreter`, `returns`, `sensitive`,
    `timeout`, `user`, `password`, `domain` and `elevated` are
    properties of this resource, with the Ruby type shown. See
    "Properties" section below for more information about all of the
    properties that may be used with this resource.