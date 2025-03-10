+++
title = "Create override settings"

[menu.cloud]
title = "Create override settings"
identifier = "chef_cloud/360/get_started/override settings"
parent = "chef_cloud/360/get_started"
weight = 80
+++

When you created the Courier Runner skill definition in the previous section,
it contained a base64-encoded TOML string in the value of `content` key. This TOML includes settings that can or should be overridden with settings for your Chef 360 SaaS system.
When Node Management runs on a node, it executes Courier Runner using values in the TOML file that are set by values stored in the Courier Runner's default settings or the Courier Runner's override settings.

## Prerequisites

- [A skill assembly is defined]({{< relref "create_skill_assembly" >}}).

## Create override settings

Create node override settings for the Courier Runner and Gohai skills.

1. Create a file named `node-override-setting.json` and paste in the following JSON:

   {{% readfile file="_vendor/github.com/chef/samples/cohorts/node-override-setting.json" highlight="json" %}}

   This JSON file creates settings for Courier Runner.

1. Use the `create-setting` subcommand to create the override setting:

    ```sh
    chef-node-management-cli management setting create-setting --body-file node-override-setting.json --profile <NODE_MANAGER_PROFILE_NAME>
    ```

    which returns:

    ```json
    {
        "item": {
            "settingId": "<SETTING_ID>"
        ｝
    }
    ```

    Save the setting ID, you'll use it to create a node cohort.

1. Verify that the setting was created.

    ```sh
    chef-node-management-cli management setting find-one-setting --settingId <SETTING_ID> --profile <NODE_MANAGER_PROFILE_NAME>
    ```

## Next step

- [Create a node cohort]({{< relref "node_cohort.md" >}})
