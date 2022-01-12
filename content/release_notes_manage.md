+++
title = "Chef Manage Release Notes"
draft = false

aliases = ["/release_notes_manage.html"]
product = []
release_notes = "manage"
layout = "release_notes"
toc_layout = "release_notes_toc"

[menu]
  [menu.release_notes]
    title = "Chef Manage"
    identifier = "release_notes/release_notes_manage.md Chef Manage"
    parent = "release_notes"
    weight = 70
+++

Chef Manage provides a web-based user interface that manages Chef Infra nodes and other policy objects, such as data bags and roles, on the instance of Chef Infra Server that it is installed on.

Chef Manage is [deprecated](/versions/#deprecated) and users should plan to migrate to [Chef Automate](/automate/) as the replacement.

## Upgrading

Download the latest version of the chef-manage package for your platform from [Chef Downloads](https://www.chef.io/downloads/tools/manage) to your Chef Infra Server, then run:

```bash
# rpm -Uvh /path/to/chef-manage-*.rpm
or
# dpkg -i /path/to/chef-manage-*.deb

then
# chef-manage-ctl reconfigure
# chef-server-ctl reconfigure
```
