.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings:

``add_formatter``
   A 3rd-party formatter. (See `nyan-cat <https://github.com/andreacampi/nyan-cat-chef-formatter>`_ for an example of a 3rd-party formatter.) Each formatter requires its own entry. For example:

   .. code-block:: ruby

      add_formatter :nyan
      add_formatter :foo
      add_formatter :bar

``checksum_path``
   The location in which checksum files are stored. These are used to validate individual cookbook files, such as recipes. The checksum itself is stored in the Chef server database and is then compared to a file in the checksum path that has a filename identical to the checksum. For example:

   .. code-block:: ruby

      checksum_path 'path_to_folder'

``cookbook_path``
   The sub-directory for cookbooks on the chef-client. This value can be a string or an array of file system locations, processed in the specified order. The last cookbook is considered to override local modifications. For example:

   .. code-block:: ruby

      cookbook_path [ 
        '/var/chef/cookbooks', 
        '/var/chef/site-cookbooks' 
      ]

``data_bag_path``
   The location from which a data bag is loaded. Default value: ``/var/chef/databags``. For example:

   .. code-block:: ruby

      data_bag_path '/var/chef/databags'

``file_backup_path``
   The location in which backup files are stored. If this value is empty, backup files are stored in the directory of the target file. Default value: ``/var/chef/backup``. For example:

   .. code-block:: ruby

      file_backup_path '/var/chef/backup'

``file_cache_path``
   The location in which cookbooks (and other transient data) files are stored when they are synchronized. This value can also be used in recipes to download files with the **remote_file** resource. For example:

   .. code-block:: ruby

      file_cache_path '/var/chef/cache'

``json_attribs``
   The path to a file that contains JSON data. For example:

   .. code-block:: ruby

      json_attribs nil

``lockfile``
   The location of the chef-client lock file. For example:

   .. code-block:: ruby

      lockfile nil

``log_level``
   The level of logging to be stored in a log file. Possible levels: ``:auto`` (default), ``debug``, ``info``, ``warn``, ``error``, or ``fatal``. For example:

   .. code-block:: ruby

      log_level :info

``log_location``
   The location of the log file. Default value: ``STDOUT``. For example:

   .. code-block:: ruby

      log_location STDOUT

``node_name``
   The name of the node. For example:

   .. code-block:: ruby

      node_name 'mynode.example.com'

``recipe_url``
   The URL location from which a remote cookbook tar.gz is to be downloaded. For example:

   .. code-block:: ruby

      recipe_url 'http://path/to/remote/cookbook'

``rest_timeout``
   The time (in seconds) after which an HTTP REST request is to time out. Default value: ``300``. For example:

   .. code-block:: ruby

      rest_timeout 300

``role_path``
   The location in which role files are located. Default value: ``/var/chef/roles``. For example:

   .. code-block:: ruby

      role_path '/var/chef/roles'

``sandbox_path``
   The location in which cookbook files are stored (temporarily) during upload. For example:

   .. code-block:: ruby

      sandbox_path 'path_to_folder'

``solo``
   Run the chef-client in chef-solo mode. This setting determines if the chef-client is to attempt to communicate with the Chef server. Default value: ``false``. For example:

   .. code-block:: ruby

      solo false

``syntax_check_cache_path``
   All files in a cookbook must contain valid Ruby syntax. Use this setting to specify the location in which knife caches information about files that have been checked for valid Ruby syntax.

``umask``
   The file mode creation mask, or umask. Default value: ``0022``. For example:

   .. code-block:: ruby

      umask 0022

``verbose_logging``
   Set the log level. Options: ``true``, ``nil``, and ``false``. When this is set to ``false``, notifications about individual resources being processed are suppressed (and are output at the ``:info`` logging level). Setting this to ``false`` can be useful when a chef-client is run as a daemon. Default value: ``nil``. For example, when ``verbose_logging`` is set to ``true`` or ``nil``:

   .. code-block:: bash

      [date] INFO: *** Chef 0.10.6.rc.1 ***
      [date] INFO: Setting the run_list 
                   to ["recipe[a-verbose-logging]"] from JSON
      [date] INFO: Run List is [recipe[a-verbose-logging]]
      [date] INFO: Run List expands to [a-verbose-logging]
      [date] INFO: Starting Chef Run for some_node
      [date] INFO: Running start handlers
      [date] INFO: Start handlers complete.
      [date] INFO: Loading cookbooks [test-verbose-logging]
      [date] INFO: Processing file[/tmp/a1] action create  
                   (a-verbose-logging::default line 20)
      [date] INFO: Processing file[/tmp/a2] action create  
                   (a-verbose-logging::default line 21)
      [date] INFO: Processing file[/tmp/a3] action create  
                   (a-verbose-logging::default line 22)
      [date] INFO: Processing file[/tmp/a4] action create  
                   (a-verbose-logging::default line 23)
      [date] INFO: Chef Run complete in 1.802127 seconds
      [date] INFO: Running report handlers
      [date] INFO: Report handlers complete

   When ``verbose_logging`` is set to ``false`` (for the same output):

   .. code-block:: bash

      [date] INFO: *** Chef 0.10.6.rc.1 ***
      [date] INFO: Setting the run_list 
                   to ["recipe[a-verbose-logging]"] from JSON
      [date] INFO: Run List is [recipe[a-verbose-logging]]
      [date] INFO: Run List expands to [a-verbose-logging]
      [date] INFO: Starting Chef Run for some_node
      [date] INFO: Running start handlers
      [date] INFO: Start handlers complete.
      [date] INFO: Loading cookbooks [a-verbose-logging]
      [date] INFO: Chef Run complete in 1.565369 seconds
      [date] INFO: Running report handlers
      [date] INFO: Report handlers complete

   Where in the examples above, ``[date]`` represents the date and time the long entry was created. For example: ``[Mon, 21 Nov 2011 09:37:39 -0800]``.
