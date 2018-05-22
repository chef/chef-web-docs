=====================================================
AWS OpsWorks for Chef Automate
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/aws_opsworks_chef_automate.rst>`__

`AWS OpsWorks for Chef Automate <https://aws.amazon.com/opsworks/chefautomate/>`__ is an AWS service which you can use to create a Chef Automate instance.

For documentation on how to setup and create a new instance, please see the `AWS OpsWorks User Guide <http://docs.aws.amazon.com/opsworks/latest/userguide/welcome_opscm.html>`_.

For a tutorial on how to use your new Chef Automate instance, go to `Manage a node with Chef Automate <https://learn.chef.io/modules/manage-a-node-chef-automate/>`_, choose the platform you want to manage, then choose **AWS OpsWorks for Chef Automate**.

Finally, the general Chef Automate documentation on this site applies to the instances you create via OpsWorks for Chef Automate, so feel free to refer to it as needed.

The following is applicable to any instances created with AWS OpsWorks for Chef Automate.

.. _find-opsworks-instance:

Finding your AWS OpsWorks for Chef Automate instance
=====================================================

All of the Chef Automate instances created via AWS OpsWorks for Chef Automate are named ``aws-opsworks-cm-YOUR_INSTANCE_NAME``. In order to access your Chef Automate instance, you can simply search for ``aws-opsworks-cm`` in the AWS Management console.

Configuring AWS OpsWorks for Chef Automate with runners
========================================================

In order to add runners to your "AWS OpsWorks for Chef Automate" instance you need to do the following:

#. Make sure you have selected ``Use an existing EC2 key pair`` in the ``Select an SSH key`` section while creating your AWS OpsWorks for Chef Automate instance. In order to add a runner, you need to SSH into your instance and run the `install-runner </ctl_automate_server.html#install-runner>`__ subcommand.
#. Your runner should be reachable via SSH from your Chef Automate instance. For this to succeed, you need to make sure its subnet, security groups, and SSH key pair are configured correctly. We also recommend setting up a dedicated SSH key pair in AWS and copying the private key to your Chef Automate instance and use it while running `install-runner </ctl_automate_server.html#install-runner>`__ command.
#. You can find the FQDN of your "AWS OpsWorks for Chef Automate" instance in the OpsWorks console. You can use ``ec2-user`` as the username to SSH into your instance. Assuming you have configured the SSH keys correctly, the SSH command should look like ``ssh ec2-user@<instance-name>-<random-chars>.gamma.opsworks-cm.io``.

.. warning:: Runners on AWS OpsWorks must use Chef DK version 1.5.0. Use ``automate-ctl`` to configure a runner with Chef DK 1.5.0:

   .. code-block:: ruby

      automate-ctl install-runner --chefdk-version 1.5.0 RUNNER_FQDN

Pushing a change through AWS OpsWorks for Chef Automate
========================================================

Existing documentation for pushing a change through Chef Automate is applicable for AWS OpsWorks for Chef Automate. The only extra configuration that you will need to do is to make sure you edit the security group of your AWS OpsWorks for Chef Automate instance to allow inbound Git traffic (using the SSH protocol). This is required so that you can create and approve changes in your Chef Automate instance. Once you `find your Chef Automate instance </aws_opsworks_chef_automate.html#find-opsworks-instance>`__ you can go to the linked security group and add a new inbound rule.

.. code-block:: text

   Protocol: TCP
   Port Range: 8989
   Source: 0.0.0.0/0

