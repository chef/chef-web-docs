+++
title = "Enroll nodes"

[menu.cloud]
title = "Enroll nodes"
identifier = "chef_cloud/360/get_started/enroll_nodes"
parent = "chef_cloud/360/get_started"
weight = 100
+++

When you enroll a node into a node cohort, Chef 360 Platform installs the Chef skills and skill settings that are defined for all nodes in that cohort.
These skills allow Chef 360 Platform to manage the node, execute Chef Courier jobs, and report back to Chef 360 Platform.

Chef 360 Platform installs the following skills in the default skill assembly:

- **Chef Infra Client interpreter skill**: Executes Chef Infra Client runs.
- **Courier Runner skill**: Interprets and executes Chef Courier jobs.
- **Gohai skill**: Reports node attribute data to Chef 360 Platform.
- **Inspec interpreter skill**: Executes Chef InSpec audits.
- **Node Management agent**: Manages and installs other skills on the node.
- **Restart interpreter skill**: Restarts nodes.
- **Shell interpreter skill**: Executes shell scripts.

For more information, see the [Chef 360 skills](https://docs.chef.io/360/1.3/node_management/skills/) documentation.

## Node enrollment methods

This document demonstrates two different methods of node enrollment:

- cookbook-based enrollment
- single-node enrollment

For more information, see the [node enrollment documentation](https://docs.chef.io/360/1.3/node_management/enroll_nodes/).

{{< note >}}

Chef 360 Platform doesn't support node re-enrollment.

{{< /note >}}

## Role requirements

To enroll nodes, use a profile with the [node-manager role](https://docs.chef.io/360/1.3/administration/system_roles/).

## Before you begin

- Review the [node requirements]({{< relref "/360/saas/system_requirements#node-requirements" >}}).

## Single-node enrollment

Single-node enrollment allows you to enroll nodes directly from the server side. With this method, you specify the connection and configuration details for each node and upload them to Chef 360 Platform. Chef 360 Platform then connects to each node, installs Chef Habitat, Chef Node Management, and any skills or agents associated with the node's cohort.

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

With cookbook-based enrollment, you enroll nodes from the client side by uploading a [cookbook](/cookbooks/) with enrollment settings to Chef Infra Server and then Chef Infra Client enrolls the node with Chef 360 SaaS.

### Enroll nodes with a cookbook

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

   In the [`metadata.rb` file](/config_rb_metadata/) of your wrapper cookbook, add the following dependency to include the `chef-cookbook-enroll` cookbook:

    ```ruby
    depends 'chef360-node-enroll', '~> 1.0.0'
    ```

1. Copy of the Chef 360 SaaS public key and add it to your wrapper cookbook:

    ```plaintext
    -----BEGIN CERTIFICATE-----
    MIIDXzCCAkegAwIBAgILBAAAAAABIVhTCKIwDQYJKoZIhvcNAQELBQAwTDEgMB4
    GA1UECxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbF
    NpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wHhcNMDkwMzE4MTAwMDAwWhcNMjkwM
    zE4MTAwMDAwWjBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzET
    MBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMKR2xvYmFsU2lnbjCCASIwDQY
    JKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMwldpB5BngiFvXAg7aEyiie/QV2Ec
    WtiHL8RgJDx7KKnQRfJMsuS+FggkbhUqsMgUdwbN1k0ev1LKMPgj0MK66X17YUh
    hB5uzsTgHeMCOFJ0mpiLx9e+pZo34knlTifBtc+ycsmWQ1z3rDI6SYOgxXG71uL
    0gRgykmmKPZpO/bLyCiR5Z2KYVc3rHQU3HTgOu5yLy6c+9C7v/U9AOEGM+iCK65
    TpjoWc4zdQQ4gOsC0p6Hpsk+QLjJg6VfLuQSSaGjlOCZgdbKfd/+RFO+uIEn8rU
    AVSNECMWEZXriX7613t2Saer9fwRPvm2L7DWzgVGkWqQPabumDk3F2xmmFghcCA
    wEAAaNCMEAwDgYDVR0PAQH/BAQDAgEGMA8GA1UdEwEB/wQFMAMBAf8wHQYDVR0O
    BBYEFI/wS3+oLkUkrk1Q+mOai97i3Ru8MA0GCSqGSIb3DQEBCwUAA4IBAQBLQNv
    AUKr+yAzv95ZURUm7lgAJQayzE4aGKAczymvmdLm6AC2upArT9fHxD4q/c2dKg8
    dEe3jgr25sbwMpjjM5RcOO5LlXbKr8EpbsU8Yt5CRsuZRj+9xTaGdWPoO4zzUhw
    8lo/s7awlOqzJCK6fBdRoyV3XpYKBovHd7NADdBj+1EbddTKJd+82cEHhXXipa0
    095MJ6RMG3NzdvQXmcIfeg7jLQitChws/zyrVQ4PkX4268NXSb7hLi18YIvDQVE
    TI53O9zJrlAGomecsMx86OyXShkDOOyyGeMlhLxS67ttVb9+E7gUJTb0o2HLO02
    JQZR7rkpeDMdmztcpHWD9f
    -----END CERTIFICATE-----
    ```

    This public key expires on March 18, 2029.

1. Generate an access key and secret key:

    ```bash
    chef-platform-auth-cli user-account self create-token --body '{"expiration": "<EXPIRATION_DATE>", "name": "<TOKEN_NAME>"}' --profile <PROFILE_NAME>
    ```

    Replace:

    - `<EXPIRATION_DATE>` with a date and time in ISO 8601 format (for example, `2027-12-31T11:42:23-05:00`).
    - `<TOKEN_NAME>` with a meaningful token name for easy identification.
    - `<PROFILE_NAME>` with a profile that has the node-manager role assigned to it.

    The response includes an access key and secret key and is similar to the following:

    ```json
    {
      "item": {
        "accessKey": "6QIUKP4WIXD4RVAF0BQ3",
        "expiration": "2027-12-31T11:42:23-05:00",
        "id": "bcba5b7a-fb0b-4a62-b442-7ba7bda5e05a",
        "name": "CI-CD Token",
        "role": {
          "id": "5fcb0235-1e56-4ece-8857-404a5d39a290",
          "name": "tenant-admin"
        },
        "secretKey": "x6aCg1NckQoLsQnere26fmGgD0RiWOrf4RNXBhlg"
      }
    }
    ```

1. Define the `node_management_enroll` resource in your wrapper cookbook's recipe:

    ```ruby
    node_management_enroll 'Enroll Node' do
      chef_platform_url '<CHEF_360_FQDN>'
      enroll_type '<ENROLLMENT_TYPE>'
      api_port '443'
      access_key '<ACCESS_KEY>'
      secret_key '<SECRET_KEY>'
      cohort_id '<COHORT_ID>'
      hab_builder_url '<HABITAT_BUILDER_URL>'
      root_ca <CHEF_360_SAAS_PUBLIC_KEY>
      working_dir_path '<VALID_DIR_PATH>'
      upgrade_skills <UPGRADE_SKILLS>
    end
    ```

    Replace:

    - `<CHEF_360_FQDN>` with the fully qualified domain name (FQDN) for your Chef 360 SaaS deployment.
    - `<ENROLLMENT_TYPE>` with either `full` or `partial` depending on the form of enrollment. Use `full` unless you must `partial`.
    - `<ACCESS_KEY>` with the access key for secure communication with Chef 360 SaaS. This should be stored using an [encrypted Chef data bag](/data_bags/) or [secrets manager](/infra_language/secrets/).
    - `<SECRET_KEY>` with the secret key for secure communication with Chef 360 SaaS. This should be stored using an [encrypted Chef data bag](/data_bags/) or [secrets manager](/infra_language/secrets/).
    - `<COHORT_ID>` with a valid cohort UUID. The cohort defines all skills and settings installed on the node.
    - `<HABITAT_BUILDER_URL>` with the URL of the Chef Habitat Builder used by your organization. Default value: `https://bldr.habitat.sh`
    - `<CHEF_360_SAAS_PUBLIC_KEY>` if TLS is enabled, with the root CA public key. For example, `node['enroll']['root_ca']`.
    - `<VALID_DIR_PATH>` with a temporary working directory where all required builds are downloaded. Specify a valid path based on the OS. Default value: `/tmp`.
    - `<UPGRADE_SKILLS>` with `true` or `false`. If `true`, Chef 360 SaaS checks for the latest skill versions and installs them if found. Default value: `false`.

1. Push the wrapper cookbook or policy to the Chef Infra Server.

    1. If you're using a role, [upload](/workstation/knife_cookbook/#upload) the wrapper cookbook to the Chef Infra Server:

        ```bash
        knife cookbook upload <WRAPPER_COOKBOOK_NAME> --cookbook-path <WRAPPER_COOKBOOK_DIR_PATH>
        ```

    1. If you're using a Policyfile, [create `Policyfile.lock.json` file](/workstation/ctl_chef/#chef-install) and [push](/workstation/ctl_chef/#chef-push) the Policyfile to Chef Infra Server:

        ```bash
        chef install
        chef push <POLICY_GROUP> <POLICYFILE>
        ```

1. Include the wrapper cookbook in your node's run-list by adding it to a role or Policyfile. See the [run-list](/run_lists/) and [role](/roles/#manage-roles) documentation for more information.

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
