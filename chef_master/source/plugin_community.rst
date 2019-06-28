=====================================================
Community Plugins
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/plugin_community.rst>`__

This page lists plugins for Ohai plugins and Chef Infra Client handlers that are developed and maintained by the Chef community.

Ohai
=====================================================
.. tag ohai_summary

Ohai is a tool that is used to collect system configuration data, which is provided to the Chef Infra Client for use within cookbooks. Ohai is run by the Chef Infra Client at the beginning of every Chef run to determine system state. Ohai includes many built-in plugins to detect common configuration details as well as a plugin model for writing custom plugins.

The types of attributes Ohai collects include but are not limited to:

* Operating System
* Network
* Memory
* Disk
* CPU
* Kernel
* Host names
* Fully qualified domain names
* Virtualization
* Cloud provider metadata

Attributes that are collected by Ohai are automatic level attributes, in that these attributes are used by the Chef Infra Client to ensure that these attributes remain unchanged after the Chef Infra Client is done configuring the node.

.. end_tag

The following Ohai plugins are available from the open source community:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Plugin
     - Description
   * - `dell.rb <https://github.com/demonccc/chef-ohai-plugins/blob/master/dell.rb>`_
     - Adds some useful Dell server information to Ohai. For example: service tag, express service code, storage info, RAC info, and so on. To use this plugin, OMSA and SMBIOS applications need to be installed.
   * - `ipmi.rb <https://bitbucket.org/retr0h/ohai>`_
     - Adds a MAC address and an IP address to Ohai, where available.
   * - `kvm_extensions.rb <https://github.com/albertsj1/ohai-plugins/blob/master/kvm_extensions.rb>`_
     - Adds extensions for virtualization attributes to provide additional host and guest information for KVM.
   * - `ladvd.rb <https://github.com/demonccc/chef-ohai-plugins/blob/master/linux/ladvd.rb>`_
     - Adds ladvd information to Ohai, when it exists.
   * - `lxc_virtualization.rb <https://github.com/jespada/ohai-plugins/blob/master/lxc_virtualization.rb>`_
     - Adds extensions for virtualization attributes to provide host and guest information for Linux containers.
   * - `network_addr.rb <https://gist.github.com/1040543>`_
     - Adds extensions for network attributes with additional ``ipaddrtype_iface`` attributes to make it semantically easier to retrieve addresses.
   * - `network_ports.rb <https://github.com/agoddard/ohai-plugins/blob/master/plugins/network_ports.rb>`_
     - Adds extensions for network attributes so that Ohai can detect to which interfaces TCP and UDP ports are bound.
   * - `parse_host_plugin.rb <https://github.com/sbates/Chef-odds-n-ends/blob/master/ohai/parse_host_plugin.rb>`_
     - Adds the ability to parse a host name using three top-level attribute and five nested attributes.
   * - `r.rb <https://github.com/stevendanna/ohai-plugins/blob/master/plugins/r.rb>`_
     - Adds the ability to collect basic information about the R Project.
   * - `sysctl.rb <https://github.com/spheromak/cookbooks/blob/master/ohai/files/default/sysctl.rb>`_
     - Adds sysctl information to Ohai.
   * - `vserver.rb <https://github.com/albertsj1/ohai-plugins/blob/master/vserver.rb>`_
     - Adds extensions for virtualization attributes to allow a Linux virtual server host and guest information to be used by Ohai.
   * - `wtf.rb <https://github.com/cloudant/ohai_plugins/blob/master/wtf.rb>`_
     - Adds the irreverent wtfismyip.com service so that Ohai can determine a machine's external IPv4 address and geographical location.
   * - `xenserver.rb <https://github.com/spheromak/cookbooks/blob/master/ohai/files/default/xenserver.rb>`_
     - Adds extensions for virtualization attributes to load up Citrix XenServer host and guest information.
   * - `win32_software.rb <https://github.com/timops/ohai-plugins/blob/master/win32_software.rb>`_
     - Adds the ability for Ohai to use Windows Management Instrumentation (WMI) to discover useful information about software that is installed on any node that is running Microsoft Windows.
   * - `win32_svc.rb <https://github.com/timops/ohai-plugins/blob/master/win32_svc.rb>`_
     - Adds the ability for Ohai to query using Windows Management Instrumentation (WMI) to get information about all services that are registered on a node that is running Microsoft Windows.

