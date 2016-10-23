.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following general settings:

``addons['install']``
   Default value: ``false``.

``addons['path']``
   Default value: ``nil``.

``addons['packages']``
   Default value:

   .. code-block:: ruby

      %w{opscode-reporting chef-manage opscode-analytics opscode-push-jobs-server}

``api_version``
   The version of the Chef server. Default value: ``'12.0.0'``.

``default_orgname``
   The Chef server API used by the Open Source Chef server does not have an ``/organizations/ORG_NAME`` endpoint. Use this setting to ensure that migrated Open Source Chef servers are able to connect to the Chef server API. This value should be the same as the name of the organization that was created during the upgrade from Open Source Chef version 11 to Chef server version 12, which means it will be identical to the ``ORG_NAME`` part of the ``/organizations`` endpoint in Chef server version 12. Default value: the name of the organization specified during the upgrade process from Open Source Chef 11 to Chef server 12.

``flavor``
   Default value: ``'cs'``.

``install_path``
   The directory in which the Chef server is installed. Default value: ``'/opt/opscode'``.

``from_email``
   The email address from which invitations to the Chef management console are sent. Default value: ``'"Opscode" <donotreply@opscode.com>'``.

``license['nodes']``
   The number of licensed nodes. Default value: ``25``.

``license['upgrade_url']``
   The URL to visit for more information about how to update the number of nodes licensed for an organization. Default value: ``'http://www.chef.io/contact/on-premises-simple'``.

``notification_email``
   The email addressed to which email notifications are sent. Default value: ``'pc-default@opscode.com'``.

``role``
   The configuration type of the Chef server. Possible values: ``backend``, ``frontend``, or ``standalone``. Default value: ``'standalone'``.

``topology``
   The topology of the Chef server. Possible values: ``ha``, ``manual``, ``standalone``, and ``tier``. Default value: ``'standalone'``.
