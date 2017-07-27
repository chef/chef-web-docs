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

#. Make sure you have selected ``Use an existing EC2 key pair`` in the ``Select an SSH key`` section while creating your AWS OpsWorks for Chef Automate instance. In order to add a runner, you need to SSH into your instance and run the :ref:`install-runner` subcommand.
#. Your runner should be reachable via SSH from your Chef Automate instance. For this to succeed, you need to make sure its subnet, security groups, and SSH key pair are configured correctly. We also recommend setting up a dedicated SSH key pair in AWS and copying the private key to your Chef Automate instance and use it while running :ref:`install-runner` command.
#. You can find the FQDN of your "AWS OpsWorks for Chef Automate" instance in the OpsWorks console. You can use ``ec2-user`` as the username to SSH into your instance. Assuming you have configured the SSH keys correctly, the SSH command should look like ``ssh ec2-user@<instance-name>-<random-chars>.gamma.opsworks-cm.io``.

.. warning:: Runners on AWS OpsWorks must use Chef DK version 1.5. Use ``automate-ctl`` to configure a runner with Chef DK 1.5:

   .. code-block:: ruby

      automate-ctl install-runner --chefdk-version 1.5 RUNNER_FQDN

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

.. note:: These instructions only detail what has to be added to the existing configuration as found in AWS OpsWorks for Chef Automate. For general instructions, see :doc:`integrate_compliance_server_chef_automate` (collector ``chef-server-visibility``) and :doc:`install_chef_automate`.

Adding push jobs server based build nodes to AWS OpsWorks for Chef Automate
============================================================================

Build nodes enable you to push infrastructure or application changes through a pipeline. Pipelines are part of Chef Automate's :doc:`workflow <workflow>` feature. Build nodes run jobs, called *phases*, which define how your change is built, tested, and deployed to your infrastructure.

:doc:`Push jobs <push_jobs>` are one way to trigger jobs to run on your build nodes. Configuring push jobs on AWS OpsWorks for Chef Automate requires changes to the Chef Automate instance as well as the node that will run as a builder.

If you don't already have a system set up to run as your build node, refer to the :doc:`installation guide <install_chef_automate>` to learn about the supported platforms and network requirements. Then, bring up an instance to serve as your build node. The examples that follow use CentOS 7.3 running on Amazon Web Services with ports 22 (SSH) and 443 (HTTPS) open to inbound network traffic.

To prepare for the steps that follow, create an SSH connection to both your Chef Automate server and your build node. Here's an example for connecting to your Chef Automate instance.

.. code-block:: bash

   $ ssh -i ~/.ssh/id_rsa ec2-user@test-ntex3ai8ej1yhnqu.us-east-1.opsworks-cm.io

To simplify the process, you can run ``sudo -s`` from each of your SSH connections to run commands using ``root`` privileges.

From your Chef Automate server, export the path to the ``knife`` executable to make these commands easier to run.

.. code-block:: bash

   $ export PATH=/opt/opscode/embedded/bin:$PATH

In the steps that follow, you'll need to replace placeholder values with yours. Gather the following information about your environment. The **Placeholder** column lists the placeholder text you'll replace in the steps that follow.

+----------------------------------+----------------------------------------------------+---------------------------+
| Description                      | Example                                            | Placeholder               |
+==================================+====================================================+===========================+
| Your Chef Automate server's FQDN | ``test-ntex3ai8ej1yhnqu.us-east-1.opsworks-cm.io`` | ``CHEF_AUTOMATE_FQDN``    |
+----------------------------------+----------------------------------------------------+---------------------------+
| The SSH key you use to connect   | ``id_rsa``                                         | ``CHEF_AUTOMATE_SSH_KEY`` |
| to your Chef Automate server     |                                                    |                           |
+----------------------------------+----------------------------------------------------+---------------------------+
| Your build node's IP address     | ``52.23.235.94``                                   | ``BUILD_NODE_IP_ADDRESS`` |
+----------------------------------+----------------------------------------------------+---------------------------+
| Your build node's user name      | ``ec2-user``                                       | ``BUILD_NODE_USERNAME``   |
+----------------------------------+----------------------------------------------------+---------------------------+
| The SSH key you use to connect   | ``id_rsa``                                         | ``BUILD_NODE_SSH_KEY``    |
| to your build node               |                                                    |                           |
+----------------------------------+----------------------------------------------------+---------------------------+

