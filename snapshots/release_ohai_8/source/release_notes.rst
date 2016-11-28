=====================================================
Release Notes: Ohai 8
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
.. .. include:: ../../includes_adopted_platforms/includes_adopted_platforms_ohai.rst

What's New
=====================================================
Ohai 8 introduces the following change:

* **Minimum supported version of Ruby** The version of Ruby supported by Ohai 8 is Ruby version 2.0.
