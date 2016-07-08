=====================================================
Chef Automate Disaster Recovery
=====================================================

.. include:: ../../includes_chef_automate/includes_chef_automate_mark.rst 

Use a standby |automate| server to protect against the loss of the primary |automate| server. A standby |automate| server is configured to replicate data from the primary |automate| server. In the event of loss of the primary |automate| server, the standby is then reconfigured to become the primary.

.. note:: Disaster Recovery for |automate| pertains to the workflow capabilities only. Also, these instructions assume that the primary and standby servers are in the same data center. If they are in different geographical locations additional considerations are necessary, as well as tuning the configuration to account for latency between data centers.

Requirements
====================================================
A disaster recovery configuration for |automate| has the following requirements:

* Two identically-configured |automate| servers, one to act as the primary server and the other to act as a standby

  .. note:: You cannot log in to the |automate| web UI on the standby server.

* |ssh| access between both |automate| servers via port 22
* |postgresql| replication allowed between both |automate| servers via port 5432
* The latest version of the |chef dk| is installed on the provisioning node
* A |automate| license


Install a Standby |automate| Server
=====================================================
The following steps describe how to manually install a |automate| server for use as a standby.

.. note:: Look for items delimited with ``<BRACKETS>``. Replace the bracketed words (and the brackets) with the correct values for your configuration. All files require default permissions, unless noted. All commans must be run as the root user or by using ``sudo``.

#. Provision a standby server that is exactly the same as the existing |automate| server.

#. Download the |automate| package to the standby server: `<https://downloads.chef.io/automate/>`_.

#. As a root user, install the |automate| package on the server, using the name of the package provided by |company_name|. 

   For Debian:
  
   .. code-block:: bash

      dpkg -i $PATH_TO_AUTOMATE_SERVER_PACKAGE


   For Red Hat or Centos:
  
   .. code-block:: bash

      rpm -Uvh $PATH_TO_AUTOMATE_SERVER_PACKAGE

   After a few minutes, |automate| will be installed.

#. Create the license directory:

   .. code-block:: bash

      $ sudo mkdir -p /var/opt/delivery/license

   and then copy the ``delivery.license`` file that exists in the ``/var/opt/delivery/license`` directory on the primary |automate| server into the license directory.

#. Create the configuration directory:

   .. code-block:: bash

      $ sudo mkdir -p /etc/delivery

#. Edit the ``/etc/delivery/delivery.rb`` file:

   .. code-block:: bash

      $ sudo vi /etc/delivery/delivery.rb ## you may use any editor you wish

   and add the following settings:

   .. code-block:: ruby

      delivery_fqdn "<AUTOMATE_URL>"

      delivery['chef_username']    = "delivery"
      delivery['chef_private_key'] = "/etc/delivery/delivery.pem"
      delivery['chef_server']      = "https://<CHEF_SERVER_URL>/organizations/delivery"

      delivery['default_search']   = "((recipes:delivery_build OR recipes:delivery_build\\\\:\\\\:default) AND chef_environment:_default)"

      delivery['primary'] = false
      delivery['primary_ip'] = '<PRIMARY_IP_ADDRESS>'
      postgresql['listen_address'] = 'localhost,<STANDBY_IP_ADDRESS>'


   where ``PRIMARY_IP_ADDRESS``, ``STANDBY_IP_ADDRESS``, and ``AUTOMATE_URL``, ``CHEF_SERVER_URL`` should be replaced with the actual values for the |automate| configuration. The ``PRIMARY_IP_ADDRESS`` and ``STANDBY_IP_ADDRESS`` values should be from a private network between the two machines.

#. On the existing (now primary) |automate| server create a directory for the |ssh| key:

   .. code-block:: bash

      $ sudo mkdir -p /opt/delivery/embedded/.ssh

#. Create a private key on the primary |automate| server. This key is used for file synchronization between the two servers. It may be created in any location with the exception of ``/opt/delivery/embedded/.ssh`` and must not contain a passphrase. The filename itself is arbitrary, but will be used again when editing the ``delivery.rb`` configuration file. First create the directory:

   .. code-block:: bash

      $ sudo mkdir -p /opt/delivery/embedded/.ssh/

   then move into the directory:

   .. code-block:: bash

      $ cd /opt/delivery/embedded/.ssh

   then generate the key:

   .. code-block:: bash

      $ sudo ssh-keygen -t rsa -b 4096 -C "<EMAIL_ADDRESS>"

   and then save the filename for later.

#. Add the public key to ``/opt/delivery/embedded/.ssh/authorized_keys`` on the standby server:

   .. code-block:: bash

      $ sudo mkdir -p /opt/delivery/embedded/.ssh