Handlers
=====================================================
.. tag handler

Use a handler to identify situations that arise during a Chef Infra Client run, and then tell the Chef Infra Client how to handle these situations when they occur.

.. end_tag

.. tag handler_community_handlers

The following open source handlers are available from the Chef community:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Handler
     - Description
   * - `Airbrake <https://github.com/timops/ohai-plugins/blob/master/win32_svc.rb>`_
     - A handler that sends exceptions (only) to Airbrake, an application that collects data and aggregates it for review.
   * - `Asynchronous Resources <https://github.com/rottenbytes/chef/tree/master/async_handler>`_
     - A handler that asynchronously pushes exception and report handler data to a STOMP queue, from which data can be processed into data storage.
   * - `Campfire <https://github.com/ampledata/chef-handler-campfire>`_
     - A handler that collects exception and report handler data and reports it to Campfire, a web-based group chat tool.
   * - `Datadog <https://github.com/DataDog/chef-handler-datadog>`_
     - A handler that collects Chef Infra Client stats and sends them into a Datadog newsfeed.
   * - `Flowdock <https://github.com/mmarschall/chef-handler-flowdock>`_
     - A handler that collects exception and report handler data and sends it to users via the Flowdock API..
   * - `Graphite <https://github.com/imeyer/chef-handler-graphite/wiki>`_
     - A handler that collects exception and report handler data and reports it to Graphite, a graphic rendering application.
   * - `Graylog2 GELF <https://github.com/jellybob/chef-gelf/>`_
     - A handler that provides exception and report handler status (including changes) to a Graylog2 server, so that the data can be viewed using Graylog Extended Log Format (GELF).
   * - `Growl <https://rubygems.org/gems/chef-handler-growl>`_
     - A handler that collects exception and report handler data and then sends it as a Growl notification.
   * - `HipChat <https://github.com/mojotech/hipchat/blob/master/lib/hipchat/chef.rb>`_
     - A handler that collects exception handler data and sends it to HipChat, a hosted private chat service for companies and teams.
   * - `IRC Snitch <https://rubygems.org/gems/chef-irc-snitch>`_
     - A handler that notifies administrators (via Internet Relay Chat (IRC)) when a Chef Infra Client run fails.
   * - `Journald <https://github.com/marktheunissen/chef-handler-journald>`_
     - A handler that logs an entry to the systemd journal with the Chef Infra Client run status, exception details, configurable priority, and custom details.
   * - `net/http <https://github.com/b1-systems/chef-handler-httpapi/>`_
     - A handler that reports the status of a Chef run to any API via net/HTTP.
   * - `Simple Email <https://rubygems.org/gems/chef-handler-mail>`_
     - A handler that collects exception and report handler data and then uses pony to send email reports that are based on Erubis templates.
   * - `SendGrid Mail Handler <https://github.com/sendgrid-ops/chef-sendgrid_mail_handler>`_
     - A chef handler that collects exception and report handler data and then uses SendGrid Ruby gem to send email reports that are based on Erubis templates.
   * - `SNS <http://onddo.github.io/chef-handler-sns/>`_
     - A handler that notifies exception and report handler data and sends it to a SNS topic.
   * - `Slack <https://github.com/rackspace-cookbooks/chef-slack_handler>`_
     - A handler to send Chef Infra Client run notifications to a Slack channel.
   * - `Splunk Storm <http://ampledata.org/splunk_storm_chef_handler.html>`_
     - A handler that supports exceptions and reports for Splunk Storm.
   * - `Syslog <https://github.com/jblaine/syslog_handler>`_
     - A handler that logs basic essential information, such as about the success or failure of a Chef Infra Client run.
   * - `Updated Resources <https://rubygems.org/gems/chef-handler-updated-resources>`_
     - A handler that provides a simple way to display resources that were updated during a Chef Infra Client run.
   * - `ZooKeeper <http://onddo.github.io/chef-handler-zookeeper/>`_
     - A Chef report handler to send Chef run notifications to ZooKeeper.

.. end_tag
