+++
title = "Chef Infra DSL: Shelling Out"
draft = false

[menu]
  [menu.docs]
    title = "Shelling Out"
    identifier = "chef_infra/cookbook_reference/recipe_dsl/dsl_recipe.md DSL Overview"
    parent = "chef_infra/cookbook_reference/recipe_dsl"
    weight = 10
+++

[\[edit on GitHub\]](https://github.com/chef/chef-web-docs/blob/master/content/dsl_recipe_shellout.md)

Chef Infra includes several built-in resources for executing commands and scripts on a system such as `execute`, `bash`, and `powershell_script`. There are also several DSL helpers that can be used to execute commands when you need to return a value or would like to work more directly with Ruby.

shell_out
----------

The `shell_out` method can be used to run a command against the node,
and then display the output to the console when the log level is set to
`debug`.

The syntax for the `shell_out` method is as follows:

``` ruby
shell_out(command_to_run, optional_arguments)
```

### arguments

The `shell_out` helper takes a number of optional arguments used to control how the execution occurs:

#### user

The user to execute the command with.

Example:

```ruby
shell_out('which ruby', user: 'www')
```

#### domain

The domain of the user to execute the command with. This must be used in conjunction with the `user` and `password` arguments. **Windows only**

Example:

```ruby
shell_out('which ruby', { user: 'www', domain: 'example.com', password: '123' })
```

#### password

The password of the user to execute the command with. **Windows only**

Example:

```ruby
shell_out('which ruby', { user: 'www', password: '123' })
```

#### elevated

Run the command in an elevated process. **Windows only**

Example:

```ruby
shell_out('which ruby', elevated: true )
```

#### env

Environmental variables to set before shelling out.

Example:

```ruby
shell_out('which ruby', env: { 'PATH' => '/usr/local/bin' })

```

#### cwd

The directory to execute your command from.

Example:

```ruby
shell_out('which ruby', cwd: '/usr/local/bin' )
```

#### timeout

The number of seconds to wait before cancelling the shellout.

Example:

```ruby
shell_out('which ruby', timeout: 1 )
```

#### returns

Specify the return values that are not considered errors.

Example:

```ruby
shell_out('which ruby', returns: [0, 2] )
```

#### sensitive

Don't log the output of the command to prevent logging sensitive data.

```ruby
shell_out('which ruby', sensitive: true )
```

### Mixlib::ShellOut Object

The shell_out helper returns a `Mixlib::ShellOut` object that includes many useful helpers:

#### status

The status of the shellout command.

#### error?

Return a `true` if the command returned a non-0 exit status.

#### error!

Raise an exception if it didn't exit with 0.

```ruby
shell_out('which ruby').error!
```

#### stderr

The stderr output of the command.

#### stdout

The stdout output of the command.

### Examples

Gathering the output of a command:

``` ruby
ruby_path = shell_out('which ruby').stdout
```

shell_out!
-----------

The `shell_out!` method can be used to run a command against the node,
display the output to the console when the log level is set to `debug`,
and then raise an error when the method returns `false`.

The syntax for the `shell_out!` method is as follows:

``` ruby
shell_out!(command_args)
```

where `command_args` is the command that is run against the node. This
method will return `true` or `false`.

powershell_out
--------

The `powershell_out` helper allows running a command in PowerShell and returning the `stdout` and `stderr` of the command. It behaves similarly to the `shell_out` helper used on non-Windows operating systems with the addition of an architecture flag to allow specifying command to run in either :i386 mode or :x86_64 mode.




powershell_out!
--------

The `powershell_out!` helper behaves the same as the `powershell_out` helper except that it raises an exception if the PowerShell command encounters an error during execution.

powershell_exec
--------

The `powershell_exec` helper is used to execute commands on Windows systems that ship with PowerShell 4.0 and later (Windows 2012+). powershell_exec directly communicates with PowerShell using a COM interop instead of spawning processes like the powershell_out helper. This results in much faster execution.

# The powershell_exec mixin provides in-process access to PowerShell engine via
# a COM interop (installed by the Chef Client installer).
#
# powershell_exec returns a Chef::PowerShell object that provides 3 methods:
#
# .result - returns a hash representing the results returned by executing the
#           PowerShell script block
# .errors - this is an array of string containing any messages written to the
#           PowerShell error stream during execution
# .error? - returns true if there were error messages written to the PowerShell
#           error stream during execution
#
# Some examples of usage:
#
# > powershell_exec("(Get-Item c:\\windows\\system32\\w32time.dll).VersionInfo"
#   ).result["FileVersion"]
#  => "10.0.14393.0 (rs1_release.160715-1616)"
#
# > powershell_exec("(get-process ruby).Mainmodule").result["FileName"]
#  => C:\\opscode\\chef\\embedded\\bin\\ruby.exe"
#
# > powershell_exec("$a = $true; $a").result
#  => true
#
# > powershell_exec("not-found").errors
#  => ["ObjectNotFound: (not-found:String) [], CommandNotFoundException: The
#  term 'not-found' is not recognized as the name of a cmdlet, function, script
#  file, or operable program. Check the spelling of the name, or if a path was
#  included, verify that the path is correct and try again. (at <ScriptBlock>,
#   <No file>: line 1)"]
#
# > powershell_exec("not-found").error?
#  => true
#
# > powershell_exec("get-item c:\\notfound -erroraction stop")
# WIN32OLERuntimeError: (in OLE method `ExecuteScript': )
#     OLE error code:80131501 in System.Management.Automation
#       The running command stopped because the preference variable
#       "ErrorActionPreference" or common parameter is set to Stop: Cannot find
#       path 'C:\notfound' because it does not exist.
#
# *Why use this and not powershell_out?* Startup time to invoke the PowerShell
# engine is much faster (over 7X faster in tests) than writing the PowerShell
# to disk, shelling out to powershell.exe and retrieving the .stdout or .stderr
# methods afterwards.  Additionally we are able to have a higher fidelity
# conversation with PowerShell because we are now working with the objects that
# are returned by the script, rather than having to parse the stdout of
# powershell.exe to get a result.
#
# *How does this work?*  In .NET terms, when you run a PowerShell script block
# through the engine, behind the scenes you get a Collection<PSObject> returned
# and simply we are serializing this, adding any errors that were generated to
# a custom JSON string transferred in memory to Ruby.  The easiest way to
# develop for this approach is to imagine that the last thing that happens in
# your PowerShell script block is "ConvertTo-Json".  That's exactly what we are
# doing here behind the scenes.
#
# There are a handful of current limitations with this approach:
# - Windows UAC elevation is controlled by the token assigned to the account
#   that Ruby.exe is running under.
# - Terminating errors will result in a WIN32OLERuntimeError and typically are
#   handled as an exception.
# - There are no return/error codes, as we are not shelling out to
#   powershell.exe but calling a method inline, no errors codes are returned.
# - There is no settable timeout on powershell_exec method execution.
# - It is not possible to impersonate another user running powershell, the
#   credentials of the user running Chef Client are used.
#