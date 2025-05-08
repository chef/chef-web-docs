+++
title = "Node management settings"

[menu.cloud]
title = "Node management settings"
identifier = "chef_cloud/360/get_started/node settings"
parent = "chef_cloud/360/get_started"
weight = 50
+++

When you first deploy Chef 360 Platform or you create a new organization with the default skill assembly and default node management settings,
Chef 360 Platform adds the default node cohort to your organization with those default settings.

## Cohort

The default node cohort is called `sample-node-cohort`.
All nodes enrolled in this cohort get the default Node Management agent settings, skill assembly, and skill override settings that are described on this page.

To get a list of cohorts in an organization, use the following command:

```sh
chef-node-management-cli management cohort find-all-cohorts --profile <NODE_MANAGER_PROFILE_NAME>
```

## Node Management agent

The Node Management agent is a special skill that manages the node and installs and manages the skills defined in the skill assembly.

{{< readfile file="/360/saas/reusable_text/md/node_management_agent_default_settings.md" >}}

### Optional: Modify Node Management agent settings

You can modify the Node Management agent settings.
For example, you can configure it to fetch skills from your own deployment of Habitat Builder.

{{< accordion-list data-allow-all-closed="true" >}}
{{< accordion-item accordion-title="Optional: Modify Node Management agent settings" >}}

If you want to modify the Node Management agent settings, follow these steps:

1. Create a JSON file with the following settings:

    ```json
    {
      "settings": [
        {
          "name": "authToken",
          "value": ""
        },
        {
          "name": "bldrUrl",
          "value": "<HABITAT_BUILDER_URL>"
        },
        {
          "name": "bldrChannel",
          "value": "<CHANNEL>"
        },
        {
          "name": "logLevel",
          "value": "<LOG_LEVEL>"
        },
        {
          "name": "nodeCheckinInterval",
          "value": "<CHECK_IN_INTERVAL>"
        },
        {
          "name": "updateSkillMetadataInterval",
          "value": "<UPDATE_SKILL_INTERVAL>"
        }
      ],
      "skillName": "node-management-agent"
    }
    ```

   Replace:

   - `<HABITAT_BUILDER_URL>` with the Chef Habitat Builder URL. Use `https://bldr.habitat.sh` for Chef's Habitat Builder or the URL of your own Habitat Builder deployment.
   - `<CHANNEL>` with the release channel from which to install skills. For example, `stable`.
   - `<CHECK_IN_INTERVAL>` with the interval (in seconds) at which check-in occurs. Values start at `3600` (1 hour).

     The check-in interval splay is automatically set to a value between zero and half the check-in interval time.

   - `<UPDATE_SKILL_INTERVAL>` with the interval (in seconds) at which skill definitions are updated. Values start at `3600` (1 hour).

     The update skill interval splay is automatically set to a value between zero and half the check-in interval time.

   - `<LOG_LEVEL>`: The logging level of the agent. For example, `debug`.

     Supported log levels:

     `debug`
     : Reports detailed information that can aid in identifying issues or debugging a workload. This includes the info, warn, and error logs.

     `info`
     : Reports general information about the system's operations.

     `warn`
     : Reports potential failures, but the operation can continue functioning for the time being.

     `error`
     : Reports errors that prevent the execution of an operation.

1. Get the override settings ID with the `find-all-settings` command:

    ```sh
    chef-node-management-cli management setting find-all-settings --profile <PROFILE_NAME>
    ```

1. Update the Node Management agent settings with the `update-skillSettings` command:

    ```sh
    chef-node-management-cli management setting update-skillSettings \
      --skillName node-management-agent \
      --body-file <PATH_TO_JSON_FILE> \
      --settingId <SETTINGS_ID> \
      --profile <PROFILE_NAME>
    ```

{{< /accordion-item>}}
{{< /accordion-list >}}

## Skill assembly

A skill assembly defines the skills and skill versions installed on all nodes in a cohort.

{{< readfile file="/360/saas/reusable_text/md/skill_assembly_default.md" >}}

`sample-skill-assembly` includes the latest versions of all skills:

{{< accordion-list data-allow-all-closed="true" >}}
{{< accordion-item accordion-title="Default skill assembly" >}}
{{% readfile file="_vendor/github.com/chef/samples/cohorts/skill-assembly.json" highlight="json" %}}
{{< /accordion-item>}}
{{< /accordion-list >}}

## Skill override settings

Each skill has global default settings that define how the skill works and apply to all nodes unless overridden by the override settings.
Override settings override global default settings and apply to all nodes enrolled in a cohort.

By default, Chef 360 Platform adds the following override settings for the Courier Runner and Gohai skills to the `sample-node-cohort` cohort:

{{< accordion-list data-allow-all-closed="true" >}}
{{< accordion-item accordion-title="Default override settings" >}}
{{% readfile file="_vendor/github.com/chef/samples/cohorts/node-override-setting.json" highlight="json" %}}
{{< /accordion-item>}}
{{< /accordion-list >}}

## More information

- [Node Management agent](https://docs.chef.io/360/1.3/node_management/skills/node_agent/)
- [Chef skills](https://docs.chef.io/360/1.3/node_management/skills/)
- [Skill assembly](https://docs.chef.io/360/1.3/node_management/skills/skill_assembly/)
- [Skill override settings](https://docs.chef.io/360/1.3/node_management/skills/override_settings/)
- [Managing node cohorts](https://docs.chef.io/360/1.3/node_management/node_cohort/)

## Next step

- [Enroll nodes with Chef 360 Platform]({{< relref "enroll_nodes" >}})
