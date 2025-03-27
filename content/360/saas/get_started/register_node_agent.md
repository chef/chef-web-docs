+++
title = "Register Node Management agent"

[menu.cloud]
title = "Register Node Management Agent"
identifier = "chef_cloud/360/get_started/Register Node Management Agent"
parent = "chef_cloud/360/get_started"
weight = 50
+++

The Node Management agent manages skills on a node.
You must define settings on the Node Management agent before defining skills and override settings that are installed on nodes.

## Prerequisites

- [CLIs are installed and registered]({{< relref "../get_started/install_cli" >}}).

## Register the Node Management agent

To register the Node Management agent, follow these steps:

1. Create a file named `register-agent-skill.json` that defines the Node Management agent settings:

    ```json
    {
    "bldrUrl": "<HABITAT_BUILDER_URL>",
    "bldrChannel": "<CHANNEL>",
    "bldrAuthToken": "<TOKEN>",
    "nodeCheckinInterval": <CHECK_IN_INTERVAL>,
    "updateSkillMetadataInterval": <UPDATE_SKILL_INTERVAL>,
    "logLevel": "<LOG_LEVEL>"
    }
    ```

    Replace:

    - `<HABITAT_BUILDER_URL>` with the Chef Habitat Builder URL. Use `https://bldr.habitat.sh` for Chef's Habitat Builder or the URL of your own Habitat Builder deployment.
    - `<CHANNEL>` with the release channel from which to install skills. For example, `stable`.
    - `<TOKEN>` with the authentication token for Habitat Builder. If you're using Chef's Habitat Builder, set this to an empty string.
    - `<CHECK_IN_INTERVAL>` with the interval (in seconds) at which check-in occurs. Value starting from `3600` (1 hour).
    - `<UPDATE_SKILL_INTERVAL>` with the interval (in seconds) at which skill definitions are updated. Value starting from `3600` (1 hour).
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

1. Create the skill assembly:

    ```sh
    chef-node-management-cli management skill update-agent --body-file register-agent-skill.json
    ```

    It returns the following response:

    ```json
    {
     "code" : 200,
     "message" : update-agent successful
    }
    ```

## Next step

- [Create skill definitions]({{< relref "define_skills.md" >}}).
