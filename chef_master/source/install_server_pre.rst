=====================================================
Chef Infra Server Prerequisites
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/install_server_pre.rst>`__

The following is a detailed discussion of the prerequisites for every installation of the Chef Infra Server. See `Install Chef Infra Server </install_server.html>` for installation instructions.

Platforms
=====================================================
.. tag adopted_platforms_server

The following table lists the commercially-supported platforms and versions for the Chef Infra Server:

.. list-table::
   :widths: 280 100 120
   :header-rows: 1

   * - Platform
     - Architecture
     - Version
   * - CentOS
     - ``x86_64``
     - ``6.x``, ``7.x``
   * - Oracle Enterprise Linux
     - ``x86_64``
     - ``6.x``, ``7.x``
   * - Red Hat Enterprise Linux
     - ``x86_64``, ``ppc64le`` (7.x only), ``ppc64`` (7.x only)
     - ``6.x``, ``7.x``
   * - SUSE Enterprise Linux Server
     - ``x86_64``
     - ``11 SP4``, ``12 SP1+``
   * - Ubuntu
     - ``x86_64``
     - ``16.04``, ``18.04``

.. end_tag

Untested Platforms
----------------------------------------------------
The following platforms are not tested by Chef Software:

* Any Linux or UNIX distribution that is not listed as a Foundational platform.
* Microsoft Windows
* 32-bit architectures



Capacity Planning
=====================================================
Read the `guidance around capacity planning </server_components.html#capacity-planning>`__ for information about how to choose the right topology for the Chef Infra Server.

Hardware Requirements
=====================================================
.. tag system_requirements_server_hardware

All machines in a Chef Infra Server deployment have the following hardware requirements. Disk space for standalone and backend servers should scale up with the number of nodes that the servers are managing. A good rule to follow is to allocate 2 MB per node. The disk values listed below should be a good default value that you will want to modify later if/when your node count grows. Fast, redundant storage (SSD/RAID-based solution either on-prem or in a cloud environment) is preferred.

**All Deployments**

* 64-bit architecture

**Standalone Deployments**

* 4 total cores (physical or virtual)
* 8 GB of RAM or more
* 5 GB of free disk space in ``/opt``
* 5 GB of free disk space in ``/var``

.. note:: The RAM requirement can be lowered down to a minimum of 4 GB of RAM if the number of Chef Infra Client runs (CCRs) per minute are low (i.e. less than 33 CCRs/min). See `Capacity Planning </server_components.html#capacity-planning>`_ for more information on how this metric affects scalability.

For a high availability deployment:

**General Requirements**

* Three backend servers; as many frontend servers as required
* 1 x GigE NIC interface (if on premises)

.. tag system_requirements_ha

**Frontend Requirements**

* 4 cores (physical or virtual)
* 4GB RAM
* 20 GB of free disk space (SSD if on premises, Premium Storage in Microsoft Azure, EBS-Optimized GP2 in AWS)

**Backend Requirements**

* 2 cores (physical or virtual)
* 8GB RAM
* 50 GB/backend server (SSD if on premises, Premium Storage in Microsoft Azure, EBS-Optimized GP2 in AWS)

.. warning:: The Chef Infra Server MUST NOT use a network file system of any type---virtual or physical---for backend storage. The Chef Infra Server database operates quickly. The behavior of operations, such as the writing of log files, will be unpredictable when run over a network file system.

.. end_tag

.. end_tag

Software Requirements
=====================================================
.. tag system_requirements_server_software

Before installing the Chef Infra Server, ensure that each machine has the following installed and configured properly:

* **Hostnames** --- Ensure that all systems have properly configured hostnames. The hostname for the Chef Infra Server must be a FQDN, have fewer than 64 characters including the domain suffix, be lowercase, and resolvable. See `Hostnames, FQDNs </install_server_pre.html#hostnames>`_ for more information
* **FQDNs** --- Ensure that all systems have a resolvable FQDN
* **NTP** --- Ensure that every server is connected to NTP; the Chef Infra Server is sensitive to clock drift
* **Mail Relay** --- The Chef Infra Server uses email to send notifications for various events; a local mail transfer agent should be installed and available to the Chef server
* **cron** --- Periodic maintenance tasks are performed using cron
* **git** --- git must be installed so that various internal services can confirm revisions
* **libfreetype and libpng** --- These libraries are required
* **Apache Qpid** --- This daemon must be disabled on CentOS and Red Hat systems
* **Required users** --- If the environment in which the Chef Infra Server will run has restrictions on the creation of local user and group accounts, ensure that the correct users and groups exist before reconfiguring
* **Firewalls and ports** --- If host-based firewalls (iptables, ufw, etc.) are being used, ensure that ports 80 and 443 are open. These ports are used by the **nginx** service

