.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Once the ``/etc/opscode`` files have been copied over to the backend slave from the master, the backend slave may be updated.

On |redhat| |rpm| based systems run |rpm| with the appropriate upgrade flags and with the new |rpm| to be installed:

.. code-block:: bash

   $ rpm -Uvh private-chef-1.1.10-1.el6.x86_64.rpm

On |ubuntu| or |debian| deb-package based systems run |debian dpkg| with the install flag:

.. code-block:: bash

   $ dpkg -i private-chef_1.1.10-1.ubuntu.10.04_amd64.deb

After installing the upgraded package, instruct |private chef ctl| to update the configuration and perform the upgrade:

.. code-block:: bash

   $ private-chef-ctl upgrade

This may trigger a cluster failover, which will require watching the |keepalived| logs until the cluster failover completes and the server has transitioned fully into either the master or backup states:

.. code-block:: bash

   $ private-chef-ctl tail keepalived
   
   ==> /var/log/opscode/keepalived/cluster.log <==
   Wed, 28 Mar 2012 22:09:14 +0000: Stopping service opscode-expander-reindexer
   Wed, 28 Mar 2012 22:09:14 +0000: Stopping service opscode-org-creator
   Wed, 28 Mar 2012 22:09:15 +0000: Stopping service opscode-chef
   Wed, 28 Mar 2012 22:09:15 +0000: Stopping service opscode-erchef
   Wed, 28 Mar 2012 22:09:15 +0000: Stopping service opscode-webui
   Wed, 28 Mar 2012 22:09:16 +0000: Stopping service php-fpm
   Wed, 28 Mar 2012 22:09:16 +0000: Stopping service fcgiwrap
   Wed, 28 Mar 2012 22:09:17 +0000: Stopping service nagios
   Wed, 28 Mar 2012 22:09:17 +0000: Stopping service nginx
   Wed, 28 Mar 2012 22:09:18 +0000: Transitioned to backup

If instead bringing the backup node online triggers a transition to master, use the top command to watch for the load average to fall below 1.00 before proceeding.