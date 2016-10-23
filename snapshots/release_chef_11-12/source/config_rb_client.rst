.. THIS PAGE DOCUMENTS chef-client version 11.12

=====================================================
client.rb
=====================================================

.. include:: ../../includes_config/includes_config_rb_client.rst

Settings
=====================================================
This configuration file has the following settings:

``add_formatter``
   A 3rd-party formatter. (See `nyan-cat <https://github.com/andreacampi/nyan-cat-chef-formatter>`_ for an example of a 3rd-party formatter.) Each formatter requires its own entry.

``cache_path``
   Optional. The home directory for the user that is running the chef-client as a non-root user.

``checksum_path``
   The location in which checksum files are stored. These are used to validate individual cookbook files, such as recipes. The checksum itself is stored in the Chef server database and is then compared to a file in the checksum path that has a filename identical to the checksum.

``chef_server_url``
   The URL for the Chef server.

``chef_zero.enabled``
   Enable chef-zero. Default value: ``false``.

``chef_zero[:port]``
   The port on which chef-zero is to listen. Default value: ``8889``.

``client_key``
   The location of the file that contains the client key. Default value: ``/etc/chef/client.pem``.

``client_registration_retries``
   The number of times a chef-client is to attempt to register with a Chef server. Default value: ``5``.

``cookbook_path``
   The sub-directory for cookbooks on the chef-client. This value can be a string or an array of file system locations, processed in the specified order. The last cookbook is considered to override local modifications.

``data_bag_decrypt_minimum_version``
   The minimum required version of data bag encryption. Possible values: ``0``, ``1``, and ``2``. When all of the machines in an organization are running chef-client version 11.6 (or higher), it is recommended that this value be set to ``2``.

``data_bag_path``
   The location from which a data bag is loaded. Default value: ``/var/chef/data_bags``.

``diff_disabled``
   Cause the chef-client to create a diff when changes are made to a file. Default value: ``false``.

``diff_filesize_threshold``
   The maximum size (in bytes) of a file for which the chef-client can create a diff. Default value: ``10000000``.

``diff_output_threshold``
   The maximum size (in bytes) of a diff file created by the chef-client. Default value: ``1000000``.

``enable_reporting``
   Cause the chef-client to send data to the Chef server for use with Reporting. 

   .. warning:: This setting is available only when using Reporting, an add-on for Enterprise Chef that collects reporting data about nodes.

``enable_reporting_url_fatals``
   Cause the chef-client run to fail when Reporting data cannot be sent to the Chef server (for any reason).

   .. warning:: This setting is available only when using Reporting, an add-on for Enterprise Chef that collects reporting data about nodes.

``enable_selinux_file_permission_fixup``
   SELinux environments only. Cause the chef-client to attempt to apply the correct file permissions to an updated file via the ``restorecon`` command. Set this value to ``false`` to prevent the chef-client from attempting this action.

``encrypted_data_bag_secret``
   The subdirectory in which encrypted data bag secrets are located.

``environment``
   The name of the environment.

``environment_path``
   The path to the environment. Default value: ``/var/chef/environments``.

``file_atomic_update``
   Apply atomic file updates to all resources. Set to ``true`` for global atomic file updates. Set to ``false`` for global non-atomic file updates. (Use the ``atomic_update`` setting on a per-resource basis to override this setting.) Default value: ``true``.

   .. warning:: .. include:: ../../includes_notes/includes_notes_config_rb_no_file_atomic_update.rst

``file_backup_path``
   The location in which backup files are stored. If this value is empty, backup files are stored in the directory of the target file. Default value: ``/var/chef/backup``.

``file_cache_path``
   The location in which cookbooks (and other transient data) files are stored when they are synchronized. This value can also be used in recipes to download files with the **remote_file** resource.

``file_staging_uses_destdir``
   How file staging (via temporary files) is done. When ``true``, temporary files are created in the directory in which files will reside. When ``false``, temporary files are created under ``ENV['TMP']``. Default value: ``false``.

``group``
   The group that owns a process. This is required when starting any executable as a daemon. Default value: ``nil``.

``http_proxy``
   The proxy server for HTTP connections. Default value: ``nil``.

``http_proxy_pass``
   The password for the proxy server when the proxy server is using an HTTP connection. Default value: ``nil``.

``http_proxy_user``
   The user name for the proxy server when the proxy server is using an HTTP connection. Default value: ``nil``.

``http_retry_count``
   The number of retry attempts. Default value: ``5``.

``http_retry_delay``
   The delay (in seconds) between retry attempts. Default value: ``5``.

``https_proxy``
   The proxy server for HTTPS connections. Default value: ``nil``.

``https_proxy_pass``
   The password for the proxy server when the proxy server is using an HTTPS connection. Default value: ``nil``.

``https_proxy_user``
   The user name for the proxy server when the proxy server is using an HTTPS connection. Default value: ``nil``.

``interval``
   The frequency (in seconds) at which the chef-client runs. Default value: ``1800``.

``json_attribs``
   The path to a file that contains JSON data.

