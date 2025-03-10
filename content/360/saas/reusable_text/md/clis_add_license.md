
Before you can use the Chef 360 Platform CLIs, you must add your license to your workstation.

- To add a license, use the `license-management license load-license` command and your license key:

  ```sh
  chef-platform-auth-cli license-management license load-license --body '{"licenseId":"<LICENSE_ID>"}' --profile tenant-admin
  ```

  Replace `<LICENSE_ID>` with the license key you received in your email.

  After adding your license, `chef-platform-auth-cli` returns a success message.
