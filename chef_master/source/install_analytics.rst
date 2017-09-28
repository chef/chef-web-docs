=====================================================
Install Chef Analytics
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/install_analytics.rst>`__

.. tag analytics_legacy

.. note:: This documentation is meant to support existing Chef customers using Analytics.

          If you are a new Chef customer, or are looking to gain better insight into your fleet, try :doc:`Chef Automate </chef_automate>`. You'll get a graphical interface and query language that gives you insight into operational, compliance, and workflow events. Download Chef Automate `here <https://downloads.chef.io/automate/>`__.


.. end_tag

.. tag analytics_summary

The Chef Analytics platform is a feature of Chef that provides real-time visibility into what is happening on the Chef server, including what's changing, who made those changes, and when they occurred. Individuals may be notified of these changes in real-time. Use this visibility to verify compliance against internal controls.

.. end_tag

Prerequisites
=====================================================
The Chef Analytics server shares the :doc:`same prerequisites </install_server_pre>` as the Chef server. In addition:

* Chef server version 12.0.3 **or** Enterprise Chef version 11.3 is required to use Chef Analytics 1.1
* chef-client version 12.1 is required for audit-mode and using the ``control_group`` and ``control`` Recipe DSL methods
* The Chef management console must be installed on the Chef server prior to installing Chef Analytics; follow these steps to install the Chef management console
* Reporting is installed on the Chef server. Reporting version 1.2.3 is required to view the results of audit-mode, i.e. ``run_start``, ``run_resource``, and ``run_converge`` messages; earlier versions of Reporting may be used, but will not show these results
* An x86_64 compatible system architecture; Red Hat Enterprise Linux and CentOS may require updates prior to installation
* A resolvable hostname that is specified using a FQDN or an IP address
* A connection to Network Time Protocol (NTP) to prevent clock drift
* A local mail transfer agent that allows Chef Analytics to send email notifications; for versions of Chef Analytics prior to 1.1.3, ``to``, ``from``, ``host`` (the email server), ``password``, ``port``, and ``username`` must be specified.
* Using cron and the ``/etc/cron.d`` directory for periodic maintenance tasks
* Disabling the Apache Qpid daemon on CentOS and Red Hat systems
* Optional. A local user account under which services will run, a local user account for PostgreSQL, and a group account under which services will run. See the `Chef server installation prerequisites </install_server_pre.html>`_ for more information.
* The RabbitMQ queues on the Chef server that are used by Chef Analytics---``/analytics``---are capped to prevent unintended disk overruns. For example:

  .. code-block:: bash

     $ export PATH=/opt/opscode/embedded/bin:$PATH
     $ rabbitmqctl set_policy -p /analytics max_length '(erchef|alaska|notifier.notifications|notifier_config)' '{"max-length":10000}' --apply-to queues

* The RabbitMQ port on the Chef server must allow inbound traffic from Chef Analytics.

Hostnames
-----------------------------------------------------
.. tag install_analytics_hostname

The hostname for the Chef Analytics server may be specified using a FQDN or an IP address. This hostname must be resolvable. For example, a Chef Analytics server that is running in a production environment with a resolvable FQDN hostname can be added in the DNS system. But when deploying Chef Analytics into a testing environment, adding the hostname to the ``/etc/hosts`` file is enough to ensure that hostname is resolvable.

* **FQDN Hostnames** When the hostname for the Chef Analytics server is a FQDN be sure to include the domain suffix. For example, something like ``myanalyticsserver.example.com`` (and not something like ``myanalyticsserver``).

The ``analytics_fqdn`` setting must be added to the opscode-analytics.rb file (it is not there by default). Its value should be equal to the FQDN or IP address for the service URI used by the Chef Analytics server. For example: ``analytics_fqdn "chef-analytics.example.com"`` or ``analytics_fqdn 123.45.67.890``.

.. end_tag

