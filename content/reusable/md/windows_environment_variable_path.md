On Windows, Chef Infra Client must have two entries added to
the `PATH` environment variable:

- `C:\opscode\chef\bin`
- `C:\opscode\chef\embedded\bin`

This is typically done during the installation of Chef Infra Client
automatically. If these values (for any reason) aren't in the `PATH`
environment variable, Chef Infra Client won't run properly.

![image](/images/includes_windows_environment_variable_path.png)
