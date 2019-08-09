=====================================================
apt_repository resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_apt_repository.rst>`__

Use the **apt_repository** resource to specify additional APT repositories. Adding a new repository will update the APT package cache immediately.

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
    arch               String, false
    cache_rebuild      true, false # default value: true
    components         Array
    cookbook           String, false
    deb_src            true, false # default value: false
    distribution       String, false # default value: The LSB codename of the host such as 'bionic'.
    key                String, Array, false
    key_proxy          String, false
    keyserver          String, false # default value: "keyserver.ubuntu.com"
    repo_name          String # default value: 'name' unless specified
    trusted            true, false # default value: false
    uri                String
    action             Symbol # defaults to :add if not specified
  end

where:

* ``apt_repository`` is the resource.
* ``name`` is the name given to the resource block.
* ``action`` identifies which steps Chef Infra Client will take to bring the node into the desired state.
* ``arch``, ``cache_rebuild``, ``components``, ``cookbook``, ``deb_src``, ``distribution``, ``key``, ``key_proxy``, ``keyserver``, ``repo_name``, ``trusted``, and ``uri`` are the properties available to this resource.

Actions
=====================================================

The apt_repository resource has the following actions:

``:add``
   Default. Creates a repository file at ``/etc/apt/sources.list.d/`` and builds the repository listing.

``:remove``
   Removes the repository listing.

``:nothing``
   .. tag resources_common_actions_nothing

   This resource block does not act unless notified by another resource to take action. Once notified, this resource block either runs immediately or is queued up to run at the end of a Chef Infra Client run.

   .. end_tag

Properties
=====================================================

The apt_repository resource has the following properties:

``arch``
   **Ruby Type:** String, false

   Constrain packages to a particular CPU architecture such as ``i386`` or ``amd64``.

``cache_rebuild``
   **Ruby Type:** true, false | **Default Value:** ``true``

   Determines whether to rebuild the APT package cache.

``components``
   **Ruby Type:** Array

   Package groupings, such as 'main' and 'stable'.

``cookbook``
   **Ruby Type:** String, false

   If key should be a cookbook_file, specify a cookbook where the key is located for files/default. Default value is nil, so it will use the cookbook where the resource is used.

``deb_src``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Determines whether or not to add the repository as a source repo as well.

``distribution``
   **Ruby Type:** String, false | **Default Value:** ``The LSB codename of the host such as 'bionic'.``

   Usually a distribution's codename, such as trusty, xenial or bionic. Default value: the codename of the node's distro.

``key``
   **Ruby Type:** String, Array, false

   If a keyserver is provided, this is assumed to be the fingerprint; otherwise it can be either the URI of GPG key for the repo, or a cookbook_file.

``key_proxy``
   **Ruby Type:** String, false

   If set, a specified proxy is passed to GPG via ``http-proxy=``.

``keyserver``
   **Ruby Type:** String, false | **Default Value:** ``"keyserver.ubuntu.com"``

   The GPG keyserver where the key for the repo should be retrieved.

``repo_name``
   **Ruby Type:** String | **Default Value:** ``The resource block's name``

   An optional property to set the repository name if it differs from the resource block's name. The value of this setting must not contain spaces.

   *New in Chef Client 14.1.*

``trusted``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Determines whether you should treat all packages from this repository as authenticated regardless of signature.

``uri``
   **Ruby Type:** String

   The base of the Debian distribution.

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

  Ensure that sensitive resource data is not logged by Chef Infra Client.

.. end_tag

Notifications
-----------------------------------------------------

``notifies``
  **Ruby Type:** Symbol, 'Chef::Resource[String]'

  .. tag resources_common_notification_notifies

  A resource may notify another resource to take action when its state changes. Specify a ``'resource[name]'``, the ``:action`` that resource should take, and then the ``:timer`` for that action. A resource may notify more than one resource; use a ``notifies`` statement for each resource to be notified.

  .. end_tag

.. tag resources_common_notification_timers

A timer specifies the point during a Chef Infra Client run at which a notification is run. The following timers are available:

``:before``
   Specifies that the action on a notified resource should be run before processing the resource block in which the notification is located.

``:delayed``
   Default. Specifies that a notification should be queued up, and then executed at the end of a Chef Infra Client run.

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

A timer specifies the point during a Chef Infra Client run at which a notification is run. The following timers are available:

``:before``
   Specifies that the action on a notified resource should be run before processing the resource block in which the notification is located.

``:delayed``
   Default. Specifies that a notification should be queued up, and then executed at the end of a Chef Infra Client run.

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

A guard property can be used to evaluate the state of a node during the execution phase of a Chef Infra Client run. Based on the results of this evaluation, a guard property is then used to tell Chef Infra Client if it should continue executing a resource. A guard property accepts either a string value or a Ruby block value:

* A string is executed as a shell command. If the command returns ``0``, the guard is applied. If the command returns any other value, then the guard property is not applied. String guards in a **powershell_script** run Windows PowerShell commands and may return ``true`` in addition to ``0``.
* A block is executed as Ruby code that must return either ``true`` or ``false``. If the block returns ``true``, the guard property is applied. If the block returns ``false``, the guard property is not applied.

A guard property is useful for ensuring that a resource is idempotent by allowing that resource to test for the desired state as it is being executed, and then if the desired state is present, for Chef Infra Client to do nothing.

.. end_tag

**Properties**

.. tag resources_common_guards_properties

The following properties can be used to define a guard that is evaluated during the execution phase of a Chef Infra Client run:

``not_if``
  Prevent a resource from executing when the condition returns ``true``.

``only_if``
  Allow a resource to execute only if the condition returns ``true``.

.. end_tag

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
