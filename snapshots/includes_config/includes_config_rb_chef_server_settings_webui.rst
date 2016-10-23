.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings:

``chef_server_webui['backlog']``
   Default value: ``1024``.

``chef_server_webui['cookie_domain']``
   Default value: ``all``.

``chef_server_webui['cookie_secret']``
   Default value: ``47b3b8d95dea455baf32155e95d1e64e``.

``chef_server_webui['dir']``
   The working directory. The default value is the recommended value. Default value: ``/var/opt/chef-server/chef-server-webui``.

``chef_server_webui['enable']``
   Enable a service. Default value: ``true``.

``chef_server_webui['environment']``
   Default value: ``chefserver``.

``chef_server_webui['ha']``
   Run the Chef server in a high availability topology. Default value: ``false``.

``chef_server_webui['listen']``
   Default value: ``127.0.0.1:9462``.

``chef_server_webui['log_directory']``
   The directory in which log files are located. Default value: ``/var/log/chef-server/chef-server-webui``.

``chef_server_webui['port']``
   The port on which the service is to listen. Default value: ``9462``.

``chef_server_webui['session_key']``
   Default value: ``_sandbox_session``.

``chef_server_webui['tcp_nodelay']``
   Enable the Nagle buffering algorithm. Default value: ``true``.

``chef_server_webui['umask']``
   The file mode creation mask, or umask. Default value: ``0022``.

``chef_server_webui['vip']``
   The virtual IP address. Default value: ``127.0.0.1``.

``chef_server_webui['web_ui_admin_default_password']``
   Default value: ``p@ssw0rd1``.

``chef_server_webui['web_ui_admin_user_name']``
   The name of the administrator for the web user interface. Default value: ``admin``.

``chef_server_webui['web_ui_client_name']``
   The name of the Chef server web user interface. Default value: ``chef-webui``.

``chef_server_webui['worker_processes']``
   The number of allowed worker processes. Default value: ``2``.

``chef_server_webui['worker_timeout']``
   The amount of time (in seconds) that a worker can be silent before it is killed and restarted. Default value: ``3600``.
