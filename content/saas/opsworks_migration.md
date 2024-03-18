+++
title = "Migrate from AWS OpsWorks to Chef SaaS"
draft = false

[menu]
  [menu.saas]
    title = "OpsWorks Migration"
    identifier = "chef_infra/OpsWorks Migration"
    parent = "chef_saas"
    weight = 30
+++

This guide will walk you through the migration scenarios from AWS OPSWorks to Chef SaaS.

{{< note >}} Assuming that you have upgraded to Automate 2.0 {{< /note >}}

If you have already upgraded to Chef Automate 2.0, no further installation, upgrade or maintenance is required.

## Prerequisites

1. Running Automate 2.0 in AWS OpsWorks.

1. A Chef SaaS Environment. Refer to the [Getting Started](/get_started/) with Chef SaaS page.

1. An S3 bucket provided by Progress Chef.

## Advantages to migrate from AWS OpsWorks to Chef SaaS

Advantages to migrate from AWS OpsWorks to Chef SaaS is given below:

1. Customer reviews ans reduced current data as needed.

1. Creates Data Backup.

1. Chef creates SaaS account.

1. Chef restores backup.

1. Register nodes with Chef SaaS.

## Prepare DNS for cutover

As part of the migration process, we deploy with a Blue/Green method that links to your existing public DNS. Refer to an example shown in the image below:

IMAGE

## Backup OpsWorks

You can take the backup of your OpsWorks using the following steps:

1. Connect to the existing AWS OpsWorks environment and take a backup.

1. Create a `.zip` file of the OpsWorks backup.

1. Copy the backup .zip file to provide the S3 Bucket. (This bucket will expire in 7 days after the environment is set up and will only allow one backup file. If you provide two or more .zip files, the last upload will remain in the bucket)

## Restore OpsWorks backup to Chef SaaS

The restore process is taken care by Progress Chef Engineers. You will be notified by your account manager once the restoration is complete.

## Verify Restore

Once the restore is complete, you can log into the Chef SaaS using your OpsWorks credentials. Once logged in, you will see data in the environment upto day of the backup. This will include users, cookbooks, client runs, etc.

## Update DNS

The final step in the migration process will point your OpsWorks Nodes to the new Chef SaaS DNS to have node data flow going forward.
