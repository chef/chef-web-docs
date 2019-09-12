If a DSC script contains configuration data that takes parameters, those
parameters may be passed using the `flags` property. For example, the
following Windows PowerShell script takes parameters for the
`EditorChoice` and `EditorFlags` settings:

``` powershell
$choices = @{'emacs' = 'c:\emacs\bin\emacs';'vi' = 'c:\vim\vim.exe';'powershell' = 'powershell_ise.exe'}
  Configuration 'DefaultEditor'
    {
      [CmdletBinding()]
      param
        (
          $EditorChoice,
          $EditorFlags = ''
        )
      Environment 'TextEditor'
      {
        Name = 'EDITOR'
        Value =  "$($choices[$EditorChoice]) $EditorFlags"
      }
    }
```

Use the following recipe to set those parameters:

``` ruby
dsc_script 'DefaultEditor' do
  flags ({ :EditorChoice => 'emacs', :EditorFlags => '--maximized' })
  command 'c:\dsc_scripts\editors.ps1'
end
```