You'll also need to specify the name of an SSL certificate file that matches a special format. This format takes your Chef Automate server's FQDN, replaces the dot ``.`` character with an underscore ``_`` and ends with ``_crt``. For example, if your Chef Automate server's FQDN is:

.. code-block:: bash

   test-ntex3ai8ej1yhnqu.us-east-1.opsworks-cm.io

Then your SSL certificate file name would be:

.. code-block:: bash

   test-ntex3ai8ej1yhnqu_us-east-1_opsworks-cm_io_crt

This certificate file name appears as ``CHEF_AUTOMATE_SSL_CERT`` in the steps that follow.

#. **From your Chef Automate server**, install push jobs server. Here's an example. You can get the URL for the latest package from https://downloads.chef.io/push-jobs-server.

   .. code-block:: bash

      $ wget https://packages.chef.io/files/stable/opscode-push-jobs-server/2.1.1/el/7/opscode-push-jobs-server-2.1.1-1.el7.x86_64.rpm
      $ chef-server-ctl install opscode-push-jobs-server --path /home/ec2-user/opscode-push-jobs-server-2.1.1-1.el7.x86_64.rpm
      $ opscode-push-jobs-server-ctl reconfigure

#. **From your build node**, install the Chef DK and create the required directories.

   .. code-block:: bash

      $ curl -L https://omnitruck.chef.io/chef/install.sh | bash -s -- -c stable -P chefdk
      $ mkdir ~/installer
      $ mkdir -p /etc/chef/trusted_certs && chown BUILD_NODE_USERNAME /etc/chef/trusted_certs

#. **From your workstation**, copy the SSH key you use to connect to your build node instance to the Chef Automate instance. Here's an example.

   .. code-block:: bash

      $ scp -i ~/.ssh/CHEF_AUTOMATE_SSH_KEY ~/.ssh/BUILD_NODE_SSH_KEY ec2-user@CHEF_AUTOMATE_FQDN:

#. **From your Chef Automate server**, run these commands to copy the required keys to the build node.

   .. code-block:: bash

      $ scp -i /home/ec2-user/BUILD_NODE_SSH_KEY -r /opt/delivery/embedded/service/omnibus-ctl/installer BUILD_NODE_USERNAME@BUILD_NODE_IP_ADDRESS:installer/
      $ scp -i /home/ec2-user/BUILD_NODE_SSH_KEY /etc/delivery/builder_key BUILD_NODE_USERNAME@BUILD_NODE_IP_ADDRESS:installer/
      $ scp -i /home/ec2-user/BUILD_NODE_SSH_KEY /etc/delivery/delivery.pem BUILD_NODE_USERNAME@BUILD_NODE_IP_ADDRESS:installer/

#. **From your build node**, fetch the required SSL certificates from your Chef Automate server.

   .. code-block:: bash

      $ sh -c 'openssl s_client -showcerts -connect CHEF_AUTOMATE_FQDN:443 </dev/null 2> /dev/null | openssl x509 -outform PEM > /etc/chef/trusted_certs/CHEF_AUTOMATE_SSL_CERT'

