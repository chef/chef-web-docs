=====================================================
Prerequisites
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/install_server_pre.rst>`__

The following prerequisites apply to every installation of the Chef server.

Platforms
=====================================================
.. tag adopted_platforms_server

The following table lists the Foundational platforms for the Chef server:

.. list-table::
   :widths: 280 100 120
   :header-rows: 1

   * - Platform
     - Architecture
     - Version
   * - CentOS
     -
     - ``5.x``, ``6.x``, ``7.x``
   * - Oracle Linux
     -
     - ``5.x``, ``6.x``
   * - Red Hat Enterprise Linux
     -
     - ``5.x``, ``6.x``, ``7.x``
   * - SUSE Enterprise Linux Server
     - ``x86_64``, ``s390x``
     - ``11 SP4``, ``12 SP1``
   * - Ubuntu
     -
     - ``12.04``, ``14.04``, ``16.04``

.. end_tag

Untested Platforms
-----------------------------------------------------
.. tag adopted_platforms_server_other

The following platforms are not tested by Chef Software:

* Any Linux or UNIX distribution that is not listed as a Foundational platform.
* Microsoft Windows
* 32-bit architectures

.. end_tag

Capacity Planning
=====================================================
Read the `guidance around capacity planning </server_components.html#capacity-planning>`__ for information about how to choose the right toplogy for the Chef server.

Software Requirements
=====================================================
.. tag system_requirements_server_software

Before installing the Chef server, ensure that each machine has the following installed and configured properly:

* **Hostnames** --- Ensure that all systems have properly configured hostnames. The hostname for the Chef server must be a FQDN, including the domain suffix, and must be resolvable. See `Hostnames, FQDNs </install_server_pre.html#hostnames>`_ for more information
* **FQDNs** --- Ensure that all systems have a resolvable FQDN
* **NTP** --- Ensure that every server is connected to NTP; the Chef server is sensitive to clock drift
* **Mail Relay** --- The Chef server uses email to send notifications for various events; a local mail transfer agent should be installed and available to the Chef server
* **cron** --- Periodic maintenance tasks are performed using cron
* **git** --- git must be installed so that various internal services can confirm revisions
* **libfreetype and libpng** --- These libraries are required
* **Apache Qpid** --- This daemon must be disabled on CentOS and Red Hat systems
* **Required users** --- If the environment in which the Chef server will run has restrictions on the creation of local user and group accounts, ensure that the correct users and groups exist before reconfiguring
* **Firewalls and ports** --- If host-based firewalls (iptables, ufw, etc.) are being used, ensure that ports 80 and 443 are open. These ports are used by the **nginx** service
* **Hostname** --- The hostname for the Chef server must be a FQDN, including the domain suffix, and must be resolvable. See `Hostnames, FQDNs </install_server_pre.html#hostnames>`_ for more information

In addition:

* **Browser** --- Firefox, Google Chrome, Safari, or Internet Explorer (versions 9 or better)
* **chef-client communication with the Chef server** Every node that will be configured by the chef-client and every workstation that will upload data to the Chef server must be able to communicate with the Chef server

.. end_tag

Hardware Requirements
=====================================================
.. tag system_requirements_server_hardware

All machines in a Chef server deployment have the following hardware requirements. Disk space for standalone and backend servers should scale up with the number of nodes that the servers are managing. A good rule to follow is to allocate 2 MB per node. The disk values listed below should be a good default value that you will want to modify later if/when your node count grows. Fast, redundant storage (SSD/RAID-based solution either on-prem or in a cloud environment) is preferred.

For all deployments:

* 64-bit architecture

For a standalone deployment:

* 4 total cores (physical or virtual)
* 8 GB of RAM or more
* 5 GB of free disk space in ``/opt``
* 5 GB of free disk space in ``/var``

.. note:: The RAM requirement can be lowered down to a minimum of 4 GB of RAM if the number of Chef client runs (CCRs) per minute are low (i.e. less than 33 CCRs/min). See `Capacity Planning </server_components.html#capacity-planning>`_ for more information on how this metric affects scalability.

For a high availability deployment:

General requirements

