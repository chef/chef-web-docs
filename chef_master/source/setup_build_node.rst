===========================================================
Set up a build node
===========================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/setup_build_node.rst>`__

Push job-based build nodes can be used by Chef Automate to build, test, and deploy your components within Chef Automate and your infrastructure; however, if you are creating new nodes for this purpose, then you should use the SSH-based job dispatch system that uses runners to perform these tasks. The instructions below are for customers who have a hard requirement to use the previous push jobs-based system.

The following steps should be performed on a Chef Automate server:

#. If you have an on-premises Supermarket installation, copy the Supermarket certificate file to ``/etc/delivery/supermarket.crt``.

#. Download the latest ChefDK from `<https://downloads.chef.io/chefdk/>`_. Version 0.15.16 or greater is required. The download location is referred to below as ``$CHEF_DK_PACKAGE_PATH``.

#. Run the ``install-build-node`` subcommand.

   .. code-block:: bash

      automate-ctl install-build-node $BUILD_NODE_FQDN \
                                      $SSH_USERNAME \
                                      --password [$OPTIONAL_SSH_OR_SUDO_PASSWORD] \
                                      --installer $CHEF_DK_PACKAGE_PATH \
                                      --ssh-identity-file $SSH_IDENTITY_FILE \
                                      --port $SSH_PORT \
                                      --full-ohai
   .. tag chef_automate_build_nodes

   .. note:: Legacy build nodes created by ``delivery-cluster`` can be used with a Chef Automate server.  Some node visibility features are designed to only work with new build nodes and runners installed through the command line process, but the workflow feature in Chef Automate can use legacy, new, or mixed node pools; however, you cannot upgrade a legacy build node to the new build node or runner models.  If you would like to use new build nodes/runners, please use fresh hosts or completely wipe your legacy build nodes before attempting to run ``automate-ctl install-build-node`` or ``automate-ctl install-runner``.

   .. end_tag

   .. tag chef_automate_build_nodes_with_full_ohai

   .. note:: If ``--full-ohai`` flag is set, Chef runs with full Ohai plugins. By default, Chef runs with bare Ohai plugins that are required for the node.

   .. end_tag

   .. tag delivery_ctl_note

   .. note:: Prior to Chef Automate 0.6.0, this tool was named ``delivery-ctl``. To support backwards compatibility, you can continue to call ``delivery-ctl`` in Chef Automate 0.6.0.

   .. end_tag

   You can view the logs at ``/var/log/automate-ctl/build-node-install_$BUILD_NODE_FDQN.log``.

   Any existing nodes with the same name as your build node's FQDN will be overwritten on the Chef server. This will remove any previous run lists or Chef Server configuration on this node. This is done in case this hostname was previously being used for something else. Setting the ``--[no]-overwrite-registration`` flag when calling ``install-build-node`` will allow you to avoid that prompt.

.. note:: Certain sensitive files are copied over to a temporary directory on the build node. In the event of failure after these files have been copied, the installer will attempt to remove them. If it is unable to do so, it will provide you with instructions for doing so manually.
