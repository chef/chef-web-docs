=====================================================
manage.rb
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/config_rb_manage.rst>`__

.. meta:: 
    :robots: noindex 

.. tag chef_automate_mark

.. image:: ../../images/a2_docs_banner.svg
   :target: https://automate.chef.io/docs

.. end_tag

.. tag EOL_manage

.. warning:: Chef Manage is `deprecated </versions.html#deprecated-products-and-versions>`__. The `Chef Enterprise Automation Stack <https://www.chef.io/products/enterprise-automation-stack>`_ allows you to define infrastructure, security policies, and application dependencies as code, deliver the stack via an automated pipeline to any platform, and deploy, observe, and manage the stack over its lifecycle. Chef Automate is included as part of the Chef license agreement and is `available via subscription <https://www.chef.io/pricing/>`_.

.. end_tag


.. tag EOL_a1

.. danger:: This documentation applies to a deprecated product </versions.html#deprecated-products-and-versions>`__. The new Chef Automate includes newer out-of-the-box compliance profiles, an improved compliance scanner with total cloud scanning functionality, better visualizations, role-based access control and many other features. The new Chef Automate is included as part of the Chef Automate license agreement and is `available via subscription <https://www.chef.io/pricing/>`_.

.. end_tag

.. tag chef_manager

Chef management console is a web-based interface for the Chef Infra Server that provides users a way to manage the following objects:

* Nodes
* Cookbooks and recipes
* Roles
* Stores of JSON data (data bags), including encrypted data
* Environments
* Searching of indexed data
* User accounts and user data for the individuals who have permission to log on to and access the Chef server

.. end_tag

The manage.rb file is the default configuration file used by Chef management console. These settings are applied every time ``chef-manage-ctl reconfigure`` is run.

The configuration file is located at: ``/etc/chef-manage/manage.rb``.

Settings
==========================================================================

.. warning:: All of the following settings should be specified without using the equals symbol (``=``). For example:

   .. code-block:: ruby

      chef_documentation_url 'https://docs.chef.io'

This configuration file has the following settings:

``backbone_paginator_timeout``
   The amount of time (in milliseconds) after which search requests made via the web client will timeout and cause an error. Default value: ``120000``.

``chef_documentation_url``
   The URL at which documentation for Chef is located. Default value: ``https://docs.chef.io``.

``disable_sign_up``
   Use to disable sign-up and only allow sign-in. Default value: ``false``.

``email_from_address``
   The email address from which Chef Infra Server notifications are sent. Default value: ``'Chef Notifications <notifications@chef.io>'``.

``events.port``
   The port on which the events services run. Default value: ``11001``.

``logging.chef_log_level``
   The log level used for requests to the Chef Infra Server from the web application. Default value: ``info``.

``logging.log_level``
   The log level for Ruby on Rails services. Default value: ``info``.

``max_login_failures``
   The the maximim number of failed login attempts allowed before the user must use the password reset link to reset their password (has no effect when using external authentication/LDAP). Default value: ``7``.

``nginx_addon_prefix``
   The prefix used by Chef management console. Default value: ``30``.

``org_creation_enabled``
   Whether or not users can create new organizations from Chef management console.  Default value: ``true``.

``platform.user``
   The name of the privileged user that manages requests to the Chef Infra Server. Default value: ``'pivotal'``.

``public_port``
   The port on which the external load balancer will listen. Default value: ``443``.

``recaptcha.enabled``
   Enable reCAPTCHA for the sign-up page. Default value: ``false``.

``recaptcha.fail_open``
   If the reCAPTCHA service cannot be reached, allow to sign-up? Default value: ``true``.

``recaptcha.verify_url``
   Verify-URL of reCAPTCHA service to be used. Default value: ``https://www.google.com/recaptcha/api/siteverify``.

``recaptcha.site_key``
   The Site Key received from reCAPTCHA.

``recaptcha.secret_key``
   The Secret Key received from reCAPTCHA.

``redis.host``
   The host on which Redis runs. Default value: ``localhost``.

``redis.port``
   The port on which Redis listens. Default value: ``11002``.

``redis.url``
   The URL used by Redis. Default value: ``redis://#{redis.host}:#{redis.port}/0``.

``runit_timeout``
   The amount of time (in seconds) to wait before timing out. Default value: ``30``.

``secret_token``
   The secret token used by Ruby on Rails to prevent session tampering. See: http://guides.rubyonrails.org/security.html#session-storage. Default value: **generated**.

   To override the default value, use the `Secrets Management </ctl_chef_server.html#ctl-chef-server-secrets-management>`__ commands: ``chef-server-ctl set-secret manage secret_token``.

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
   The URL at which links to Chef support are located. Default value: ``http://chef.io/support``.

``support_tickets_url``
   The URL at which Chef support tickets are created. Default value: ``https://chef.io/support/tickets``.

``webapp.backlog``
   The size of the backlog. Default value: ``1024``.

``webapp.listen``
   The port on which Chef management console services listen. Default value: ``{ '127.0.0.1:#{port}' }``.

``webapp.port``
   The port on which Chef management console services run. Default value: ``9462``.

``webapp.tcp_nodelay``
   Enable the Nagle buffering algorithm. Default value: ``true``.

``webapp.worker_processes``
   The number of allowed worker processes. Default value: ``node['cpu.total'].to_i``.

``webapp.worker_timeout``
   The amount of time (in seconds) that a worker can be silent before it is killed and restarted. Default value: ``3600``.

Web UI Private Key
==========================================================================
Chef Manage uses the Web UI private key for signing requests sent to the Chef Infra Server.
The key is subject to Chef server's `Secrets Management </ctl_chef_server.html#ctl-chef-server-secrets-management>`__, and will be stored in ``/etc/opscode/private-chef-secrets.json``.

Any run of ``chef-server-ctl reconfigure`` will ensure the key exists and is stored without any additional steps.

To verify that the key is stored and ready to use by manage, run:

.. code-block:: bash

   $ chef-server-ctl show-secret chef-server webui_key
   -----BEGIN RSA PRIVATE KEY-----
   MIIEpgIBAAKCAQEA3fJ+U+5prsJ8PtnbYzWAq+J2cE48u+iT7t/M9JS+3tlEgf3r
   1PTl70cW9jOI+kGGvayTKb8Dzqtm0tpQJo7Bv+XX42OylyVF2SN4WvMusT+jtJuF
   ...
   -----END RSA PRIVATE KEY-----


Example
==========================================================================
The following example shows how the settings look when added to the configuration file:

.. code-block:: ruby

   chef_documentation_url ''
   disable_sign_up false
   events.port 11001
   logging.chef_log_level 'info'
   logging.log_level 'info'
   nginx_addon_prefix 30
   platform.user 'pivotal'
   public_port 443
   redis.host 'localhost'
   redis.port 11002
   # redis.url derived from redis.host and redis.port
   runit_timeout 30
   services['opscode-manage-events'].enable true
   services['opscode-manage-webapp'].enable true
   services['opscode-manage-worker'].enable true
   support_email_address 'support@chef.io'
   support_site_url 'http://chef.io/support'
   support_tickets_url 'https://chef.io/support/tickets'
   webapp.backlog 1024
   # webapp.listen derived from webapp.port
   webapp.port 9462
   webapp.tcp_nodelay true
   webapp.worker_processes 2
   webapp.worker_timeout 3600
