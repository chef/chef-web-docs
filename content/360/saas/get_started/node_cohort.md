+++
title = "Create a node cohort"

[menu.cloud]
title = "Create a node cohort"
identifier = "chef_cloud/360/get_started/cohort"
parent = "chef_cloud/360/get_started"
weight = 90
+++

{{< readfile file="content/360/saas/reusable_text/md/node_cohort_overview.md" >}}

## Prerequisites

- [Override settings are defined]({{< relref "override_settings" >}}).

## Create a node cohort

To create a node cohort, follow these steps:

1. Create a file named `node-cohort.json` that contains the skill assembly ID and the settings ID it should be associated to.

    ```json
    {
      "name": "node-cohort-mchef",
      "description": "Description first cohort",
      "settingId": "5b305ea5-c89b-4ac3-a471-60dadf4980ed",
      "skillAssemblyId":"4ecbe415-838a-4446-abc1-9c57de9211d8"
    }
    ```

1. Create the node cohort:

    ```sh
    chef-node-management-cli management cohort create-cohort --body-file node-cohort.json --profile <NODE_MANAGER_PROFILE_NAME>
    ```

    ```json
    {
    "item": {
        "cohortId": "86628101-0f31-48aa-b035-a8889232e568"
      }
    }
    ```

    The above command returns a response containing the `cohortId`. Save it for using during Node Enrollment.

## Troubleshooting

- Verify that the node cohort was created successfully:

  ```sh
  chef-node-management-cli management cohort find-one-cohort --cohortId <COHORT_ID> --profile <NODE_MANAGER_PROFILE_NAME>
  ```

## Next step

- [Enroll Nodes]({{< relref "enroll_nodes.md" >}}).
