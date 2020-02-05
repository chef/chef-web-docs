+++
title = "About Files"
draft = false

aliases = "/files.html"

[menu]
  [menu.docs]
    title = "Files"
    identifier = "chef_infra/cookbook_reference/files.md Files"
    parent = "chef_infra/cookbook_reference"
    weight = 30
+++    

[\[edit on GitHub\]](https://github.com/chef/chef-web-docs/blob/master/content/files.md)

Files are managed using the following resources:

-   Use the [cookbook_file](/resource_cookbook_file/) resource to
    manage files that are added to nodes based on files that are located
    in the `/files` directory in a cookbook.
-   Use the [file](/resource_file/) resource to manage files
    directly on a node.
-   Use the [remote_file](/resource_remote_file/) resource to
    transfer files to nodes from remote locations.
-   Use the [template](/resource_template/) resource to manage files
    that are added to nodes based on files that are located in the
    `/templates` directory in a cookbook.