.. warning:: The FQDN for the Chef Analytics server should not exceed 64 characters when using OpenSSL. OpenSSL requires the ``CN`` in a certificate to be no longer than 64 characters. By default, Chef Analytics uses the FQDN of the server to determine the common name (``CN``). If the FQDN of the Chef Analytics server is longer than 64 characters, the ``chef-server-ctl reconfigure`` command will not fail, but an empty certificate file will be created. Nginx will not start if a certificate file is empty.

Install the Server
=====================================================
Chef Analytics is installed on dedicated hardware with its own configuration topology that is independent from the machines in the Chef server configuration and compatible with the existing Chef server machine topology (standalone, tiered, or high availability). Chef Analytics may only be installed as a standalone configuration.

Standalone
-----------------------------------------------------
In a standalone configuration, the Chef Analytics deployment is on a different server from the Chef server. This allows you to scale Chef Analytics independently from the Chef server. To set up Chef Analytics in a standalone configuration, an existing Chef server deployment should already running. Chef Analytics is installed in two steps: configuring the Chef server for Chef Analytics, and then installing Chef Analytics.

.. warning:: The Chef management console must be installed on the Chef server prior to installing Chef Analytics; follow these steps to install the Chef management console prior to installing Chef Analytics.

Install Chef Analytics:

#. Download the package from http://downloads.chef.io/analytics/ to the dedicated standalone server that will be used for Chef Analytics. For Red Hat and CentOS 6:

   .. code-block:: bash

      $ rpm -Uvh /tmp/opscode-analytics-<version>.rpm

   For Ubuntu:

   .. code-block:: bash

      $ dpkg -i /tmp/opscode-analytics-<version>.deb

   After a few minutes, Chef Analytics will be installed.

Configure the Chef server. On each server in the Chef server configuration, do the following:

#. Add the FQDN for the Chef Analytics server to ``/etc/opscode/chef-server.rb``. The ending slash is required:

   .. code-block:: bash

      oc_id['applications'] ||= {}
      oc_id['applications']['analytics'] = {
        'redirect_uri' => 'https://<analytics_fqdn>/'
      }

#. Stop the Chef server:

   .. code-block:: bash

      $ chef-server-ctl stop

#. Enable remote access to RabbitMQ on the Chef server backend by adding the following settings to ``/etc/opscode/chef-server.rb``:

   .. code-block:: ruby

      rabbitmq['vip'] = 'BACKEND_VIP'
      rabbitmq['node_ip_address'] = '0.0.0.0'   # see below

   where ``BACKEND_VIP`` is the external IP address for the backend Chef server. ``node_ip_address`` MUST be set to ``0.0.0.0``.

   .. note:: Chef Analytics uses the same RabbitMQ service that is configured on the Chef server. When the Chef Analytics server is configured as a standalone server, the default settings for ``rabbitmq['node_ip_address']`` and ``rabbitmq['vip']`` must be updated.

#. Reconfigure the Chef server:

   .. code-block:: bash

      $ chef-server-ctl reconfigure

   This updates the Chef server and creates the ``actions-source.json`` file, which is required by Chef Analytics, and adds it to the ``/etc/opscode-analytics`` directory on the Chef server.

#. Restart the Chef server:

   .. code-block:: bash

      $ chef-server-ctl restart

#. Reconfigure the Chef management console:

   .. code-block:: bash

      $ chef-manage-ctl reconfigure

   .. note:: .. tag chef_license_reconfigure_manage

             Starting with the Chef management console 2.3.0, the :doc:`Chef MLSA </chef_license>` must be accepted when reconfiguring the product. If the Chef MLSA has not already been accepted, the reconfigure process will prompt for a ``yes`` to accept it. Or run ``chef-manage-ctl reconfigure --accept-license`` to automatically accept the license.

             .. end_tag

Configure the Chef Analytics standalone server:

#. Copy over the files in the ``/etc/opscode-analytics`` directory from the Chef server to the standalone Chef Analytics server.

