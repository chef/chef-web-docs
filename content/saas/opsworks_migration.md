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

Advantages to migrate from AWS OPSWorks to Chef SaaS is given below:

1. Customer reviews ans reduced current data as needed.

1. Creates Data Backup.

1. Chef creates SaaS account.

1. Chef restores backup.

1. Register nodes with Chef SaaS.

The steps to migrate from  AWS OPSWorks to Chef SaaS is given below:

1. You will get a SaaS environment to start the process. The image is given below:

    IMAGE

1. Once the environment is created, the environment will be inserted under the monitoring tools.

    IMAGE

1. As a part of the process, a deployment will take place in a Blue/Green method which will directly link to your public DNS.

    IMAGE

1. Once the environment is created, you will get:

    * Created default admin user.

    * Created Master PEM and Pivitol User PEM file.

    The above pointers will ensure that the environment can be used as a fresh environment.

1. Once you receive the generic information that the SaaS environment is ready it is time to make a backup of the OPSWorks environment.

    IMAGE

1. Download the backup in **.zip** format, once it is created.

    IMAGE

1. While created a SaaS environment, a S3 bucket has also been created that can be used for storing the backup. The S3 bucket expires in 14 days after the environment set up and will only allow once backup file per bucket. If you provide two or more files, only the last upload will remain in the bucket.

    IMAGE

1. Once the above steps are done, a backup will be restores into your new SaaS environment.

    IMAGE

1. Once the restoring is done, you can login to Chef SaaS using your OPSWorks credentials. After logging in, you will see data in the environment up to the day of the backup. This will include users, cookbooks, client runs, ECT.

The last step will be to point you OPSWorks Nodes to the Chef SaaS DNS to have node data flow going forward.
