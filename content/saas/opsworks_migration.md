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

This guide will walk you through the migration scenarios from AWS OpsWorks to Chef SaaS.

{{< note >}} Assuming that you have upgraded to Automate 2.0 {{< /note >}}

## Prerequisites

Before you start working on the migration from AWS OpsWorks to Chef SaaS, have a quick look at the following prerequisites:

* Running Automate 2.0 in AWS OpsWorks.
* A Chef SaaS Environment. Refer to the [Getting Started](/saas/get_started/) with the Chef SaaS page.
* An S3 bucket from Progress Chef.

## Backup AWS OpsWorks

AWS OpsWorks for Chef Automate can have two configuration setups.

* Cluster with SSH access
* Cluster without SSH access

Both types of clusters will have SSM access. Customers should be able to log in to the AWS OpsWorks Chef Automate instance and follow the given steps to create a backup. By default, AWS OpsWorks has the manual backup feature, which creates a backup in S3. You can use the S3 backup if you cannot log in to an instance via SSH/SSM.

### Back up AWS OpsWorks using SSH/SSM

For the customers with SSH/SSM access, follow the steps to create a backup:

1. Log into to the AWS OpsWorks EC2 instance using SSH/SSM from the EC2 console.
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

    Check the chef-automate status and wait for all the services to turn healthy.

1. Back up your Chef Automate data:

    ```sh
    sudo chef-automate backup create
    sudo chef-automate bootstrap bundle create bootstrap.abb
    ```

    Once the backup process is complete, Chef Automate returns the **Success** message. The backup data is available in `/var/opt/chef-automate/backups/`.

1. Zip the backup and share it with the Chef Team. Include the `timestamp-based directory`, `automate-elasticsearch-data`, `.tmp` directory, and `bootstrap.abb`.

    ```sh
    [root@ip-10-200-140-7 backups]# ls -a /var/opt/chef-automate/backups/
    20230605230117  automate-elasticsearch-data .tmp bootstrap.abb

    [root@ip-10-200-140-7 backups]# zip -r backup.zip automate-elasticsearch-data 20230605230117 .tmp bootstrap.abb
    [root@ip-10-200-140-7 backups]# ls -a
    20230605230117  automate-elasticsearch-data .tmp bootstrap.abb  backup.zip
    ```

    Customers can share the Backup using pre-signed URLs. The SOP provides steps for sharing the Backup with the Chef Team.

### Back up AWS OpsWorks using the AWS UI

For the customers without SSH/SSM access, follow the steps to create a backup:

1. Go to the **AWS OpsWorks** console.
1. Choose the server you want to back up on the **Chef Automate servers** page.
1. On the properties page for the Chef Infra Server, in the left navigation pane, choose **Backups**.
1. Choose **Create Backup**.
1. The manual backup is finished when the page shows a green checkmark in the backup's **Status** column.

    {{< figure src="/images/saas-status-column.png" alt="Status Column">}}

1. In the AWS S3 console, find the AWS OpsWorks bucket in which the backups are stored.

    {{< figure src="/images/saas-aws-console.png" alt="AWS s3 Console">}}

    Zip the latest `timestamp-based` directory and `automate-elasticsearch-data` directory and share it with the Chef Team.

Progress Chef Engineers handle the restoration process. Your account manager will notify you once the restoration is complete.

## Verify Restore

Once the restore is complete, you can log into Chef SaaS using AWS OpsWorks credentials. Once logged in, you will see data in the environment up to the day of the backup. This will include users, cookbooks, client runs, etc.
