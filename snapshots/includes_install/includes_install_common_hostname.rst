.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 

The hostname for the Chef server may be specified using a FQDN or an IP address. This hostname must be resolvable. For example, a Chef server running in a production environment with a resolvable FQDN hostname can be added the DNS system. But when deploying Chef server into a testing environment, adding the hostname to the ``/etc/hosts`` file is enough to ensure that hostname is resolvable.

* **FQDN Hostnames** When the hostname for the Chef server is a FQDN be sure to include the domain suffix. For example, something like ``mychefserver.example.com`` (and not something like ``mychefserver``).
* **IP Address Hostnames** When the Chef server is run in IPv6 mode, a hostname specified using an IP address must also be bracketed (``[ ]``) or the Chef server will not be able to recognize it as an IPv6 address. For example:

   .. code-block:: ruby
   
      bookshelf['url'] "https://[2001:db8:85a3:8d3:1319:8a2e:370:7348]"

The ``api_fqdn`` setting can be added to the private-chef.rb file (it is not there by default). When added, its value should be equal to the FQDN or IP address for the service URI used by the Chef server. Then configure the same value for the ``bookshelf['vip']`` setting prior to installing the Chef server. For example: ``api_fqdn "chef.example.com"`` or ``api_fqdn 123.45.67.890``.
