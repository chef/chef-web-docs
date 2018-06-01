=====================================================
About the Recipe DSL
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/dsl_recipe.rst>`__

.. tag dsl_recipe_summary

The Recipe DSL is a Ruby DSL that is primarily used to declare resources from within a recipe. The Recipe DSL also helps ensure that recipes interact with nodes (and node properties) in the desired manner. Most of the methods in the Recipe DSL are used to find a specific parameter and then tell the chef-client what action(s) to take, based on whether that parameter is present on a node.

.. end_tag

Because the Recipe DSL is a Ruby DSL, then anything that can be done using Ruby can also be done in a recipe, including ``if`` and ``case`` statements, using the ``include?`` Ruby method, including recipes in recipes, and checking for dependencies.

Use Ruby
=====================================================
Common Ruby techniques can be used with the Recipe DSL methods.

if Statements
-----------------------------------------------------
.. tag ruby_style_basics_statement_if

An ``if`` statement can be used to specify part of a recipe to be used when certain conditions are met. ``else`` and ``elseif`` statements can be used to handle situations where either the initial condition is not met or when there are other possible conditions that can be met. Since this behavior is 100% Ruby, do this in a recipe the same way here as anywhere else.

For example, using an ``if`` statement with the ``platform`` node attribute:

.. code-block:: ruby

   if node['platform'] == 'ubuntu'
     # do ubuntu things
   end

.. future example: step_resource_ruby_block_reload_configuration
.. future example: step_resource_ruby_block_run_specific_blocks_on_specific_platforms
.. future example: step_resource_mount_mysql
.. future example: step_resource_package_install_sudo_configure_etc_sudoers
.. future example: step_resource_ruby_block_if_statement_use_with_platform
.. future example: step_resource_remote_file_transfer_remote_source_changes
.. future example: step_resource_remote_file_use_platform_family
.. future example: step_resource_scm_use_different_branches
.. future example: step_resource_service_stop_do_stuff_start

.. end_tag

case Statements
-----------------------------------------------------
.. tag ruby_style_basics_statement_case

A ``case`` statement can be used to handle a situation where there are a lot of conditions. Use the ``when`` statement for each condition, as many as are required.

For example, using a ``case`` statement with the ``platform`` node attribute:

.. code-block:: ruby

   case node['platform']
   when 'debian', 'ubuntu'
     # do debian/ubuntu things
   when 'redhat', 'centos', 'fedora'
     # do redhat/centos/fedora things
   end

For example, using a ``case`` statement with the ``platform_family`` node attribute:

.. code-block:: ruby

   case node['platform_family']
   when 'debian'
     # do things on debian-ish platforms (debian, ubuntu, linuxmint)
   when 'rhel'
     # do things on RHEL platforms (redhat, centos, scientific, etc)
   end

.. future example: step_resource_package_install_package_on_platform
.. future example: step_resource_package_use_case_statement
.. future example: step_resource_service_manage_ssh_based_on_node_platform

.. end_tag

include? Method
-----------------------------------------------------
.. tag ruby_style_basics_parameter_include

The ``include?`` method can be used to ensure that a specific parameter is included before an action is taken. For example, using the ``include?`` method to find a specific parameter:

.. code-block:: ruby

   if %w(debian ubuntu).include?(node['platform'])
     # do debian/ubuntu things
   end

or:

.. code-block:: ruby

   if %w{rhel}.include?(node['platform_family'])
     # do RHEL things
   end

.. end_tag

Array Syntax Shortcut
-----------------------------------------------------
.. tag ruby_style_basics_array_shortcut

The ``%w`` syntax is a Ruby shortcut for creating an array without requiring quotes and commas around the elements.

For example:

.. code-block:: ruby

   if %w(debian ubuntu).include?(node['platform'])
     # do debian/ubuntu things with the Ruby array %w() shortcut
   end

.. end_tag

Include Recipes
=====================================================
.. tag cookbooks_recipe_include_in_recipe

A recipe can include one (or more) recipes from cookbooks by using the ``include_recipe`` method. When a recipe is included, the resources found in that recipe will be inserted (in the same exact order) at the point where the ``include_recipe`` keyword is located.

The syntax for including a recipe is like this:

.. code-block:: ruby

   include_recipe 'recipe'

For example:

.. code-block:: ruby

   include_recipe 'apache2::mod_ssl'

Multiple recipes can be included within a recipe. For example:

.. code-block:: ruby

   include_recipe 'cookbook::setup'
   include_recipe 'cookbook::install'
   include_recipe 'cookbook::configure'

If a specific recipe is included more than once with the ``include_recipe`` method or elsewhere in the run_list directly, only the first instance is processed and subsequent inclusions are ignored.

.. end_tag

Reload Attributes
-----------------------------------------------------
.. tag cookbooks_attribute_file_reload_from_recipe

Attributes sometimes depend on actions taken from within recipes, so it may be necessary to reload a given attribute from within a recipe. For example:

.. code-block:: ruby

   ruby_block 'some_code' do
     block do
       node.from_file(run_context.resolve_attribute('COOKBOOK_NAME', 'ATTR_FILE'))
     end
     action :nothing
   end

.. end_tag

Recipe DSL Methods
=====================================================
The Recipe DSL provides support for using attributes, data bags (and encrypted data), and search results in a recipe, as well as four helper methods that can be used to check for a node's platform from the recipe to ensure that specific actions are taken for specific platforms. The helper methods are:

* ``platform?``
* ``platform_family?``
* ``value_for_platform``
* ``value_for_platform_family``

attribute?
-----------------------------------------------------
Use the ``attribute?`` method to ensure that certain actions only execute in the presence of a particular node attribute. The ``attribute?`` method will return true if one of the listed node attributes matches a node attribute that is detected by Ohai during every chef-client run.

The syntax for the ``attribute?`` method is as follows:

.. code-block:: ruby

   attribute?('name_of_attribute')

For example:

.. code-block:: ruby

   if node.attribute?('ipaddress')
     # the node has an ipaddress
   end

cookbook_name
-----------------------------------------------------
Use the ``cookbook_name`` method to return the name of a cookbook.

The syntax for the ``cookbook_name`` method is as follows:

.. code-block:: ruby

   cookbook_name

This method is often used as part of a log entry. For example:

.. code-block:: ruby

   Chef::Log.info('I am a message from the #{recipe_name} recipe in the #{cookbook_name} cookbook.')

data_bag
-----------------------------------------------------
.. tag data_bag

A data bag is a global variable that is stored as JSON data and is accessible from a Chef server. A data bag is indexed for searching and can be loaded by a recipe or accessed during a search.

.. end_tag

Use the ``data_bag`` method to get a list of the contents of a data bag.

The syntax for the ``data_bag`` method is as follows:

.. code-block:: ruby

   data_bag(bag_name)

**Examples**

The following example shows how the ``data_bag`` method can be used in a recipe.

**Get a data bag, and then iterate through each data bag item**

.. tag dsl_recipe_data_bag

.. The following is an example of using the ``data_bag`` method:

.. code-block:: ruby

   data_bag('users') #=> ['sandy', 'jill']

Iterate over the contents of the data bag to get the associated ``data_bag_item``:

.. code-block:: ruby

   data_bag('users').each do |user|
     data_bag_item('users', user)
   end

The ``id`` for each data bag item will be returned as a string.

.. end_tag

data_bag_item
-----------------------------------------------------
.. tag data_bag

A data bag is a global variable that is stored as JSON data and is accessible from a Chef server. A data bag is indexed for searching and can be loaded by a recipe or accessed during a search.

.. end_tag

The ``data_bag_item`` method can be used in a recipe to get the contents of a data bag item.

The syntax for the ``data_bag_item`` method is as follows:

.. code-block:: ruby

   data_bag_item(bag_name, item, secret)

where ``secret`` is the secret used to load an encrypted data bag. If ``secret`` is not specified, the chef-client looks for a secret at the path specified by the ``encrypted_data_bag_secret`` setting in the client.rb file.

**Examples**

The following examples show how the ``data_bag_item`` method can be used in a recipe.

**Get a data bag, and then iterate through each data bag item**

.. tag dsl_recipe_data_bag

.. The following is an example of using the ``data_bag`` method:

.. code-block:: ruby

   data_bag('users') #=> ['sandy', 'jill']

Iterate over the contents of the data bag to get the associated ``data_bag_item``:

.. code-block:: ruby

   data_bag('users').each do |user|
     data_bag_item('users', user)
   end

The ``id`` for each data bag item will be returned as a string.

.. end_tag

**Use the contents of a data bag in a recipe**

The following example shows how to use the ``data_bag`` and ``data_bag_item`` methods in a recipe, also using a data bag named ``sea-power``):

.. code-block:: ruby

   package 'sea-power' do
     action :install
   end

   directory node['sea-power']['base_path'] do
     # attributes for owner, group, mode
   end

   gale_warnings = data_bag('sea-power').map do |viking_north|
     data_bag_item('sea-power', viking_north)['source']
   end

   template '/etc/seattle/power.list' do
     source 'seattle-power.erb'
     # attributes for owner, group, mode
     variables(
       :base_path => node['sea-power']['base_path'],
       # more variables
       :repo_location => gale_warnings
     )
   end

For a more complete version of the previous example, see the default recipe in the https://github.com/hw-cookbooks/apt-mirror community cookbook.


declare_resource
-----------------------------------------------------
.. tag dsl_recipe_method_declare_resource

Use the ``declare_resource`` method to instantiate a resource and then add it to the resource collection.

The syntax for the ``declare_resource`` method is as follows:

.. code-block:: ruby

   declare_resource(:resource_type, 'resource_name', resource_attrs_block)

where:

* ``:resource_type`` is the resource type, such as ``:file`` (for the **file** resource), ``:template`` (for the **template** resource), and so on. Any resource available to Chef may be declared.
* ``resource_name`` the property that is the default name of the resource, typically the string that appears in the ``resource 'name' do`` block of a resource (but not always); see the Syntax section for the resource to be declared to verify the default name property.
* ``resource_attrs_block`` is a block in which properties of the instantiated resource are declared.

For example:

.. code-block:: ruby

   declare_resource(:file, '/x/y.txy', caller[0]) do
     action :delete
   end

is equivalent to:

.. code-block:: ruby

   file '/x/y.txt' do
     action :delete
   end

New in Chef Client 12.10.

.. end_tag

delete_resource
-----------------------------------------------------
.. tag dsl_recipe_method_delete_resource

Use the ``delete_resource`` method to find a resource in the resource collection, and then delete it.

The syntax for the ``delete_resource`` method is as follows:

.. code-block:: ruby

   delete_resource(:resource_type, 'resource_name')

where:

* ``:resource_type`` is the resource type, such as ``:file`` (for the **file** resource), ``:template`` (for the **template** resource), and so on. Any resource available to Chef may be declared.
* ``resource_name`` the property that is the default name of the resource, typically the string that appears in the ``resource 'name' do`` block of a resource (but not always); see the Syntax section for the resource to be declared to verify the default name property.

For example:

.. code-block:: ruby

   delete_resource(:template, '/x/y.erb')

New in Chef Client 12.10.

.. end_tag

delete_resource!
-----------------------------------------------------
.. tag dsl_recipe_method_delete_resource_bang

Use the ``delete_resource!`` method to find a resource in the resource collection, and then delete it. If the resource is not found, an exception is returned.

The syntax for the ``delete_resource!`` method is as follows:

.. code-block:: ruby

   delete_resource!(:resource_type, 'resource_name')

where:

* ``:resource_type`` is the resource type, such as ``:file`` (for the **file** resource), ``:template`` (for the **template** resource), and so on. Any resource available to Chef may be declared.
* ``resource_name`` the property that is the default name of the resource, typically the string that appears in the ``resource 'name' do`` block of a resource (but not always); see the Syntax section for the resource to be declared to verify the default name property.

For example:

.. code-block:: ruby

   delete_resource!(:file, '/x/file.txt')

New in Chef Client 12.10.

.. end_tag

edit_resource
-----------------------------------------------------
.. tag dsl_recipe_method_edit_resource

Use the ``edit_resource`` method to:

* Find a resource in the resource collection, and then edit it.
* Define a resource block. If a resource block with the same name exists in the resource collection, it will be updated with the contents of the resource block defined by the ``edit_resource`` method. If a resource block does not exist in the resource collection, it will be created.

The syntax for the ``edit_resource`` method is as follows:

.. code-block:: ruby

   edit_resource(:resource_type, 'resource_name', resource_attrs_block)

where:

* ``:resource_type`` is the resource type, such as ``:file`` (for the **file** resource), ``:template`` (for the **template** resource), and so on. Any resource available to Chef may be declared.
* ``resource_name`` the property that is the default name of the resource, typically the string that appears in the ``resource 'name' do`` block of a resource (but not always); see the Syntax section for the resource to be declared to verify the default name property.
* ``resource_attrs_block`` is a block in which properties of the instantiated resource are declared.

For example:

.. code-block:: ruby

   edit_resource(:template, '/x/y.txy') do
     cookbook 'cookbook_name'
   end

and a resource block:

.. code-block:: ruby

   edit_resource(:template, '/etc/aliases') do
     source 'aliases.erb'
     cookbook 'aliases'
     variables({:aliases => {} })
     notifies :run, 'execute[newaliases]'
   end

New in Chef Client 12.10.

.. end_tag

edit_resource!
-----------------------------------------------------
.. tag dsl_recipe_method_edit_resource_bang

Use the ``edit_resource!`` method to:

* Find a resource in the resource collection, and then edit it.
* Define a resource block. If a resource with the same name exists in the resource collection, its properties will be updated with the contents of the resource block defined by the ``edit_resource`` method.

In both cases, if the resource is not found, an exception is returned.

The syntax for the ``edit_resource!`` method is as follows:

.. code-block:: ruby

   edit_resource!(:resource_type, 'resource_name')

where:

* ``:resource_type`` is the resource type, such as ``:file`` (for the **file** resource), ``:template`` (for the **template** resource), and so on. Any resource available to Chef may be declared.
* ``resource_name`` the property that is the default name of the resource, typically the string that appears in the ``resource 'name' do`` block of a resource (but not always); see the Syntax section for the resource to be declared to verify the default name property.
* ``resource_attrs_block`` is a block in which properties of the instantiated resource are declared.

For example:

.. code-block:: ruby

   edit_resource!(:file, '/x/y.rst')

New in Chef Client 12.10.

.. end_tag

find_resource
-----------------------------------------------------
.. tag dsl_recipe_method_find_resource

Use the ``find_resource`` method to:

* Find a resource in the resource collection.
* Define a resource block. If a resource block with the same name exists in the resource collection, it will be returned. If a resource block does not exist in the resource collection, it will be created.

The syntax for the ``find_resource`` method is as follows:

.. code-block:: ruby

   find_resource(:resource_type, 'resource_name')

where:

* ``:resource_type`` is the resource type, such as ``:file`` (for the **file** resource), ``:template`` (for the **template** resource), and so on. Any resource available to Chef may be declared.
* ``resource_name`` the property that is the default name of the resource, typically the string that appears in the ``resource 'name' do`` block of a resource (but not always); see the Syntax section for the resource to be declared to verify the default name property.

For example:

.. code-block:: ruby

   find_resource(:template, '/x/y.txy')

and a resource block:

.. code-block:: ruby

   find_resource(:template, '/etc/seapower') do
     source 'seapower.erb'
     cookbook 'seapower'
     variables({:seapower => {} })
     notifies :run, 'execute[newseapower]'
   end

New in Chef Client 12.10.

.. end_tag

find_resource!
-----------------------------------------------------
.. tag dsl_recipe_method_find_resource_bang

Use the ``find_resource!`` method to find a resource in the resource collection. If the resource is not found, an exception is returned.

The syntax for the ``find_resource!`` method is as follows:

.. code-block:: ruby

   find_resource!(:resource_type, 'resource_name')

where:

* ``:resource_type`` is the resource type, such as ``:file`` (for the **file** resource), ``:template`` (for the **template** resource), and so on. Any resource available to Chef may be declared.
* ``resource_name`` the property that is the default name of the resource, typically the string that appears in the ``resource 'name' do`` block of a resource (but not always); see the Syntax section for the resource to be declared to verify the default name property.

For example:

.. code-block:: ruby

   find_resource!(:template, '/x/y.erb')

New in Chef Client 12.10.

.. end_tag

platform?
-----------------------------------------------------
Use the ``platform?`` method to ensure that certain actions are run for specific platform. The ``platform?`` method will return true if one of the listed parameters matches the ``node['platform']`` attribute that is detected by Ohai during every chef-client run.

The syntax for the ``platform?`` method is as follows:

.. code-block:: ruby

   platform?('parameter', 'parameter')

where:

* ``parameter`` is a comma-separated list, each specifying a platform, such as Red Hat, CentOS, or Fedora
* ``platform?`` method is typically used with an ``if``, ``elseif``, or ``case`` statement that contains Ruby code that is specific for the platform, if detected

.. future example: step_resource_ruby_block_if_statement_use_with_platform
.. future example: step_resource_ruby_block_run_specific_blocks_on_specific_platforms

Parameters
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following parameters can be used with this method:

.. list-table::
   :widths: 100 500
   :header-rows: 1

   * - Parameter
     - Platforms
   * - ``aix``
     - AIX. All platform variants of AIX return ``aix``.
   * - ``arch``
     - Arch Linux
   * - ``debian``
     - Debian, Linux Mint, Ubuntu
   * - ``fedora``
     - Fedora
   * - ``freebsd``
     - FreeBSD. All platform variants of FreeBSD return ``freebsd``.
   * - ``gentoo``
     - Gentoo
   * - ``mac_os_x``
     - macOS
   * - ``netbsd``
     - NetBSD. All platform variants of NetBSD return ``netbsd``.
   * - ``openbsd``
     - OpenBSD. All platform variants of OpenBSD return ``openbsd``.
   * - ``slackware``
     - Slackware
   * - ``solaris``
     - Solaris. For Solaris-related platforms, the ``platform_family`` method does not support the Solaris platform family and will default back to ``platform_family = platform``. For example, if the platform is OmniOS, the ``platform_family`` is ``omnios``, if the platform is SmartOS, the ``platform_family`` is ``smartos``, and so on. All platform variants of Solaris return ``solaris``.
   * - ``suse``
     - openSUSE, SUSE Enterprise Linux Server.
   * - ``windows``
     - Microsoft Windows. All platform variants of Microsoft Windows return ``windows``.

.. note:: Ohai collects platform information at the start of the chef-client run and stores that information in the ``node['platform']`` attribute.

For example:

.. code-block:: ruby

   platform?('debian')

or:

.. code-block:: ruby

   platform?('rhel', 'debian')

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following example shows how the ``platform?`` method can be used in a recipe.

**Use an if statement with the platform recipe DSL method**

.. tag resource_ruby_block_if_statement_use_with_platform

The following example shows how an if statement can be used with the ``platform?`` method in the Recipe DSL to run code specific to Microsoft Windows. The code is defined using the **ruby_block** resource:

.. code-block:: ruby

   # the following code sample comes from the ``client`` recipe
   # in the following cookbook: https://github.com/chef-cookbooks/mysql

   if platform?('windows')
     ruby_block 'copy libmysql.dll into ruby path' do
       block do
         require 'fileutils'
         FileUtils.cp "#{node['mysql']['client']['lib_dir']}\\libmysql.dll",
           node['mysql']['client']['ruby_dir']
       end
       not_if { File.exist?("#{node['mysql']['client']['ruby_dir']}\\libmysql.dll") }
     end
   end

.. end_tag

platform_family?
-----------------------------------------------------
Use the ``platform_family?`` method to ensure that certain actions are run for specific platform family. The ``platform_family?`` method will return true if one of the listed parameters matches the ``node['platform_family']`` attribute that is detected by Ohai during every chef-client run.

The syntax for the ``platform_family?`` method is as follows:

.. code-block:: ruby

   platform_family?('parameter', 'parameter')

where:

* ``'parameter'`` is a comma-separated list, each specifying a platform family, such as Debian, or Red Hat Enterprise Linux
* ``platform_family?`` method is typically used with an ``if``, ``elseif``, or ``case`` statement that contains Ruby code that is specific for the platform family, if detected

For example:

.. code-block:: ruby

   if platform_family?('rhel')
     # do RHEL things
   end

or:

.. code-block:: ruby

   if platform_family?('debian', 'rhel')
     # do things on debian and rhel families
   end

For example:

.. code-block:: ruby

   platform_family?('gentoo')

or:

.. code-block:: ruby

   platform_family?('slackware', 'suse', 'arch')

.. note:: ``platform_family?`` will default to ``platform?`` when ``platform_family?`` is not explicitly defined.

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples show how the ``platform_family?`` method can be used in a recipe.

**Use a specific binary for a specific platform**

.. tag resource_remote_file_use_platform_family

The following is an example of using the ``platform_family?`` method in the Recipe DSL to create a variable that can be used with other resources in the same recipe. In this example, ``platform_family?`` is being used to ensure that a specific binary is used for a specific platform before using the **remote_file** resource to download a file from a remote location, and then using the **execute** resource to install that file by running a command.

.. code-block:: ruby

   if platform_family?('rhel')
     pip_binary = '/usr/bin/pip'
   else
     pip_binary = '/usr/local/bin/pip'
   end

   remote_file "#{Chef::Config[:file_cache_path]}/distribute_setup.py" do
     source 'http://python-distribute.org/distribute_setup.py'
     mode '0755'
     not_if { File.exist?(pip_binary) }
   end

   execute 'install-pip' do
     cwd Chef::Config[:file_cache_path]
     command <<-EOF
       # command for installing Python goes here
       EOF
     not_if { File.exist?(pip_binary) }
   end

where a command for installing Python might look something like:

.. code-block:: ruby

    #{node['python']['binary']} distribute_setup.py
    #{::File.dirname(pip_binary)}/easy_install pip

.. end_tag

reboot_pending?
-----------------------------------------------------
Use the ``reboot_pending?`` method to test if a node needs a reboot, or is expected to reboot. ``reboot_pending?`` returns ``true`` when the node needs a reboot.

The syntax for the ``reboot_pending?`` method is as follows:

.. code-block:: ruby

   reboot_pending?

recipe_name
-----------------------------------------------------
Use the ``recipe_name`` method to return the name of a recipe.

The syntax for the ``recipe_name`` method is as follows:

.. code-block:: ruby

   recipe_name

This method is often used as part of a log entry. For example:

.. code-block:: ruby

   Chef::Log.info('I am a message from the #{recipe_name} recipe in the #{cookbook_name} cookbook.')

resources
-----------------------------------------------------
Use the ``resources`` method to look up a resource in the resource collection. The ``resources`` method returns the value for the resource that it finds in the resource collection. The preferred syntax for the ``resources`` method is as follows:

.. code-block:: ruby

   resources('resource_type[resource_name]')

but the following syntax can also be used:

.. code-block:: ruby

   resources(:resource_type => 'resource_name')

where in either approach ``resource_type`` is the name of a resource and ``resource_name`` is the name of a resource that can be configured by the chef-client.

The ``resources`` method can be used to modify a resource later on in a recipe. For example:

.. code-block:: ruby

   file '/etc/hosts' do
     content '127.0.0.1 localhost.localdomain localhost'
   end

and then later in the same recipe, or elsewhere:

.. code-block:: ruby

   f = resources('file[/etc/hosts]')
   f.mode '0644'

where ``file`` is the type of resource, ``/etc/hosts`` is the name, and ``f.mode`` is used to set the ``mode`` property on the **file** resource.

search
-----------------------------------------------------
.. tag search

Search indexes allow queries to be made for any type of data that is indexed by the Chef server, including data bags (and data bag items), environments, nodes, and roles. A defined query syntax is used to support search patterns like exact, wildcard, range, and fuzzy. A search is a full-text query that can be done from several locations, including from within a recipe, by using the ``search`` subcommand in knife, the ``search`` method in the Recipe DSL, the search box in the Chef management console, and by using the ``/search`` or ``/search/INDEX`` endpoints in the Chef server API. The search engine is based on Apache Solr and is run from the Chef server.

.. end_tag

Use the ``search`` method to perform a search query against the Chef server from within a recipe.

The syntax for the ``search`` method is as follows:

.. code-block:: ruby

   search(:index, 'query')

where:

* ``:index`` is of name of the index on the Chef server against which the search query will run: ``:client``, ``:data_bag_name``, ``:environment``, ``:node``, and ``:role``
* ``'query'`` is a valid search query against an object on the Chef server (see below for more information about how to build the query)

For example, using the results of a search query within a variable:

.. code-block:: ruby

   webservers = search(:node, 'role:webserver')

and then using the results of that query to populate a template:

.. code-block:: ruby

   template '/tmp/list_of_webservers' do
     source 'list_of_webservers.erb'
     variables(:webservers => webservers)
   end

:filter_result
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag dsl_recipe_method_search_filter_result

Use ``:filter_result`` as part of a search query to filter the search output based on the pattern specified by a Hash. Only attributes in the Hash will be returned.

.. note:: .. tag notes_filter_search_vs_partial_search

          Prior to chef-client 12.0, this functionality was available from the ``partial_search`` cookbook and was referred to as "partial search".

          .. end_tag

The syntax for the ``search`` method that uses ``:filter_result`` is as follows:

.. code-block:: ruby

   search(:index, 'query',
     :filter_result => { 'foo' => [ 'abc' ],
                         'bar' => [ '123' ],
                         'baz' => [ 'sea', 'power' ]
                       }
         ).each do |result|
     puts result['foo']
     puts result['bar']
     puts result['baz']
   end

where:

* ``:index`` is of name of the index on the Chef server against which the search query will run: ``:client``, ``:data_bag_name``, ``:environment``, ``:node``, and ``:role``
* ``'query'`` is a valid search query against an object on the Chef server
* ``:filter_result`` defines a Hash of values to be returned

For example:

.. code-block:: ruby

   search(:node, 'role:web',
     :filter_result => { 'name' => [ 'name' ],
                         'ip' => [ 'ipaddress' ],
                         'kernel_version' => [ 'kernel', 'version' ]
                       }
         ).each do |result|
     puts result['name']
     puts result['ip']
     puts result['kernel_version']
   end

.. end_tag

Query Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag search_query_syntax

A search query is comprised of two parts: the key and the search pattern. A search query has the following syntax:

.. code-block:: ruby

   key:search_pattern

where ``key`` is a field name that is found in the JSON description of an indexable object on the Chef server (a role, node, client, environment, or data bag) and ``search_pattern`` defines what will be searched for, using one of the following search patterns: exact, wildcard, range, or fuzzy matching. Both ``key`` and ``search_pattern`` are case-sensitive; ``key`` has limited support for multiple character wildcard matching using an asterisk ("*") (and as long as it is not the first character).

.. end_tag

Keys
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. tag search_key

A field name/description pair is available in the JSON object. Use the field name when searching for this information in the JSON object. Any field that exists in any JSON description for any role, node, chef-client, environment, or data bag can be searched.

.. end_tag

**Nested Fields**

.. tag search_key_nested

A nested field appears deeper in the JSON data structure. For example, information about a network interface might be several layers deep: ``node[:network][:interfaces][:en1]``. When nested fields are present in a JSON structure, the chef-client will extract those nested fields to the top-level, flattening them into compound fields that support wildcard search patterns.

By combining wildcards with range-matching patterns and wildcard queries, it is possible to perform very powerful searches, such as using the vendor part of the MAC address to find every node that has a network card made by the specified vendor.

Consider the following snippet of JSON data:

.. code-block:: javascript

   {"network":
     [
     //snipped...
       "interfaces",
         {"en1": {
           "number": "1",
           "flags": [
             "UP",
             "BROADCAST",
             "SMART",
             "RUNNING",
             "SIMPLEX",
             "MULTICAST"
           ],
           "addresses": {
             "fe80::fa1e:dfff:fed8:63a2": {
               "scope": "Link",
               "prefixlen": "64",
               "family": "inet6"
             },
             "f8:1e:df:d8:63:a2": {
               "family": "lladdr"
             },
             "192.0.2.0": {
               "netmask": "255.255.255.0",
               "broadcast": "192.168.0.255",
               "family": "inet"
             }
           },
           "mtu": "1500",
           "media": {
             "supported": {
               "autoselect": {
                 "options": [

                 ]
               }
             },
             "selected": {
               "autoselect": {
                 "options": [

                 ]
               }
             }
           },
           "type": "en",
           "status": "active",
           "encapsulation": "Ethernet"
         },
     //snipped...

Before this data is indexed on the Chef server, the nested fields are extracted into the top level, similar to:

.. code-block:: none

   "broadcast" => "192.168.0.255",
   "flags"     => ["UP", "BROADCAST", "SMART", "RUNNING", "SIMPLEX", "MULTICAST"]
   "mtu"       => "1500"

which allows searches like the following to find data that is present in this node:

.. code-block:: ruby

   node "broadcast:192.168.0.*"

or:

.. code-block:: ruby

   node "mtu:1500"

or:

.. code-block:: ruby

   node "flags:UP"

This data is also flattened into various compound fields, which follow the same pattern as the JSON hierarchy and use underscores (``_``) to separate the levels of data, similar to:

.. code-block:: none

     # ...snip...
     "network_interfaces_en1_addresses_192.0.2.0_broadcast" => "192.168.0.255",
     "network_interfaces_en1_addresses_fe80::fa1e:tldr_family"  => "inet6",
     "network_interfaces_en1_addresses"                         => ["fe80::fa1e:tldr","f8:1e:df:tldr","192.0.2.0"]
     # ...snip...

which allows searches like the following to find data that is present in this node:

.. code-block:: ruby

   node "network_interfaces_en1_addresses:192.0.2.0"

This flattened data structure also supports using wildcard compound fields, which allow searches to omit levels within the JSON data structure that are not important to the search query. In the following example, an asterisk (``*``) is used to show where the wildcard can exist when searching for a nested field:

.. code-block:: ruby

   "network_interfaces_*_flags"     => ["UP", "BROADCAST", "SMART", "RUNNING", "SIMPLEX", "MULTICAST"]
   "network_interfaces_*_addresses" => ["fe80::fa1e:dfff:fed8:63a2", "192.0.2.0", "f8:1e:df:d8:63:a2"]
   "network_interfaces_en0_media_*" => ["autoselect", "none", "1000baseT", "10baseT/UTP", "100baseTX"]
   "network_interfaces_en1_*"       => ["1", "UP", "BROADCAST", "SMART", "RUNNING", "SIMPLEX", "MULTICAST",
                                        "fe80::fa1e:dfff:fed8:63a2", "f8:1e:df:d8:63:a2", "192.0.2.0",
                                        "1500", "supported", "selected", "en", "active", "Ethernet"]

For each of the wildcard examples above, the possible values are shown contained within the brackets. When running a search query, the query syntax for wildcards is to simply omit the name of the node (while preserving the underscores), similar to:

.. code-block:: ruby

   network_interfaces__flags

This query will search within the ``flags`` node, within the JSON structure, for each of ``UP``, ``BROADCAST``, ``SMART``, ``RUNNING``, ``SIMPLEX``, and ``MULTICAST``.

.. end_tag

Patterns
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. tag search_pattern

A search pattern is a way to fine-tune search results by returning anything that matches some type of incomplete search query. There are four types of search patterns that can be used when searching the search indexes on the Chef server: exact, wildcard, range, and fuzzy.

.. end_tag

**Exact Match**

.. tag search_pattern_exact

An exact matching search pattern is used to search for a key with a name that exactly matches a search query. If the name of the key contains spaces, quotes must be used in the search pattern to ensure the search query finds the key. The entire query must also be contained within quotes, so as to prevent it from being interpreted by Ruby or a command shell. The best way to ensure that quotes are used consistently is to quote the entire query using single quotes (' ') and a search pattern with double quotes (" ").

.. end_tag

**Wildcard Match**

.. tag search_pattern_wildcard

A wildcard matching search pattern is used to query for substring matches that replace zero (or more) characters in the search pattern with anything that could match the replaced character. There are two types of wildcard searches:

* A question mark (``?``) can be used to replace exactly one character (as long as that character is not the first character in the search pattern)
* An asterisk (``*``) can be used to replace any number of characters (including zero)

.. end_tag

**Range Match**

.. tag search_pattern_range

A range matching search pattern is used to query for values that are within a range defined by upper and lower boundaries. A range matching search pattern can be inclusive or exclusive of the boundaries. Use square brackets ("[ ]") to denote inclusive boundaries and curly braces ("{ }") to denote exclusive boundaries and with the following syntax:

.. code-block:: ruby

   boundary TO boundary

where ``TO`` is required (and must be capitalized).

.. end_tag

**Fuzzy Match**

.. tag search_pattern_fuzzy

A fuzzy matching search pattern is used to search based on the proximity of two strings of characters. An (optional) integer may be used as part of the search query to more closely define the proximity. A fuzzy matching search pattern has the following syntax:

.. code-block:: ruby

   "search_query"~edit_distance

where ``search_query`` is the string that will be used during the search and ``edit_distance`` is the proximity. A tilde ("~") is used to separate the edit distance from the search query.

.. end_tag

Operators
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. tag search_boolean_operators

An operator can be used to ensure that certain terms are included in the results, are excluded from the results, or are not included even when other aspects of the query match. Searches can use the following operators:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Operator
     - Description
   * - ``AND``
     - Use to find a match when both terms exist.
   * - ``OR``
     - Use to find a match if either term exists.
   * - ``NOT``
     - Use to exclude the term after ``NOT`` from the search results.

.. end_tag

Special Characters
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. tag search_special_characters

A special character can be used to fine-tune a search query and to increase the accuracy of the search results. The following characters can be included within the search query syntax, but each occurrence of a special character must be escaped with a backslash (``\``), also (``/``) must be escaped against the Elasticsearch:

