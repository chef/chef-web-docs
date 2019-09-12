The following example shows how to specify custom configuration data
using the `configuration_name` property. For example, the following
Windows PowerShell script defines the `vi` configuration:

``` powershell
Configuration 'emacs'
  {
    Environment 'TextEditor'
    {
      Name = 'EDITOR'
      Value = 'c:\emacs\bin\emacs.exe'
    }
}

Configuration 'vi'
{
    Environment 'TextEditor'
    {
      Name = 'EDITOR'
      Value = 'c:\vim\bin\vim.exe'
    }
}
```

Use the following recipe to specify that configuration:

``` ruby
dsc_script 'EDITOR' do
  configuration_name 'vi'
  command 'C:\dsc_scripts\editors.ps1'
end
```