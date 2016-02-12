.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. note:: The following table contains paraphrased descriptions for quick reference. See http://linux.die.net/man/5/yum.conf for complete descriptions of these properties as they exist from the |yum| command line.

This resource has the following properties:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Property
     - Description
   * - ``alwaysprompt``
     - |alwaysprompt|
   * - ``assumeyes``
     - |assume_yes|
   * - ``bandwidth``
     - |bandwidth_yum|
   * - ``bugtracker_url``
     - |url_bugtracker|
   * - ``cachedir``
     - |cachedir| Default value: ``/var/cache/yum/$basearch/$releasever``.
   * - ``clean_requirements_on_remove``
     - |clean_requirements_on_remove|
   * - ``color``
     - |color|
   * - ``color_list_available_downgrade``
     - |color_list_available_downgrade|
   * - ``color_list_available_install``
     - |color_list_available_install|
   * - ``color_list_available_reinstall``
     - |color_list_available_reinstall|
   * - ``color_list_available_upgrade``
     - |color_list_available_upgrade|
   * - ``color_list_installed_extra``
     - |color_list_installed_extra|
   * - ``color_list_installed_newer``
     - |color_list_installed_newer|
   * - ``color_list_installed_older``
     - |color_list_installed_older|
   * - ``color_list_installed_reinstall``
     - |color_list_installed_reinstall|
   * - ``color_search_match``
     - |color_search_match|
   * - ``color_update_installed``
     - |color_update_installed|
   * - ``color_update_local``
     - |color_update_local|
   * - ``color_update_remote``
     - |color_update_remote|
   * - ``commands``
     - |commands_yum|
   * - ``debuglevel``
     - |debug_level| Default value: ``2``.
   * - ``diskspacecheck``
     - |diskspacecheck|
   * - ``distroverpkg``
     - |distroverpkg|
   * - ``enable_group_conditionals``
     - |enable_group_conditionals|
   * - ``errorlevel``
     - |errorlevel|
   * - ``exactarch``
     - |exactarch| Default value: ``true``.
   * - ``exclude``
     - |exclude_package_list|
   * - ``gpgcheck``
     - |gpg_check| Default value: ``true``.
   * - ``group_package_types``
     - |group_package_types|
   * - ``groupremove_leaf_only``
     - |groupremove_leaf_only|
   * - ``history_list_view``
     - |history_list_view|
   * - ``history_record``
     - |history_record|
   * - ``history_record_packages``
     - |history_record_packages|
   * - ``http_caching``
     - |http_caching| Possible values: ``all`` (cache all HTTP downloads), ``none`` (cache no HTTP downloads), or ``packages`` (cache only |rpm| downloads, but not repository metadata downloads).
   * - ``installonly_limit``
     - |installonly_limit| Set to ``0`` to disable. Default value: ``3``.
   * - ``installonlypkgs``
     - |installonlypkgs|
   * - ``installroot``
     - |installroot|
   * - ``keepalive``
     - |use keepalive|
   * - ``keepcache``
     - |keepcache| Default value: ``false``.
   * - ``kernelpkgnames``
     - |kernelpkgnames|
   * - ``localpkg_gpgcheck``
     - |localpkg_gpgcheck|
   * - ``logfile``
     - |logfile_yum| Default value: ``/var/log/yum.log``.
   * - ``max_retries``
     - |max_retry|
   * - ``mdpolicy``
     - |mdpolicy|
   * - ``metadata_expire``
     - |metadata_expire|
   * - ``mirrorlist_expire``
     - |mirrorlist_expire yum|
   * - ``multilib_policy``
     - |multilib_policy|
   * - ``obsoletes``
     - |obsoletes| Default value: ``1``.
   * - ``overwrite_groups``
     - |overwrite_groups|
   * - ``password``
     - |password yum_basic_auth|
   * - ``path``
     - |path repository|
   * - ``persistdir``
     - |persistdir|
   * - ``pluginconfpath``
     - |pluginconfpath|
   * - ``pluginpath``
     - |pluginpath|
   * - ``plugins``
     - |plugins_yum| Default value: ``1`` (enabled).
   * - ``protected_multilib``
     - |protected_multilib|
   * - ``protected_packages``
     - |protected_packages|
   * - ``proxy``
     - |url proxy_server|
   * - ``proxy_password``
     - |password proxy_server|
   * - ``proxy_username``
     - |name proxy|
   * - ``recent``
     - |recent_yum|
   * - ``repo_gpgcheck``
     - |repo_gpgcheck|
   * - ``reset_nice``
     - |reset_nice|
   * - ``rpmverbosity``
     - |rpm_verbosity|
   * - ``showdupesfromrepos``
     - |showdupesfromrepos|
   * - ``skip_broken``
     - |skip_broken|
   * - ``ssl_check_cert_permissions``
     - |ssl_check_cert_permissions_yum|
   * - ``sslcacert``
     - |ssl_ca_cert_yum|
   * - ``sslclientcert``
     - |ssl_client_cert_yum|
   * - ``sslclientkey``
     - |ssl_client_key_yum|
   * - ``sslverify``
     - |ssl_certificate verify|
   * - ``syslog_device``
     - |syslog_device|
   * - ``syslog_facility``
     - |syslog_facility|
   * - ``syslog_ident``
     - |syslog_ident|
   * - ``throttle``
     - |throttle|
   * - ``timeout``
     - |timeout connection|
   * - ``tolerant``
     - |tolerant|
   * - ``tsflags``
     - |tsflags|
   * - ``username``
     - |name user yum_basic_auth|