.. code-block:: ruby

   +  -  &&  | |  !  ( )  { }  [ ]  ^  "  ~  *  ?  :  \  /

For example:

.. code-block:: ruby

   \(1\+1\)\:2

.. end_tag

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following examples show how the ``search`` method can be used in a recipe.

**Use the search recipe DSL method to find users**

.. tag resource_execute_use_search_dsl_method

The following example shows how to use the ``search`` method in the Recipe DSL to search for users:

.. code-block:: ruby

   #  the following code sample comes from the openvpn cookbook: https://github.com/chef-cookbooks/openvpn

   search("users", "*:*") do |u|
     execute "generate-openvpn-#{u['id']}" do
       command "./pkitool #{u['id']}"
       cwd '/etc/openvpn/easy-rsa'
       environment(
         'EASY_RSA' => '/etc/openvpn/easy-rsa',
         'KEY_CONFIG' => '/etc/openvpn/easy-rsa/openssl.cnf',
         'KEY_DIR' => node['openvpn']['key_dir'],
         'CA_EXPIRE' => node['openvpn']['key']['ca_expire'].to_s,
         'KEY_EXPIRE' => node['openvpn']['key']['expire'].to_s,
         'KEY_SIZE' => node['openvpn']['key']['size'].to_s,
         'KEY_COUNTRY' => node['openvpn']['key']['country'],
         'KEY_PROVINCE' => node['openvpn']['key']['province'],
         'KEY_CITY' => node['openvpn']['key']['city'],
         'KEY_ORG' => node['openvpn']['key']['org'],
         'KEY_EMAIL' => node['openvpn']['key']['email']
       )
       not_if { File.exist?("#{node['openvpn']['key_dir']}/#{u['id']}.crt") }
     end

     %w{ conf ovpn }.each do |ext|
       template "#{node['openvpn']['key_dir']}/#{u['id']}.#{ext}" do
         source 'client.conf.erb'
         variables :username => u['id']
       end
     end

     execute "create-openvpn-tar-#{u['id']}" do
       cwd node['openvpn']['key_dir']
       command <<-EOH
         tar zcf #{u['id']}.tar.gz \
         ca.crt #{u['id']}.crt #{u['id']}.key \
         #{u['id']}.conf #{u['id']}.ovpn \
       EOH
       not_if { File.exist?("#{node['openvpn']['key_dir']}/#{u['id']}.tar.gz") }
     end
   end

