.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following general settings:

``enterprise['name']``
   Default value: ``'supermarket'``.

``supermarket['app_directory']``
   Default value: ``"#{node['supermarket']['install_directory']}/embedded/service/supermarket"``.

``supermarket['chef_server_url']``
   |url chef_server|

``supermarket['config_directory']``
   Default value: ``'/etc/supermarket'``.

``supermarket['features']``
   Use to enable announcments, CLA features, a service that reports on cookbook quality, |github| integration, enable joining of corporate CLAs, and tools. Default value: ``'tools'``.

``supermarket['fqdn']``
   Default value: ``node['fqdn']``.

``supermarket['group']``
   Default value: ``'supermarket'``.

``supermarket['install_directory']``
   Default value: ``'/opt/supermarket'``.

``supermarket['install_path']``
   The directory in which |supermarket| is installed. Default value: ``node['supermarket']['install_directory']``.

``supermarket['log_directory']``
   Default value: ``'/var/log/supermarket'``.

``supermarket['sysvinit_id']``
   Use to specify 1-4 characters that define a unique identifier for the file located in ``/etc/inittab``. Default value: ``SUP``.

``supermarket['user']``
   Default value: ``'supermarket'``.

``supermarket['var_directory']``
   Default value: ``'/var/opt/supermarket'``.

.. there are these as well:
.. 
.. supermarket['fieri_url'] = nil
.. supermarket['fieri_key'] = nil
.. supermarket['from_email'] = nil
.. supermarket['github_access_token'] = nil
.. supermarket['github_key'] = nil
.. supermarket['github_secret'] = nil
.. supermarket['google_analytics_id'] = nil
.. supermarket['host'] = node['supermarket']['fqdn']
.. supermarket['newrelic_agent_enabled'] = 'false'
.. supermarket['newrelic_app_name'] = nil
.. supermarket['newrelic_license_key'] = nil
.. supermarket['port'] = node['supermarket']['nginx']['force_ssl'] ? node['supermarket']['nginx']['ssl_port'] : node['supermarket']['non_ssl_port']
.. supermarket['protocol'] = node['supermarket']['nginx']['force_ssl'] ? 'https' : 'http'
.. supermarket['pubsubhubbub_callback_url'] = nil
.. supermarket['pubsubhubbub_secret'] = nil
.. supermarket['redis_url'] = "redis://#{node['supermarket']['redis']['bind']}:#{node['supermarket']['redis']['port']}/0/supermarket"
.. supermarket['sentry_url'] = nil