=====================================================
apt_repository resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_apt_repository.rst>`__

Use the **apt_repository** resource to specify additional APT repositories. Adding a new repository will update APT package cache immediately.

Syntax
==========================================
An **apt_repository** resource specifies APT repository information and adds an additional APT repository to the existing list of repositories:

.. code-block:: ruby

   apt_repository 'nginx' do
     uri        'http://nginx.org/packages/ubuntu/'
     components ['nginx']
   end

where

* ``apt_repository`` is the resource
* ``name`` is the name of the APT repository, or the name of the resource block. Must not contain spaces.
* ``uri`` is a base URI for the distribution where the APT packages are located at
* ``components`` is an array of package groupings in the repository

The full syntax for all of the properties that are available to the **apt_repository** resource is:

.. code-block:: ruby

   apt_repository 'name' do
      repo_name             String
      uri                   String
      distribution          String
      components            Array
      arch                  String
      trusted               true, false
      deb_src               true, false
      keyserver             String
      key                   String, Array
      key_proxy             String
      cookbook              String
      cache_rebuild         true, false
      sensitive             true, false
      action                Symbol # defaults to :add if not specified
   end

where:

* ``apt_repository`` is the resource.
* ``name`` is the name given to the resource block.
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state.
* ``repo_name``, ``uri``, ``distribution``, ``components``, ``arch``, ``trusted``, ``deb_src``, ``keyserver``, ``key``, ``key_proxy``, ``cookbook``, ``cache_rebuild``, and ``sensitive`` are properties of this resource, with the Ruby type shown. See “Properties” section below for more information about all of the properties that may be used with this resource.

Actions
=====================================================
This resource has the following actions:

``:add``
   Default. Creates a repository file at ``/etc/apt/sources.list.d/`` and builds the repository listing.

``:remove``
   Removes the repository listing.

Properties
=====================================================
This resource has the following properties:


``arch``
   **Ruby Type:** String, false

   Constrain packages to a particular CPU architecture such as ``i386`` or ``amd64``.

``cache_rebuild``
   **Ruby Type:** true, false | **Default Value:** ``true``

   Determines whether to rebuild the APT package cache.

``components``
   **Ruby Type:** Array | **Default Value:** ``lazy default``

   Package groupings, such as 'main' and 'stable'.

``cookbook``
   **Ruby Type:** String, false

   If key should be a cookbook_file, specify a cookbook where the key is located for files/default. Default value is nil, so it will use the cookbook where the resource is used.

``deb_src``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Determines whether or not to add the repository as a source repo as well.

``distribution``
   **Ruby Type:** String, false | **Default Value:** ``lazy default``

   Usually a distribution's codename, such as trusty, xenial or bionic. Default value: the codename of the node's distro.

``key``
   **Ruby Type:** String, Array, false | **Default Value:** ``lazy default``

   If a keyserver is provided, this is assumed to be the fingerprint; otherwise it can be either the URI of GPG key for the repo, or a cookbook_file.

``key_proxy``
   **Ruby Type:** String, false

   If set, a specified proxy is passed to GPG via ``http-proxy=``.

``keyserver``
   **Ruby Type:** String, false | **Default Value:** ``keyserver.ubuntu.com``

   The GPG keyserver where the key for the repo should be retrieved.

``repo_name``
   **Ruby Type:** String

   The name of the repository to configure, if it differs from the name of the resource block. The value of this setting must not contain spaces.

``sensitive``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Determines whether sensitive resource data (such as key information) is not logged by the chef-client.

``trusted``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Determines whether you should treat all packages from this repository as authenticated regardless of signature.

``uri``
   **Ruby Type:** String

   The base of the Debian distribution.

Examples
=====================================================

**Add repository with basic settings**

.. code-block:: ruby

   apt_repository 'nginx' do
     uri        'http://nginx.org/packages/ubuntu/'
     components ['nginx']
   end

**Enable Ubuntu multiverse repositories**

.. code-block:: ruby

   apt_repository 'security-ubuntu-multiverse' do
     uri          'http://security.ubuntu.com/ubuntu'
     distribution 'trusty-security'
     components   ['multiverse']
     deb_src      true
   end

**Add the Nginx PPA, autodetect the key and repository url**

.. code-block:: ruby

   apt_repository 'nginx-php' do
     uri          'ppa:nginx/stable'
   end

**Add the JuJu PPA, grab the key from the keyserver, and add source repo**

.. code-block:: ruby

   apt_repository 'juju' do
     uri 'http://ppa.launchpad.net/juju/stable/ubuntu'
     components ['main']
     distribution 'trusty'
     key 'C8068B11'
     keyserver 'keyserver.ubuntu.com'
     action :add
     deb_src true
   end

**Add repository that requires multiple keys to authenticate packages**

.. code-block:: ruby

   apt_repository 'rundeck' do
     uri 'https://dl.bintray.com/rundeck/rundeck-deb'
     distribution '/'
     key ['379CE192D401AB61', 'http://rundeck.org/keys/BUILD-GPG-KEY-Rundeck.org.key']
     keyserver 'keyserver.ubuntu.com'
     action :add
   end

**Add the Cloudera Repo of CDH4 packages for Ubuntu 12.04 on AMD64**

.. code-block:: ruby

   apt_repository 'cloudera' do
     uri          'http://archive.cloudera.com/cdh4/ubuntu/precise/amd64/cdh'
     arch         'amd64'
     distribution 'precise-cdh4'
     components   ['contrib']
     key          'http://archive.cloudera.com/debian/archive.key'
   end

**Remove a repository from the list**

.. code-block:: ruby

   apt_repository 'zenoss' do
     action :remove
   end