where

* the search will use both of the **execute** resources, unless the condition specified by the ``not_if`` commands are met
* the ``environments`` property in the first **execute** resource is being used to define values that appear as variables in the OpenVPN configuration
* the **template** resource tells the chef-client which template to use

.. end_tag

shell_out
-----------------------------------------------------
.. tag dsl_recipe_method_shell_out

The ``shell_out`` method can be used to run a command against the node, and then display the output to the console when the log level is set to ``debug``.

The syntax for the ``shell_out`` method is as follows:

.. code-block:: ruby

   shell_out(command_args)

where ``command_args`` is the command that is run against the node.

.. end_tag

shell_out!
-----------------------------------------------------
.. tag dsl_recipe_method_shell_out_bang

The ``shell_out!`` method can be used to run a command against the node, display the output to the console when the log level is set to ``debug``, and then raise an error when the method returns ``false``.

The syntax for the ``shell_out!`` method is as follows:

.. code-block:: ruby

   shell_out!(command_args)

where ``command_args`` is the command that is run against the node. This method will return ``true`` or ``false``.

.. end_tag

shell_out_with_systems_locale
-----------------------------------------------------
.. tag dsl_recipe_method_shell_out_with_systems_locale

The ``shell_out_with_systems_locale`` method can be used to run a command against the node (via the ``shell_out`` method), but using the ``LC_ALL`` environment variable.