In addition:

* **Browser** --- Firefox, Google Chrome, Safari, or Internet Explorer (versions 9 or better)
* **Chef Infra Client communication with the Chef Infra Server** Every node that will be configured by the Chef Infra Client and every workstation that will upload data to the Chef Infra Server must be able to communicate with the Chef server

.. end_tag

UIDs and GIDs
-----------------------------------------------------
The installation process for the Chef Infra Server requires the use of at least two user and group identifiers (UIDs and GIDs). These are used to create the ``opscode`` and ``opscode-pgsql`` users and their default groups.

.. note:: The creation of required user and group identifiers is done **automatically** during the installation process for the Chef Infra Server; however, the following user and group accounts **may** be created in advance of installing the Chef Infra Server if specific UIDs and GIDs are preferred. The user **and** group must be created as a pair to satisfy reconfiguration requirements.

   * A local user account named ``opscode`` under which services will run
   * A local user account named ``opscode-pgsql`` that is used by PostgreSQL
   * A group account for each user account, one named ``opscode`` and the other named ``opscode-pgsql`` under which services will run

.. warning:: If the UID and GID of ``opscode`` and ``opscode-pgsql`` do not match on both backend Chef Infra Server machines, a high availability configuration will not run correctly.

   The embedded Chef Infra Server cookbooks can handle two cases:

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

   If the ``opscode`` and ``opscode-pgsql`` user and group identifiers exist prior to installing the Chef Infra Server, the Chef Infra Server installation process will use the existing identifiers instead of creating them.


Firewalls
-----------------------------------------------------

iptables
+++++++++++++++++++++++++++++++++++++++++++++++++++++
To allow access to your Chef Infra Server on ports 80 and 443 via the iptables firewall, issue the following command with root privileges:

.. code-block:: bash

   $ iptables -A INPUT -p tcp -m multiport --destination-ports 80,443 -j ACCEPT

Note that you will need to make use of a tool such as `iptables-persistent <https://packages.ubuntu.com/xenial/admin/iptables-persistent>`_ to restore your iptables rules upon reboot.

FirewallD
+++++++++++++++++++++++++++++++++++++++++++++++++++++
On RHEL and CentOS versions 7 and above, the FirewallD firewall is enabled by default. Issue the following command with root privileges to open ports 80 and 443:

.. code-block:: bash

   $ firewall-cmd --permanent --zone public --add-service http && firewall-cmd --permanent --zone public --add-service https && firewall-cmd --reload

UFW
+++++++++++++++++++++++++++++++++++++++++++++++++++++
While UFW is installed on Ubuntu, it is not enabled by default. However, if you wish to use a UFW-based firewall on your Chef Infra Server, issue the following command with root privileges to open ports 80 and 443:

.. code-block:: bash

   $ ufw allow proto tcp from any to any port 80,443

Security Modules
-----------------------------------------------------

SELinux
+++++++++++++++++++++++++++++++++++++++++++++++++++++
On CentOS and Red Hat Enterprise Linux systems, SELinux is enabled in enforcing mode by default. The Chef Infra Server does not have a profile available to run under SELinux. In order for the Chef Infra Server to run, SELinux must be disabled or set to ``Permissive`` mode.

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
+++++++++++++++++++++++++++++++++++++++++++++++++++++
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
On CentOS and Red Hat Enterprise Linux  systems, the Apache Qpid daemon is installed by default. The Chef Infra Server uses RabbitMQ for messaging. Because both Apache Qpid and RabbitMQ share the same protocol, Apache Qpid must be disabled.

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
Periodic maintenance tasks are performed on the Chef Infra Server servers via cron and the ``/etc/cron.d`` directory. With certain CentOS 6 configurations, an additional step is required to install crontab:

.. code-block:: bash

   $ yum install crontabs

Enterprise Linux Updates
-----------------------------------------------------
The Chef Infra Server requires an x86_64 compatible systems architecture. When the Chef Infra Server is installed on Red Hat Enterprise Linux or CentOS, run ``yum update`` prior to installing the Chef Infra Server. This will ensure those platforms are fully compatible with this requirement.

IP Addresses
-----------------------------------------------------
Unless you intend to operate the Chef Infra Server in IPv6 mode, you should disable ipv6 in the system's ``/etc/hosts`` file by commenting out or removing all references to IPv6 addresses like "::1" or "fe80:db8:85a3:8d3:1319:8a2e:370:7348".

Without these changes, a Chef Infra Server install intended to run in ipv4 mode will mistakenly only start the postgres service on the ipv6 loopback address of "::1" rather than the ipv4 loopback address of 127.0.0.1. This will make further progress through an initial reconfiguration impossible.

