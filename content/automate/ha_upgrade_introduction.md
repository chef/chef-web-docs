+++
title = "Upgrade Chef Automate HA"

draft = false

[menu]
  [menu.automate]
    title = "Upgrade"
    parent = "automate/deploy_high_availability"
    identifier = "automate/deploy_high_availability/ha_upgrade_introduction.md Upgrade HA"
    weight = 70
+++

To upgrade Chef Automate HA, follow these steps:

1. Download the latest CLI:

    ```bash
    curl https://packages.chef.io/files/current/latest/chef-automate-cli/chef-automate_linux_amd64.zip | gunzip - > chef-automate && chmod +x chef-automate | cp -f chef-automate /usr/bin/chef-automate
    ```

1. Download the airgap bundle.

    To download the latest bundle, run:

    ```bash
    curl https://packages.chef.io/airgap_bundle/current/automate/latest.aib -o latest.aib
    ```

    To download a specific version, run:

    ```bash
    curl https://packages.chef.io/airgap_bundle/current/automate/<version>.aib -o automate-<version>.aib
    ```

    {{< note >}}
    Chef Automate bundles are available for 365 days from the release of a version. However, the milestone release bundles are available for download forever.
    {{< /note >}}

1. Run the appropriate upgrade command.

   To upgrade only frontend services (Chef Automate and Chef Infra Server), run:

    ```bash
    chef-automate upgrade run --airgap-bundle latest.aib --upgrade-frontends
    ```

   To upgrade only backend services (PostgreSQL and OpenSearch), run:

    ```bash
    chef-automate upgrade run --airgap-bundle latest.aib --upgrade-backends
    ```

   To upgrade the full Chef Automate HA system from the bastion host, run:

    ```bash
    chef-automate upgrade run --airgap-bundle latest.aib
    ```

    {{< note >}}

    - Backend upgrades restart backend services, so the cluster might take some time to return to a healthy state.
    - Perform backend upgrades during a maintenance window.
    - The upgrade command currently supports only minor upgrades.
    - We recommend always performing a chef-automate backup before initiating any upgrade.
    {{< /note >}}

1. Optional: To skip the confirmation prompt during upgrade, add the `--auto-approve` flag.

    ```bash
    chef-automate upgrade run --airgap-bundle latest.aib --auto-approve
    chef-automate upgrade run --airgap-bundle latest.aib --upgrade-backends --auto-approve
    chef-automate upgrade run --airgap-bundle latest.aib --upgrade-frontends --auto-approve
    ```

The upgrade command also checks for a newer version of the bastion workspace.
If a newer version is available, the command prompts you to confirm the workspace upgrade before it upgrades the frontend or backend nodes.

To avoid that prompt, set the `--workspace-upgrade` flag explicitly:

```bash
chef-automate upgrade run --airgap-bundle latest.aib --auto-approve --workspace-upgrade yes
chef-automate upgrade run --airgap-bundle latest.aib --auto-approve --workspace-upgrade no
```

{{< note >}}

AMI upgrade applies only to AWS deployments.
For on-premises deployments, you manage the infrastructure resources yourself.

{{< /note >}}

## AMI upgrade setup for AWS deployment

{{< note >}}

In the following section, the existing cluster with the older AMI images is called the **primary cluster**.
The cluster with the upgraded AMI is called the **new cluster**.

{{< /note >}}

{{< note >}}

The AWS deployment must use S3.
Both the primary cluster and the new cluster must be configured to use the same S3 bucket.

{{< /note >}}

### Set up the AMI-upgraded cluster

1. Deploy the new cluster in the same region or a different region with S3 backup configured.
   To learn more, see [AWS Deployment steps](/automate/ha_aws_deploy_steps/#deployment).

1. Configure backup only if you didn't provide the backup settings during deployment.
   To learn more, see the [S3 configuration](/automate/ha_backup_restore_aws_s3/#configuration-in-provision-host) section.

1. On the primary cluster, create a backup from the bastion host:

    ```sh
    chef-automate backup create --no-progress > /var/log/automate-backups.log
    ```

1. On one of the Automate nodes in the primary cluster, create a bootstrap bundle.
   The bootstrap bundle captures local credentials and secrets that aren't persisted in the database:

    ```sh
    chef-automate bootstrap bundle create bootstrap.abb
    ```

1. Copy `bootstrap.abb` to all Automate and Chef Infra Server frontend nodes in the new cluster.

1. On all frontend nodes in the new cluster, unpack `bootstrap.abb`:

    ```sh
    sudo chef-automate bootstrap bundle unpack bootstrap.abb
    ```

1. On the bastion host for the new cluster, get the backup ID:

    ```sh
    chef-automate backup list
    ```

1. Verify that all services in the new cluster are running:

    ```sh
    chef-automate status
    ```

1. Prepare the restore configuration for the new cluster.

   For Chef-managed OpenSearch, save the current configuration:

    ```bash
    sudo chef-automate config show > current_config.toml
    ```

   Add the following configuration to `current_config.toml` without modification, and copy `current_config.toml` to the bastion host:

    ```bash
    [global.v1.external.opensearch.auth.basic_auth]
        username = "admin"
        password = "admin"
    ```

1. From the bastion host, restore the primary cluster backup to the new cluster:

    ```sh
    sudo chef-automate backup restore s3://<s3-bucket-name>/<path-to-backup>/<backup-id>/ --patch-config /path/to/current_config.toml --airgap-bundle /path/to/airgap-bundle --skip-preflight --s3-access-key "Access_Key" --s3-secret-key "Secret_Key"
    ```

1. If you want to reuse the existing custom domain, update your DNS record to point to the load balancer for the new cluster.

1. After the restore completes successfully, destroy the primary cluster.
