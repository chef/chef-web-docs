+++
title = "Troubleshooting"
draft = false


[menu]
  [menu.workstation_26_1]
    title = "Troubleshooting"
    identifier = "workstation_26_1/troubleshooting.md Troubleshooting"
    weight = 50
+++

## Chef Workstation logs

Chef Workstation logs are stored in `~/.chef-workstation/logs`.

## Trusted certs

On Windows, restart Chef Workstation PowerShell after adding certificates to the `trusted_certs` directory.
After you add a certificate with `knife ssl fetch`, certificate-related commands such as `knife ssl check` may not return the expected results. If this happens:

1. Exit Chef Workstation PowerShell.
1. Select the Chef Workstation PowerShell icon to reopen it.
1. Retry the command.
