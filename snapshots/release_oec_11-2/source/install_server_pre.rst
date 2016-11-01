

=====================================================
Prerequisites
=====================================================

The following prerequisites apply to every installation of the Chef server.

Apache Qpid
=====================================================
.. tag install_common_apache_qpid

On CentOS and Red Hat Enterprise Linux  systems, the Apache Qpid daemon is installed by default. The Chef server uses RabbitMQ for messaging. Because both Apache Qpid and RabbitMQ share the same protocol, Apache Qpid must be disabled.

To determine if Apache Qpid is installed, run the following command:

.. code-block:: bash

   $ rpm -qa | grep qpid

If Apache Qpid is installed, a response similar to the following is displayed:

.. code-block:: bash

   $ qpid-cpp-server-0.12-6.el6.x86_64

To disable Apache Qpid run:

.. code-block:: bash

   $ service qpidd stop

and then:

.. code-block:: bash

   $ chkconfig --del qpidd

.. end_tag

cron
=====================================================
.. tag install_common_cron

Periodic maintenance tasks are performed on the Chef server servers via cron and the ``/etc/cron.d`` directory. With certain CentOS 6 configurations, an additional step is required to install crontab:

.. code-block:: bash

   $ yum install crontabs

.. end_tag

Enterprise Linux Platform Updates
=====================================================
.. tag install_common_enterprise_linux_platform_updates

The Chef server requires an x86_64 compatible systems architecture. When the Chef server is installed on Red Hat Enterprise Linux or CentOS, run ``yum update`` prior to installing the Chef server. This will ensure those platforms are fully compatible with this requirement.

.. end_tag

Hostnames
=====================================================
.. tag install_common_hostname

The hostname for the Chef server may be specified using a FQDN or an IP address. This hostname must be resolvable. For example, a Chef server running in a production environment with a resolvable FQDN hostname can be added the DNS system. But when deploying Chef server into a testing environment, adding the hostname to the ``/etc/hosts`` file is enough to ensure that hostname is resolvable.

* **FQDN Hostnames** When the hostname for the Chef server is a FQDN be sure to include the domain suffix. For example, something like ``mychefserver.example.com`` (and not something like ``mychefserver``).
* **IP Address Hostnames** When the Chef server is run in IPv6 mode, a hostname specified using an IP address must also be bracketed (``[ ]``) or the Chef server will not be able to recognize it as an IPv6 address. For example:

   .. code-block:: ruby

      bookshelf['url'] "https://[2001:db8:85a3:8d3:1319:8a2e:370:7348]"

The ``api_fqdn`` setting can be added to the private-chef.rb file (it is not there by default). When added, its value should be equal to the FQDN or IP address for the service URI used by the Chef server. Then configure the same value for the ``bookshelf['vip']`` setting prior to installing the Chef server. For example: ``api_fqdn "chef.example.com"`` or ``api_fqdn 123.45.67.890``.

.. end_tag

.. warning:: The FQDN for the Chef Analytics server should not exceed 64 characters when using OpenSSL. OpenSSL requires the ``CN`` in a certificate to be no longer than 64 characters. By default, Chef Analytics uses the FQDN of the server to determine the common name (``CN``). If the FQDN of the Chef Analytics server is longer than 64 characters, the ``private-chef-ctl reconfigure`` command will not fail, but an empty certificate file will be created. Nginx will not start if a certificate file is empty.

**To verify if a hostname is a FQDN**

.. tag install_common_hostname_is_fqdn

To verify if a hostname is a FQDN, run the following command:

.. code-block:: bash

   $ hostname

If the hostname is a FQDN, it will return something like:

.. code-block:: bash

   $ mychefserver.example.com

If the hostname is not a FQDN, it must be configured so that it is one.

.. end_tag

**To verify is a hostname is resolvable**

.. tag install_common_hostname_is_resolvable

To verify is a hostname is resolvable, run the following command:

.. code-block:: bash

   $ hostname -f

If the hostname is resolvable, it will return something like:

.. code-block:: bash

   $ mychefserver.example.com

.. end_tag

**To change a hostname**

