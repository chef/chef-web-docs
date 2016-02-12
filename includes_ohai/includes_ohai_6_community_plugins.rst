.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following |ohai| plugins are available from the |chef| community:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Plugin
     - Description
   * - `chef-ohai-mdadm <https://github.com/tas50/chef-ohai-mdadm>`_
     - Adds output for |mdadm| software |raid| volumes.
   * - `dell.rb <https://github.com/demonccc/chef-repo/blob/master/plugins/ohai/dell.rb>`_
     - Adds some useful Dell server information to |ohai|. For example: service tag, express service code, storage info, RAC info, and so on. To use this plugin, OMSA and SMBIOS applications need to be installed.
   * - `dpkg.rb <https://github.com/demonccc/chef-repo/blob/master/plugins/ohai/linux/dpkg.rb>`_
     - Adds |debian dpkg| info to |ohai| so that information about the status of |debian| packages and various installed packages can be collected.
   * - `ipmi.rb <https://bitbucket.org/retr0h/ohai>`_
     - Adds a |mac address| and an IP address to |ohai|, where available.
   * - `kvm_extensions.rb <https://github.com/albertsj1/ohai-plugins/blob/master/kvm_extensions.rb>`_
     - Adds extensions for virtualization attributes to provide additional host and guest information for |kvm|.
   * - `ladvd.rb <https://github.com/demonccc/chef-repo/blob/master/plugins/ohai/linux/ladvd.rb>`_
     - Adds |ladvd| information to |ohai|, when it exists.
   * - `lxc_virtualization.rb <https://github.com/jespada/ohai-plugins/blob/master/lxc_virtualization.rb>`_
     - Adds extensions for virtualization attributes to provide host and guest information for |linux| containers.
   * - `network_ports.rb <https://github.com/agoddard/ohai-plugins/blob/master/plugins/network_ports.rb>`_
     - Adds extensions for network attributes so that |ohai| can detect to which interfaces TCP and UDP ports are bound.
   * - `parse_host_plugin.rb <https://github.com/sbates/Chef-odds-n-ends/blob/master/ohai/parse_host_plugin.rb>`_
     - Adds the ability to parse a host name using three top-level attribute and five nested attributes.
   * - `sysctl.rb <https://github.com/spheromak/cookbooks/blob/master/ohai/files/default/sysctl.rb>`_
     - Adds |sysctl| information to |ohai|.
   * - `vserver.rb <https://github.com/albertsj1/ohai-plugins/blob/master/vserver.rb>`_
     - Adds extensions for virtualization attributes to allow a |linux| virtual server host and guest information to be used by |ohai|.
   * - `wtf.rb <https://github.com/cloudant/ohai_plugins/blob/master/wtf.rb>`_
     - Adds the irreverent wtfismyip.com service so that |ohai| can determine a machine's external IPv4 address and geographical location.
   * - `xenserver.rb <https://github.com/spheromak/cookbooks/blob/master/ohai/files/default/xenserver.rb>`_
     - Adds extensions for virtualization attributes to load up |xenserver| host and guest information.
   * - `win32_software.rb <https://github.com/timops/ohai-plugins/blob/master/win32_software.rb>`_
     - Adds the ability for |ohai| to use |windows wmi| to discover useful information about software that is installed on any node that is running |windows|.
   * - `win32_svc.rb <https://github.com/timops/ohai-plugins/blob/master/win32_svc.rb>`_
     - Adds the ability for |ohai| to query using |windows wmi| to get information about all services that are registered on a node that is running |windows|.