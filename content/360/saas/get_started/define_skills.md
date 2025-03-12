+++
title = "Define skills"

[menu.cloud]
title = "Define skills"
identifier = "chef_cloud/360/get_started/skills"
parent = "chef_cloud/360/get_started"
weight = 60
+++

This document describes how to define the set of required skills on a node or set of nodes.

A skill is an agent that gives you the ability to perform actions on a node to achieve an outcome.

## Prerequisites

- [Node Management agent is registered]({{< relref "register_node_agent" >}}).
- The Chef Infra Client interpreter requires Chef Infra Client installed on each node.
- The Chef InSpec interpreter requires Chef InSpec installed on each node.

## Create skill definitions

The following Chef 360 skills are required or recommended for managing nodes, running actions, and returning action results:

- Courier Runner skill
- Gohai skill
- Shell interpreter skill
- Restart interpreter skill
- Chef Client interpreter skill

### Courier Runner

The Courier Runner skill interprets the Courier Job definitions sent to it by the Courier Dispatcher and executes them on the node.

1. Create a JSON file called `courier-runner-skill.json` containing the following skill definition for Courier Runner:

   {{% readfile file="_vendor/github.com/chef/samples/skills/courier-runner-skill.json" highlight="json" %}}

   {{< note >}} If the skill is registered as a service, then the `name` and `canister.name` fields must be identical. {{< /note >}}

1. Create the skill:

    ```sh
    chef-node-management-cli management skill create-skill --body-file courier-runner-skill.json --profile <NODE_MANAGER_PROFILE_NAME>
    ```

### Gohai

The Gohai skill collects attributes about a node in addition to attributes collected by the Node Management agent.

1. Create a file named `gohai-skill.json` containing the skill definition for gohai.

   {{% readfile file="_vendor/github.com/chef/samples/skills/gohai-skill.json" highlight="json" %}}

   {{< note >}} If the skill is registered as a service, then the `name` and `canister.name` fields must be identical. {{< /note >}}

1. Create the skill:

    ```sh
    chef-node-management-cli management skill create-skill --body-file gohai-skill.json --profile <NODE_MANAGER_PROFILE_NAME>
    ```

### Shell interpreter

The Shell interpreter skill executes OS commands in a Courier Job.

1. Create a file named `shell-interpreter-skill.json` containing the skill definition:

   {{% readfile file="_vendor/github.com/chef/samples/skills/shell-interpreter-skill.json" highlight="json" %}}

1. Create the skill:

    ```sh
    chef-node-management-cli management skill create-skill --body-file shell-interpreter-skill.json --profile <NODE_MANAGER_PROFILE_NAME>
    ```

### Restart interpreter

If your jobs will reboot a node, then you need the Restart interpreter skill.

1. Create a file named `restart-interpreter-skill.json` containing the skill definition.

   {{% readfile file="_vendor/github.com/chef/samples/skills/restart-interpreter-skill.json" highlight="json" %}}

1. Create the skill:

    ```sh
    chef-node-management-cli management skill create-skill --body-file restart-interpreter-skill.json --profile <NODE_MANAGER_PROFILE_NAME>
    ```

### Chef Infra Client interpreter

If your Courier jobs will invoke Infra Client runs, then you need the Chef Infra Client interpreter skill.

1. Create a file named `chef-client-interpreter-skill.json` and add the following the skill definition.

   {{% readfile file="_vendor/github.com/chef/samples/skills/chef-client-interpreter.json" highlight="json" %}}

1. Create the skill:

    ```sh
    chef-node-management-cli management skill create-skill --body-file chef-client-interpreter-skill.json --profile <NODE_MANAGER_PROFILE_NAME>
    ```

### Chef InSpec interpreter

If your Courier jobs will invoke Chef InSpec scans, then you need the Chef InSpec interpreter skill.

1. Create a file named `inspec-interpreter-skill.json` and add the following skill definition.

   {{% readfile file="_vendor/github.com/chef/samples/skills/inspec-interpreter-skill.json" highlight="json" %}}

1. Create the skill:

    ```sh
    chef-node-management-cli management skill create-skill --body-file inspec-interpreter-skill.json --profile <NODE_MANAGER_PROFILE_NAME>
    ```

## Verify skills

- Get a list of all the defined skills using the `find-all-skills` subcommand:

  ```sh
  chef-node-management-cli management skill find-all-skills --profile <NODE_MANAGER_PROFILE_NAME>
  ```

  It returns an output listing the defined skills.

## Next step

- [Create a skill assembly]({{< relref "create_skill_assembly.md" >}}) that adds or removes skills from nodes.