.. tag install_common_hostname_edit

In some cases, the hostname for the Chef server needs to be updated. The process for updating a hostname varies, depending on the platform on which the Chef server will run. Refer to the manual for the platform or contact a local systems administrator for specific guidance for a specific platform. The following example shows how a hostname can be changed when running Red Hat or CentOS:

.. code-block:: bash

   $ sudo hostname 'mychefserver.example.com'

and then:

.. code-block:: bash

   $ echo "mychefserver.example.com" | sudo tee /etc/hostname

.. end_tag

**To add a hostname to /etc/hosts**

.. tag install_common_hostname_add_to_etc_hosts

If a hostname is not resolvable, refer to a local systems administrator for specific guidance on how to add the hostname to the DNS system. If the Chef server is being into a testing environment, just add the hostname to ``/etc/hosts``. The following example shows how a hostname can be added to ``/etc/hosts`` when running Red Hat or CentOS:

.. code-block:: bash

   $ echo -e "127.0.0.2 `hostname` `hostname -s`" | sudo tee -a /etc/hosts

.. end_tag

Mail Relay
=====================================================
.. tag install_common_mail_relay

The Chef server server uses email to send notifications for various events:

* Password resets
* User invitations
* Failover notifications
* Failed job notifications

Configure a local mail transfer agent on the Chef server using the steps appropriate for the platform on which the Chef server is running.

.. end_tag

NTP
=====================================================
.. tag install_common_ntp

The Chef server requires that the systems on which it is running be connected to Network Time Protocol (NTP), as the Chef server is particularly sensitive to clock drift. For Red Hat and CentOS 6:

.. code-block:: bash

   $ yum install ntp

or:

.. code-block:: bash

   $ chkconfig ntpd on

or:

.. code-block:: bash

   $ service ntpd start

For Ubuntu:

.. code-block:: bash

   $ apt-get install ntp

.. end_tag

chef-client
-----------------------------------------------------
.. tag install_common_ntp_chef_client

The Chef server server requires that every node that is under management by Chef also have an accurate clock that is synchronized very closely with the clock on the Chef server. If the clocks are not synchronized closely, the authentication process may fail when the clocks are out-of-sync by more than 15 minutes. A failure will trigger a ``401 Unauthorized`` response similar to:

.. code-block:: bash

   [Tue, 01 Nov 2011 16:55:23 -0700] INFO: *** Chef 11.X.X ***
   [Tue, 01 Nov 2011 16:55:23 -0700] INFO: Client key /etc/chef/client.pem is not present - registering
   [Tue, 01 Nov 2011 16:55:24 -0700] INFO: HTTP Request Returned 401 Unauthorized: 
       Failed to authenticate as ORGANIZATION-validator. Synchronize the clock on your host.
   [Tue, 01 Nov 2011 16:55:24 -0700] FATAL: Stacktrace dumped to /var/chef/cache/chef-stacktrace.out
   [Tue, 01 Nov 2011 16:55:24 -0700] FATAL: Net::HTTPServerException: 401 "Unauthorized"

In this situation, re-synchronize the system clocks with the Network Time Protocol (NTP) server, and then re-run the chef-client.

.. end_tag

Required Accounts
=====================================================
.. tag install_common_required_accounts

By default, accounts required by the Chef server are created during setup. If your environment has restrictions on the creation of local user and group accounts that will prevent these accounts from being created automatically during setup, you will need to create these accounts.

.. note:: The Chef push jobs and Reporting premium features of the Chef server use the same user and group accounts as the Chef server.

.. end_tag

Group Accounts
-----------------------------------------------------
.. tag install_common_required_accounts_group

The following group accounts are required:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Group Account
     - Description
   * - ``opscode``
     - The group name under which services will run.

.. end_tag

User Accounts
-----------------------------------------------------
.. tag install_common_required_accounts_user

The following user accounts are required:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - User Account
     - Description
   * - ``opscode``
     - The user name under which services will run.
   * - ``opscode-pgsql``
     - The user name for PostgreSQL. (This is only required on the back end servers in a high availability setup.)

.. end_tag

