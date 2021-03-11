+++
title = "Chef Infra Language: Windows"
draft = false

gh_repo = "chef-web-docs"

[menu]
  [menu.infra]
    title = "Windows"
    identifier = "chef_infra/cookbook_reference/infra_language/windows.md Windows"
    parent = "chef_infra/cookbook_reference/infra_language"
    weight = 39
+++

Chef Infra Client 15.8 and later include Windows-specific helpers for checking platform and package information.

## windows_server_core?

Determine if the current node is Windows Server Core.

## windows_workstation?

Determine if the current node is Windows Workstation.

## windows_server?

Determine if the current node is Windows Server.

## windows_nt_version

Determine the current Windows NT version. The NT version often differs from the marketing version, but offers a good way to find desktop and server releases that are based on the same codebase. For example NT 6.3 corresponds to Windows 8.1 and Windows 2012 R2.

## powershell_version

Determine the installed version of PowerShell.