The syntax for the ``shell_out_with_systems_locale`` method is as follows:

.. code-block:: ruby

   shell_out_with_systems_locale(command_args)

where ``command_args`` is the command that is run against the node.

.. end_tag

tag, tagged?, untag
-----------------------------------------------------
.. tag chef_tags

A tag is a custom description that is applied to a node. A tag, once applied, can be helpful when managing nodes using knife or when building recipes by providing alternate methods of grouping similar types of information.

.. end_tag

.. tag cookbooks_recipe_tags

Tags can be added and removed. Machines can be checked to see if they already have a specific tag. To use tags in your recipe simply add the following:

.. code-block:: ruby

   tag('mytag')

To test if a machine is tagged, add the following:

.. code-block:: ruby

   tagged?('mytag')

to return ``true`` or ``false``. ``tagged?`` can also use an array as an argument.

To remove a tag:

.. code-block:: ruby

   untag('mytag')

For example:

.. code-block:: ruby

   tag('machine')

   if tagged?('machine')
      Chef::Log.info("Hey I'm #{node[:tags]}")
   end

   untag('machine')

   if not tagged?('machine')
      Chef::Log.info('I has no tagz')
   end

Will return something like this:

.. code-block:: none

   [Thu, 22 Jul 2010 18:01:45 +0000] INFO: Hey I'm machine
   [Thu, 22 Jul 2010 18:01:45 +0000] INFO: I has no tagz

