+++
title = "Enroll nodes"

[menu.cloud]
title = "Enroll nodes"
identifier = "chef_cloud/360/get_started/enroll_nodes"
parent = "chef_cloud/360/get_started"
weight = 100
+++

Node enrollment brings nodes under management by Chef 360 SaaS.

This document demonstrates two different methods of node enrollment:

- cookbook-based enrollment
- single-node enrollment

{{< note >}}

This version of Chef 360 SaaS doesn't support node re-enrollment.

{{< /note >}}

## Prerequisites

- [A node cohort has been created]({{< relref "node_cohort" >}}).

## Requirements

Review the [node requirements]({{< relref "system_requirements#node-requirements" >}}) before enrolling nodes.

## Single-node enrollment

Single-node enrollment enrolls nodes from the server side.
With this method, you define connection and configuration details and push them up to Chef 360 SaaS, which connects to each node and installs Chef Habitat, Chef Node Management, and any skills or agents assigned to a node cohort.

### Enroll Linux nodes

To enroll a Linux node, follow these steps:

1. Create a JSON file that defines the node connection settings:

   {{% readfile file="content/360/saas/reusable_text/json/enroll-node-linux-rsa.json" highlight="json" %}}

   {{< note >}}

   Format SSH keys in a JSON payload as a single-line string.
   To add a multiline key, replace new lines with the newline character `\n`.

   Use the following command to replace new lines in a PEM file:

   ```sh
   awk 'NF {sub(/\r/, ""); printf "%s\\n",$0;}' <PEM_FILENAME>
   ```

   {{< /note >}}

   Replace the following:

   - `<COHORT_ID>` with the ID of the cohort that the node will be enrolled with.
   - `<NODE_DNS_OR_PUBLIC_IP>` with a public domain name or IP address.
   - `<SSH_USERNAME>` with the SSH username to authenticate with the node.
   - `<SSH_KEY>` with the SSH key used to authenticate with the node.
   - `<SSH_PORT>` with the SSH port. Default is `22`.

   {{< note >}}

   You can also authenticate with an SSH password instead of an RSA key. To do so, replace `key` with `password` in the SSH connection settings file. For example, `"password": "<PASSWORD_STRING>"`.

   {{< /note >}}

1. Enroll the node using the `enrollment enroll-node` command:

    ```sh
    chef-node-management-cli enrollment enroll-node --body-file <JSON_WINDOWS_SETTINGS_FILE> --profile <NODE_MANAGER_PROFILE_NAME>
    ```

    The response is similar to the following:

    ```json
    {
        "item": {
            "id": "36c570b1-798a-4530-ada5-2661dfeb3fac",
            "nodeId": "e4b1b524-4e77-4448-b1a9-01b80288c898"
        }
    }
    ```

### Enroll Windows nodes

To enroll a Windows node, follow these steps:

1. Create a JSON file that defines the node connection settings:

   {{% readfile file="content/360/saas/reusable_text/json/enroll-node-windows.json" highlight="json" %}}

    Replace the following:

    - `<COHORT_ID>` with the ID of the cohort that the node will be enrolled with.
    - `<NODE_DNS_OR_PUBLIC_IP>` with the node's public domain name or IP address.
    - `<WINDOWS_USERNAME>` with the Windows username to authenticate with the node.
    - `<WINDOWS_PASSWORD>` with the Windows password used to authenticate with the node.

1. Enroll the node using the `enrollment enroll-node` command:

    ```sh
    chef-node-management-cli enrollment enroll-node --body-file <JSON_WINDOWS_SETTINGS_FILE> --profile <NODE_MANAGER_PROFILE_NAME>
    ```

    The response is similar to the following:

    ```json
    {
        "item": {
            "id": "36c570b1-798a-4530-ada5-2661dfeb3fac",
            "nodeId": "e4b1b524-4e77-4448-b1a9-01b80288c898"
        }
    }
    ```

## Cookbook-based enrollment

