+++
title = "Stream Data from Chef Automate"
description = "DESCRIPTION"
draft = false

aliases = "/stream_data_chef_automate.html"

[menu]
  [menu.docs]
    title = "Stream Data"
    identifier = "stream data/stream_data_chef_automate.html"
    parent = "chef automate 1/getting started"
    weight = 80
+++    

[\[edit on
GitHub\]](https://github.com/chef/chef-web-docs/blob/master/chef_master/source/stream_data_chef_automate.rst)

{{% chef_automate_mark %}}

{{% EOL_a1 %}}

Chef Automate exposes an endpoint to stream the data that is visualized
in the UI. Every event is streamed as JSON and can be accessed from a
websocket consumer by doing the following:

1.  Make sure the node visibility capability of Chef Automate has been
    installed and is running.

2.  Connect a websocket consumer to the fully-qualified domain name of
    the Chef Automate server on port 3232.

    ``` none
    ws://10.194.11.67:3232
    ```