.. end_tag

value_for_platform
-----------------------------------------------------
Use the ``value_for_platform`` method in a recipe to select a value based on the ``node['platform']`` and ``node['platform_version']`` attributes. These values are detected by Ohai during every chef-client run.

The syntax for the ``value_for_platform`` method is as follows:

.. code-block:: ruby

   value_for_platform( ['platform', ...] => { 'version' => 'value' } )

where:

* ``'platform', ...`` is a comma-separated list of platforms, such as Red Hat, openSUSE, or Fedora
* ``version`` specifies the version of that platform
* Version constraints---``>``, ``<``, ``>=``, ``<=``, ``~>``---may be used with ``version``; an exception is raised if two version constraints match; an exact match will always take precedence over a match made from a version constraint
* ``value`` specifies the value that will be used if the node's platform matches the ``value_for_platform`` method

When each value only has a single platform, use the following syntax:

.. code-block:: ruby

   value_for_platform(
     'platform' => { 'version' => 'value' },
     'platform' => { 'version' => 'value' },
     'platform' => 'value'
   )

When each value has more than one platform, the syntax changes to:

.. code-block:: ruby

   value_for_platform(
     ['platform', 'platform', ... ] => {
       'version' => 'value'
     },
   )

Changed in Chef Client 12.0 to support version constraints.

