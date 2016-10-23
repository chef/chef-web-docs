.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The environment variables ``http_proxy``, ``https_proxy``, and ``ftp_proxy`` are honored by Kitchen for proxies. The client.rb file is read to look for proxy configuration settings. If ``http_proxy``, ``https_proxy``, and ``ftp_proxy`` are specified in the client.rb file, the chef-client will configure the ``ENV`` variable based on these (and related) settings. For example:

.. code-block:: ruby

   http_proxy 'http://proxy.example.org:8080'
   http_proxy_user 'myself'
   http_proxy_pass 'Password1'

will be set to:

.. code-block:: ruby

   ENV['http_proxy'] = 'http://myself:Password1@proxy.example.org:8080'

Kitchen also supports ``http_proxy`` and ```https_proxy`` in the ``.kitchen.yml`` file:

.. code-block:: yaml

   driver:
     name: vagrant

   provisioner:
     name: chef_zero
     http_proxy: http://10.0.0.1