* Three backend servers; as many frontend servers as required
* 1 x GigE NIC interface (if on premises)

.. tag system_requirements_ha

Frontend requirements

* 4 cores (physical or virtual)
* 4GB RAM
* 20 GB of free disk space (SSD if on premises, Premium Storage in Microsoft Azure, EBS-Optimized GP2 in AWS)

Backend requirements

* 2 cores (physical or virtual)
* 8GB RAM
* 50 GB/backend server (SSD if on premises, Premium Storage in Microsoft Azure, EBS-Optimized GP2 in AWS)

.. warning:: The Chef server MUST NOT use a network file system of any type---virtual or physical---for backend storage. The Chef server database operates quickly. The behavior of operations, such as the writing of log files, will be unpredictable when run over a network file system.

.. end_tag

.. end_tag

UIDs and GIDs
-----------------------------------------------------
The installation process for the Chef server requires the use of at least two user and group identifiers (UIDs and GIDs). These are used to create the ``opscode`` and ``opscode-pgsql`` users and their default groups.

.. note:: The creation of required user and group identifiers is done **automatically** during the installation process for the Chef server; however, the following user and group accounts **may** be created in advance of installing the Chef server if specific UIDs and GIDs are preferred. The user **and** group must be created as a pair to satisfy reconfiguration requirements.

   * A local user account named ``opscode`` under which services will run
   * A local user account named ``opscode-pgsql`` that is used by PostgreSQL
   * A group account for each user account, one named ``opscode`` and the other named ``opscode-pgsql`` under which services will run

.. warning:: If the UID and GID of ``opscode`` and ``opscode-pgsql`` do not match on both backend Chef server machines, a high availability configuration will not run correctly.

   The embedded Chef server cookbooks can handle two cases:

   * Both ``opscode`` and ``opscode-pgsql`` user and group not found on the new server
   * Both ``opscode`` and ``opscode-pgsql`` user and group found on the new server

   Having only the group and not the corresponding users present during a chef-server-ctl reconfigure is unsupported and may lead to an error in the reconfiguration run.

   To determine the current range of IDs, run the following command:

   .. code-block:: bash

      $ grep -E '(UID|GID)' /etc/login.defs

   The defaults for CentOS and Red Hat Enterprise Linux systems look like this:

   .. code-block:: bash

      UID_MIN             500
      UID_MAX           60000
      GID_MIN             500
      GID_MAX           60000

   If the defaults have been changed for any reason, and if that change would result in less than 2 UID/GIDs being available to the ``useradd`` program, edit ``/etc/login.defs`` with changes to make at least 2 more UIDs and GIDs available for association. The currently used ID ranges for UIDs and GIDs can be found in ``/etc/passwd`` and ``/etc/group``, respectively.

   If the ``opscode`` and ``opscode-pgsql`` user and group identifiers exist prior to installing the Chef server, the Chef server installation process will use the existing identifiers instead of creating them.

SELinux
-----------------------------------------------------
On CentOS and Red Hat Enterprise Linux systems, SELinux is enabled in enforcing mode by default. The Chef server does not have a profile available to run under SELinux. In order for the Chef server to run, SELinux must be disabled or set to ``Permissive`` mode.

To determine if SELinux is installed, run the following command:

.. code-block:: bash

   $ getenforce

If a response other than ``"Disabled"`` or ``"Permissive"`` is returned, SELinux must be disabled.

To set SELinux to ``Permissive`` mode, run:

.. code-block:: bash

   $ setenforce Permissive

and then check the status:

.. code-block:: bash

   $ getenforce

AppArmor
-----------------------------------------------------
On Ubuntu systems, AppArmor is enabled in enforcing mode by default. Chef products do not have a profile available to run under AppArmor. In order for the Chef products to run, AppArmor must set to ``Complaining`` mode or disabled.

To determine if AppArmor is installed, run the following command:

.. code-block:: bash

   $ sudo apparmor_status

To install AppArmor, run the following command:

.. code-block:: bash

   $ sudo apt-get install apparmor-utils —yes

If a response other than ``"0 processes are in enforce mode"`` or ``"0 profiles are in enforce mode."`` is returned, AppArmor must be set to ``Complaining`` mode or disabled.

