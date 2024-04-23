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

If you have already upgraded to Chef Automate 2.0, no further installation, upgrade, or maintenance is required.

## Prerequisites

Before you start working for the migration from AWS OpsWorks to Chef SaaS, have a quick look to the following prerequisites:

* Running Automate 2.0 in AWS OpsWorks.
* A Chef SaaS Environment. Refer to the [Getting Started](/saas/get_started/) with the Chef SaaS page.
* An S3 bucket is provided by Progress Chef.

## Prepare DNS for cutover

As part of the migration process, we deploy a blue/green method that links to your existing public DNS. Refer to an example shown in the following code snippet:

```ruby
# The external fully qualified domain name.
# When the application is deployed, you should be able to access 'https://<fqdn>/' to log in.
fqdn = "june15.opsworks.chef.co"
```

## Backup AWS OpsWorks

AWS OpsWorks for Chef Automate can have two configuration setups.

* Cluster with SSH access
* Cluster without SSH access

Both types of clusters will have SSM access. Customers should be able to log in to the AWS OpsWorks Chef Automate instance and follow the below steps to create a backup. By default, AWS OpsWorks has the manual backup feature, which creates a backup in S3 that can be used in case customers are not able to log in to an instance via SSH/SSM.

## Steps to access SSH/SSH

For the customers with SSH/SSM access, follow the below steps to create a backup

1. Login to the AWS OpsWorks EC2 instance via SSH/SSM from the EC2 console.
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

1. Run backup create command:

  ```sh
  sudo chef-automate backup create
  sudo chef-automate bootstrap bundle create bootstrap.abb
  ```

  You will get the **Success** message once the backup process is complete, as shown in the screenshot above. The backup data will be available in `/var/opt/chef-automate/backups/`

1. Zip the backup and share it with the chef team. Include the timestamp-based directory, `automate-elasticsearch-data`, `.tmp` directory, and `bootstrap.abb`.

  ```sh
  [root@ip-10-200-140-7 backups]# ls -a /var/opt/chef-automate/backups/
  20230605230117  automate-elasticsearch-data .tmp bootstrap.abb

  [root@ip-10-200-140-7 backups]# zip -r backup.zip automate-elasticsearch-data 20230605230117 .tmp bootstrap.abb
  [root@ip-10-200-140-7 backups]# ls -a
  20230605230117  automate-elasticsearch-data .tmp bootstrap.abb  backup.zip
  ```

  Customers can share the Backup using pre-signed URLs. The SOP provides steps for sharing the backup with the chef team.

For the customers without SSH/SSM access, follow the steps to create a backup:

1. Go to the **AWS OpsWorks** console.
1. Choose the server you want to back up on the **Chef Automate servers** page.
1. On the properties page for the Chef Infra server, in the left navigation pane, choose **Backups**.
1. Choose **Create Backup**.
1. The manual backup is finished when the page shows a green checkmark in the backup's **Status** column.

  {{< figure src="/images/saas-status-column.png" alt="Status Column">}}

1. Now go to the AWS S3 console and find the AWS OpsWorks bucket in which the backups are stored.

  {{< figure src="/images/saas-aws-console.png" alt="AWS s3 Console">}}

  Zip the latest timestamp-based directory and automate-elasticsearch-data directory and share it with the chef team.

Progress Chef Engineers handle the restoration process. Your account manager will notify you once the restoration is complete.

## Verify Restore

Once the restore is complete, you can log into the Chef SaaS using the credentials of AWS OpsWorks. Once logged in, you will see data in the environment up to the day of the backup. This will include users, cookbooks, client runs, etc.