Operators
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag cookbooks_version_constraints_operators

The following operators may be used:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Operator
     - Description
   * - ``=``
     - equal to
   * - ``>``
     - greater than
   * - ``<``
     - less than
   * - ``>=``
     - greater than or equal to; also known as "optimistically greater than", or "optimistic"
   * - ``<=``
     - less than or equal to
   * - ``~>``
     - approximately greater than; also known as "pessimistically greater than", or "pessimistic"

.. end_tag

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following example will set ``package_name`` to ``httpd`` for the Red Hat platform and to ``apache2`` for the Debian platform:

.. code-block:: ruby

   package_name = value_for_platform(
     ['centos', 'redhat', 'suse', 'fedora' ] => {
       'default' => 'httpd'
     },
     ['ubuntu', 'debian'] => {
       'default' => 'apache2'
     }
   )

The following example will set ``package`` to ``apache-couchdb`` for OpenBSD platforms, ``dev-db/couchdb`` for Gentoo platforms, and ``couchdb`` for all other platforms:

.. code-block:: ruby

   package = value_for_platform(
     'openbsd' => { 'default' => 'apache-couchdb' },
     'gentoo' => { 'default' => 'dev-db/couchdb' },
     'default' => 'couchdb'
   )

The following example shows using version constraints to specify a value based on the version:

.. code-block:: ruby

   value_for_platform(
     'os1' => { '< 1.0' => 'less than 1.0',
                '~> 2.0' => 'version 2.x',
                '>= 3.0' => 'version 3.0',
                '3.0.1' => '3.0.1 will always use this value' }
   )

value_for_platform_family
-----------------------------------------------------
Use the ``value_for_platform_family`` method in a recipe to select a value based on the ``node['platform_family']`` attribute. This value is detected by Ohai during every chef-client run.

The syntax for the ``value_for_platform_family`` method is as follows:

.. code-block:: ruby

   value_for_platform_family( 'platform_family' => 'value', ... )

where:

* ``'platform_family' => 'value', ...`` is a comma-separated list of platforms, such as Fedora, openSUSE, or Red Hat Enterprise Linux
* ``value`` specifies the value that will be used if the node's platform family matches the ``value_for_platform_family`` method

When each value only has a single platform, use the following syntax:

.. code-block:: ruby

   value_for_platform_family(
     'platform_family' => 'value',
     'platform_family' => 'value',
     'platform_family' => 'value'
   )

When each value has more than one platform, the syntax changes to:

.. code-block:: ruby

   value_for_platform_family(
     ['platform_family', 'platform_family', 'platform_family', 'platform_family' ] => 'value',
     ['platform_family', 'platform_family'] => 'value',
     'default' => 'value'
   )

The following example will set ``package`` to ``httpd-devel`` for the Red Hat Enterprise Linux, Fedora, and openSUSE platforms and to ``apache2-dev`` for the Debian platform:

.. code-block:: ruby

   package = value_for_platform_family(
     ['rhel', 'fedora', 'suse'] => 'httpd-devel',
       'debian' => 'apache2-dev'
   )

with_run_context
-----------------------------------------------------
.. tag dsl_recipe_method_with_run_context

Use the ``with_run_context`` method to define a block that has a pointer to a location in the ``run_context`` hierarchy. Resources in recipes always run at the root of the ``run_context`` hierarchy, whereas custom resources and notification blocks always build a child ``run_context`` which contains their sub-resources.

The syntax for the ``with_run_context`` method is as follows:

.. code-block:: ruby

   with_run_context :type do
     # some arbitrary pure Ruby stuff goes here
   end

where ``:type`` may be one of the following:

* ``:root`` runs the block as part of the root ``run_context`` hierarchy
* ``:parent`` runs the block as part of the parent process in the ``run_context`` hierarchy

For example:

.. code-block:: ruby

   action :run do
     with_run_context :root do
       edit_resource(:my_thing, "accumulated state") do
         action :nothing
         my_array_property << accumulate_some_stuff
       end
     end
     log "kick it off" do
       notifies :run, "my_thing[accumulated state], :delayed
     end
   end

.. end_tag

Windows Platform
=====================================================
.. tag dsl_recipe_method_windows_methods

Six methods are present in the Recipe DSL to help verify the registry during a chef-client run on the Microsoft Windows platform---``registry_data_exists?``, ``registry_get_subkeys``, ``registry_get_values``, ``registry_has_subkeys?``, ``registry_key_exists?``, and ``registry_value_exists?``---these helpers ensure the **powershell_script** resource is idempotent.

.. end_tag

.. note:: .. tag notes_dsl_recipe_order_for_windows_methods

          The recommended order in which registry key-specific methods should be used within a recipe is: ``key_exists?``, ``value_exists?``, ``data_exists?``, ``get_values``, ``has_subkeys?``, and then ``get_subkeys``.

          .. end_tag

registry_data_exists?
-----------------------------------------------------
.. tag dsl_recipe_method_registry_data_exists

Use the ``registry_data_exists?`` method to find out if a Microsoft Windows registry key contains the specified data of the specified type under the value.

.. note:: .. tag notes_registry_key_not_if_only_if

          This method can be used in recipes and from within the ``not_if`` and ``only_if`` blocks in resources. This method is not designed to create or modify a registry key. If a registry key needs to be modified, use the **registry_key** resource.

          .. end_tag

The syntax for the ``registry_data_exists?`` method is as follows:

.. code-block:: ruby

   registry_data_exists?(
     KEY_PATH,
     { name: 'NAME', type: TYPE, data: DATA },
     ARCHITECTURE
   )

where:

* ``KEY_PATH`` is the path to the registry key value. The path must include the registry hive, which can be specified either as its full name or as the 3- or 4-letter abbreviation. For example, both ``HKLM\SECURITY`` and ``HKEY_LOCAL_MACHINE\SECURITY`` are both valid and equivalent. The following hives are valid: ``HKEY_LOCAL_MACHINE``, ``HKLM``, ``HKEY_CURRENT_CONFIG``, ``HKCC``, ``HKEY_CLASSES_ROOT``, ``HKCR``, ``HKEY_USERS``, ``HKU``, ``HKEY_CURRENT_USER``, and ``HKCU``.
* ``{ name: 'NAME', type: TYPE, data: DATA }`` is a hash that contains the expected name, type, and data of the registry key value
* ``type:`` represents the values available for registry keys in Microsoft Windows. Use ``:binary`` for REG_BINARY, ``:string`` for REG_SZ, ``:multi_string`` for REG_MULTI_SZ, ``:expand_string`` for REG_EXPAND_SZ, ``:dword`` for REG_DWORD, ``:dword_big_endian`` for REG_DWORD_BIG_ENDIAN, or ``:qword`` for REG_QWORD.
* ``ARCHITECTURE`` is one of the following values: ``:x86_64``, ``:i386``, or ``:machine``. In order to read or write 32-bit registry keys on 64-bit machines running Microsoft Windows, the ``architecture`` property must be set to ``:i386``. The ``:x86_64`` value can be used to force writing to a 64-bit registry location, but this value is less useful than the default (``:machine``) because the chef-client returns an exception if ``:x86_64`` is used and the machine turns out to be a 32-bit machine (whereas with ``:machine``, the chef-client is able to access the registry key on the 32-bit machine).

This method will return ``true`` or ``false``.

.. note:: .. tag notes_registry_key_architecture

          The ``ARCHITECTURE`` attribute should only specify ``:x86_64`` or ``:i386`` when it is necessary to write 32-bit (``:i386``) or 64-bit (``:x86_64``) values on a 64-bit machine. ``ARCHITECTURE`` will default to ``:machine`` unless a specific value is given.

          .. end_tag

