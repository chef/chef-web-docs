.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following providers:

``Chef::Provider::Ifconfig``, ``ifconfig``
   The default provider for all platforms. Currently, this provider only writes out a start-up configuration file for the interface on |redhat|-based platforms (it writes to ``/etc/sysconfig/network-scripts/ifcfg-#{device_name}``). 