With cookbook-based enrollment, you enroll nodes from the client side by uploading a [cookbook](https://docs.chef.io/cookbooks/) with enrollment settings to Chef Infra Server and then Chef Infra Client enrolls the node with Chef 360 SaaS.

### Enroll nodes

The `chef-cookbook-enroll` cookbook uses the `node_management_enroll` custom resource and a [wrapper cookbook](https://www.chef.io/blog/writing-wrapper-cookbooks) to define enrollment settings.

To configure the cookbooks and define enrollment settings, follow these steps:

1. Download the [`chef360-node-enroll` cookbook](https://supermarket.chef.io/cookbooks/chef360-node-enroll).

1. Upload the `chef360-node-enroll` cookbook, which includes the `node_management_enroll` resource, to your Chef Infra Server:

    ```bash
    knife cookbook upload chef360-node-enroll --cookbook-path <COOKBOOK_DIR_PATH>
    ```

    Replace `COOKBOOK_DIR_PATH` with the path to your cookbook directory.

1. Create a wrapper cookbook and add the `chef360-node-enroll` cookbook as a dependency:

    ```sh
    chef generate cookbook <COOKBOOK_NAME>
    ```

   In the [`metadata.rb` file](https://docs.chef.io/config_rb_metadata/) of your wrapper cookbook, add the following dependency to include the `chef-cookbook-enroll` cookbook:

    ```ruby
    depends 'chef360-node-enroll', '~> 1.0.0'
    ```

1. Define the `node_management_enroll` resource in your wrapper cookbook's recipe:

    ```ruby
    node_management_enroll 'Enroll Node' do
      chef_platform_url '<CHEF_360_FQDN>'
      enroll_type '<ENROLLMENT_TYPE>'
      api_port '<API_PORT>'
      access_key '<ACCESS_KEY>'
      secret_key '<SECRET_KEY>'
      cohort_id '<COHORT_ID>'
      hab_builder_url '<HABITAT_BUILDER_URL>'
      working_dir_path '<VALID_DIR_PATH>'
      upgrade_skills <UPGRADE_SKILLS>
    end
    ```

    Replace:

    - `<CHEF_360_FQDN>` with the fully qualified domain name (FQDN) for your Chef 360 SaaS deployment.
    - `<ENROLLMENT_TYPE>` with either `full` or `partial` depending on the form of enrollment. Use `full` unless you must `partial`.
    - `<API_PORT>` with the API port configured in Chef 360 SaaS. The default value is `31000`.
    - `<ACCESS_KEY>` with an access key for secure communication with Chef 360 SaaS. Store securely using an [encrypted Chef data bag](https://docs.chef.io/data_bags/) or a [secrets manager](https://docs.chef.io/infra_language/secrets/).
    - `<SECRET_KEY>` with a secret key for secure communication with Chef 360 SaaS. Store securely using an [encrypted Chef data bag](https://docs.chef.io/data_bags/) or a [secrets manager](https://docs.chef.io/infra_language/secrets/).
    - `<COHORT_ID>` with a valid cohort UUID. The cohort defines all skills and settings installed on the node.
    - `<HABITAT_BUILDER_URL>` with the URL of the Chef Habitat Builder used by your organization. Default value: `https://bldr.habitat.sh`
    - `<VALID_DIR_PATH>` with a temporary working directory where all required builds are downloaded. Specify a valid path based on the OS. Default value: `/tmp`.
    - `<UPGRADE_SKILLS>` with `true` or `false`. If `true`, Chef 360 SaaS checks for the latest skill versions and installs them if found. Default value: `false`.

1. Push the wrapper cookbook or policy to the Chef Infra Server.

    1. If you're using a role, [upload](https://docs.chef.io/workstation/knife_cookbook/#upload) the wrapper cookbook to the Chef Infra Server:

        ```bash
        knife cookbook upload <WRAPPER_COOKBOOK_NAME> --cookbook-path <WRAPPER_COOKBOOK_DIR_PATH>
        ```

    1. If you're using a Policyfile, [create `Policyfile.lock.json` file](https://docs.chef.io/workstation/ctl_chef/#chef-install) and [push](https://docs.chef.io/workstation/ctl_chef/#chef-push) the Policyfile to Chef Infra Server:

        ```bash
        chef install
        chef push <POLICY_GROUP> <POLICYFILE>
        ```

1. Include the wrapper cookbook in your node's run-list by adding it to a role or Policyfile. See the [run-list](https://docs.chef.io/run_lists/) and [role](https://docs.chef.io/roles/#manage-roles) documentation for more information.

   The next time Chef Infra Client runs, it executes the `node_management_enroll` resource and the node is enrolled with Chef 360 SaaS.

## Check the node enrollment status

{{< readfile file="content/360/saas/reusable_text/md/node_enrollment_status_node_id.md" >}}

## Verify that the skills are installed

- Verify that the skills are installed:

  ```sh
  chef-node-management-cli management node find-one-node --nodeId <NODE_ID> --profile <NODE_MANAGER_PROFILE_NAME>
  ```

  The response includes a list of the installed skills.

## Next step

- [Create a Courier job]({{< relref "jobs.md" >}}).
