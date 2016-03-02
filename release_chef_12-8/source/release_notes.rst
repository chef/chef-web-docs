=====================================================
Release Notes: |chef client| 12.8
=====================================================

.. include:: ../../includes_chef/includes_chef.rst

What's New
=====================================================
The following items are new for |chef client| 12.8 and/or are changes from previous versions. The short version:

* **New launchd resource** Use the |resource launchd| resource to manage system-wide services (daemons) and per-user services (agents) on the |mac os x| platform.
* **New property for the mdadm resource** Use the ``mdadm_defaults`` property to set the default values for ``chunk`` and ``metadata`` to ``nil``, which allows |mdadm| to apply its own default values.

launchd
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_launchd.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_launchd_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_launchd_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_launchd_attributes.rst


Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Create a LaunchDaemon from cookbook file**

.. code-block:: ruby

   launchd 'com.chef.every15' do
     source 'com.chef.every15.plist'
   end

**Create a LaunchDaemon using keys**

.. code-block:: ruby

   launchd 'call.mom.weekly' do
     program '/Library/scripts/call_mom.sh'
     start_calendar_interval 'Weekday' => 7, 'Hourly' => 10
     time_out 300
   end

**Remove LaunchDaemon**

.. code-block:: ruby

   launchd 'com.chef.every15' do
     action :delete
   end



xxxxx
-----------------------------------------------------
xxxxx

xxxxxx
+++++++++++++++++++++++++++++++++++++++++++++++++++++
xxxxx


Changelog
=====================================================
https://github.com/chef/chef/blob/master/CHANGELOG.md
