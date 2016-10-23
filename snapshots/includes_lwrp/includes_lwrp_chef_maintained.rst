.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Chef maintains a collection of cookbooks that define some common scenarios and provides resources to support them. These cookbooks are located at https://github.com/chef-cookbooks. To use these resources within recipes, first download the cookbook. Then add those resources to recipes.

Some of the most popular Chef-maintained cookbooks are listed below:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Cookbook
     - Description
   * - `apt <https://github.com/chef-cookbooks/apt>`_
     - The ``apt`` cookbook is used to configure Apt and Apt services, for managing Apt repositories and preferences.
   * - `aws <https://github.com/chef-cookbooks/aws>`_
     - The ``aws`` cookbook is used to manage resources that are running in Amazon Web Services (AWS).
   * - `bluepill <https://github.com/chef-cookbooks/bluepill>`_
     - The ``bluepill`` cookbook is used to install Blue Pill, and then use it to manage services.
   * - `chef_handler <https://docs.chef.io/resource_chef_handler.html>`_
     - The **chef_handler** cookbook is used to distribute and enable exception and report handlers. This cookbook also exposes the **chef_handler** resource, which allows exception and report handlers to be exposed from within recipes, as opposed to having them hard-coded within the client.rb file.
   * - `cron <https://github.com/chef-cookbooks/cron>`_
     - Use to install cron and start the crond service.
   * - `dmg <https://github.com/chef-cookbooks/dmg>`_
     - The ``dmg`` cookbook is used to create a DMG package for use with Mac OS X.
   * - `dynect <https://github.com/chef-cookbooks/dynect>`_
     - The ``dynect`` cookbook is used to manage DNS records using the DynECT REST API.
   * - `firewall <https://github.com/chef-cookbooks/firewall>`_
     - The ``firewall`` cookbook is used to manage firewalls and their associated firewall rulesets.
   * - `freebsd <https://github.com/chef-cookbooks/freebsd>`_
     - The ``freebsd`` cookbook is used to manage port options for FreeBSD.
   * - `gunicorn <https://github.com/chef-cookbooks/gunicorn>`_
     - Gunicorn is a web service gateway interface server for UNIX that is a pre-fork worker model from the Ruby Unicorn project. The ``gunicorn`` cookbook is used to install and configure Gunicorn.
   * - `homebrew <https://github.com/chef-cookbooks/homebrew>`_
     - The ``homebrew`` cookbook is used to install and configure Homebrew for use as the package manager for Mac OS X.
   * - `iis <https://github.com/chef-cookbooks/iis>`_
     - The ``iis`` cookbook is used to install and configure Internet Information Services (IIS).
   * - `lvm <https://github.com/chef-cookbooks/lvm>`_
     - Use to install the ``lvm2`` package, and then manage logical volume manager (LVM).
   * - `maven <https://github.com/chef-cookbooks/maven>`_
     - The ``maven`` cookbook is used to install and configure Apache Maven.
   * - `openssh <https://github.com/chef-cookbooks/openssh>`_
     - The ``openssh`` cookbook is used to install OpenSSH.
   * - `omnibus <https://github.com/chef-cookbooks/omnibus>`_
     - Use to prepare a machine to be an Omnibus builder.
   * - `php <https://github.com/chef-cookbooks/php>`_
     - The ``php`` cookbook is used to install and configure PHP and PHP modules.
   * - `postfix <https://github.com/chef-cookbooks/postfix>`_
     - Use to install and configure postfix for client or outbound relayhost.
   * - `powershell <https://github.com/chef-cookbooks/powershell>`_
     - Use to run Windows PowerShell. See the `powershell_script resource <https://docs.chef.io/resource_powershell_script.html>`__ (built into the chef-client) for more information about improved ways to run Windows PowerShell when using Chef.
   * - `squid <https://github.com/chef-cookbooks/squid>`_
     - Use to configure squid as a caching proxy.
   * - `sudo <https://github.com/chef-cookbooks/sudo>`_
     - The ``sudo`` cookbook is used to install sudo and configure ``/etc/sudoers``.
   * - `transmission <https://github.com/chef-cookbooks/transmission>`_
     - The ``transmission`` cookbook is used to install and configure the Transmission BitTorrent client.
   * - `webpi <https://github.com/chef-cookbooks/webpi>`_
     - The ``webpi`` cookbook is used to run the Microsoft Web Platform Installer (WebPI).
   * - `windows <https://github.com/chef-cookbooks/windows>`_
     - The ``windows`` cookbook is used to configure auto run, batch, reboot, enable built-in operating system packages, configure Microsoft Windows packages, reboot machines, and more.
   * - `yum <https://github.com/chef-cookbooks/yum>`_
     - The ``yum`` cookbook is used to manage the contents of the ``yum.conf`` configuration file for global Yum configurations and for individual Yum repositories.
