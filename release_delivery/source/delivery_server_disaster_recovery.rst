=====================================================
Delivery Server Disaster Recovery
=====================================================

Use a standby |delivery| server to protect against the loss of the primary |delivery| server. A standby |delivery| server is configured in an identical manner as the primary |delivery| server, but is powered down. In the event of loss of the primary |delivery| server, the standby is powered up, activated with a recent copy of data, and then reconfigured to become the primary.

.. note:: These instructions assume that the primary and standby servers are in the same data center. If they are in different geographical locations additional considerations are necessary, as well as tuning the configuration to account for latency between data centers.


Install w/delivery-cluster
=====================================================
The following steps describe how to install a standby |delivery| server using the ``delivery-cluster`` cookbook.

Requirements
-----------------------------------------------------
A disaster recovery configuration for |delivery| has the following requirements:

* Two identically-configured |delivery| servers, one to act as the primary server and the other to act as a standby
* |ssh| access between both |delivery| servers via port 22
* |postgresql| replication allowed between both |delivery| servers via port 5432
* The latest version of the |chef dk| is installed on the provisioning node
* A |delivery| license

Steps
-----------------------------------------------------
To install a standby |delivery| server using the ``delivery-cluster`` cookbook:

#. Download the ``delivery-cluster`` cookbook:

   .. code-block:: bash

      $ git clone https://github.com/chef-cookbooks/delivery-cluster

   or:

   .. code-block:: bash

      $ wget https://github.com/chef-cookbooks/delivery-cluster/archive/master.zip

#. Create an environment:

   .. code-block:: bash

      $ rake setup:generate_env

#. After creating the environment file in the easy setup instructions, edit the ``environments/<clust-name>.json`` file to add the following block to the ``"delivery"`` property.

   If using the |amazon aws| provisioner:

   .. code-block:: javascript

      "delivery": {
        "dr": {
          "enable": true
        },
        ...
      }

   If using the |ssh| provisioner:

   .. code-block:: javascript

      "delivery": {
        "dr": {
          "enable": true,
          "ip": "10.194.8.8"
        },
        ...
      }

#. Provision the |delivery| cluster:

        $ rake setup:cluster

5. For more information about the ``delivery-cluster`` cookbook, see https://github.com/chef-cookbooks/delivery-cluster.



Install Manually
=====================================================
The following steps describe how to manually install a |delivery| server for use as a standby.

.. note:: Look for items delimited with ``<BRACKETS>``. Replace the bracketed words (and the brackets) with the correct values for your configuration. All files require default permissions, unless noted. All commans must be run as the root user or by using ``sudo``.

#. Provision a standby server that is exactly the same as the existing |delivery| server.

#. Download the |delivery| package to the standby server: https://bintray.com/chef/stable/delivery.

#. As a root user, install the |delivery| package on the server, using the name of the package provided by |company_name|. For |centos|:

   .. code-block:: bash

      $ sudo rpm -i /path/to/delivery-package.rpm

   For |ubuntu|:

   .. code-block:: bash

      $ sudo dpkg -i /path/to/delivery-package.deb

   After a few minutes, |delivery| will be installed.

#. Create the license directory:

   .. code-block:: bash

      $ sudo mkdir -p /var/opt/delivery/license

   and then copy the ``delivery.license`` file that exists in the ``/var/opt/delivery/license`` directory on the primary |delivery| server into the license directory.

#. Create the configuration directory:

   .. code-block:: bash

      $ sudo mkdir -p /etc/delivery

#. Edit the ``/etc/delivery/delivery.rb`` file:

   .. code-block:: bash

      $ sudo vi /etc/delivery/delivery.rb ## you may use any editor you wish

   and add the following settings:

   .. code-block:: ruby

      delivery_fqdn "<DELIVERY_URL>"

      delivery['chef_username']    = "delivery"
      delivery['chef_private_key'] = "/etc/delivery/delivery.pem"
      delivery['chef_server']      = "https://<CHEF_SERVER_URL>/organizations/delivery"

      delivery['default_search']   = "((recipes:delivery_build OR recipes:delivery_build\\\\:\\\\:default) AND chef_environment:_default)"

      delivery['primary'] = false
      delivery['primary_ip'] = '<PRIMARY_IP_ADDRESS>'
      postgresql['listen_address'] = 'localhost,<STANDBY_IP_ADDRESS>'


   where ``PRIMARY_IP_ADDRESS``, ``STANDBY_IP_ADDRESS``, and ``DELIVERY_URL``, ``CHEF_SERVER_URL`` should be replaced with the actual values for the |delivery| configuration. The ``PRIMARY_IP_ADDRESS`` and ``STANDBY_IP_ADDRESS`` values should be from a private network between the two machines.

