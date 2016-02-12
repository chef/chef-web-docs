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

      %w{opscode-reporting opscode-manage opscode-analytics opscode-push-jobs-server}

``api_version``
   |version chef_server| Default value: ``'12.0.0'``.

``default_orgname``
   |default_orgname|

``flavor``
   Default value: ``'cs'``.

``install_path``
   |directory chef_server| Default value: ``'/opt/opscode'``.

``from_email``
   The email address from which invitations to the |chef manage| are sent. Default value: ``'"Opscode" <donotreply@opscode.com>'``.

``license['nodes']``
   |license chef_server| Default value: ``25``.

``license['upgrade_url']``
   |license url| Default value: ``'http://www.chef.io/contact/on-premises-simple'``.

``notification_email``
   |email chef_server| Default value: ``'pc-default@opscode.com'``.

``role``
   |role chef_server| Possible values: ``backend``, ``frontend``, or ``standalone``. Default value: ``'standalone'``.

``topology``
   The topology of the |chef server|. Possible values: ``ha``, ``manual``, ``standalone``, and ``tier``. Default value: ``'standalone'``.
