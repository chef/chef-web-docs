.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following example shows how the settings look when added to the configuration file:

.. code-block:: ruby

   chef_documentation_url 'https://docs.chef.io'
   disable_sign_up false
   events.port 11001
   logging.chef_log_level 'info'
   logging.log_level 'info'
   nginx_addon_prefix 30
   platform.user 'pivotal'
   platform.key_file '/etc/opscode/webui_priv.pem'
   public_port 443
   redis.host 'localhost'
   redis.port 11002
   # redis.url derived from redis.host and redis.port
   runit_timeout 30
   secret_token 'abcdefghij1234567890KLMNOPQRST1234567890uvwxyzabcd'
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
