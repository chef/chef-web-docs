<!-- cspell:ignore Schtasks -->

To run Chef Infra Client at periodic intervals (so that it can check in with Chef Infra Server automatically), configure Chef Infra Client to run as a scheduled task.
You can do this using the MSI by selecting the **Chef Unattended Execution Options** > **Chef Infra Client Scheduled Task** option on the **Custom Setup** page.
Alternatively, you can create a Windows scheduled task with Schtasks after you install Chef Infra Client.

For example:

```powershell
SCHTASKS.EXE /CREATE /TN ChefClientSchTask /SC MINUTE /MO 30 /F /RU "System" /RP /RL HIGHEST /TR "cmd /c \"C:\opscode\chef\embedded\bin\ruby.exe C:\opscode\chef\bin\chef-client -L C:\chef\chef-client.log -c C:\chef\client.rb\""
```

For more information, see [Microsoft's Schtasks.exe documentation](https://docs.microsoft.com/en-us/windows/win32/taskschd/schtasks).

After you configure Chef Infra Client to run as a scheduled task, the default log file path is `c:\chef\chef-client.log`.
