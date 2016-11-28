=====================================================
Release Notes: chef-client 11.18
=====================================================

.. tag chef

Chef is a powerful automation platform that transforms infrastructure into code. Whether you’re operating in the cloud, on-premises, or in a hybrid environment, Chef automates how infrastructure is configured, deployed, and managed across your network, no matter its size.

This diagram shows how you develop, test, and deploy your Chef code.

.. image:: ../../images/start_chef.svg
   :width: 700px
   :align: center

.. end_tag

What's New
=====================================================
The following items are new for chef-client 11-18 and/or are changes from previous versions. The short version:

* **Dependency on ffi-yajl** Dependencies on the ``json`` gem have been replaced with ``ffi-yajl``. Use ``Chef::JSONCompat`` for parsing and printing.
* **dsc_script resource may use Powershell 4 (or higher)** A recipe using the **dsc_script** resource may install Windows PowerShell 4 (or higher).
* **cacerts pinned to known working version** The cacerts bundle is pinned to a known working version, which helps work around issues where SSL connections fail due to certificate errors. (Added in 11.18.6.)

Changelog
=====================================================
https://github.com/chef/chef/blob/11-stable/CHANGELOG.md
