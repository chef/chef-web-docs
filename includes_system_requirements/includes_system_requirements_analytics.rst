.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


|chef analytics| has the following requirements:

* |chef server oec| version 11.1.8 (or later)
* |chef analytics| will run on any platform supported by |chef server oec|

When configured in |standalone| mode:

* The |chef analytics| machine needs to connect to the |chef server oec| machine on the rabbitmq port (default 5672)
* |chef analytics| requires the ``api_fqdn`` to be set in the ``/etc/opscode/private-chef.rb`` file. For example:

  .. code-block:: ruby
  
     api_fqdn = 'CHEF_SERVER_VIP'