#. On the primary |automate| server edit the ``/etc/delivery/delivery.rb`` file to add the following:

   .. code-block:: ruby

      delivery['primary'] = true
      postgresql['trust_auth_cidr_addresses'] = [ '127.0.0.1/32',
                                                  '::1/128',
                                                  '<PRIMARY_IP_ADDRESS>/32',
                                                  '<STANDBY_IP_ADDRESS>/32'
                                                ]
      postgresql['listen_address'] = 'localhost,<PRIMARY_IP_ADDRESS>'
      delivery['standby_ip'] = '<STANDBY_IP_ADDRESS>'
      lsyncd['ssh_key'] = '/opt/delivery/embedded/.ssh/<PRIVATE_KEY>'

   where ``PRIMARY_IP_ADDRESS``, ``STANDBY_IP_ADDRESS``, and ``PRIVATE_KEY`` should be replaced with the actual values for the |automate| configuration. The ``PRIMARY_IP_ADDRESS`` and ``STANDBY_IP_ADDRESS`` values should be from a private network between the two machines.

#. Copy the following files from the ``/etc/delivery/`` directory on the primary |automate| server to the standby: ``delivery.pem``, ``builder_key``, ``builder_key.pub``, and ``delivery-secrets.json``. And then verify that ``builder_key``, ``builder_key.pub``, and ``delivery-secrets.json`` have a mode of ``600``.

#. On the standby server, create the ``/etc/chef/trusted_certs`` directory:

   .. code-block:: bash

      $ sudo mkdir -p /etc/chef/trusted_certs

#. Copy all of the files in ``/etc/chef/trusted_certs/`` from the primary |automate| server to the same directory on the standby server.

#. Create the ``/var/opt/delivery/nginx/ca/`` directory on the standby server:

   .. code-block:: bash

      $ sudo mkdir -p /var/opt/delivery/nginx/ca/

#. Copy all contents of ``/var/opt/delivery/nginx/ca/`` from the primary |automate| server to the same directory on the standby server.

#. Run the following command on the primary |automate| server:

   .. code-block:: bash

      $ sudo delivery-ctl reconfigure

#. Run the following command on the standby |automate| server:

   .. code-block:: bash

      $ sudo delivery-ctl reconfigure


Disaster Recovery
=====================================================
In most scenarios, converting the standby |automate| server to a standalone configuration is the simplest way to get |automate| itself back up and running, after which you can rebuild a standby server, update the IP address for the standby server, and then reconfigure the |automate| configuration to have a primary and standby server.

Failover the |automate| Server
-----------------------------------------------------
To promote a standby |automate| server to primary, do the following:

#. Log into the standby |automate| server (via |ssh|, and not the |automate| web UI) and make a backup of the data:

   .. code-block:: bash

      $ sudo delivery-ctl backup-data

   Move this data to a location that is not on the standby |automate| server.

#. If the primary |automate| server is still accessible, log into it and run the following command as the root user:

   .. code-block:: bash

      $ delivery-ctl stop

#. Convert the standby server to a standalone |automate| server. Update the ``delivery["primary"]``, ``delivery["primary_ip"]``, and ``postgresql["listen_address"]`` settings in the ``/etc/delivery/delivery.rb`` file to be similar to:

   .. code-block:: ruby

      delivery["primary"] = false
      delivery["primary_ip"] = '192.168.10.10'
      postgresql["listen_address"] = 'localhost,192.168.10.11'

#. On the standby server, run the following command as the root user:

   .. code-block:: bash

      $ delivery-ctl reconfigure

   This will reconfigure the server to become a standalone |automate| server, after which a new standby server can be installed and configured to be the new standby.

#. Set the DNS/load balancer to redirect traffic to the new primary |automate| server, as required.

Recreate the Standby
-----------------------------------------------------
Recreating the standby |automate| server requires the following steps:

* Deleting the old primary server
* Updating configuration if |ssh| provisioning is being used
* Installing a |automate| server to act as a standby

Delete the Primary
+++++++++++++++++++++++++++++++++++++++++++++++++++++
To delete the failed primary, do the following:

#. Log in to the |chef server| and delete the primary |automate| server node and client.
#. Delete or destroy the primary |automate| machine.

Configure SSH
+++++++++++++++++++++++++++++++++++++++++++++++++++++
If provisioning uses the |ssh| driver, do the following:

#. Remove the disaster recovery block in the |automate| cluster.
#. Set the correct IP address for new primary node.
#. Run the following command:

   .. code-block:: bash

      $ rm .chef/provisioning/ssh/delivery-server-test.json

Reinstall Standby
+++++++++++++++++++++++++++++++++++++++++++++++++++++
To set up a new standby |automate| server, follow the same steps for installing the |automate| server (either manually or using the ``delivery-cluster`` cookbook), as described earlier in this topic.