``local_key_generation``
   Whether the Chef server or chef-client generates the private/public key pair. When ``true``, the chef-client generates the key pair, and then sends the public key to the Chef server.

``local_mode``
   Run the chef-client in local mode. This allows all commands that work against the Chef server to also work against the local chef-repo.

``lockfile``
   The location of the chef-client lock file.

``log_level``
   The level of logging to be stored in a log file. Possible levels: ``:auto`` (default), ``:debug``, ``:info``, ``:warn``, ``:error``, or ``:fatal``. Default value: ``:warn`` (when a terminal is available) or ``:info`` (when a terminal is not available).

``log_location``
   The location of the log file. Possible values: ``/path/to/log_location``, ``STDOUT`` or ``STDERR``. The application log will specify the source as ``Chef``. Default value: ``STDOUT``.

``no_lazy_load``
   Download all cookbook files and templates at the beginning of the chef-client run. Default value: ``false``.

``no_proxy``
   A comma-separated list of URLs that do not need a proxy. Default value: ``nil``.

``node_name``
   The name of the node. Determines which configuration should be applied and sets the ``client_name``, which is the name used when authenticating to a Chef server. The default value is the FQDN of the chef-client, as detected by Ohai. In general, Chef recommends that you leave this setting blank and let Ohai assign the FQDN of the node as the ``node_name`` during each chef-client run.

``node_path``
   The location in which nodes are stored when the chef-client is run in local mode. Default value: ``/var/chef/node``.

``pid_file``
   The location in which a process identification number (pid) is saved. An executable, when started as a daemon, writes the pid to the specified file. Default value: ``/tmp/name-of-executable.pid``.

``rest_timeout``
   The time (in seconds) after which an HTTP REST request is to time out.

``role_path``
   The location in which role files are located. Default value: ``/var/chef/roles``.

``splay``
   A random number between zero and ``splay`` that is added to ``interval``. Use splay to help balance the load on the Chef server by ensuring that many chef-client runs are not occuring at the same interval. Default value: ``nil``.

``ssl_ca_file``
   The file in which the OpenSSL key is saved. This setting is generated automatically by the chef-client and most users do not need to modify it.

``ssl_ca_path``
   The path to where the OpenSSL key is located. This setting is generated automatically by the chef-client and most users do not need to modify it.

``ssl_client_cert``
   The OpenSSL X.509 certificate used for mutual certificate validation. This setting is only necessary when mutual certificate validation is configured on the Chef server.

``ssl_client_key``
   The OpenSSL X.509 key used for mutual certificate validation. This setting is only necessary when mutual certificate validation is configured on the Chef server.

``ssl_verify_mode``
   Set the verify mode for HTTPS requests.
       
   * Use ``:verify_none`` to do no validation of SSL certificates.
   * Use ``:verify_peer`` to do validation of all SSL certificates, including the Chef server connections, S3 connections, and any HTTPS **remote_file** resource URLs used in the chef-client run. This is the recommended setting.
       
   Depending on how OpenSSL is configured, the ``ssl_ca_path`` may need to be specified.

``syntax_check_cache_path``
   All files in a cookbook must contain valid Ruby syntax. Use this setting to specify the location in which knife caches information about files that have been checked for valid Ruby syntax.

``umask``
   The file mode creation mask, or umask. Default value: ``0022``.

``user``
   The user that owns a process. This is required when starting any executable as a daemon. Default value: ``nil``.

``validation_client_name``
   The name of the chef-validator key that is used by the chef-client to access the Chef server during the initial chef-client run.

``validation_key``
   The location of the file that contains the key used when a chef-client is registered with a Chef server. A validation key is signed using the ``validation_client_name`` for authentication. Default value: ``/etc/chef/validation.pem``.

``verbose_logging``
   Set the log level. Options: ``true``, ``nil``, and ``false``. When this is set to ``false``, notifications about individual resources being processed are suppressed (and are output at the ``:info`` logging level). Setting this to ``false`` can be useful when a chef-client is run as a daemon. Default value: ``nil``.

``verify_api_cert``
   Verify the SSL certificate on the Chef server. When ``true``, the chef-client always verifies the SSL certificate. When ``false``, the chef-client uses the value of ``ssl_verify_mode`` to determine if the SSL certificate requires verification. Default value: ``false``.

``whitelist``
   A Hash that contains the whitelist used by Chef push jobs. For example:

   .. code-block:: ruby

      whitelist {
        'job-name' => 'command',
        'job-name' => 'command',
        'chef-client' => 'chef-client'
      }

   A job entry may also be ``'job-name' => {:lock => true}``, which will check the ``lockfile`` setting in the client.rb file before starting the job.

   .. warning:: The ``whitelist`` setting is available only when using Chef push jobs, a tool that runs jobs against nodes in an Chef server organization.

Ohai Settings
=====================================================

.. include:: ../../includes_config/includes_config_rb_ohai.rst

.. include:: ../../includes_config/includes_config_rb_12-4_ohai_settings.rst
