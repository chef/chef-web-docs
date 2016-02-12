.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. note:: The following table contains paraphrased descriptions for quick reference. See http://linux.die.net/man/5/yum.conf for complete descriptions of these properties as they exist from the |yum| command line.

This resource has the following properties:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Property
     - Description
   * - ``baseurl``
     - |path repository|
   * - ``cost``
     - |cost_repo|
   * - ``description``
     - |description yum_repository| Default value: ``Ye Ole Rpm Repo``.
   * - ``enabled``
     - |use repo| Default value: ``true``.
   * - ``enablegroups``
     - |enable_package_groups|
   * - ``exclude``
     - |exclude_package_list|
   * - ``failovermethod``
     - |failover_method|
   * - ``fastestmirror_enabled``
     - |fastest_mirror_enabled|
   * - ``gpgcheck``
     - |gpg_check| Default value: ``true``.
   * - ``gpgkey``
     - |gpg_key|
   * - ``http_caching``
     - |http_caching| Possible values: ``all`` (cache all HTTP downloads), ``none`` (cache no HTTP downloads), or ``packages`` (cache only |rpm| downloads, but not repository metadata downloads).
   * - ``include_config``
     - |include_config|
   * - ``includepkgs``
     - |include_packages|
   * - ``keepalive``
     - |use keepalive|
   * - ``max_retries``
     - |max_retry|
   * - ``metadata_expire``
     - |metadata_expire|
   * - ``mirrorlist``
     - |mirrorlist yum|
   * - ``mirror_expire``
     - |mirror_expire yum|
   * - ``mirrorlist_expire``
     - |mirrorlist_expire yum|
   * - ``priority``
     - |priority yum| Possible values: ``1`` - ``99``.
   * - ``proxy``
     - |url proxy_server|
   * - ``proxy_password``
     - |password proxy_server|
   * - ``proxy_username``
     - |name proxy|
   * - ``report_instanceid``
     - |id report_instance| 
   * - ``repositoryid``
     - |name repository_yum|
   * - ``sslcacert``
     - |path ssl_certificate yum_directory|
   * - ``sslclientcert``
     - |path ssl_certificate yum_client|
   * - ``sslclientkey``
     - |path ssl_certificate yum_client_key|
   * - ``sslverify``
     - Indicates whether |yum| verifies |ssl| certificates.
   * - ``timeout``
     - |timeout connection|
