.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A |resource yum_repository| resource creates a Yum repository configuration file to make individual Yum repositories available for use. The |resource yum_repository| resource can be as simple as the following:

.. code-block:: ruby

   yum_repository 'zenoss' do
     description "Zenoss Stable repo"
     baseurl "http://dev.zenoss.com/yum/stable/"
     gpgkey 'http://dev.zenoss.com/yum/RPM-GPG-KEY-zenoss'
     action :create
   end

where 

* ``'baseurl'`` is the URL to the directory where the Yum repository's 'repodata' directory lives
* ``'gpgkey'`` is the GPG key for the repository

The full syntax for all of the properties that are available to the |resource yum_repository| resource is:

.. code-block:: ruby

   yum_repository 'name' do
      baseurl                 String
      cost                    String
      clean_headers           TrueClass, FalseClass 
      clean_metadata          TrueClass, FalseClass 
      description             String 
      enabled                 TrueClass, FalseClass
      enablegroups            TrueClass, FalseClass
      exclude                 String
      failovermethod          String
      fastestmirror_enabled   TrueClass, FalseClass
      gpgcheck                TrueClass, FalseClass]
      gpgkey                  String, Array 
      http_caching            String 
      include_config          String 
      includepkgs             String 
      keepalive               TrueClass, FalseClass 
      make_cache              TrueClass, FalseClass 
      max_retries             String, Integer 
      metadata_expire         String 
      mirrorexpire            String 
      mirrorlist              String 
      mirror_expire           String 
      mirrorlist_expire       String
      options                 Hash 
      priority                String 
      proxy                   String 
      proxy_username          String 
      proxy_password          String 
      username                String 
      password                String 
      repo_gpgcheck           TrueClass, FalseClass 
      report_instanceid       TrueClass, FalseClass 
      repositoryid            String 
      sensitive               TrueClass, FalseClass 
      skip_if_unavailable     TrueClass, FalseClass 
      source                  String 
      sslcacert               String 
      sslclientcert           String 
      sslclientkey            String 
      sslverify               TrueClass, FalseClass 
      timeout                 String 
      action                  Symbol # default is :create if not specified
   end

where 

* ``yum_repository`` is the resource 
* ``name`` is the name of the resource block
* ``:action`` identifies which steps the |chef client| will take to bring the node into the desired state
*  ``baseurl``, ``cost``, ``clean_headers``, ``clean_metadata``, ``description``, ``enabled``, ``enablegroups``, ``exclude``, ``failovermethod``, ``fastestmirror_enabled``, ``gpgcheck``, ``gpgkey``, ``http_caching``, ``include_config``, ``includepkgs``, ``keepalive``, ``make_cache``, ``max_retries``, ``metadata_expire``, ``mirrorexpire``, ``mirrorlist``, ``mirror_expire``, ``mirrorlist_expire``, ``options``, ``priority``, ``proxy``, ``proxy_username``, ``proxy_password``, ``username``, ``password``, ``repo_gpgcheck``, ``report_instanceid``, ``repositoryid``, ``sensitive``, ``skip_if_unavailable``, ``source``, ``sslcacert``, ``sslclientcert``, ``sslclientkey``, ``sslverify``, ``timeout`` are properties of this resource, with the |ruby| type shown. |see attributes|