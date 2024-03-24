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

If you have already upgraded to Chef Automate 2.0, no further installation, upgrade, or maintenance is required.

## Prerequisites

* Running Automate 2.0 in AWS OpsWorks.

* A Chef SaaS Environment. Refer to the [Getting Started](/get_started/) with the Chef SaaS page.

* An S3 bucket provided by Progress Chef.

## High-level steps to migrate from AWS OpsWorks to Chef SaaS (REPHRASE)

The advantages of migrating from AWS OpsWorks to Chef SaaS are:

* Customer reviews and reduced current data as needed.

* Creates Data Backup.

* Chef creates SaaS account.

* Chef restores backup.

* Register nodes with Chef SaaS.

## Prepare DNS for cutover

As part of the migration process, we deploy a Blue/Green method that links to your existing public DNS. Refer to an example shown in the code snippet below:

```ruby
# The external fully qualified domain name.
# When the application is deployed, you should be able to access 'https://<fqdn>/' to log in.
fqdn = "june15.opsworks.chef.co"
```

## Backup OpsWorks (NEW SECTION SHOULD BE ADDED)

You can take the backup of your OpsWorks using the following steps:

1. Connect to the existing AWS OpsWorks environment and take a backup.

1. Create a `.zip` file of the OpsWorks backup.

1. Copy the backup .zip file to provide the S3 Bucket. (This bucket will expire seven days after the environment is set up and will only allow one backup file. If you provide two or more .zip files, the last upload will remain in the bucket)

## Restore OpsWorks backup to Chef SaaS

Progress Chef Engineers handle the restoration process. Your account manager will notify you once the restoration is complete.

## Verify Restore

Once the restore is complete, you can log into the Chef SaaS using your OpsWorks credentials. Once logged in, you will see data in the environment up to the day of the backup. This will include users, cookbooks, client runs, etc.

## Update DNS

The final step in the migration process will point your OpsWorks Nodes to the new Chef SaaS DNS so that node data flows forward.
