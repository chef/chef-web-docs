+++
title = "Migrate from AWS OpsWorks to Chef SaaS"
draft = false
[menu]
  [menu.saas]
    title = " AWS OpsWorks Migration"
    identifier = "chef_infra/OpsWorks Migration"
    parent = "chef_saas"
    weight = 30
+++

This guide describes the migration scenarios from AWS OpsWorks to Chef SaaS.

## Prerequisites

The following prerequisites must be in place before migrating from AWS OpsWorks to Chef SaaS:

- AWS OpsWorks must be running Chef Automate 2.0.
- A Chef SaaS environment must be configured. Refer to the [Getting Started with Chef SaaS](/saas/get_started/) page.
- An S3 bucket must be provided from Progress Chef.

## Backup AWS OpsWorks

AWS OpsWorks for Chef Automate can have two configuration setups:

- cluster with SSH access
- cluster without SSH access

Both types of clusters have SSM access. You should be able to log in to the AWS OpsWorks Chef Automate instance and follow the steps to create a backup. By default, AWS OpsWorks has the manual backup feature, which creates a backup in S3. You can use the S3 backup if you can't log in to an instance using SSH/SSM.

### Back up AWS OpsWorks using SSH/SSM

If you have SSH/SSM access, follow these steps to create a backup:

1. Log in to the AWS OpsWorks EC2 instance using SSH/SSM from the EC2 console.
1. Create a `patch.toml` as shown in the following code snippet:

    ```sh
    [global.v1.backups]
    location = "filesystem"

    [global.v1.backups.filesystem]
    path = "/var/opt/chef-automate/backups/"
    ```

1. Apply the patch:

    ```sh
    chef-automate config patch patch.toml
    ```

    Check the Chef Automate status and wait for all services to turn healthy.

1. Back up your Chef Automate data:

    ```sh
    sudo chef-automate backup create
    sudo chef-automate bootstrap bundle create bootstrap.abb
    ```

    Once the backup process is complete, Chef Automate returns a **Success** message. The backup data is available in `/var/opt/chef-automate/backups/`.

1. Zip the backup and share it with the Chef team. Include the `timestamp-based directory`, `automate-elasticsearch-data`, `.tmp` directory, and `bootstrap.abb`.

    ```sh
    [root@ip-10-200-140-7 backups]# ls -a /var/opt/chef-automate/backups/
    20230605230117  automate-elasticsearch-data .tmp bootstrap.abb

    [root@ip-10-200-140-7 backups]# zip -r backup.zip automate-elasticsearch-data 20230605230117 .tmp bootstrap.abb
    [root@ip-10-200-140-7 backups]# ls -a
    20230605230117  automate-elasticsearch-data .tmp bootstrap.abb  backup.zip
    ```

    You can share the backup using pre-signed URLs. The SOP provides steps for sharing the backup with the Chef team.

### Back up AWS OpsWorks using the AWS Management Console

If you don't have SSH/SSM access, follow these steps to create a backup:

1. Go to the **AWS OpsWorks** console.
1. Choose the server to back up on the **Chef Automate servers** page.
1. On the properties page for the Chef Infra Server, in the left navigation pane, select **Backups**.
1. Select **Create backup**.
1. The manual backup is finished when the page shows a green checkmark in the backup's **Status** column.

    {{< figure src="/images/saas/saas-status-column.png" alt="Chef Automate showing list of backups on AWS OpsWorks.">}}

1. In the AWS S3 console, find the AWS OpsWorks bucket where the backups are stored.

    {{< figure src="/images/saas/saas-aws-console.png" alt="AWS S3 console showing list of Automate server backups.">}}

1. Zip the latest `timestamp-based` directory and `automate-elasticsearch-data` directory and share it with the Chef team.

Progress Chef engineers handle the restoration process. Your account manager will notify you when the restoration is complete.

## Verify the restore

When the restore is complete, log into Chef SaaS. You will see data in the environment up to the day of the backup including users, cookbooks, Infra Client runs.
