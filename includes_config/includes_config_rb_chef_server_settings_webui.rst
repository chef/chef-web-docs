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
   |directory generic| |default_value_recommended| Default value: ``/var/opt/chef-server/chef-server-webui``.

``chef_server_webui['enable']``
   |enable service| Default value: ``true``.

``chef_server_webui['environment']``
   Default value: ``chefserver``.

``chef_server_webui['ha']``
   |use ha| Default value: ``false``.

``chef_server_webui['listen']``
   Default value: ``127.0.0.1:9462``.

``chef_server_webui['log_directory']``
   The directory in which log files are located. Default value: ``/var/log/chef-server/chef-server-webui``.

``chef_server_webui['port']``
   |port service| Default value: ``9462``.

``chef_server_webui['session_key']``
   Default value: ``_sandbox_session``.

``chef_server_webui['tcp_nodelay']``
   |use nagle| Default value: ``true``.

``chef_server_webui['umask']``
   |umask| Default value: ``0022``.

``chef_server_webui['vip']``
   |ip_address virtual| Default value: ``127.0.0.1``.

``chef_server_webui['web_ui_admin_default_password']``
   Default value: ``p@ssw0rd1``.

``chef_server_webui['web_ui_admin_user_name']``
   |name admin_webui| Default value: ``admin``.

``chef_server_webui['web_ui_client_name']``
   |name client_webui| Default value: ``chef-webui``.

``chef_server_webui['worker_processes']``
   |worker_processes| Default value: ``2``.

``chef_server_webui['worker_timeout']``
   |timeout worker| Default value: ``3600``.
