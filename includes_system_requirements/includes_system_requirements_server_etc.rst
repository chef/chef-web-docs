.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Before installing the |chef server|, ensure that each machine has the following installed and configured properly:

* **Hostnames** --- Ensure that all systems have properly configured hostnames. The hostname for the |chef server| must be a |fqdn|, including the domain suffix, and must be resolvable. See `Hostnames, FQDNs <https://docs.chef.io/install_server_pre.html#about-the-hostname>`_ for more information
* **FQDNs** --- Ensure that all systems have a resolvable |fqdn|
* **NTP** --- Ensure that every server is connected to NTP; the |chef server| is sensitive to clock drift
* **Mail Relay** --- The |chef server| uses email to send notifications for various events; a local mail transfer agent should be installed and available to the |chef server|
* **cron** --- Periodic maintenance tasks are performed using |cron|
* **git** --- |git| must be installed so that various internal services can confirm revisions
* **libfreetype and libpng** --- These libraries are required
* **Apache Qpid** --- This daemon must be disabled on |centos| and |redhat| systems
* **Required users** --- If the environment in which the |chef server| will run has restrictions on the creation of local user and group accounts, ensure that the correct users and groups exist before reconfiguring
* **Firewalls and ports** --- If host-based firewalls (iptables, ufw, etc.) are being used, ensure that ports 80 and 443 are open. These ports are used by the |service nginx| service
* **Hostname** --- The hostname for the |chef server| must be a |fqdn|, including the domain suffix, and must be resolvable. See `Hostnames, FQDNs <https://docs.chef.io/install_server_pre.html#about-the-hostname>`_ for more information

In addition:

* **Browser** --- |firefox|, |google chrome|, |apple safari|, or |microsoft ie| (versions 9 or better)
* **chef-client communication with the Chef server** Every node that will be configured by the |chef client| and every workstation that will upload data to the |chef server| must be able to communicate with the |chef server|
