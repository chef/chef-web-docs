=====================================================
opscode-reporting.rb
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/config_rb_reporting.rst>`__

.. tag reporting_legacy

.. note:: This documentation is meant to support existing Chef customers using Reporting.

          Are you a new Chef customer, or looking to gain better insight into your fleet? Take advantage of `Chef Automate </chef_automate.html>`__. You'll get a graphical interface and query language that gives you insight into operational, compliance, and workflow events. You can `download Chef Automate here <https://downloads.chef.io/automate>`__.

.. end_tag

The ``opscode-reporting.rb`` file contains all of the non-default configuration settings used by the Reporting add-on for the Chef server.

These settings are applied every time ``opscode-reporting-ctl reconfigure`` is run.

The configuration file is located at: ``/etc/opscode-reporting/opscode-reporting.rb``.

.. note:: If the ``opscode-reporting.rb`` file does not exist, create a file called ``opscode-reporting.rb`` and put it in the ``/etc/opscode-reporting/`` directory.

.. note:: .. tag chef_subscriptions

          This feature is included as part of the Chef Automate license agreement and is `available via subscription <https://www.chef.io/pricing/>`_.

          .. end_tag

Settings
==========================================================================

The following settings are typically added to the ``opscode-reporting.rb`` file:

``enable``
   Enable a service. Default value: ``true``.

``ha``
   Run the Chef server in a high availability topology. When ``topology`` is set to ``ha``, this setting defaults to ``true``. Default value: ``false``.

``dir``
   The working directory. The default value is the recommended value. Default value: ``'/var/opt/opscode-reporting/opscode-reporting'``.

``log_directory``
   The directory in which log data is stored. The default value is the recommended value. Default value: ``'/var/log/opscode/opscode-reporting'``.

``protocol_version``
   Default value: ``'0.1.0'``.

``vip``
   The virtual IP address. Default value: ``'127.0.0.1'``.

``listen``
   Default value: ``'127.0.0.1'``.

``port``
   Default value: ``10010``.

``auth_skew``
   Default value: ``'900'``.

``db_pool_size``
   The number of open connections to PostgreSQL that are maintained by the service. Default value: ``25``.

``node_search_limit``
   Default value: ``50``.

``org_cache_size``
   Default value: ``'10000'``.

``org_cache_ttl``
   Default value: ``'14400'`` (four hours).

``principals_cache_size``
   Default value: ``'10000'``.

``principals_cache_ttl``
   Default value: ``'14400'`` (four hours).

``node_identifiers_cache_size``
   Default value: ``'20000'``.

``enable_graphite``
   Default value: ``false``.

``node_identifiers_cache_ttl``
   Default value: ``'14440'`` (four hours).

``pool['timeout']``
   Default value: ``10000``.

``pool['http_pool_size']``
   Default value: ``25``.

``pool['cull_interval']``
   May be ``min``, ``sec``, or ``ms``. Default value: ``'{1, min}'``.

``pool['max_age']``
   May be ``min``, ``sec``, or ``ms``. Default value: ``'{70, sec}'``.

``pool['max_connection_duration']``
   May be ``min``, ``sec``, or ``ms``. Default value: ``'{70, sec}'``.

``pool['ibrowse_options']``
   The amount of time (in milliseconds) to wait for a connection to be established. Default value: ``'[{connect_timeout, 8000}]'``.

``log_rotation['file_maxbytes']``
   The log rotation policy for this service. Log files are rotated when they exceed ``file_maxbytes``. The maximum number of log files in the rotation is defined by ``num_to_keep``. Default value: ``104857600``.

``log_rotation['num_to_keep']``
   Default value: ``10``.

``chef_api_version``
   The version of the Chef server API. Default value: ``'11.1.0'``.

``refresh_runcounts_interval``
   Default value: ``5``.

``rabbitmq_user``
   Default value: ``'runs'``.

``rabbitmq_password``
   The password for the RabbitMQ user. Default value: **generated**.

   To override the default value, use ``chef-server-ctl set-secret opscode-reporting rabbitmq_password`` from the `Secrets Management </ctl_chef_server.html#ctl-chef-server-secrets-management>`__ commands.

``postgresql['enable']``
   Enable a service. Default value: ``true``.

``postgresql['username']``
   The PostgreSQL account user name. Default value: ``'opscode-pgsql'``.

``postgresql['sql_user']``
   Default value: ``'opscode_reporting'``.

``postgresql['sql_password']``
   The password for the PostgreSQL user account. Default value: **generated**.

   To override the default value, use ``chef-server-ctl set-secret opscode-reporting sql_password`` from the `Secrets Management </ctl_chef_server.html#ctl-chef-server-secrets-management>`__ commands.

``postgresql['sql_ro_user']``
   Default value: ``'opscode_reporting_ro'``.

``postgresql['sql_ro_password']``
   Default value: **generated**.

   To override the default value, use ``chef-server-ctl set-secret opscode-reporting sql_ro_password`` from the `Secrets Management </ctl_chef_server.html#ctl-chef-server-secrets-management>`__ commands: .

``postgresql['vip']``
   The virtual IP address. Default value: ``'127.0.0.1'``.

``postgresql['port']``
   The port on which the service is to listen. Default value: ``5432``.

``nginx['enable']``
   Enable a service. Default value: ``true``.

``graphite['host']``
   Default value: ``'localhost'``.

``graphite['port']``
   The port on which the service is to listen. Default value: ``2003``.

``graphite['prefix']``
   Default value: ``'folsom'``.

``graphite['send_interval']``
   Default value: ``10000``.

``sqerl['db_pooler_timeout']``
   Default value: ``'0'``.

``pooler['db_pool_queue_max']``
   Default value: ``'50'``.
