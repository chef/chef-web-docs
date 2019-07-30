+++
title = "knife serve"
description = "DESCRIPTION"
draft = false

aliases = "/knife_serve.html"

[menu]
  [menu.docs]
    title = "knife serve"
    identifier = "knife serve/knife_serve.html"
    parent = "chefdk/knife"
    weight = 240
+++    

[\[edit on
GitHub\]](https://github.com/chef/chef-web-docs/blob/master/chef_master/source/knife_serve.rst)

{{% knife_serve_summary %}}

Syntax
======

This subcommand has the following syntax:

``` bash
$ knife serve (options)
```

Options
=======

<div class="note" markdown="1">

<div class="admonition-title" markdown="1">

Note

</div>

{{% knife_common_see_common_options_link %}}

</div>

This subcommand has the following options:

`--chef-repo-path PATH`

:   The path to the chef-repo. Default value: same as `chef_repo_path`
    in the client.rb file.

`--chef-zero-host IP`

:   Override the host on which chef-zero listens. Default value:
    `127.0.0.1`.

`--chef-zero-port PORT`

:   The port on which chef-zero listens. The default behavior will bind
    to the first available port between `8889` and `9999`.

`--repo-mode MODE`

:   Use to specify the local chef-repo layout. Possible values: `static`
    (for environments, roles, data bags, and cookbooks), `everything`
    (same as static, plus nodes, clients, and users),
    `hosted_everything` (for ACLs, groups). Default value:
    `everything/hosted_everything`.

Examples
========

None.
