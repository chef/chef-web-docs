=====================================================
Release Notes: chef-client 11.18
=====================================================

.. include:: ../../includes_chef/includes_chef.rst

What's New
=====================================================
The following items are new for chef-client 11-18 and/or are changes from previous versions. The short version:

* **Dependency on ffi-yajl** Dependencies on the ``json`` gem have been replaced with ``ffi-yajl``. Use ``Chef::JSONCompat`` for parsing and printing.
* **dsc_script resource may use Powershell 4 (or higher)** A recipe using the **dsc_script** resource may install Windows PowerShell 4 (or higher).
* **cacerts pinned to known working version** The cacerts bundle is pinned to a known working version, which helps work around issues where SSL connections fail due to certificate errors. (Added in 11.18.6.)

Changelog
=====================================================
https://github.com/chef/chef/blob/11-stable/CHANGELOG.md
