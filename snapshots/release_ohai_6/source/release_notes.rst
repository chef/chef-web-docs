=====================================================
Release Notes: Ohai 6
=====================================================

.. tag ohai

Ohai is a tool that is used to detect attributes on a node, and then provide these attributes to the chef-client at the start of every chef-client run. Ohai is required by the chef-client and must be present on a node. (Ohai is installed on a node as part of the chef-client install process.)

The types of attributes Ohai collects include (but are not limited to):

* Platform details
* Network usage
* Memory usage
* CPU data
* Kernel data
* Host names
* Fully qualified domain names
* Other configuration details

Attributes that are collected by Ohai are automatic attributes, in that these attributes are used by the chef-client to ensure that these attributes remain unchanged after the chef-client is done configuring the node.

.. end_tag

.. Adopted Platforms
.. =====================================================
.. .. include:: ../../includes_adopted_platforms/includes_adopted_platforms_ohai_6.rst

What's Fixed
=====================================================

The following bugs were fixed:

* `OHAI-110 <http://tickets.opscode.com/browse/OHAI-110>`_  --- Ohai fails to detect virtualbox guests
* `OHAI-201 <http://tickets.opscode.com/browse/OHAI-201>`_  --- Ohai should fail gracefully when optional plugins are missing dependencies
* `OHAI-245 <http://tickets.opscode.com/browse/OHAI-245>`_  --- Encoding errors on Ruby 1.9.2
* `OHAI-267 <http://tickets.opscode.com/browse/OHAI-267>`_  --- identifying rackspace's managed cloud instances
* `OHAI-272 <http://tickets.opscode.com/browse/OHAI-272>`_  --- platform_version for SuSE 11.3 is an empty String
* `OHAI-273 <http://tickets.opscode.com/browse/OHAI-273>`_  --- Unable to find version for Windows 2003 Server R2 node
* `OHAI-275 <http://tickets.opscode.com/browse/OHAI-275>`_  --- Ohai's strings are incorrectly marked as ASCII-8BIT on Ruby 1.9
* `OHAI-276 <http://tickets.opscode.com/browse/OHAI-276>`_  --- ip_scopes plugin fails when there's a network interface without addresses like linux's sit
* `OHAI-281 <http://tickets.opscode.com/browse/OHAI-281>`_  --- Solaris platform plugin does not work with GNU uname on OpenIndiana/OpenSolaris.
* `OHAI-282 <http://tickets.opscode.com/browse/OHAI-282>`_  --- IPv6 addresses blow away IPv4 addresses during Ohai Solaris network detection.
* `OHAI-291 <http://tickets.opscode.com/browse/OHAI-291>`_  --- StringIO needs to be required in ruby 1.8.7

What's Improved
=====================================================
The following improvements were made:

* `OHAI-253 <http://tickets.opscode.com/browse/OHAI-253>`_  --- Detect Xen guests more reliable
* `OHAI-288 <http://tickets.opscode.com/browse/OHAI-288>`_  --- report FreeBSD jail guest/host

New Features
=====================================================
The following features were added:

* `OHAI-70 <http://tickets.opscode.com/browse/OHAI-70>`_  --- add support for reporting routing tables to the network plugin