To set AppArmor to ``Complaining`` mode, run:

.. code-block:: bash

   $ sudo aa-complain /etc/apparmor.d/*

Or to disable AppArmor entirely, run:

.. code-block:: bash

   $ sudo invoke-rc.d apparmor kill
   $ sudo update-rc.d -f apparmor remove

and then check the status:

.. code-block:: bash

   $ sudo apparmor_status

Apache Qpid
-----------------------------------------------------
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

cron
-----------------------------------------------------
Periodic maintenance tasks are performed on the Chef server servers via cron and the ``/etc/cron.d`` directory. With certain CentOS 6 configurations, an additional step is required to install crontab:

.. code-block:: bash

   $ yum install crontabs

Enterprise Linux Updates
-----------------------------------------------------
The Chef server requires an x86_64 compatible systems architecture. When the Chef server is installed on Red Hat Enterprise Linux or CentOS, run ``yum update`` prior to installing the Chef server. This will ensure those platforms are fully compatible with this requirement.

IP Addresses
-----------------------------------------------------
Unless you intend to operate the Chef server in IPv6 mode, you should disable ipv6 in the system's ``/etc/hosts`` file by commenting out or removing all references to IPv6 addresses like "::1" or "fe80:db8:85a3:8d3:1319:8a2e:370:7348".

Without these changes, a Chef server install intended to run in ipv4 mode will mistakenly only start the postgres service on the ipv6 loopback address of "::1" rather than the ipv4 loopback address of 127.0.0.1. This will make further progress through an initial reconfiguration impossible.

Hostnames
-----------------------------------------------------
The hostname for the Chef server may be specified using a FQDN or an IP address. This hostname must be resolvable. For example, a Chef server running in a production environment with a resolvable FQDN hostname can be added the DNS system. But when deploying Chef server into a testing environment, adding the hostname to the ``/etc/hosts`` file is enough to ensure that hostname is resolvable.

* **FQDN Hostnames** When the hostname for the Chef server is a FQDN be sure to include the domain suffix. For example, something like ``mychefserver.example.com`` (and not something like ``mychefserver``).
* **IP Address Hostnames** When the Chef server is run in IPv6 mode, a hostname specified using an IP address must also be bracketed (``[ ]``) or the Chef server will not be able to recognize it as an IPv6 address. For example:

   .. code-block:: ruby

      bookshelf['url'] "https://[2001:db8:85a3:8d3:1319:8a2e:370:7348]"

The ``api_fqdn`` setting can be added to the private-chef.rb file (it is not there by default). When added, its value should be equal to the FQDN or IP address for the service URI used by the Chef server. Then configure the same value for the ``bookshelf['vip']`` setting prior to installing the Chef server. For example: ``api_fqdn "chef.example.com"`` or ``api_fqdn 123.45.67.890``.

Configure Hostnames
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Use the following sections to verify the hostnames that is used by the Chef server.

**To verify if a hostname is a FQDN**

To verify if a hostname is a FQDN, run the following command:

.. code-block:: bash

   $ hostname

If the hostname is a FQDN, it will return something like:

.. code-block:: bash

   $ mychefserver.example.com

If the hostname is not a FQDN, it must be configured so that it is one.

**To verify the FQDN is all lowercase**

To verify if the alphabetic parts of a FQDN are all lowercase, run the following command:

.. code-block:: bash

   $ hostname -f | grep -E '^([[:digit:]]|[[:lower:]]|\.|-|_)+$' && echo yes

If the hostname is all lowercase, it will return something like:

.. code-block:: bash

   mychefserver.example.com
   yes

If the hostname's alphabetic parts are not all lowercase, it must be configured so that they are.

**To verify a hostname is resolvable**

To verify is a hostname is resolvable, run the following command:

.. code-block:: bash

   $ hostname -f

If the hostname is resolvable, it will return something like:

.. code-block:: bash

   $ mychefserver.example.com

**To change a hostname**

In some cases, the hostname for the Chef server needs to be updated. The process for updating a hostname varies, depending on the platform on which the Chef server will run. Refer to the manual for the platform or contact a local systems administrator for specific guidance for a specific platform. The following example shows how a hostname can be changed when running Red Hat or CentOS:

.. code-block:: bash

   $ sudo hostname 'mychefserver.example.com'

and then:

.. code-block:: bash

   $ echo "mychefserver.example.com" | sudo tee /etc/hostname

**To add a hostname to /etc/hosts**

If a hostname is not resolvable, refer to a local systems administrator for specific guidance on how to add the hostname to the DNS system. If the Chef server is being into a testing environment, just add the hostname to ``/etc/hosts``. The following example shows how a hostname can be added to ``/etc/hosts`` when running Red Hat or CentOS:

.. code-block:: bash

   $ echo -e "127.0.0.2 `hostname` `hostname -s`" | sudo tee -a /etc/hosts

Chef Analytics
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The hostname for the Chef Analytics server may be specified using a FQDN or an IP address. This hostname must be resolvable. For example, a Chef Analytics server that is running in a production environment with a resolvable FQDN hostname can be added in the DNS system. But when deploying Chef Analytics into a testing environment, adding the hostname to the ``/etc/hosts`` file is enough to ensure that hostname is resolvable.

* **FQDN Hostnames** When the hostname for the Chef Analytics server is a FQDN be sure to include the domain suffix. For example, something like ``myanalyticsserver.example.com`` (and not something like ``myanalyticsserver``).

The ``analytics_fqdn`` setting must be added to the opscode-analytics.rb file (it is not there by default). Its value should be equal to the FQDN or IP address for the service URI used by the Chef Analytics server. For example: ``analytics_fqdn "chef-analytics.example.com"`` or ``analytics_fqdn 123.45.67.890``.

.. warning:: The FQDN for the Chef Analytics server should not exceed 64 characters when using OpenSSL. OpenSSL requires the ``CN`` in a certificate to be no longer than 64 characters. By default, Chef Analytics uses the FQDN of the server to determine the common name (``CN``). If the FQDN of the Chef Analytics server is longer than 64 characters, the ``chef-server-ctl reconfigure`` command will not fail, but an empty certificate file will be created. Nginx will not start if a certificate file is empty.

Mail Relay
-----------------------------------------------------
The Chef server server uses email to send notifications for various events:

* Password resets
* User invitations
* Failover notifications
* Failed job notifications

Configure a local mail transfer agent on the Chef server using the steps appropriate for the platform on which the Chef server is running.

NTP
-----------------------------------------------------
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

chef-client
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The Chef server server requires that every node that is under management by Chef also have an accurate clock that is synchronized very closely with the clock on the Chef server. If the clocks are not synchronized closely, the authentication process may fail when the clocks are out-of-sync by more than 15 minutes. A failure will trigger a ``401 Unauthorized`` response similar to:

.. code-block:: bash

   [Tue, 01 Nov 2011 16:55:23 -0700] INFO: *** Chef 11.X.X ***
   [Tue, 01 Nov 2011 16:55:23 -0700] INFO: Client key /etc/chef/client.pem is not present - registering
   [Tue, 01 Nov 2011 16:55:24 -0700] INFO: HTTP Request Returned 401 Unauthorized:
       Failed to authenticate as ORGANIZATION-validator. Synchronize the clock on your host.
   [Tue, 01 Nov 2011 16:55:24 -0700] FATAL: Stacktrace dumped to /var/chef/cache/chef-stacktrace.out
   [Tue, 01 Nov 2011 16:55:24 -0700] FATAL: Net::HTTPServerException: 401 "Unauthorized"

In this situation, re-synchronize the system clocks with the Network Time Protocol (NTP) server, and then re-run the chef-client.

Required Accounts
-----------------------------------------------------
By default, accounts required by the Chef server are created during setup. If your environment has restrictions on the creation of local user and group accounts that will prevent these accounts from being created automatically during setup, you will need to create these accounts.

.. note:: The Chef push jobs and Reporting premium features of the Chef server use the same user and group accounts as the Chef server.

Group Accounts
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following group accounts are required:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Group Account
     - Description
   * - ``opscode``
     - The group name under which services will run.

User Accounts
+++++++++++++++++++++++++++++++++++++++++++++++++++++
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
