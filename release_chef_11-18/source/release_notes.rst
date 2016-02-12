=====================================================
Release Notes: |chef client| 11.18
=====================================================

.. include:: ../../includes_chef/includes_chef.rst

What's New
=====================================================
The following items are new for |chef client| 11-18 and/or are changes from previous versions. The short version:

* **Dependency on ffi-yajl** Dependencies on the ``json`` |gem| have been replaced with ``ffi-yajl``. Use ``Chef::JSONCompat`` for parsing and printing.
* **dsc_script resource may use Powershell 4 (or higher)** A recipe using the |resource dsc_script| resource may install |windows powershell| 4 (or higher).
* **cacerts pinned to known working version** The cacerts bundle is pinned to a known working version, which helps work around issues where SSL connections fail due to certificate errors. (Added in 11.18.6.)

Changelog
=====================================================
https://github.com/chef/chef/blob/11-stable/CHANGELOG.md

.. What's Fixed
.. =====================================================
.. The following bugs were fixed:
.. 
.. * `CHEF-xxxxx <http://tickets.opscode.com/browse/CHEF-xxxxx>`_  --- xxxxx
.. * `CHEF-xxxxx <http://tickets.opscode.com/browse/CHEF-xxxxx>`_  --- xxxxx
.. 
.. What's Improved
.. =====================================================
.. The following improvements were made:
.. 
.. * `CHEF-xxxxx <http://tickets.opscode.com/browse/CHEF-xxxxx>`_  --- xxxxx
.. * `CHEF-xxxxx <http://tickets.opscode.com/browse/CHEF-xxxxx>`_  --- xxxxx
.. 
.. New Features
.. =====================================================
.. The following features were added:
.. 
.. * `CHEF-xxxxx <http://tickets.opscode.com/browse/CHEF-xxxxx>`_  --- xxxxx
.. * `CHEF-xxxxx <http://tickets.opscode.com/browse/CHEF-xxxxx>`_  --- xxxxx