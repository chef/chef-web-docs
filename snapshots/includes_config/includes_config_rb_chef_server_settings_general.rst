.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings:

``api_fqdn``
   The FQDN for the Chef server. This setting is not in the private-chef.rb file by default. When added, its value should be equal to the FQDN for the service URI used by the Chef server. Then configure the same value for the ``bookshelf['vip']`` setting prior to installing the Chef server. For example: ``api_fqdn 'chef.example.com'``.

``bootstrap``
   Default value: ``true``.

``ip_version``
   Use to enable IPv6 and run Open Source Chef in "dual IPv4/IPv6 mode". When this setting is ``ipv6``, the Open Source Chef server will use IPv6 for all internal comunication and will be able to accept external communications that are using IPv6 (via the Nginx load balancer). Default value: ``ipv4``.

   .. note:: Setting ``ip_version`` to true will also set ``nginx['enable_ipv6']`` to ``true``.

``notification_email``
   Default value: ``info@example.com``.

``topology``
   Default value: ``standalone``.