#. Configure the Chef Analytics server by setting the ``analytics_fqdn`` in ``/etc/opscode-analytics/opscode-analytics.rb``. This is the FQDN for the Chef Analytics web application. For example:

   .. code-block:: bash

      analytics_fqdn "analytics.example.com"
      topology "standalone"

#. Verify the configuration using the preflight check command:

   .. code-block:: bash

      $ opscode-analytics-ctl preflight-check

   If there are any errors in the preflight check, correct them before carrying on to the next step.

#. Reconfigure the Chef Analytics server on the Chef Analytics server:

   .. code-block:: bash

      $ opscode-analytics-ctl reconfigure

   .. note:: .. tag chef_license_reconfigure_analytics

             Starting with Chef Analytics 1.4.0, the Chef MLSA must be accepted when reconfiguring the product. If the Chef MLSA has not already been accepted, the reconfigure process will prompt for a ``yes`` to accept it. Or run ``opscode-analytics-ctl reconfigure --accept-license`` to automatically accept the license.

             .. end_tag

Standalone (version 1.0)
-----------------------------------------------------
In a standalone configuration, the Chef Analytics deployment is on a different machine from the Chef server. This allows you to scale Chef Analytics independently from the Chef server. To set up Chef Analytics in a standalone configuration, an existing Chef server deployment should already running. Chef Analytics is installed in two steps: configuring the Chef server for Chef Analytics, and then installing Chef Analytics.

On the Chef server:

#. Download the package from http://downloads.chef.io/analytics/.
#. Enable the Chef server deployment to publish to Chef actions by adding the following line to ``/etc/opscode/chef-server.rb``:

   .. code-block:: bash

      dark_launch['actions'] = true

#. Stop the Chef server:

   .. code-block:: bash

      $ chef-server-ctl stop

#. Enable remote access to RabbitMQ on the Chef server backend machine by adding the following settings to ``/etc/opscode/chef-server.rb``:

   .. code-block:: ruby

      rabbitmq['vip'] = 'BACKEND_VIP'
      rabbitmq['node_ip_address'] = ''

   where ``BACKEND_VIP`` is the external IP address for the backend Chef server. ``node_ip_address`` MUST be set to ``0.0.0.0``.

   .. note:: Chef Analytics uses the same RabbitMQ service that is configured on the Chef server. When the Chef Analytics server is configured as a standalone server, the default settings for ``rabbitmq['node_ip_address']`` and ``rabbitmq['vip']`` must be updated.

#. Reconfigure the Chef server:

   .. code-block:: bash

      $ chef-server-ctl reconfigure

#. Restart the Chef server:

   .. code-block:: bash

      $ chef-server-ctl start

#. If you are on Chef server 11.1.8 you need to manually copy a single file from ``/etc/opscode`` to ``/etc/opscode-analytics``:

   .. code-block:: bash

      $ cp /etc/opscode/webui_priv.pem /etc/opscode-analytics

On the dedicated, standalone machine:

#. Install the Chef Analytics package on the standalone Chef Analytics machine. For example on Ubuntu:

   .. code-block:: bash

      $ dpkg -i opscode-analytics<version>.deb

#. Copy over the ``/etc/opscode-analytics`` directory from the Chef server machine to the standalone Chef Analytics machine.

#. Configure the Chef Analytics server by setting the ``analytics_fqdn`` in ``/etc/opscode-analytics/opscode-analytics.rb``. This is the FQDN for the Chef Analytics web application. For example:

   .. code-block:: bash

      analytics_fqdn "analytics.example.com"
      topology "standalone"

#. Verify the configuration using the preflight check command:

   .. code-block:: bash

      $ opscode-analytics-ctl preflight-check

   If there are any errors in the preflight check, correct them before carrying on to the next step.

#. Reconfigure the Chef Analytics server on the Chef Analytics machine:

   .. code-block:: bash

      $ opscode-analytics-ctl reconfigure