.. end_tag

registry_get_subkeys
-----------------------------------------------------
.. tag dsl_recipe_method_registry_get_subkeys

Use the ``registry_get_subkeys`` method to get a list of registry key values that are present for a Microsoft Windows registry key.

.. note:: .. tag notes_registry_key_not_if_only_if

          This method can be used in recipes and from within the ``not_if`` and ``only_if`` blocks in resources. This method is not designed to create or modify a registry key. If a registry key needs to be modified, use the **registry_key** resource.

          .. end_tag

The syntax for the ``registry_get_subkeys`` method is as follows:

.. code-block:: ruby

   subkey_array = registry_get_subkeys(KEY_PATH, ARCHITECTURE)

where:

* ``KEY_PATH`` is the path to the registry key. The path must include the registry hive, which can be specified either as its full name or as the 3- or 4-letter abbreviation. For example, both ``HKLM\SECURITY`` and ``HKEY_LOCAL_MACHINE\SECURITY`` are both valid and equivalent. The following hives are valid: ``HKEY_LOCAL_MACHINE``, ``HKLM``, ``HKEY_CURRENT_CONFIG``, ``HKCC``, ``HKEY_CLASSES_ROOT``, ``HKCR``, ``HKEY_USERS``, ``HKU``, ``HKEY_CURRENT_USER``, and ``HKCU``.
* ``ARCHITECTURE`` is one of the following values: ``:x86_64``, ``:i386``, or ``:machine``. In order to read or write 32-bit registry keys on 64-bit machines running Microsoft Windows, the ``architecture`` property must be set to ``:i386``. The ``:x86_64`` value can be used to force writing to a 64-bit registry location, but this value is less useful than the default (``:machine``) because the chef-client returns an exception if ``:x86_64`` is used and the machine turns out to be a 32-bit machine (whereas with ``:machine``, the chef-client is able to access the registry key on the 32-bit machine).

This returns an array of registry key values.

.. note:: .. tag notes_registry_key_architecture

          The ``ARCHITECTURE`` attribute should only specify ``:x86_64`` or ``:i386`` when it is necessary to write 32-bit (``:i386``) or 64-bit (``:x86_64``) values on a 64-bit machine. ``ARCHITECTURE`` will default to ``:machine`` unless a specific value is given.

          .. end_tag

.. end_tag

registry_get_values
-----------------------------------------------------
.. tag dsl_recipe_method_registry_get_values

Use the ``registry_get_values`` method to get the registry key values (name, type, and data) for a Microsoft Windows registry key.

.. note:: .. tag notes_registry_key_not_if_only_if

          This method can be used in recipes and from within the ``not_if`` and ``only_if`` blocks in resources. This method is not designed to create or modify a registry key. If a registry key needs to be modified, use the **registry_key** resource.

          .. end_tag

The syntax for the ``registry_get_values`` method is as follows:

.. code-block:: ruby

   subkey_array = registry_get_values(KEY_PATH, ARCHITECTURE)

where:

* ``KEY_PATH`` is the path to the registry key. The path must include the registry hive, which can be specified either as its full name or as the 3- or 4-letter abbreviation. For example, both ``HKLM\SECURITY`` and ``HKEY_LOCAL_MACHINE\SECURITY`` are both valid and equivalent. The following hives are valid: ``HKEY_LOCAL_MACHINE``, ``HKLM``, ``HKEY_CURRENT_CONFIG``, ``HKCC``, ``HKEY_CLASSES_ROOT``, ``HKCR``, ``HKEY_USERS``, ``HKU``, ``HKEY_CURRENT_USER``, and ``HKCU``.
* ``ARCHITECTURE`` is one of the following values: ``:x86_64``, ``:i386``, or ``:machine``. In order to read or write 32-bit registry keys on 64-bit machines running Microsoft Windows, the ``architecture`` property must be set to ``:i386``. The ``:x86_64`` value can be used to force writing to a 64-bit registry location, but this value is less useful than the default (``:machine``) because the chef-client returns an exception if ``:x86_64`` is used and the machine turns out to be a 32-bit machine (whereas with ``:machine``, the chef-client is able to access the registry key on the 32-bit machine).

This returns an array of registry key values.

.. note:: .. tag notes_registry_key_architecture

          The ``ARCHITECTURE`` attribute should only specify ``:x86_64`` or ``:i386`` when it is necessary to write 32-bit (``:i386``) or 64-bit (``:x86_64``) values on a 64-bit machine. ``ARCHITECTURE`` will default to ``:machine`` unless a specific value is given.

          .. end_tag

.. end_tag

registry_has_subkeys?
-----------------------------------------------------
.. tag dsl_recipe_method_registry_has_subkeys

Use the ``registry_has_subkeys?`` method to find out if a Microsoft Windows registry key has one (or more) values.

.. note:: .. tag notes_registry_key_not_if_only_if

          This method can be used in recipes and from within the ``not_if`` and ``only_if`` blocks in resources. This method is not designed to create or modify a registry key. If a registry key needs to be modified, use the **registry_key** resource.

          .. end_tag

The syntax for the ``registry_has_subkeys?`` method is as follows:

.. code-block:: ruby

   registry_has_subkeys?(KEY_PATH, ARCHITECTURE)

where:

* ``KEY_PATH`` is the path to the registry key. The path must include the registry hive, which can be specified either as its full name or as the 3- or 4-letter abbreviation. For example, both ``HKLM\SECURITY`` and ``HKEY_LOCAL_MACHINE\SECURITY`` are both valid and equivalent. The following hives are valid: ``HKEY_LOCAL_MACHINE``, ``HKLM``, ``HKEY_CURRENT_CONFIG``, ``HKCC``, ``HKEY_CLASSES_ROOT``, ``HKCR``, ``HKEY_USERS``, ``HKU``, ``HKEY_CURRENT_USER``, and ``HKCU``.
* ``ARCHITECTURE`` is one of the following values: ``:x86_64``, ``:i386``, or ``:machine``. In order to read or write 32-bit registry keys on 64-bit machines running Microsoft Windows, the ``architecture`` property must be set to ``:i386``. The ``:x86_64`` value can be used to force writing to a 64-bit registry location, but this value is less useful than the default (``:machine``) because the chef-client returns an exception if ``:x86_64`` is used and the machine turns out to be a 32-bit machine (whereas with ``:machine``, the chef-client is able to access the registry key on the 32-bit machine).

This method will return ``true`` or ``false``.

.. note:: .. tag notes_registry_key_architecture

          The ``ARCHITECTURE`` attribute should only specify ``:x86_64`` or ``:i386`` when it is necessary to write 32-bit (``:i386``) or 64-bit (``:x86_64``) values on a 64-bit machine. ``ARCHITECTURE`` will default to ``:machine`` unless a specific value is given.

          .. end_tag

.. end_tag

registry_key_exists?
-----------------------------------------------------
.. tag dsl_recipe_method_registry_key_exists

Use the ``registry_key_exists?`` method to find out if a Microsoft Windows registry key exists at the specified path.

.. note:: .. tag notes_registry_key_not_if_only_if

          This method can be used in recipes and from within the ``not_if`` and ``only_if`` blocks in resources. This method is not designed to create or modify a registry key. If a registry key needs to be modified, use the **registry_key** resource.

          .. end_tag

The syntax for the ``registry_key_exists?`` method is as follows:

.. code-block:: ruby

   registry_key_exists?(KEY_PATH, ARCHITECTURE)

where:

