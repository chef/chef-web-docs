=====================================================
AWS OpsWorks for Chef Automate
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/aws_opsworks_chef_automate.rst>`__

`AWS OpsWorks for Chef Automate <https://aws.amazon.com/opsworks/chefautomate/>`__ is an AWS service which you can use to create a Chef Automate instance.

For documentation on how to setup and create a new instance, please see the `AWS OpsWorks User Guide <http://docs.aws.amazon.com/opsworks/latest/userguide/welcome_opscm.html>`_.

For a tutorial on how to use your new Chef Automate instance, see the OpsWorks for Chef Automate version of `Manage a Node <https://learn.chef.io/tutorials/manage-a-node/opsworks/>`_.

Finally, the general Chef Automate documentation on this site applies to the instances you create via OpsWorks for Chef Automate, so feel free to refer to it as needed.

The following is applicable to any instances created with AWS OpsWorks for Chef Automate.

.. _find-opsworks-instance:

Finding your AWS OpsWorks for Chef Automate instance
=====================================================

All of the Chef Automate instances created via AWS OpsWorks for Chef Automate are named ``aws-opsworks-cm-YOUR_INSTANCE_NAME``. In order to access your Chef Automate instance, you can simply search for ``aws-opsworks-cm`` in the AWS Management console.

Configuring AWS OpsWorks for Chef Automate with runners
========================================================

In order to add runners to your "AWS OpsWorks for Chef Automate" instance you need to do the following:

#. Make sure you have selected ``Use an existing EC2 key pair`` in the ``Select an SSH key`` section while creating your AWS OpsWorks for Chef Automate instance. In order to add a runner, you need to SSH into your instance and run the :ref:`install-runner` subcommand.
#. Your runner should be reachable via SSH from your Chef Automate instance. For this to succeed, you need to make sure its subnet, security groups, and SSH key pair are configured correctly. We also recommend setting up a dedicated SSH key pair in AWS and copying the private key to your Chef Automate instance and use it while running :ref:`install-runner` command.
#. You can find the FQDN of your "AWS OpsWorks for Chef Automate" instance in the OpsWorks console. You can use ``ec2-user`` as the username to SSH into your instance. Assuming you have configured the SSH keys correctly, the SSH command should look like ``ssh ec2-user@<instance-name>-<random-chars>.gamma.opsworks-cm.io``.

Pushing a change through AWS OpsWorks for Chef Automate
========================================================

Existing documentation for pushing a change through Chef Automate is applicable for AWS OpsWorks for Chef Automate. The only extra configuration that you will need to do is to make sure you edit the security group of your AWS OpsWorks for Chef Automate instance to allow inbound Git traffic (using the SSH protocol). This is required so that you can create and approve changes in your Chef Automate instance. Once you :ref:`found your Chef Automate instance <find-opsworks-instance>` you can go to the linked security group and add a new inbound rule.

.. code-block:: text

   Protocol: TCP
   Port Range: 8989
   Source: 0.0.0.0/0

Compliance profiles in AWS OpsWorks for Chef Automate
=====================================================

.. note:: This requires at least version 2.3.0 of the `audit cookbook <https://github.com/chef-cookbooks/audit>`_.

Enabling the compliance profile storage service in AWS OpsWorks for Chef Automate requires changes to ``/etc/delivery/delivery.rb`` and ``/etc/opscode/chef-server.rb``.

#. Enable the service in Chef Automate by adding

   .. code-block:: ruby

      compliance_profiles["enable"] = true

   to ``delivery.rb`` and run ``sudo automate-ctl reconfigure``.

#. Enable the authentication and forwarding through Chef server by adding

   .. code-block:: ruby

      profiles["root_url"] = "https://localhost/"

   to ``chef-server.rb`` and run ``sudo chef-server-ctl reconfigure``.

#. :ref:`Upload compliance profiles <compliance-profile-api>` to your Chef Automate instance.

#. `Configure the audit cookbook <https://github.com/chef-cookbooks/audit#reporting-to-chef-visibility-via-chef-server>`_ to scan your nodes.

.. note:: These instructions only detail what has to be added to the existing configuration as found in AWS OpsWorks for Chef Automate. For general instructions, see :doc:`integrate_compliance_chef_automate` (collector ``chef-server-visibility``) and :doc:`install_chef_automate`.

