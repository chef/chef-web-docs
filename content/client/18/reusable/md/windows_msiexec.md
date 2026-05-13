Msiexec.exe installs Chef Infra Client on a node as part of a bootstrap operation.
The actual command that's run by the default bootstrap script is:

```bash
msiexec /qn /i "%LOCAL_DESTINATION_MSI_PATH%"
```

where:

- `/qn` sets the user interface level to "No UI" (silent installation with no prompts)
- `/i` defines the location where Chef Infra Client is installed
- `"%LOCAL_DESTINATION_MSI_PATH%"` is a variable defined in the default
[windows-chef-client-msi.erb](https://github.com/chef/chef/blob/main/knife/lib/chef/knife/bootstrap/templates/windows-chef-client-msi.erb) bootstrap template.

For more information, see [Microsoft's MSI command line options documentation](https://docs.microsoft.com/en-us/windows/win32/msi/command-line-options).
