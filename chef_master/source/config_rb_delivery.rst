.. THIS PAGE IS IDENTICAL TO docs.chef.io/config_rb_delivery_optional_settings.html BY DESIGN
.. THIS PAGE IS LOCATED AT THE /delivery/ PATH.

=====================================================
delivery.rb Settings
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/config_rb_delivery.rst>`__

.. tag chef_automate_mark

.. image:: ../../images/chef_automate_full.png
   :width: 40px
   :height: 17px

.. end_tag

The ``delivery.rb`` file, located at ``/etc/delivery/delivery.rb``, contains all of the non-default configuration settings used by the Chef Automate. (The default settings are built-in to the Chef Automate configuration and should only be added to the ``delivery.rb`` file to apply non-default values.) These configuration settings are processed when the ``delivery-server-ctl reconfigure`` command is run, such as immediately after setting up Chef Automate or after making a change to the underlying configuration settings after the server has been deployed. The ``delivery.rb`` file is a Ruby file, which means that conditional statements can be used in the configuration file.

Recommended Settings
=====================================================
.. tag delivery_server_tuning_general

The following settings are typically added to the server configuration file, including:

* Logging directories
* Maximum file sizes at which log rotation occurs
* The number of log files to keep

These values have the same default across all Chef Automate services, but individual services can have their values overwritten. Add the service-specific values to the ``delivery.rb`` file. The list of services delivery starts which include logging can be determined by looking in the ``node['delivery']['log_directory']`` directory.

``<service_name>['log_directory']``
   The directory in which log data is stored. The default value is the recommended value. Default value: ``/var/log/delivery/<service_name>``.

``<service_name>['log_rotation']['file_maxbytes']``
   The log rotation policy for this service. Log files are rotated when they exceed ``file_maxbytes``. The maximum number of log files in the rotation is defined by ``num_to_keep``. Default value: ``100 * 1024 * 1024`` (100MB).

``<service_name>['log_rotation']['num_to_keep']``
   The log rotation policy for this service. Log files are rotated when they exceed ``file_maxbytes``. The maximum number of log files in the rotation is defined by ``num_to_keep``. Default value: ``10``.

.. end_tag

SSL Protocols
-----------------------------------------------------
The following settings are often modified from the default as part of the tuning effort for the **nginx** service and to configure the Chef Automate server to use SSL certificates:

``delivery['ssl_certificates']``
   A hash of SSL certificate files to use for FQDNs. Will use ``remote_file`` to download the key and crt specified. If you wanted to use a pre-generated SSL certificate for the main fqdn (``delivery_fqdn``) you could specify that here. For example:

   .. code-block:: ruby

      delivery['ssl_certificates'] = {
        'delivery.example.com' => {
          'key' => 'file:///etc/ssl_certificates/delivery.example.com.key',
          'crt' => 'file:///etc/ssl_certificates/delivery.example.com.crt'
        }
      }

``nginx['ssl_ciphers']``
   The list of supported cipher suites that are used to establish a secure connection. To favor AES256 with ECDHE forward security, drop the ``RC4-SHA:RC4-MD5:RC4:RSA`` prefix. See `this link <https://wiki.mozilla.org/Security/Server_Side_TLS>`__ for more information. Default value:

   .. code-block:: ruby

      "RC4-SHA:RC4-MD5:RC4:RSA:HIGH:MEDIUM:!LOW:!kEDH:!aNULL:!ADH:!eNULL:!EXP:!SSLv2:!SEED:!CAMELLIA:!PSK"

``nginx['ssl_protocols']``
   The SSL protocol versions that are enabled. For the highest possible security, disable SSL 3.0 and allow only TLS:

   .. code-block:: ruby

      nginx['ssl_protocols'] = 'TLSv1 TLSv1.1 TLSv1.2'

   Default value: Default value: ``"SSLv3 TLSv1"``.

.. note:: See https://wiki.mozilla.org/Security/Server_Side_TLS for more information about the values used with the ``nginx['ssl_ciphers']`` and ``nginx['ssl_protocols']`` settings.

For example, after copying the SSL certificate files to the Chef Automate server, update the ``delivery['ssl_certificates']`` hash settings to specify the paths to those files, and then (optionally) update the ``nginx['ssl_ciphers']`` and ``nginx['ssl_protocols']`` settings to reflect the desired level of hardness for the Chef Automate server:

.. code-block:: ruby

   delivery['ssl_certificates'] = {
      'delivery.example.com' => {
         'key' => 'file:///etc/ssl_certificates/delivery.example.com.key',
         'crt' => 'file:///etc/ssl_certificates/delivery.example.com.crt'
      }
   }
   nginx['ssl_ciphers'] = "HIGH:MEDIUM:!LOW:!kEDH:!aNULL:!ADH:!eNULL:!EXP:!SSLv2:!SEED:!CAMELLIA:!PSK"
   nginx['ssl_protocols'] = "TLSv1 TLSv1.1 TLSv1.2"

Proxy Settings
=====================================================
If you wish to operate your Chef Automate server from behind a proxy, you may specify you proxy host name and configuration using these options.

``delivery['proxy']['host']``
    The hostname to your proxy server such as ``foo.bar.com`` or ``192.168.1.10``.

``delivery['proxy']['port']``
    The port to connect on. This will be used for all connections (http and https).

``delivery['proxy']['user']``
   Optional authentication user name when contacting the proxy server.

``delivery['proxy']['password']``
    Optional authentication password when contacting the proxy server.

``delivery['proxy']['no_proxy']``
    A list of hostnames that are blacklisted from using the proxy. Chef Automate will attempt to connect directly to these hosts. By default, this is set to ``["localhost", "127.0.0.1"]``.

Notifier Settings
=====================================================
If we wish to enable the notification feature in Chef Automate, please set one or more of these following flags.  This will let you receive notifications or JSON messages from Automate whenever it detects a Chef client run failure on a node.

``notifier['enable']``
    Set this to ``true`` if you want to use the notification feature in Chef Automate.  None of the flags below will take effect unless this is set.

``notifier['slack_webhook_url']``
    A Slack webhook URL which will be used to post Chef client run failure notifications. The default Slack channel included in the url is used.  See http://api.slack.com/incoming-webhooks for details.

``notifier['user_webhook_url']``
    A custom webhook URL that will receive a JSON POST any time a Chef client run failure is detected.  The POST will have its ``Content-Type`` set to ``application/json``.  Here is an sample notification message body:

    .. code-block:: json

       {
         "automate_fqdn":"automate.test",
         "failure_snippet":"Chef client run failure on [chef-server.test] centos-runner-1.test : https://failure_url \n Failure Reason\n",
         "exception_backtrace":"A long string with the backtrace that contains \n",
         "exception_title":"Error Resolving Cookbooks for Run List:",
         "exception_message":"412 \"Precondition Failed\"",
         "automate_failure_url":"automate.test/long/url/that-takes-you-to-run-failure-page",
         "node_name":"centos-runner-1.test"
       }

``notifier['compliance_slack_webhook_url']``
    A Slack webhook URL which will be used to post Critical Inspec control failure notifications. The default Slack channel included in the url is used.  See http://api.slack.com/incoming-webhooks for details.


``notifier['compliance_user_webhook_url']``
    A custom webhook URL that will receive a JSON POST any time a Critical Inspec control failure is detected.  The POST will have its ``Content-Type`` set to ``application/json``.  Here is an sample notification message body:

    .. code-block:: json
    
       {
         "automate_fqdn":"automate.test",
         "failure_snippet":"Chef Inspec found a critical control failure on [chef-client.solo](automate.test/viz/#/node;entity_uuid=aaaaaaaa-709a-475d-bef5-zzzzzzzzzzzz;run_id=50bf2cf9-7f36-40cf-bee8-110a7c824f73)",
         "control_impact":"0.7",
         "automate_failure_url":"automate.test/viz/#/node;entity_uuid=aaaaaaaa-709a-475d-bef5-zzzzzzzzzzzz;run_id=50bf2cf9-7f36-40cf-bee8-110a7c824f73",
         "node_name":"chef-client.solo",
         "control_title":"Check /etc/missing6.rb",
         "control_id":"Checking /etc/missing6.rb existance",
         "profile_title":"Mylinux Failure Success",
         "type":"compliance_failure",
         "tests": [
               {
                   "status": "failed",
                   "code_desc": "File /etc/missing6.rb mode should eq 678",
                   "run_time": 0.001233,
                   "start_time": "2017-04-12 14:58:44 -0700",
                   "message": "\nexpected: 678\n     got: nil\n\n(compared using ==)\n"
               }
         ]
       }

Optional Settings
=====================================================
Additional settings are available for performance tuning of the Chef Automate server.

.. note:: When changes are made to the ``delivery.rb`` file the Chef Automate server must be reconfigured by running the following command:

          .. code-block:: bash

             $ delivery-server-ctl reconfigure

.. note:: Review the full list of :doc:`optional settings </config_rb_delivery_optional_settings>` that can be added to the ``delivery.rb`` file. Many of these optional settings should not be added without first consulting with Chef support.
