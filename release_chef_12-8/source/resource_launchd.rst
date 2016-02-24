.. THIS PAGE DOCUMENTS chef-client version 12.8

=====================================================
launchd
=====================================================

.. include:: ../../includes_resources/includes_resource_launchd.rst

Syntax
=====================================================
.. include:: ../../includes_resources/includes_resource_launchd_syntax.rst

Actions
=====================================================
.. include:: ../../includes_resources/includes_resource_launchd_actions.rst

Properties
=====================================================
.. include:: ../../includes_resources/includes_resource_launchd_attributes.rst

.. 
.. Providers
.. =====================================================
.. .. include:: ../../includes_resources_common/includes_resources_common_provider.rst
.. 
.. .. include:: ../../includes_resources_common/includes_resources_common_provider_attributes.rst
.. 
.. .. include:: ../../includes_resources/includes_resource_cron_providers.rst
.. 

Examples
=====================================================
|generic resource statement|


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

