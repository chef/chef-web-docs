On Windows, running Chef Infra Client without elevated privileges (when they're required) fails silently.
It will appear that Chef Infra Client completed its run successfully, but the changes won't have been made.
To run Chef Infra Client as the administrator, do one of the following:

1. Log in to the administrator account. This isn't the same as an account in the administrator's security group.

1. Run the Chef Infra Client process from the administrator account while logged into another account.
  Run the following command:

    ```bash
    runas /user:Administrator "cmd /C chef-client"
    ```

    Enter the administrator account password when prompted.

1. Open a command prompt by right-clicking the command prompt application and selecting **Run as administrator**.
  After the command window opens, run Chef Infra Client as the administrator.
