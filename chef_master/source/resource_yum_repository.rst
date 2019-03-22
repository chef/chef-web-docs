=====================================================
yum_repository resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_yum_repository.rst>`__

Use the **yum_repository** resource to manage a Yum repository configuration file located at ``/etc/yum.repos.d/repositoryid.repo`` on the local machine. This configuration file specifies which repositories to reference, how to handle cached data, etc.

**New in Chef Client 12.14.**

Syntax
=====================================================
The yum_repository resource has the following syntax:

.. code-block:: ruby

  yum_repository 'name' do
    baseurl                    String, Array
    clean_headers              true, false # default value: false
    clean_metadata             true, false # default value: true
    cost                       String
    description                String # default value: "Yum Repository"
    enabled                    true, false # default value: true
    enablegroups               true, false
    exclude                    String
    failovermethod             String
    fastestmirror_enabled      true, false
    gpgcheck                   true, false # default value: true
    gpgkey                     String, Array
    http_caching               String
    include_config             String
    includepkgs                String
    keepalive                  true, false
    make_cache                 true, false # default value: true
    max_retries                String, Integer
    metadata_expire            String
    metalink                   String
    mirror_expire              String
    mirrorlist                 String
    mirrorlist_expire          String
    mode                       String, Integer # default value: "0644"
    options                    Hash
    password                   String
    priority                   String
    proxy                      String
    proxy_password             String
    proxy_username             String
    repo_gpgcheck              true, false
    report_instanceid          true, false
    repositoryid               String # default value: 'name' unless specified
    skip_if_unavailable        true, false
    source                     String
    sslcacert                  String
    sslclientcert              String
    sslclientkey               String
    sslverify                  true, false
    throttle                   String, Integer
    timeout                    String
    username                   String
    action                     Symbol # defaults to :create if not specified
  end

where:

* ``yum_repository`` is the resource.
* ``name`` is the name given to the resource block.
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state.
* ``baseurl``, ``clean_headers``, ``clean_metadata``, ``cost``, ``description``, ``enabled``, ``enablegroups``, ``exclude``, ``failovermethod``, ``fastestmirror_enabled``, ``gpgcheck``, ``gpgkey``, ``http_caching``, ``include_config``, ``includepkgs``, ``keepalive``, ``make_cache``, ``max_retries``, ``metadata_expire``, ``metalink``, ``mirror_expire``, ``mirrorlist``, ``mirrorlist_expire``, ``mode``, ``options``, ``password``, ``priority``, ``proxy``, ``proxy_password``, ``proxy_username``, ``repo_gpgcheck``, ``report_instanceid``, ``repositoryid``, ``skip_if_unavailable``, ``source``, ``sslcacert``, ``sslclientcert``, ``sslclientkey``, ``sslverify``, ``throttle``, ``timeout``, and ``username`` are the properties available to this resource.

Actions
=====================================================

The yum_repository resource has the following actions:

:create
   Creates a repository file and builds the repository listing.

:delete
   Deletes the repository file.

:makecache
   Updates the yum cache.


Properties
=====================================================

The yum_repository resource has the following properties:

.. Refer to http://linux.die.net/man/5/yum.conf as the source for these descriptions.

``baseurl``
   **Ruby Type:** String, Array

   URL to the directory where the Yum repository's 'repodata' directory lives. Can be an http://, https:// or a ftp:// URL. You can specify multiple URLs in one baseurl statement.

``clean_headers``
   **Ruby Type:** true, false | **Default Value:** ``false`` | ``DEPRECATED``

   Specifies whether you want to purge the package data files that are downloaded from a Yum repository and held in a cache directory.

``clean_metadata``
   **Ruby Type:** true, false | **Default Value:** ``true``

   Specifies whether you want to purge all of the packages downloaded from a Yum repository and held in a cache directory.

``cost``
   **Ruby Type:** String

   Relative cost of accessing this repository. Useful for weighing one repo's packages as greater/less than any other.

``description``
   **Ruby Type:** String | **Default Value:** ``"Yum Repository"``

   Descriptive name for the repository channel and maps to the 'name' parameter in a repository .conf.

``enabled``
   **Ruby Type:** true, false | **Default Value:** ``true``

   Specifies whether or not Yum should use this repository.

``enablegroups``
   **Ruby Type:** true, false

   Specifies whether Yum will allow the use of package groups for this repository.

``exclude``
   **Ruby Type:** String

   List of packages to exclude from updates or installs. This should be a space separated list. Shell globs using wildcards (eg. * and ?) are allowed.

``failovermethod``
   **Ruby Type:** String

   Method to determine how to switch to a new server if the current one fails, which can either be ``roundrobin`` or ``priority``. ``roundrobin`` randomly selects a URL out of the list of URLs to start with and proceeds through each of them as it encounters a failure contacting the host. ``priority`` starts from the first ``baseurl`` listed and reads through them sequentially.

``fastestmirror_enabled``
   **Ruby Type:** true, false

   Specifies whether to use the fastest mirror from a repository configuration when more than one mirror is listed in that configuration.

``gpgcheck``
   **Ruby Type:** true, false | **Default Value:** ``true``

   Specifies whether or not Yum should perform a GPG signature check on the packages received from a repository.

``gpgkey``
   **Ruby Type:** String, Array

   URL pointing to the ASCII-armored GPG key file for the repository. This is used if Yum needs a public key to verify a package and the required key hasn't been imported into the RPM database. If this option is set, Yum will automatically import the key from the specified URL.

   Multiple URLs may be specified in the same manner as the baseurl option. If a GPG key is required to install a package from a repository, all keys specified for that repository will be installed.

``http_caching``
   **Ruby Type:** String

   Determines how upstream HTTP caches are instructed to handle any HTTP downloads that Yum does. This option can take the following values:

   * ``all`` means that all HTTP downloads should be cached.

   * ``packages`` means that only RPM package downloads should be cached, but not repository metadata downloads.

   * ``none`` means that no HTTP downloads should be cached.

   The default is ``all``. This is recommended unless you are experiencing caching related issues.

``include_config``
   **Ruby Type:** String

   An external configuration file using the format ``url://to/some/location``.

``includepkgs``
   **Ruby Type:** String

   Inverse of exclude property. This is a list of packages you want to use from a repository. If this option lists only one package then that is all Yum will ever see from the repository.

``keepalive``
   **Ruby Type:** true, false

   Determines whether or not HTTP/1.1 ``keep-alive`` should be used with this repository.

``make_cache``
   **Ruby Type:** true, false | **Default Value:** ``true``

   Determines whether package files downloaded by Yum stay in cache directories. By using cached data, you can carry out certain operations without a network connection.

``max_retries``
   **Ruby Type:** String, Integer

   Number of times any attempt to retrieve a file should retry before returning an error. Setting this to '0' makes Yum try forever.

``metadata_expire``
   **Ruby Type:** String

   Time (in seconds) after which the metadata will expire. If the current metadata downloaded is less than the value specified, then Yum will not update the metadata against the repository. If you find that Yum is not downloading information on updates as often as you would like lower the value of this option. You can also change from the default of using seconds to using days, hours or minutes by appending a 'd', 'h' or 'm' respectively. The default is six hours to compliment yum-updates running once per hour. It is also possible to use the word ``never``, meaning that the metadata will never expire. Note: When using a metalink file, the metalink must always be newer than the metadata for the repository due to the validation, so this timeout also applies to the metalink file.

   .. note:: When using a metalink file, the metalink must always be newer than the metadata for the repository due to the validation, so this timeout also applies to the metalink file.

``metalink``
   **Ruby Type:** String

   Specifies a URL to a metalink file for the repomd.xml, a list of mirrors for the entire repository are generated by converting the mirrors for the repomd.xml file to a baseurl.

``mirror_expire``
   **Ruby Type:** String

   Time (in seconds) after which the mirrorlist locally cached will expire. If the current mirrorlist is less than this many seconds old then Yum will not download another copy of the mirrorlist, it has the same extra format as metadata_expire. If you find that Yum is not downloading the mirrorlists as often as you would like lower the value of this option. You can also change from the default of using seconds to using days, hours or minutes by appending a 'd', 'h' or 'm' respectively.

``mirrorlist``
   **Ruby Type:** String

   URL to a file containing a list of baseurls. This can be used instead of or with the baseurl option. Substitution variables, described below, can be used with this option.

``mirrorlist_expire``
   **Ruby Type:** String

   Specifies the time (in seconds) after which the mirrorlist locally cached will expire. If the current mirrorlist is less than the value specified, then Yum will not download another copy of the mirrorlist. You can also change from the default of using seconds to using days, hours or minutes by appending a 'd', 'h' or 'm' respectively.

``mode``
   **Ruby Type:** String, Integer | **Default Value:** ``"0644"``

   Permissions mode of .repo file on disk. This is useful for scenarios where secrets are in the repo file. If this value is set to '600', normal users will not be able to use Yum search, Yum info, etc.

``options``
   **Ruby Type:** Hash

   Specifies the repository options.

``password``
   **Ruby Type:** String

   Password to use with the username for basic authentication.

``priority``
   **Ruby Type:** String

   Assigns a priority to a repository where the priority value is between '1' and '99' inclusive. Priorities are used to enforce ordered protection of repositories. Packages from repositories with a lower priority (higher numerical value) will never be used to upgrade packages that were installed from a repository with a higher priority (lower numerical value). The repositories with the lowest numerical priority number have the highest priority.

``proxy``
   **Ruby Type:** String

   URL to the proxy server that Yum should use.

``proxy_password``
   **Ruby Type:** String

   Password for this proxy.

``proxy_username``
   **Ruby Type:** String

   Username to use for proxy.

``repo_gpgcheck``
   **Ruby Type:** true, false

   Determines whether or not Yum should perform a GPG signature check on the repodata from this repository.

``report_instanceid``
   **Ruby Type:** true, false

   Determines whether to report the instance ID when using Amazon Linux AMIs and repositories.

``repositoryid``
   **Ruby Type:** String | **Default Value:** ``The resource block's name``

   An optional property to set the repository name if it differs from the resource block's name.

``skip_if_unavailable``
   **Ruby Type:** true, false

   Allow yum to continue if this repository cannot be contacted for any reason.

``source``
   **Ruby Type:** String

   Use a custom template source instead of the default one.

``sslcacert``
   **Ruby Type:** String

   Path to the directory containing the databases of the certificate authorities Yum should use to verify SSL certificates.

``sslclientcert``
   **Ruby Type:** String

   Path to the SSL client certificate Yum should use to connect to repos/remote sites.

``sslclientkey``
   **Ruby Type:** String

   Path to the SSL client key Yum should use to connect to repos/remote sites.

``sslverify``
   **Ruby Type:** true, false

   Determines whether Yum will verify SSL certificates/hosts.

``throttle``
   **Ruby Type:** String, Integer

   Enable bandwidth throttling for downloads.

``timeout``
   **Ruby Type:** String

   Number of seconds to wait for a connection before timing out. Defaults to 30 seconds. This may be too short of a time for extremely overloaded sites.

``username``
   **Ruby Type:** String

   Username to use for basic authentication to a repository.

Common Resource Functionality
=====================================================

Chef resources include common properties, notifications, and resource guards.

Common Properties
-----------------------------------------------------

.. tag resources_common_properties

The following properties are common to every resource:

``ignore_failure``
  **Ruby Type:** true, false | **Default Value:** ``false``

  Continue running a recipe if a resource fails for any reason.

``retries``
  **Ruby Type:** Integer | **Default Value:** ``0``

  The number of attempts to catch exceptions and retry the resource.

``retry_delay``
  **Ruby Type:** Integer | **Default Value:** ``2``

  The retry delay (in seconds).

``sensitive``
  **Ruby Type:** true, false | **Default Value:** ``false``

  Ensure that sensitive resource data is not logged by the chef-client.

.. end_tag

Notifications
-----------------------------------------------------
``notifies``
  **Ruby Type:** Symbol, 'Chef::Resource[String]'

  .. tag resources_common_notification_notifies

  A resource may notify another resource to take action when its state changes. Specify a ``'resource[name]'``, the ``:action`` that resource should take, and then the ``:timer`` for that action. A resource may notify more than one resource; use a ``notifies`` statement for each resource to be notified.

  .. end_tag

.. tag resources_common_notification_timers

A timer specifies the point during the Chef Client run at which a notification is run. The following timers are available:

``:before``
   Specifies that the action on a notified resource should be run before processing the resource block in which the notification is located.

``:delayed``
   Default. Specifies that a notification should be queued up, and then executed at the end of the Chef Client run.

``:immediate``, ``:immediately``
   Specifies that a notification should be run immediately, per resource notified.

.. end_tag

.. tag resources_common_notification_notifies_syntax

The syntax for ``notifies`` is:

.. code-block:: ruby

  notifies :action, 'resource[name]', :timer

.. end_tag

``subscribes``
  **Ruby Type:** Symbol, 'Chef::Resource[String]'

.. tag resources_common_notification_subscribes

A resource may listen to another resource, and then take action if the state of the resource being listened to changes. Specify a ``'resource[name]'``, the ``:action`` to be taken, and then the ``:timer`` for that action.

Note that ``subscribes`` does not apply the specified action to the resource that it listens to - for example:

.. code-block:: ruby

 file '/etc/nginx/ssl/example.crt' do
   mode '0600'
   owner 'root'
 end

 service 'nginx' do
   subscribes :reload, 'file[/etc/nginx/ssl/example.crt]', :immediately
 end

In this case the ``subscribes`` property reloads the ``nginx`` service whenever its certificate file, located under ``/etc/nginx/ssl/example.crt``, is updated. ``subscribes`` does not make any changes to the certificate file itself, it merely listens for a change to the file, and executes the ``:reload`` action for its resource (in this example ``nginx``) when a change is detected.

.. end_tag

.. tag resources_common_notification_timers

A timer specifies the point during the Chef Client run at which a notification is run. The following timers are available:

``:before``
   Specifies that the action on a notified resource should be run before processing the resource block in which the notification is located.

``:delayed``
   Default. Specifies that a notification should be queued up, and then executed at the end of the Chef Client run.

``:immediate``, ``:immediately``
   Specifies that a notification should be run immediately, per resource notified.

.. end_tag

.. tag resources_common_notification_subscribes_syntax

The syntax for ``subscribes`` is:

.. code-block:: ruby

   subscribes :action, 'resource[name]', :timer

.. end_tag

Guards
-----------------------------------------------------

.. tag resources_common_guards

A guard property can be used to evaluate the state of a node during the execution phase of the chef-client run. Based on the results of this evaluation, a guard property is then used to tell the chef-client if it should continue executing a resource. A guard property accepts either a string value or a Ruby block value:

* A string is executed as a shell command. If the command returns ``0``, the guard is applied. If the command returns any other value, then the guard property is not applied. String guards in a **powershell_script** run Windows PowerShell commands and may return ``true`` in addition to ``0``.
* A block is executed as Ruby code that must return either ``true`` or ``false``. If the block returns ``true``, the guard property is applied. If the block returns ``false``, the guard property is not applied.

A guard property is useful for ensuring that a resource is idempotent by allowing that resource to test for the desired state as it is being executed, and then if the desired state is present, for the chef-client to do nothing.

.. end_tag
.. tag resources_common_guards_properties

The following properties can be used to define a guard that is evaluated during the execution phase of the chef-client run:

``not_if``
  Prevent a resource from executing when the condition returns ``true``.

``only_if``
  Allow a resource to execute only if the condition returns ``true``.

.. end_tag

Examples
=====================================================
The following examples demonstrate various approaches for using resources in recipes:

**Add internal company repository**

.. code-block:: ruby

   yum_repository 'OurCo' do
     description 'OurCo yum repository'
     mirrorlist 'http://artifacts.ourco.org/mirrorlist?repo=ourco-6&arch=$basearch'
     gpgkey 'http://artifacts.ourco.org/pub/yum/RPM-GPG-KEY-OURCO-6'
     action :create
   end

**Delete a repository**

.. code-block:: ruby

   yum_repository 'CentOS-Media' do
     action :delete
   end
