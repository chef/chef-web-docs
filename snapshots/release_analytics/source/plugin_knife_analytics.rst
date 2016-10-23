.. THIS PAGE IS LOCATED AT THE /release/analytics/ PATH.

=====================================================
knife analytics
=====================================================

.. include:: ../../includes_analytics/includes_analytics_legacy.rst 

.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics.rst

.. note:: Review the list of `common options <https://docs.chef.io/knife_common_options.html>`_ available to this (and all) knife subcommands and plugins.

.. note:: .. include:: ../../includes_chef/includes_chef_subscriptions.rst

Install this plugin
=====================================================
To install the ``knife analytics`` plugin using RubyGems, run the following command:

.. code-block:: bash

   $ /opt/chef/embedded/bin/gem install knife-analytics

where ``/opt/chef/embedded/bin/`` is the path to the location where the chef-client expects knife plugins to be located. If the chef-client was installed using RubyGems, omit the path in the previous example.







Configure SSL
-----------------------------------------------------
The ``knife analytics`` subcommand requires the SSL certificate for Chef Analytics to be present on the workstation from which commands will be run. Fetch the SSL certificate from Chef Analytics by using the ``knife ssl fetch`` subcommand:

.. code-block:: bash

   $ knife ssl fetch ANALYTICS_URL

For example:

.. code-block:: bash

   $ knife ssl fetch https://ec2-52-27-166-146.us-west-2.compute.amazonaws.com

Configure knife.rb
-----------------------------------------------------
The knife.rb file may be configured for the URL for Chef Analytics. Add the following setting to the knife.rb file:

.. code-block:: ruby

   analytics_server_url 'https://ANALYTICS_URL/organizations/ORG_NAME'

For example:

.. code-block:: ruby

   analytics_server_url 'https://ec2-52-27-166-146.us-west-2.compute.amazonaws.com/organizations/learnchef'

action list
=====================================================
.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics_action_list.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics_action_list_syntax.rst

Options
-----------------------------------------------------
.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics_action_list_options.rst

action show
=====================================================
.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics_action_show.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics_action_show_syntax.rst

Options
-----------------------------------------------------
.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics_action_show_options.rst

alert list
=====================================================
.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics_alert_list.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics_alert_list_syntax.rst

Options
-----------------------------------------------------
.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics_alert_list_options.rst

alert show
=====================================================
.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics_alert_show.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics_alert_show_syntax.rst

Options
-----------------------------------------------------
.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics_alert_show_options.rst

notification create
=====================================================
Use the ``notification create`` argument to create a notifications on the Chef Analytics server.

Syntax
-----------------------------------------------------
This argument has the following syntax:

.. code-block:: bash

   $ knife notification create NOTIFICATION.json

Options
-----------------------------------------------------
This argument has the following options:

``--analytics-server-url HOST``
   The URL of the server on which Chef Analytics is running, including the organization name. For example: ``https://analytics.chef.io/org-name``.

``--identity-server-url HOST``
   The URL of the server on which the **oc-id** service is running. The **oc-id** service is used by Chef Analytics when communicating with the Chef server.

Example
-----------------------------------------------------

**Create a notification**

To create a notification, run the following command:

.. code-block:: bash

   $ knife notification create FILE_NAME.json

where the ``FILE_NAME.json`` is similar to:

.. code-block:: javascript

   {
     "name": "chef-splunk-example",
     "notification_type": "Splunk",
     "modified_by": "admin",
     "delivery_options": {
       "hostname": "splunk.chef.inc.com",
       "port": 8089,
       "username": "username",
       "password": "password",
       "index": "chef-analytics",
       "sourcetype": "chef-analytics-data"
     }
   }

notification list
=====================================================
.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics_notification_list.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics_notification_list_syntax.rst

Options
-----------------------------------------------------
.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics_notification_list_options.rst

notification show
=====================================================
.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics_notification_show.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics_notification_show_syntax.rst

Options
-----------------------------------------------------
.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics_notification_show_options.rst

rule create
=====================================================
Use the ``rule create`` argument to create a rule on the Chef Analytics server.


Syntax
-----------------------------------------------------
This argument has the following syntax:

.. code-block:: bash

   $ knife rule create FILE_NAME.json

Options
-----------------------------------------------------
This argument has the following options:

``--analytics-server-url HOST``
   The URL of the server on which Chef Analytics is running.

``--identity-server-url HOST``
   The URL of the server on which the **oc-id** service is running. The **oc-id** service is used by Chef Analytics when communicating with the Chef server.

Example
-----------------------------------------------------

**Create a rule**

To create a rule, run the following command:

.. code-block:: bash

   $ knife rule create FILE_NAME.json

where the ``FILE_NAME.json`` is similar to:

.. code-block:: javascript

   {
     "name": "Rule name.",
     "modified_by": "user_name",
     "with": {
       "priority": 0
     },
     "active":true,
     "rule":"rules 'Rule group 1'\n
       rule on action\n  
       when\n    
         true\n  
       then\n    
         noop()\n  
       end\n
     end"
   }

**Create a Slack incoming webhooks notification**

.. include:: ../../includes_analytics/includes_analytics_webhook_example_slack.rst

rule list
=====================================================
.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics_rule_list.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics_rule_list_syntax.rst

Options
-----------------------------------------------------
.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics_rule_list_options.rst

rule show
=====================================================
.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics_rule_show.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics_rule_show_syntax.rst

Options
-----------------------------------------------------
.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics_rule_show_options.rst

