.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This configuration file has the following settings:

``backbone_paginator_timeout``
   The amount of time (in milliseconds) after which search requests made via the web client will timeout and cause an error. Default value: ``120000``.

``chef_documentation_url``
   The URL at which documentation for |chef| is located. Default value: ``https://docs.chef.io``.

``disable_sign_up``
   Use to disable sign-up and only allow sign-in. Default value: ``false``.

``email_from_address``
   The email address from which |chef server| notifications are sent. Default value: ``'Chef Notifications <notifications@chef.io>'``.

``events.port``
   The port on which the events services run. Default value: ``11001``.

``logging.chef_log_level``
   The log level used for requests to the |chef server| from the web application. Default value: ``info``.

``logging.log_level``
   The log level for |ruby on rails| services. Default value: ``info``.

``max_login_failures``
   The the maximim number of failed login attempts allowed before the user must use the password reset link to reset their password (has no effect when using external authentication/LDAP). Default value: ``7``.

``nginx_addon_prefix``
   The prefix used by |chef manage|. Default value: ``30``.

``org_creation_enabled``
   Whether or not users can create new organizations from |chef manage|.  Default value: ``true``.

``platform.user``
   The name of the privileged user that manages requests to the |chef server|. Default value: ``'pivotal'``.

``platform.key_file``
   The key file used by the privileged user. Default value: ``'/etc/opscode/webui_priv.pem'``.

``public_port``
   The port on which the external load balancer will listen. Default value: ``443``.

``redis.host``
   The host on which |redis| runs. Default value: ``localhost``.

``redis.port``
   The port on which |redis| listens. Default value: ``11002``.

``redis.url``
   The URL used by |redis|. Default value: ``redis://#{redis.host}:#{redis.port}/0``.

``runit_timeout``
   The amount of time (in seconds) to wait before timing out. Default value: ``30``.

``secret_token``
   The secret token used by |ruby on rails| to prevent session tampering. See: http://guides.rubyonrails.org/security.html#session-storagel. Default value: (a token).

``services['opscode-manage-events'].enable``
   Use to enable the ``opscode-manage-events`` service. Default value: ``true``.

``services['opscode-manage-webapp'].enable``
   Use to enable the ``opscode-manage-webapp`` service. Default value: ``true``.

``services['opscode-manage-worker'].enable``
   Use to enable the ``opscode-manage-worker`` service. Default value: ``true``.

``session_timeout``
   The amount of time (in minutes) of inactivity before a user is logged out. When not set (or set to 0), a browser session will not have a timed expiration and will expire when the browser session ends, quits, or when the computer restarts, or when the absolute session time limit is hit (see ``session_timeout_absolute``).  Default value: ``1440`` (one day).

``session_timeout_absolute``
   The amount of time (in minutes) after which a user will be logged out, regardless of activity. When not set (or set to 0), a browser session will not have a timed expiration unless a session is inactive longer than the session time limit (see ``session_timeout``).  Default value: ``10080`` (one week).

``sign_in_page_message``
   A message to display on the sign-in page. If present, the message will show up in a box on the sign in page. Any valid HTML is allowed here. Default value: ``nil``.

``support_email_address``
   The email address used to send feedback. Default value: ``support@chef.io``.

``support_site_url``
   The URL at which links to |company_name| support are located. Default value: ``http://chef.io/support``.

``support_tickets_url``
   The URL at which |company_name| support tickets are created. Default value: ``https://chef.io/support/tickets``.

``webapp.backlog``
   The size of the backlog. Default value: ``1024``.

``webapp.listen``
   The port on which |chef manage| services listen. Default value: ``{ '127.0.0.1:#{port}' }``.

``webapp.port``
   The port on which |chef manage| services run. Default value: ``9462``.

``webapp.tcp_nodelay``
   |use nagle| Default value: ``true``.

``webapp.worker_processes``
   |worker_processes| Default value: ``node['cpu.total'].to_i``.

``webapp.worker_timeout``
   |timeout worker| Default value: ``3600``.