#. **From your Chef Automate server**, run these commands to bootstrap your build node to the Chef server. You can replace ``build-node-1`` if you want to give your build node a different name.

   .. code-block:: bash

      $ chmod 0644 /etc/delivery/delivery.pem
      $ /opt/delivery/embedded/bin/knife ssl fetch https://CHEF_AUTOMATE_FQDN/
      $ /opt/delivery/embedded/bin/knife bootstrap BUILD_NODE_IP_ADDRESS \
       --node-name build-node-1 \
       --ssh-user BUILD_NODE_USERNAME \
       --sudo \
       --ssh-identity-file /home/ec2-user/BUILD_NODE_SSH_KEY \
       -u delivery \
       -k /etc/delivery/delivery.pem \
       --server-url https://CHEF_AUTOMATE_FQDN/organizations/default

#. **From your Chef Automate server**, run these commands to enable the ``delivery`` user to submit push jobs.

   .. code-block:: bash

      $ gem install knife-acl
      $ knife group add user delivery admins -c /etc/opscode/pivotal.rb --server-url https://localhost/organizations/default

#. **From your Chef Automate server**, restart the services to apply the changes.

   .. code-block:: bash

      $ delivery-ctl restart

#. **From your build node**, run these commands to configure the build node and connect it to the push jobs server.

   .. code-block:: bash

      $ cd /home/BUILD_NODE_USERNAME/installer
      $ ./install-build-node.sh
      $ ./gen_push_config.sh

#. Open the required ports for push jobs server on the security group of the Chef Automate instance by adding the following inbound rule. See http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-network-security.html#adding-security-group-rule to learn how to modify an EC2 security group.

   .. code-block:: text

      Protocol: TCP
      Port Range: 10000-10003
      Source: 0.0.0.0/0

#. **From your workstation**, `cd` to the directory where you extracted the starter kit. Then add a tag named ``delivery-build-node`` to your build node. Replace ``build-node-1`` with the node name you used earlier.

   .. code-block:: bash

      $ knife tag create build-node-1 delivery-build-node

#. **From your workstation**, associate the ``pivotal`` user with your Chef server's default organization.

   .. code-block:: bash

      $ knife opc org user add default pivotal

#. **From your workstation**, run these commands to verify that your build node is configured to accept push jobs. Replace ``build-node-1`` with your build node's name.

   .. code-block:: bash

      $ knife node show build-node-1

      Node Name:   build-node-1
      Environment: _default
      FQDN:        ip-172-31-25-243.ec2.internal
      IP:          52.90.62.112
      Run List:
      Roles:
      Recipes:
      Platform:    redhat 7.3
      Tags:        delivery-build-node

      $ knife node status

      build-node-1	available

Because Chef server and Chef Automate exist on the same system, Chef Automate can communicate directly with the Chef server to dispatch push jobs to build nodes. Although not typically required, you can perform the following steps if you would like to use :doc:`knife job <plugin_knife_push_jobs>` to submit push jobs to your build nodes directly.

#. Add the following inbound rule to the security group of the Chef Automate instance.

   .. code-block:: text

     Protocol: TCP
     Port Range: 8443
     Source: 0.0.0.0/0

#. Fetch the SSL certificate for your Chef Automate server from port 8443.

   .. code-block:: bash

      $ knife ssl fetch https://CHEF_AUTOMATE_FQDN:8443/

#. To verify the configuration, run the following to submit a push job that runs ``chef-client`` on your build node. This command resembles the one that Chef Automate uses to submit jobs to build nodes as a change moves through the pipeline.

   .. code-block:: bash

      $ knife job start 'chef-client' --search 'name:build-node-1 AND tags:delivery-build-node'

      Started.  Job ID: 5d3afde1afff96a1fed6ab2b4099f2a3
      .Running (1/1 in progress) ...
      ..Complete.
      command:     chef-client
      created_at:  Wed, 04 Jan 2017 03:24:50 GMT
      env:
      id:          5d3afde1afff96a1fed6ab2b4099f2a3
      nodes:
        succeeded: build-node-1
      run_timeout: 3600
      status:      complete
      updated_at:  Wed, 04 Jan 2017 03:24:53 GMT