Hostnames
-----------------------------------------------------
The hostname for the Chef Infra Server may be specified using a FQDN or an IP address. This hostname must be resolvable, be 64 characters or less, and be lowercase. For example, a Chef Infra Server running in a production environment with a resolvable FQDN hostname can be added the DNS system. But when deploying Chef Infra Server into a testing environment, adding the hostname to the ``/etc/hosts`` file is enough to ensure that hostname is resolvable.

* **FQDN Hostnames** When the hostname for the Chef Infra Server is a FQDN be sure to include the domain suffix. For example, something like ``mychefserver.example.com`` (and not something like ``mychefserver``).
* **IP Address Hostnames** When the Chef Infra Server is run in IPv6 mode, a hostname specified using an IP address must also be bracketed (``[ ]``) or the Chef Infra Server will not be able to recognize it as an IPv6 address. For example:

   .. code-block:: ruby

      bookshelf['url'] "https://[2001:db8:85a3:8d3:1319:8a2e:370:7348]"

The ``api_fqdn`` setting can be added to the private-chef.rb file (it is not there by default). When added, its value should be equal to the FQDN or IP address for the service URI used by the Chef Infra Server. Then configure the same value for the ``bookshelf['vip']`` setting prior to installing the Chef Infra Server. For example: ``api_fqdn "chef.example.com"`` or ``api_fqdn 123.45.67.890``.

Configure Hostnames
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Use the following sections to verify the hostnames that is used by the Chef Infra Server.

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

In some cases, the hostname for the Chef Infra Server needs to be updated. The process for updating a hostname varies, depending on the platform on which the Chef Infra Server will run. Refer to the manual for the platform or contact a local systems administrator for specific guidance for a specific platform. The following example shows how a hostname can be changed when running Red Hat or CentOS:

.. code-block:: bash

   $ sudo hostname 'mychefserver.example.com'

and then:

.. code-block:: bash

   $ echo "mychefserver.example.com" | sudo tee /etc/hostname

**To add a hostname to /etc/hosts**

If a hostname is not resolvable, refer to a local systems administrator for specific guidance on how to add the hostname to the DNS system. If the Chef Infra Server is being into a testing environment, just add the hostname to ``/etc/hosts``. The following example shows how a hostname can be added to ``/etc/hosts`` when running Red Hat or CentOS:

.. code-block:: bash

   $ echo -e "127.0.0.2 `hostname` `hostname -s`" | sudo tee -a /etc/hosts
.. warning:: The FQDN for the Chef Infra Server should be resolvable, lowercase, and should not exceed 64 characters when using OpenSSL, as OpenSSL requires the ``CN`` in a certificate to be no longer than 64 characters.



Mail Relay
-----------------------------------------------------
The Chef Infra Server server uses email to send notifications for various events:

* Password resets
* User invitations
* Failover notifications
* Failed job notifications

Configure a local mail transfer agent on the Chef Infra Server using the steps appropriate for the platform on which the Chef Infra Server is running.

NTP
-----------------------------------------------------
The Chef Infra Server requires that the systems on which it is running be connected to Network Time Protocol (NTP), as the Chef Infra Server is particularly sensitive to clock drift. For Red Hat and CentOS 6:

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

Chef Infra Client
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The Chef Infra Server server requires that every node that is under management by Chef also have an accurate clock that is synchronized very closely with the clock on the Chef Infra Server. If the clocks are not synchronized closely, the authentication process may fail when the clocks are out-of-sync by more than 15 minutes. A failure will trigger a ``401 Unauthorized`` response similar to:

.. code-block:: bash

   [Tue, 01 Nov 2011 16:55:23 -0700] INFO: *** Chef 11.X.X ***
   [Tue, 01 Nov 2011 16:55:23 -0700] INFO: Client key /etc/chef/client.pem is not present - registering
   [Tue, 01 Nov 2011 16:55:24 -0700] INFO: HTTP Request Returned 401 Unauthorized:
       Failed to authenticate as ORGANIZATION-validator. Synchronize the clock on your host.
   [Tue, 01 Nov 2011 16:55:24 -0700] FATAL: Stacktrace dumped to /var/chef/cache/chef-stacktrace.out
   [Tue, 01 Nov 2011 16:55:24 -0700] FATAL: Net::HTTPServerException: 401 "Unauthorized"

In this situation, re-synchronize the system clocks with the Network Time Protocol (NTP) server, and then re-run the Chef Infra Client.

Required Accounts
-----------------------------------------------------
By default, accounts required by the Chef Infra Server are created during setup. If your environment has restrictions on the creation of local user and group accounts that will prevent these accounts from being created automatically during setup, you will need to create these accounts.

.. note:: The Chef Push Jobs feature of the Chef Infra Server use the same user and group accounts as the Chef Infra Server.

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
