

=====================================================
solo.rb
=====================================================

.. warning:: .. tag notes_chef_solo_use_local_mode

             The chef-client :ref:`includes an option called local mode <ctl_chef_client-run-in-local-mode>` (``--local-mode`` or ``-z``), which runs the chef-client against the chef-repo on the local machine as if it were running against a Chef server. Local mode was added to the chef-client in the 11.8 release. If you are running that version of the chef-client (or later), you should consider using local mode instead of using chef-solo.

             .. end_tag

.. tag config_rb_solo_24

A solo.rb file is used to specify the configuration details for chef-solo.

* This file is loaded every time this executable is run
* The default location in which chef-solo expects to find this file is ``/etc/chef/solo.rb``; use the ``--config`` option from the command line to change this location
* This file is not created by default
* When a ``solo.rb`` file is present in this directory, the settings contained within that file will override the default configuration settings

.. end_tag

Settings
==========================================================================

.. tag 12_solo_settings

This configuration file has the following settings:

``add_formatter``
   A 3rd-party formatter. (See `nyan-cat <https://github.com/andreacampi/nyan-cat-chef-formatter>`_ for an example of a 3rd-party formatter.) Each formatter requires its own entry.

``checksum_path``
   The location in which checksum files are stored. These are used to validate individual cookbook files, such as recipes. The checksum itself is stored in the Chef server database and is then compared to a file in the checksum path that has a filename identical to the checksum.

``cookbook_path``
   The sub-directory for cookbooks on the chef-client. This value can be a string or an array of file system locations, processed in the specified order. The last cookbook is considered to override local modifications.

``data_bag_path``
   The location from which a data bag is loaded. Default value: ``/var/chef/data_bags``.

``environment``
   The name of the environment.

``environment_path``
   The path to the environment.  Default value: ``/var/chef/environments``.

``file_backup_path``
   The location in which backup files are stored. If this value is empty, backup files are stored in the directory of the target file. Default value: ``/var/chef/backup``.

``file_cache_path``
   The location in which cookbooks (and other transient data) files are stored when they are synchronized. This value can also be used in recipes to download files with the **remote_file** resource.

``json_attribs``
   The path to a file that contains JSON data.

``lockfile``
   The location of the chef-client lock file.

``log_level``
   The level of logging to be stored in a log file. Possible levels: ``:auto`` (default), ``debug``, ``info``, ``warn``, ``error``, or ``fatal``.

``log_location``
   The location of the log file. Default value: ``STDOUT``.

``node_name``
   The name of the node.

``recipe_url``
   The URL location from which a remote cookbook tar.gz is to be downloaded.

``rest_timeout``
   The time (in seconds) after which an HTTP REST request is to time out. Default value: ``300``.

``role_path``
   The location in which role files are located. Default value: ``/var/chef/roles``.

``sandbox_path``
   The location in which cookbook files are stored (temporarily) during upload.

``solo``
   Run the chef-client in chef-solo mode. This setting determines if the chef-client is to attempt to communicate with the Chef server. Default value: ``false``.

``syntax_check_cache_path``
   All files in a cookbook must contain valid Ruby syntax. Use this setting to specify the location in which knife caches information about files that have been checked for valid Ruby syntax.

``umask``
   The file mode creation mask, or umask. Default value: ``0022``.

``verbose_logging``
   Set the log level. Options: ``true``, ``nil``, and ``false``. When this is set to ``false``, notifications about individual resources being processed are suppressed (and are output at the ``:info`` logging level). Setting this to ``false`` can be useful when a chef-client is run as a daemon. Default value: ``nil``.

.. end_tag