Adding Push Jobs Server based build nodes to AWS OpsWorks for Chef Automate
============================================================================

Adding Push Jobs Server based build nodes to AWS OpsWorks for Chef Automate requires changes to the Chef Automate instance as well as the node that will run as a builder.

#. Install Push Jobs Server on the Chef Automate instance by downloading the Push Jobs Server from https://downloads.chef.io/push-jobs-server and running:

  .. code-block:: bash

    chef-server-ctl install opscode-push-jobs-server --path /path/to/push-jobs-server-package/opscode-push-jobs-server-2.1.1-1.el6.x86_64.rpm
    opscode-push-jobs-server-ctl reconfigure

Once the Chef Automate instance is configured, you can create a node that will run as a builder and configure it with these steps:

#. Install Chef DK on the build node and create the required directories:

  .. code-block:: bash

    curl -L https://omnitruck.chef.io/chef/install.sh | sudo bash -s -- -c stable -P chefdk
    mkdir ~/installer
    mkdir -p /etc/chef/trusted_certs && sudo chown centos /etc/chef/trusted_certs

#. Copy the required ssh key to login to the build node over to the Chef Automate instance:

  .. code-block:: bash

    scp ~/.ssh/id_rsa ec2-user@serdar-push-2rvkaivrwpgsipoa.us-west-2.opsworks-cm.io:

#. Copy the required keys from the Chef Automate instance to the build node:

  .. code-block:: bash

    scp -i /home/ec2-user/id_rsa -r /opt/delivery/embedded/service/omnibus-ctl/installer centos@52.23.235.94:installer/
    scp -i /home/ec2-user/id_rsa /etc/delivery/builder_key centos@52.23.235.94:installer/installer/
    scp -i /home/ec2-user/id_rsa /etc/delivery/delivery.pem centos@52.23.235.94:installer/installer/

#. Fetch the required certificates on the build node:

  .. code-block:: bash

    sh -c 'openssl s_client -showcerts -connect serdar-push-2rvkaivrwpgsipoa.us-west-2.opsworks-cm.io:443 </dev/null 2> /dev/null | openssl x509 -outform PEM > /etc/chef/trusted_certs/serdar-push-2rvkaivrwpgsipoa_us-west-2_opsworks-cm_io_crt'

#. Provision the build node from Chef Automate instance:

  .. code-block:: bash

    /opt/delivery/embedded/bin/knife ssl fetch https://serdar-push-2rvkaivrwpgsipoa.us-west-2.opsworks-cm.io/
    /opt/delivery/embedded/bin/knife bootstrap 52.23.235.94 \
      --node-name acceptance-node \
      --ssh-user centos \
      --sudo \
      --ssh-identity-file /home/ec2-user/id_rsa \
      -u delivery \
      -k /etc/delivery/delivery.pem \
      --server-url https://serdar-push-2rvkaivrwpgsipoa.us-west-2.opsworks-cm.io/organizations/default

#. Configure the build node and connect it to the Push Jobs Server:

  .. code-block:: bash

    cd /home/centos/installer/installer && sudo ./install-build-node.sh
    cd /home/centos/installer/installer && sudo ./gen_push_config.sh

#. Open the required ports for Push Jobs Server on the security group of the Chef Automate instance by adding the following inbound rule:

  .. code-block:: text

     Protocol: TCP
     Port Range: 10000-10003
     Source: 0.0.0.0/0

There are a few other required configuration steps if you would like to use Push Jobs Server directly.

#. Make sure that the user who is submitting push jobs is associated with the correct organization. OpsWorks starter kit is built for the ``pivotal`` user. So to make the default configuration work, we will need to associate the pivotal user with the default organization by running the following command from the OpsWorks starter kit directory:

  .. code-block:: bash

    knife opc org user add default pivotal

#. ``knife job`` commands will attempt to communicate directly with the Chef server inside the Chef Automate instance. In order to use these commands, we will need to open the Chef server's port for inbound communication by adding the following inbound rule to the security group of the Chef Automate instance:

  .. code-block:: text

     Protocol: TCP
     Port Range: 8443
     Source: 0.0.0.0/0

#. And finally, we will need to refresh the certificates for the ``knife job`` commands to work correctly.

  .. code-block:: bash

    knife ssl fetch https://serdar-push-2rvkaivrwpgsipoa.us-west-2.opsworks-cm.io:8443/