* ``KEY_PATH`` is the path to the registry key. The path must include the registry hive, which can be specified either as its full name or as the 3- or 4-letter abbreviation. For example, both ``HKLM\SECURITY`` and ``HKEY_LOCAL_MACHINE\SECURITY`` are both valid and equivalent. The following hives are valid: ``HKEY_LOCAL_MACHINE``, ``HKLM``, ``HKEY_CURRENT_CONFIG``, ``HKCC``, ``HKEY_CLASSES_ROOT``, ``HKCR``, ``HKEY_USERS``, ``HKU``, ``HKEY_CURRENT_USER``, and ``HKCU``.
* ``ARCHITECTURE`` is one of the following values: ``:x86_64``, ``:i386``, or ``:machine``. In order to read or write 32-bit registry keys on 64-bit machines running Microsoft Windows, the ``architecture`` property must be set to ``:i386``. The ``:x86_64`` value can be used to force writing to a 64-bit registry location, but this value is less useful than the default (``:machine``) because the chef-client returns an exception if ``:x86_64`` is used and the machine turns out to be a 32-bit machine (whereas with ``:machine``, the chef-client is able to access the registry key on the 32-bit machine).

This method will return ``true`` or ``false``. (Any registry key values that are associated with this registry key are ignored.)

.. note:: .. tag notes_registry_key_architecture

          The ``ARCHITECTURE`` attribute should only specify ``:x86_64`` or ``:i386`` when it is necessary to write 32-bit (``:i386``) or 64-bit (``:x86_64``) values on a 64-bit machine. ``ARCHITECTURE`` will default to ``:machine`` unless a specific value is given.

          .. end_tag

.. end_tag

registry_value_exists?
-----------------------------------------------------
.. tag dsl_recipe_method_registry_value_exists

Use the ``registry_value_exists?`` method to find out if a registry key value exists. Use ``registry_data_exists?`` to test for the type and data of a registry key value.

.. note:: .. tag notes_registry_key_not_if_only_if

          This method can be used in recipes and from within the ``not_if`` and ``only_if`` blocks in resources. This method is not designed to create or modify a registry key. If a registry key needs to be modified, use the **registry_key** resource.

          .. end_tag

The syntax for the ``registry_value_exists?`` method is as follows:

.. code-block:: ruby

   registry_value_exists?(
     KEY_PATH,
     { name: 'NAME' },
     ARCHITECTURE
   )

where:

* ``KEY_PATH`` is the path to the registry key. The path must include the registry hive, which can be specified either as its full name or as the 3- or 4-letter abbreviation. For example, both ``HKLM\SECURITY`` and ``HKEY_LOCAL_MACHINE\SECURITY`` are both valid and equivalent. The following hives are valid: ``HKEY_LOCAL_MACHINE``, ``HKLM``, ``HKEY_CURRENT_CONFIG``, ``HKCC``, ``HKEY_CLASSES_ROOT``, ``HKCR``, ``HKEY_USERS``, ``HKU``, ``HKEY_CURRENT_USER``, and ``HKCU``.
* ``{ name: 'NAME' }`` is a hash that contains the name of the registry key value; if either ``type:`` or ``:value`` are specified in the hash, they are ignored
* ``type:`` represents the values available for registry keys in Microsoft Windows. Use ``:binary`` for REG_BINARY, ``:string`` for REG_SZ, ``:multi_string`` for REG_MULTI_SZ, ``:expand_string`` for REG_EXPAND_SZ, ``:dword`` for REG_DWORD, ``:dword_big_endian`` for REG_DWORD_BIG_ENDIAN, or ``:qword`` for REG_QWORD.
* ``ARCHITECTURE`` is one of the following values: ``:x86_64``, ``:i386``, or ``:machine``. In order to read or write 32-bit registry keys on 64-bit machines running Microsoft Windows, the ``architecture`` property must be set to ``:i386``. The ``:x86_64`` value can be used to force writing to a 64-bit registry location, but this value is less useful than the default (``:machine``) because the chef-client returns an exception if ``:x86_64`` is used and the machine turns out to be a 32-bit machine (whereas with ``:machine``, the chef-client is able to access the registry key on the 32-bit machine).

This method will return ``true`` or ``false``.

.. note:: .. tag notes_registry_key_architecture

          The ``ARCHITECTURE`` attribute should only specify ``:x86_64`` or ``:i386`` when it is necessary to write 32-bit (``:i386``) or 64-bit (``:x86_64``) values on a 64-bit machine. ``ARCHITECTURE`` will default to ``:machine`` unless a specific value is given.

          .. end_tag

.. end_tag

Helpers
-----------------------------------------------------
.. tag dsl_recipe_helper_windows_platform

A recipe can define specific behaviors for specific Microsoft Windows platform versions by using a series of helper methods. To enable these helper methods, add the following to a recipe:

.. code-block:: ruby

   require 'chef/win32/version'

Then declare a variable using the ``Chef::ReservedNames::Win32::Version`` class:

.. code-block:: ruby

   variable_name = Chef::ReservedNames::Win32::Version.new

And then use this variable to define specific behaviors for specific Microsoft Windows platform versions. For example:

.. code-block:: ruby

   if variable_name.helper_name?
     # Ruby code goes here, such as
     resource_name do
       # resource block
     end

   elsif variable_name.helper_name?
     # Ruby code goes here
     resource_name do
       # resource block for something else
     end

   else variable_name.helper_name?
     # Ruby code goes here, such as
     log 'log entry' do
       level :level
     end

   end

.. end_tag

.. tag dsl_recipe_helper_windows_platform_helpers

The following Microsoft Windows platform-specific helpers can be used in recipes:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Helper
     - Description
   * - ``cluster?``
     - Use to test for a Cluster SKU (Windows Server 2003 and later).
   * - ``core?``
     - Use to test for a Core SKU (Windows Server 2003 and later).
   * - ``datacenter?``
     - Use to test for a Datacenter SKU.
   * - ``marketing_name``
     - Use to display the marketing name for a Microsoft Windows platform.
   * - ``windows_7?``
     - Use to test for Windows 7.
   * - ``windows_8?``
     - Use to test for Windows 8.
   * - ``windows_8_1?``
     - Use to test for Windows 8.1.
   * - ``windows_2000?``
     - Use to test for Windows 2000.
   * - ``windows_home_server?``
     - Use to test for Windows Home Server.
   * - ``windows_server_2003?``
     - Use to test for Windows Server 2003.
   * - ``windows_server_2003_r2?``
     - Use to test for Windows Server 2003 R2.
   * - ``windows_server_2008?``
     - Use to test for Windows Server 2008.
   * - ``windows_server_2008_r2?``
     - Use to test for Windows Server 2008 R2.
   * - ``windows_server_2012?``
     - Use to test for Windows Server 2012.
   * - ``windows_server_2012_r2?``
     - Use to test for Windows Server 2012 R2.
   * - ``windows_vista?``
     - Use to test for Windows Vista.
   * - ``windows_xp?``
     - Use to test for Windows XP.

.. end_tag

.. tag dsl_recipe_helper_windows_platform_summary

The following example installs Windows PowerShell 2.0 on systems that do not already have it installed. Microsoft Windows platform helper methods are used to define specific behaviors for specific platform versions:

.. code-block:: ruby

   case node['platform']
   when 'windows'

     require 'chef/win32/version'
     windows_version = Chef::ReservedNames::Win32::Version.new

     if (windows_version.windows_server_2008_r2? || windows_version.windows_7?) && windows_version.core?

       windows_feature 'NetFx2-ServerCore' do
         action :install
       end
       windows_feature 'NetFx2-ServerCore-WOW64' do
         action :install
         only_if { node['kernel']['machine'] == 'x86_64' }
       end

     elsif windows_version.windows_server_2008? || windows_version.windows_server_2003_r2? ||
         windows_version.windows_server_2003? || windows_version.windows_xp?

       if windows_version.windows_server_2008?
         windows_feature 'NET-Framework-Core' do
           action :install
         end

       else
         windows_package 'Microsoft .NET Framework 2.0 Service Pack 2' do
           source node['ms_dotnet2']['url']
           checksum node['ms_dotnet2']['checksum']
           installer_type :custom
           options '/quiet /norestart'
           action :install
         end
       end
     else
       log '.NET Framework 2.0 is already enabled on this version of Windows' do
         level :warn
       end
     end
   else
     log '.NET Framework 2.0 cannot be installed on platforms other than Windows' do
       level :warn
     end
   end

The previous example is from the `ms_dotnet2 cookbook <https://github.com/juliandunn/ms_dotnet2>`_, created by community member ``juliandunn``.

.. end_tag
