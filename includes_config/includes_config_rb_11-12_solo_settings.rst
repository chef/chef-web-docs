.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings:

``add_formatter``
   |add_formatter| (See `nyan-cat <https://github.com/andreacampi/nyan-cat-chef-formatter>`_ for an example of a 3rd-party formatter.) Each formatter requires its own entry.

``checksum_path``
   |checksum_path|

``cookbook_path``
   |cookbook_path subdirectory|

``data_bag_path``
   |data_bag_path| Default value: ``/var/chef/data_bags``.

``environment``
   |name environment|

``environment_path``
   |path environment|  Default value: ``/var/chef/environments``.

``file_backup_path``
   |path file_backup| Default value: ``/var/chef/backup``.

``file_cache_path``
   |file cache_path|

``json_attribs``
   |json attributes|

``lockfile``
   |lockfile|

``log_level``
   |log_level| Possible levels: ``:auto`` (default), ``debug``, ``info``, ``warn``, ``error``, or ``fatal``.

``log_location``
   |log_location| Default value: ``STDOUT``.

``node_name``
   |name node|

``recipe_url``
   |recipe_url|

``rest_timeout``
   |timeout rest| Default value: ``300``.

``role_path``
   |path roles_chef| Default value: ``/var/chef/roles``.

``sandbox_path``
   |sandbox_path|

``solo``
   |solo mode| Default value: ``false``.

``syntax_check_cache_path``
   |syntax_check_cache_path|

``umask``
   |umask| Default value: ``0022``.

``verbose_logging``
   |verbose_logging| Default value: ``nil``.