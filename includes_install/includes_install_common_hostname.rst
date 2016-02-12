.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 

The hostname for the |chef server| may be specified using a |fqdn| or an IP address. This hostname must be resolvable. For example, a |chef server| running in a production environment with a resolvable |fqdn| hostname can be added the |dns| system. But when deploying |chef server| into a testing environment, adding the hostname to the ``/etc/hosts`` file is enough to ensure that hostname is resolvable.

* **FQDN Hostnames** When the hostname for the |chef server| is a |fqdn| be sure to include the domain suffix. For example, something like ``mychefserver.example.com`` (and not something like ``mychefserver``).
* **IP Address Hostnames** When the |chef server| is run in IPv6 mode, a hostname specified using an IP address must also be bracketed (``[ ]``) or the |chef server| will not be able to recognize it as an IPv6 address. For example:

   .. code-block:: ruby
   
      bookshelf['url'] "https://[2001:db8:85a3:8d3:1319:8a2e:370:7348]"

The ``api_fqdn`` setting can be added to the |enterprise rb| file (it is not there by default). When added, its value should be equal to the |fqdn| or IP address for the service URI used by the |chef server|. Then configure the same value for the ``bookshelf['vip']`` setting prior to installing |chef server oec|. For example: ``api_fqdn "chef.example.com"`` or ``api_fqdn 123.45.67.890``.