#. On the existing (now primary) |delivery| server create a directory for the |ssh| key:

   .. code-block:: bash

      $ sudo mkdir -p /opt/delivery/embedded/.ssh

#. Create a private key on the primary |delivery| server. This key is used for file synchronization between the two servers. It may be created in any location with the exception of ``/opt/delivery/embedded/.ssh`` and must not contain a passphrase. The filename itself is arbitrary, but will be used again when editing the ``delivery.rb`` configuration file. First create the directory:

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

#. On the primary |delivery| server edit the ``/etc/delivery/delivery.rb`` file to add the following:

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

   where ``PRIMARY_IP_ADDRESS``, ``STANDBY_IP_ADDRESS``, and ``PRIVATE_KEY`` should be replaced with the actual values for the |delivery| configuration. The ``PRIMARY_IP_ADDRESS`` and ``STANDBY_IP_ADDRESS`` values should be from a private network between the two machines.

#. Copy the following files from the ``/etc/delivery/`` directory on the primary |delivery| server to the standby: ``delivery.pem``, ``builder_key``, ``builder_key.pub``, and ``delivery-secrets.json``. And then verify that ``builder_key``, ``builder_key.pub``, and ``delivery-secrets.json`` have a mode of ``600``.

#. On the standby server, create the ``/etc/chef/trusted_certs`` directory:

   .. code-block:: bash

      $ sudo mkdir -p /etc/chef/trusted_certs

#. Copy all of the files in ``/etc/chef/trusted_certs/`` from the primary |delivery| server to the same directory on the standby server.

#. Create the ``/var/opt/delivery/nginx/ca/`` directory on the standby server:

   .. code-block:: bash

      $ sudo mkdir -p /var/opt/delivery/nginx/ca/

#. Copy all contents of ``/var/opt/delivery/nginx/ca/`` from the primary |delivery| server to the same directory on the standby server.

#. Run the following command on the primary |delivery| server:

   .. code-block:: bash

      $ sudo delivery-ctl reconfigure

#. Run the following command on the standby |delivery| server:

   .. code-block:: bash

      $ sudo delivery-ctl reconfigure


Disaster Recovery
=====================================================
In most scenarios, converting the standby |delivery| server to a standalone configuration is the simplest way to get |delivery| itself back up and running, after which you can rebuild a standby server, update the IP address for the standby server, and then reconfigure the |delivery| configuration to have a primary and standby server.

Promote Standby to Primary
-----------------------------------------------------
To promote a standby |delivery| server to primary, do the following:

#. Log into the standby |delivery| server and make a backup of the data:

   .. code-block:: bash

      $ sudo delivery-ctl backup-data

   Move this data to a location that is not on the standby |delivery| server.

#. If the primary |delivery| server is still accessible, log into it and run the following command as the root user:

   .. code-block:: bash

      $ delivery-ctl stop

#. Convert the standby server to a standalone |delivery| server. Update the ``delivery["primary"]``, ``delivery["primary_ip"]``, and ``postgresql["listen_address"]`` settings in the ``/etc/delivery/delivery.rb`` file to be similar to:

   .. code-block:: ruby

      delivery["primary"] = false
      delivery["primary_ip"] = '192.168.10.10'
      postgresql["listen_address"] = 'localhost,192.168.10.11'

#. On the standby server, run the following command as the root user:

   .. code-block:: bash

      $ delivery-ctl reconfigure

   This will reconfigure the server to become a standalone |delivery| server, after which a new standby server can be installed and configured to be the new standby.

#. Set the DNS/load balancer to redirect traffic to the new primary |delivery| server, as required.

Recreate the Standby
-----------------------------------------------------
Recreating the standby |delivery| server requires the following steps:

* Deleting the old primary server
* Updating configuration if |ssh| provisioning is being used
* Installing a |delivery| server to act as a standby

Delete the Primary
+++++++++++++++++++++++++++++++++++++++++++++++++++++
To delete the failed primary, do the following:

#. Log in to the |chef server| and delete the primary |delivery| server node and client.
#. Delete or destroy the primary |delivery| machine.

Configure SSH
+++++++++++++++++++++++++++++++++++++++++++++++++++++
If provisioning uses the |ssh| driver, do the following:

#. Remove the disaster recovery block in the |delivery| cluster.
#. Set the correct IP address for new primary node.
#. Run the following command:

   .. code-block:: bash

      $ rm .chef/provisioning/ssh/delivery-server-test.json

Reinstall Standby
+++++++++++++++++++++++++++++++++++++++++++++++++++++
To set up a new standby |delivery| server, follow the same steps for installing the |delivery| server (either manually or using the ``delivery-cluster`` cookbook), as described earlier in this topic.
