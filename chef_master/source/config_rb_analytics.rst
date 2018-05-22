=====================================================
opscode-analytics.rb
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/config_rb_analytics.rst>`__

.. tag analytics_legacy

.. note:: This documentation is meant to support existing Chef customers using Analytics.

          If you are a new Chef customer, or are looking to gain better insight into your fleet, try `Chef Automate </chef_automate.html>`__. You'll get a graphical interface and query language that gives you insight into operational, compliance, and workflow events. Download Chef Automate `here <https://downloads.chef.io/automate>`__.


.. end_tag

The opscode-analytics.rb file contains all of the non-default configuration settings used by the Chef Analytics add-on for the Chef server.  (The default settings are built-in to the Chef Analytics configuration and should only be added to the opscode-analytics.rb file to apply non-default values.)

These settings are applied every time ``opscode-analytics-ctl reconfigure`` is run, such as immediately after setting up the Chef Analytics server or after making a change to the underlying configuration settings after the server has been deployed.

The configuration file is located at: ``/etc/opscode-analytics/opscode-analytics.rb``.

.. note:: If the opscode-analytics.rb file does not exist, create a file called ``opscode-analytics.rb`` and put it in the ``/etc/opscode-analytics/`` directory.

.. note:: .. tag chef_subscriptions

          This feature is included as part of the Chef Automate license agreement and is `available via subscription <https://www.chef.io/pricing/>`_.

          .. end_tag

Example
==========================================================================
The following example shows how the settings look when added to the configuration file:

.. code-block:: ruby

   # General settings
   analytics_fqdn 'chef-analytics.example.com'
   topology 'standalone'

   # actions_consumer settings
   actions_consumer['hipchat_api_token'] = '4yZvEWO6gnVhjtl3F6aU12obylgNXzzqmklI5jP0'
   actions_consumer['hipchat_room'] = 'Chef Notifications'
   actions_consumer['hipchat_enabled'] = ['prod', 'preprod']

Settings
==========================================================================

The following settings are typically added to the opscode-analytics.rb file:

``actions_consumer['hipchat_api_token']``
   An hipchat v2 API token for your hipchat account that will be used for publishing notifications.

``actions_consumer['hipchat_enabled']``
   A list of organizations for which hipchat notifications will be published.

``actions_consumer['hipchat_room']``
   The hipchat room to which notifications will be published.

``analytics_fqdn``
   The FQDN for the Chef Analytics server. This setting is not in the opscode-analytics.rb file by default. When added, its value should be equal to the FQDN for the service URI used by the Chef Analytics server. If you are installing in combined mode (Enterprise Chef and Chef Analytics servers on the same node) then this must be different from the FQDN for the Chef server.

``data_retention['month_interval_to_keep_activities']``
   The number of months for which activities data is retained. Default value: ``3``.

``data_retention['keep_all_data']``
   Use to specify if all events are kept. If this setting is ``true``, the ``month_interval_to_keep_activities`` value is ignored. Default value: ``false``.

``nginx['ssl_protocols']``
   The SSL protocol versions that are enabled. For the highest possible security, disable SSL 3.0 and allow only TLS: ``nginx['ssl_protocols'] 'TLSv1 TLSv1.1 TLSv1.2'``.

``notifier_config['accept_insecure']``
   Use to disable authentication to Automate API endpoints that create and modify rules and notifications. This setting should only be set to ``true`` when debugging rules and notifications in a non-production environment. Default value: ``false``.

``ssl['cacert_file_path']``
   Use to specify the path to the ``cacert.pem`` file. Default value: ``'/opt/opscode-analytics/embedded/ssl/certs/cacert.pem'``.

``ssl['certificate']``
   The SSL certificate used to verify communication over HTTPS.

``ssl['certificate_key']``
   The certificate key used for SSL communication.

``ssl['sslprotocols']``
   The SSL protocol versions that are enabled. For the highest possible security, disable SSL 3.0 and allow only TLS: ``nginx['ssl_protocols'] 'TLSv1 TLSv1.1 TLSv1.2'``.

``topology``
   Default value: ``combined``.

Optional Settings
=====================================================
The following settings are often used for performance tuning of Chef Analytics in larger installations.

.. note:: When changes are made to the opscode-analytics.rb file the Chef Analytics must be reconfigured by running the ``opscode-analytics-ctl reconfigure`` command.

actions
-----------------------------------------------------
The following settings are often modified from the default as part of the tuning effort for the **actions** service:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``actions['manage_endpoint']``
     - The HTTP URL for Chef management console. If your Chef server has a Chef management console installation which is on a different port or host from the Chef server API, specify the full URL to the root of the Chef management console installation here, e.g. ``"http://manage.example.com:8080"``.
   * - ``actions['session_expiry']``
     - Expiration time for web client sessions (in minutes). If web clients are timing out too quickly, increase this setting. Default value: ``30``.

partitioning
----------------------------------------------------
The following setting is used to enable and disable partitioning on the Chef Analytics server:

``features['partitioning']``
   Set this to ``false`` before running an upgrade to 1.3.0 to disable database partitioning; however, we recommend that you leave partitioning on. This setting must be set at the time of the 1.3.0 migration to take effect. See the "Upgrade With Partitions Disabled (Not Recommended)" section of the `upgrade documentation </upgrade_analytics.html>`__ for details on how to upgrade without partitioning enabled.
