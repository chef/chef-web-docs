=====================================================
Release Notes: chef-client 11.0
=====================================================

.. include:: ../../includes_chef/includes_chef.rst

The following items are new for chef-client 11.0 and/or are changes from chef-client 10.x.

What's New for chef-client and chef-solo
=====================================================
The following changes have been made to chef-client and chef-solo. Some of these changes may break recipes (or may change their behavior); other changes may affect workflow or scripts.

Shef is now chef-shell
-----------------------------------------------------
Shef has been renamed to chef-shell (CHEF-2925). Recipe mode and attributes mode must now be entered using the ``recipe_mode`` and ``attributes_mode`` commands.

Search query syntax changes
-----------------------------------------------------
Newlines may be used in search queries for versions of the chef-client 10.x and earlier. For example:

.. code-block:: ruby

   search(:node, "my_attribute:test AND (roles:first_role 
                                    OR roles:second_role 
                                    OR roles:third_role 
                                    OR roles:fourth_role)")

Starting with version 11.x, newlines are no longer supported and search queries must not contain them. For example:

.. code-block:: ruby

   search(:node, "my_attribute:test AND (roles:first_role OR roles:second_role OR roles:third_role OR roles:fourth_role)")

Node attribute changes
-----------------------------------------------------
In order to fix bugs and surprising behaviors with attributes, the implementation of ``Chef::Node::Attribute`` has been completely overhauled. The APIs for reading and writing values are now completely separate.

LWRPs AND Recipes Both Now Automatically Qualify loaded Gems
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Previously, in Chef 10, one could do the following in a recipe:

.. code-block:: ruby

   require 'win32/registry'
   registry = Win32::Registry::HKEY_LOCAL_MACHINE

In chef-client 11 you must add "::" to the beginning to avoid the automatic addition of a "Chef::" qualifier.

.. code-block:: ruby

   registry = ::Win32::Registry::HKEY_LOCAL_MACHINE

Implicit writes removed
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Node attributes may no longer be set without specifying which precedence level to set. The following example is no longer valid:

.. code-block:: ruby

   node[:my_attribute] = "value"
   node.my_attribute_2 = "value"

When a precedence level was not specified, ``normal`` was assumed. For chef-client 11, the following example replaces the previous example:

.. code-block:: ruby

   node.normal[:my_attribute] = "value"
   node.normal.my_attribute_2 = "value"

Even with this change, please take a moment to consider if a cookbook should be using default-level attributes instead. In general, normal-level attributes are only required when a value needs to persist across chef-client runs (such as auto-generated passwords) or when a node is a "special snowflake".

attribute="value" required
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following example is no longer valid:

.. code-block:: ruby

   node.default.my_attribute("value")

The following example replaces the previous example:

.. code-block:: ruby

   node.default.my_attribute = "value"

knife Output Changes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Previously, knife was adding the ID field to search results for node attributes. With chef-client 11, knife groups search results by the name of the node. For example, the old output looks something like:

.. code-block:: none

   $ knife search roles:role_name -a ipaddress -fj
   2 items found
   {
     "results": 1,
     "rows": [
       {
         "ipaddress": "ec2-54-14-193-994.compute-9.amazonaws.com",
         "id": "i-a82555d2"
       }
       {
         "ipaddress": "ec2-994-79-96-9.compute-9.amazonaws.com",
         "id": "i-75555514"
       }
    ]
   }

and the new output looks something like:

.. code-block:: none

   $ knife search roles:role_name -a ipaddress -fj
   2 items found
   {
     "results": 1,
     "rows": [
       {
         "i-a82555d2": {
           "ipaddress": "ec2-54-14-193-994.compute-9.amazonaws.com"
         }
       }
       {
         "i-75555514": {
           "ipaddress": "ec2-994-79-96-9.compute-9.amazonaws.com"
         }
       }
     ]
   }

This may require that search queries be updated for chef-client 11.

This change also affects Ohai plugin output. For example, the old output looks something like:

.. code-block:: javascript

   {
     "results": 35,
     "rows": [
       {
         "virtualization": {
           "system": "kvm",
           "role": "host",
           "kvm": {
             "guests": {
               "EXAMPLE": {
                 "id": "28",
               },
             }
           }
         },
         "id": "virt30.ny4dev.EXAMPLE.com"
       }
   }

and the new output looks something like:

.. code-block:: javascript

   {
     "results": 35,
     "rows": [
       {
         "virt18.ny4dev.EXAMPLE.com": {
           "virtualization": {
             "system": "kvm",
             "role": "host",
             "kvm": {
               "guests": {
                 "EXAMPLE": {
                   "id": "3"
                
                 }
             }
           }
         }
       }
   }

Role and Environment Attribute Changes
-----------------------------------------------------
Role and environment default and override attributes are visible in attributes files. In chef-client 11, several changes have been made to attributes to enable you to include more complex logic in your attributes files. Though you should still try to keep your attributes files simple, you can effectively generate attributes composed of other attributes or based on a node's platform in attribute files now.

Computing attributes from attributes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
In chef-client 10 (and earlier), code like the following will not work if you intend to modify the "source" attributes from roles or environments:

.. code-block:: ruby

   node.default[:app][:name] = "my_app"
   node.default[:app][:env] = "development"
   
   # In Chef 10.x, this will be the wrong value if you overwrite
   # node.default[:app][:name] or :env with roles.
   #
   # In Chef 11, it works correctly with role attributes.
   node.default[:app][:database] ="#{node.app.name}_#{node.app.env}"

In chef-client 10 (and earlier), default and override attributes are stored as a single nested hash, and role and environment attributes are applied to the node after attribute files are evaluated so that role and environment attributes can overwrite attributes from attributes files. In chef-client 11, the above code will work as you expect, because role and environment attributes are stored separately from attributes from cookbooks, and are applied when the run-list is expanded (before any cookbook code is run).

Setting attributes by platform
+++++++++++++++++++++++++++++++++++++++++++++++++++++
In chef-client 11, ``Chef::Node`` now includes the platform introspection mixin, so you can use the following methods in attributes files:

.. code-block:: ruby

   node.platform?(:platform1, :platform2)
   node.value_for_platform()
   node.platform_family?(:family1, :family2)
   node.value_for_platform_family()

Behavioral changes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
In chef-client 10, you can set a default or override attribute in a recipe, and it will overwrite the default/override value from any role/environment/attribute file. In chef-client 11, node.default always sets a cookbook-level default, and node.override always sets a cookbook-level override. Since cookbook-level attributes have lower precedence than role or environment attributes, a default or override attribute set in a recipe will not overwrite a value set by a role or environment.

For example, given code like this:

.. code-block:: ruby

   # In a role.rb file:
   default_attributes "app_name" => "from-role"
   
   # In a recipe file:
   node.default["app_name"] = "from-recipe"

In chef-client 10, the value of node"app_name" will be "from-recipe" and in chef-client 11, the value will be "from-role" (assuming there are no competing normal or override attributes).

Likewise, if you take any action based on the value of attributes when evaluating attributes files, be aware that attributes from roles and environments will now be used to compute the attribute value.

node.run_state[:seen_recipes] Replaced
-----------------------------------------------------
In chef-client 10 and lower, you could see which recipes had been evaluated by looking at ``node.run_state[:seen_recipes]``. ``Chef::Node`` was not the correct place to track this information, and the previous implementation resulted in bugs where a recipe like ``nginx::default`` could be loaded after ``nginx``, even though they are the same recipe.

The following example is no longer valid:

.. code-block:: ruby

   if node.run_state[:seen_recipes].key("my_recipe")
     # etc...
   end

In the new implementation, this is tracked by ``Chef::RunContext``. Use the following approach instead:

.. code-block:: ruby

   # Check if a recipe has been loaded:
   if run_context.loaded_recipe?("my_recipe")
     # do something
   end

Subtractive Merge Removed
-----------------------------------------------------
A special knockout prefix---``!merge``---could be used with attribute values to make the deep merge algorithm remove values from arrays. This feature is seldom used, often confusing, and its use greatly increased the time and space complexity of the deep merge implementation. 

For example, substituting an existing string in an array::

   role_or_environment 1 [ '1', '2' ]
   +
   role_or_environment 2 [ '!merge:2', '3' ]
   =
   [ '1', '3' ]

The ``!merge`` knockout prefix is removed from the chef-client, starting with version 11.0.0 and any use of the ``!merge`` knockout prefix will trigger an error upon merge. A better way to handle selectively removing elements from arrays is to place this type of logic in an attributes file.

Chef::REST#run_request Removed
-----------------------------------------------------
The ``Chef::REST#run_request`` method is removed. Use ``api_request`` or ``streaming_request`` for low-level access, or (better) use the higher-level ``GET``, ``PUT``, ``POST``, ``DELETE``, and ``HEAD`` methods.


Delayed Notifications Changes
-----------------------------------------------------
In chef-client 10 (and earlier), delayed notifications are lost when Chef does not converge successfully.

This fixes addresses the following scenario:

#. The chef-client reconfigures a service
#. A delayed notification to restart the service is queued
#. An unrelated resource fails and halts the chef-client run
#. Subsequent chef-client runs don't restart the service because it hasn't been reconfigured during that run.

In chef-client 11, delayed notifications will run after the chef-client run fails, and will be executed even if other delayed notifications fail. Conversely, if the chef-client fails to configure a service and a restart action has been queued for that service, the service will be restarted and will probably be broken.

Single Notifies for Notification
-----------------------------------------------------
Previously you could specify multiple notifications in a single call to notifies with code like this:

.. code-block:: ruby

   notifies ( [ {resources("execute[something]") => [:action, :timing]},
   {resources("execute[something]") => [:action, :timing]},
   {resources("execute[something]") => [:action, :timing]} ] )

Instead of the above, just put multiple calls to notifies in your resource declaration:

.. code-block:: ruby

   file "/tmp/foo" do
     notifies :run, "execute[something]"
     notifies :run, "execute[another-thing]"
   end


Encryption Changes
-----------------------------------------------------
In chef-client 10, objects in encrypted data bag items are serialized to YAML before being encrypted. Unfortunately, discrepancies between YAML engines in different versions of Ruby (in particular, 1.8.7 and 1.9.3) may cause silent corruption of serialized data when decrypting the data bag (the version stored on the Chef server is untouched and can be correctly deserialized with the same Ruby version that was used to create it, however).

Because the corruption is silent, there is no way for the chef-client to detect it; furthermore, all workaround possibilities we've investigated have severe limitations. Additionally, we wanted to modify the encrypted data bag item format to support using a random initialization vector each time a value is encrypted, which provides protection against some forms of cryptanalysis. In order to solve these issues, we've implemented a new encrypted data bag item format:

* The user interface to encrypted data bags is unchanged. This change only affects the format of the encrypted values.
* chef-client 11 clients will be able to read encrypted data bags created with either chef-client 10 or chef-client 11.
* chef-client 10 clients (chef-client 10-18 and higher) will be able to read encrypted data bags created with either chef-client 10 or chef-client 11
* chef-client 10 clients version chef-client 10-16 (and lower) cannot read encrypted data bags created with chef-client 11
* chef-client 11 knife commands will only create data bags in the new format.
* chef-client 10 knife commands will only create data bags in the old format.

Diagnosing Compatibility Errors
+++++++++++++++++++++++++++++++++++++++++++++++++++++
When trying to decrypt a chef-client 11 format data bag item with chef-client 10-16 (and earlier), you will see an error like this:

.. code-block:: none

   shell$ knife data bag show secret-10-stable bar -c ~/opscode-ops/chef-oss-dev/.chef/knife.rb -s password
   
   ERROR: knife encountered an unexpected error
   This may be a bug in the 'data bag show' knife command or plugin
   Please collect the output of this command with the `-VV` option before filing a bug report.
   Exception: NoMethodError: undefined method `unpack' for #<Hash:0x007ff5b264e1f0>

The above error output is from knife; the chef-client will fail with a similar error.

How to Upgrade
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Before upgrading on any workstation you use to create/edit encrypted data bag items, upgrade chef-client on all machines that use encrypted data bags to version chef-client 10-18 (and higher). Once your chef-client fleet is upgraded, you can start using chef-client 11 on your workstation (the box you create/update encrypted data bag items on).

In order to get the benefits of improved security with the new data bag item format, it's recommended that you re-upload all of your encrypted data bag items once you've migrated to compatible versions of chef-client. To migrate your data bag items, simply edit them with ``knife data bag edit`` or upload them with ``knife data bag from file``, whichever you normally do. chef-client 11 will automatically upload your data bag items in the new format.

Server Versions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Because encrypted data bag items are implemented as a client-side layer on top of regular data bag items, the format change is transparent to the server. You can begin using chef-client 11 data bags even if your server is version chef-client 10.


Non-recipe File Evaluation Includes Dependencies
---------------------------------------------------------------
In chef-client 10 and lower, library, attribute, lightweight resource, and resource definition files are loaded in undefined order (based on the order given by the Ruby Hash implementation, which differs based on version and vendor patching). 

This behavior is changed, starting with chef-client 11. Files are loaded according to the following logic:

* The expanded run-list is converted into a list of cookbooks in the same order
* Each cookbook's dependencies are inserted into the cookbook list before the cookbook that depends on them.
* Duplicates are removed

For users of chef-solo , the new loading logic means that files belonging to cookbooks which exist in the ``cookbook_path`` but are not in the expanded ``run_list`` or dependencies of the cookbooks in the expanded ``run_list`` will no longer be loaded (in chef-client 10, all non-recipe files from all cookbooks in the cookbook path were loaded). Additionally, chef-solo users will now see ``CookbookNotFound`` errors when a cookbook is listed as a dependency in the metadata but not present on disk. The error message will look like this:

.. code-block:: none

   FATAL: Chef::Exceptions::CookbookNotFound: Cookbook runit not found. If you're loading runit from another cookbook, make sure you configure the dependency in your metadata



knife Configuration Parameter Changes
-----------------------------------------------------
In chef-client 10, it is often difficult to ensure that configuration parameters are applied in the correct order. Configuration parameters should be applied in the following order:

#. Default values
#. Values set in knife.rb
#. Values passed by command line option

Because of the way the ``mixlib-cli`` library is implemented, it is difficult to determine which values are defaults and which values are user-supplied command line options. chef-client 11 takes advantage of a new mode for ``mixlib-cli`` that keeps default values separate from user-supplied values. In the configuration process, knife automatically applies configuration parameters in the following order:

#. Default values set in the ``mixlib-cli`` DSL
#. Configuration settings under ``Chef::Config[:knife]``
#. User supplied values parsed by ``mixlib-cli``

Depending on how authors of custom knife plugins have worked around the older behavior, it's possible that this change will lead to incorrect values being used. The Chef-maintained cloud plugins have been reviewed and should work correctly on both chef-client 10 and chef-client 11.

When writing knife plugins for chef-client 11, plugin authors are encouraged to define default settings using the ``mixlib-config`` DSL, similar to:

.. code-block:: ruby

   option :ssh_user,
     :short => "-x USERNAME",
     :long => "--ssh-user USERNAME",
     :description => "The ssh username",
     :default => "root"

and then access the configurable values using the ``config`` hash with symbols, similar to:

.. code-block:: ruby

   # The local variable isn't necessary, it's just here to clarify the example:
   ssh_user_name = config[:ssh_user]

If compatibility with chef-client 10 is required, accessing configuration parameters using a helper function like this will work correctly, but only if the default values are NOT set using the ``mixlib-cli`` DSL. For example:

.. code-block:: ruby

   def locate_config_value(key)
     key = key.to_sym
     config[key] || Chef::Config[:knife][key]
   end

Default values must be managed manually until support for chef-client 10 is removed, for example, like this:

.. code-block:: ruby

   ssh_user_name = locate_config_value(:ssh_user) || "root"

Further information is available in the following ticket: 

* `CHEF-3497 <http://tickets.opscode.com/browse/CHEF-3497>`_  --- Allow knife.rb to implicitly provide all knife related options

Remote File Mirror Support May Break Subclasses	
---------------------------------------------------------------
Values for the ``source`` attribute are internally stored as an array starting with the 11.0.0 version of the chef-client. (Previous versions of the chef-client---10.x and earlier---store these values as a string.) This update is a breaking change between these major versions of the chef-client. Any library code that subclasses the **remote_file** resource in the 10.x version of the chef-client may require updates for the 11.x version. Alternatively, the provider for the **remote_file** resource may be updated to properly handle the case that the ``source`` parameter is an array. And, also alternatively, the array values may be converted back into a string in the resource itself by using code similar to the following:

.. code-block:: ruby

   def source(args=nil)
     set_or_return(:source, args, :kind_of=>String)
   end

   def after_created
     true
   end



What's New for the Chef server
=====================================================
The following items are new for Chef server 11 and/or are changes from earlier versions of the Chef server.

The /clients endpoint returns JSON with a JSON class for edit (PUT) operations
----------------------------------------------------------------------------------
In chef-client 10 (and earlier), the server's response to a ``PUT`` to ``/clients/:client_name`` does not include the ``json_class`` key, though other calls, such as ``GET``, do include this key. The client-side JSON implementation uses the presence of the ``json_class`` key as an indication that it should "inflate" the response into an instance of that class (otherwise, a plain hash object is returned). As a result, code that modifies a client (such as requesting a new key from the server) and parses the response with the Ruby 'json' library must be modified to accept a ``Chef::ApiClient`` or a hash.

This change breaks the ``knife client reregister`` subcommand in chef-client 10-16 (and earlier). Forward compatibility is introduced in chef-client 10-18.

The admin and validator flags are exclusive
-----------------------------------------------------
In chef-client 11, clients may not be both admins and validators at the same time. In the current alpha release, you can set the admin flag on the validator but it has no effect. In a future release, you may receive an error when attempting to set the validator flag on a client, or when attempting to create a client with both flags set.

.. note:: Exact behavior may change before release or in a minor version release after chef-client 11.

Strict checking of top-level JSON keys
-----------------------------------------------------
All API endpoints that process requests to create or update an object validate that the JSON sent by the client does not contain unknown top-level keys. A 400 error response will be returned if unknown top-level keys are encountered.

Creating an empty sandbox is now a 400 error
-----------------------------------------------------
Sandboxes are used as part of the protocol for uploading cookbook content. An empty sandbox cannot be used for anything. Creating such a sandbox may indicate a logic error in client code and is (mildly) wasteful of server resources.

Error messages included in server error responses have changed
---------------------------------------------------------------
As part of the move to Erchef, error messages have been made more consistent. Code depending on specific error message text may be broken by these changes.

Some error codes have changes
-----------------------------------------------------
In a number of cases, Erchef returns a more specific error status than earlier versions of the Chef server. For example, returning 400 instead of 500 for some bad request data situations.

The ``chef-server`` cookbook has been completely rewritten to support an omnibus Chef server install

knife reindex is not supported in Chef Server 11
--------------------------------------------------------
You can trigger a reindex of object data using ``chef-server-ctl reindex`` while logged into the Chef server. The knife command is still present in the chef-client 11 for use with the earlier version of the Chef server.

OpenId support has been removed
-----------------------------------------------------
Support for OpenID is no longer available to the chef-client.


The Ruby server code has been removed
-----------------------------------------------------
As part of the move to Erchef, the Ruby API server code along with classes not needed by the client-side have been removed from the main chef-repo.

knife cookbook delete --purge is ignored by Chef Server 11
------------------------------------------------------------------
In Chef server 11, the server keeps track of which cookbooks use a given piece of cookbook content (via checksum). When a cookbook version is deleted, associated content will be deleted if not referenced by another cookbook version object. Therefore, there is no need for a purge operation when using the Chef server 11.


Other Notable Changes
=====================================================
Changes that are not expected to be breaking, but are notable improvements.

Output Formatters are the Default Output when Running in the Console
---------------------------------------------------------------------
In Chef server 11, when output is to a TTY, the chef-client will automatically use output formatters to display information about what it's doing. To accommodate this, the default log level is now ``auto``, which evaluates to ``warn`` when running with a TTY (so log messages will not obscure the output formatter output), and ``info`` when running without a TTY (so you get important information about changes being made to the system when output formatters are not active).

If you prefer one type of output over the other, you can force the chef-client to use output formatters or logger output with ``--force-formatter`` or ``--force-logger``.

.. note:: In previous versions, bootstrapping templates would generally configure the log level to ``info`` in the client.rb file. You may wish to change this to ``auto`` or remove the setting from your config file entirely.

add_formatter setting
+++++++++++++++++++++++++++++++++++++++++++++++++++++

The ``add_formatter`` setting can be added to the client.rb file to specify a 3rd-party formatter:

.. code-block:: ruby

   add_formatter :name_of_3rd_party_formatter

For example:

.. code-block:: ruby

   add_formatter :nyan

will add this formatter: https://github.com/andreacampi/nyan-cat-chef-formatter.

Inline Compile Mode for Lightweight Resources
-----------------------------------------------------
In chef-client 11, there is an optional "inline compilation" mode for lightweight resources, which is intended to make notifications work correctly for lightweight resources.

Without Inline Compilation
+++++++++++++++++++++++++++++++++++++++++++++++++++++
When not using inline compilation (it is disabled by default), any resources created in a lightweight provider's action blocks are inserted into the top level resource collection after the lightweight resource it belongs to. For example, given a resource collection like this:

* top_level_resource_one
* lwrp_resource
* top_level_resource_two

When ``lwrp_resource`` is executed, the resource collection will then be modified like this:

* top_level_resource_one (already processed)
* lwrp_resource (already processed)
* embedded_resource_one (created by lwrp)
* embedded_resource_two (created by lwrp)
* top_level_resource_two

This means that the ``lwrp_resource`` cannot correctly set its updated status based on the embedded resources, because it has finished executing before its embedded resources are processed.

With Inline Compilation
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Inline compilation is enabled by calling ``use_inline_resources`` at the top of your lightweight provider file. When this is enabled, the code in your action block is executed in a self contained chef-client run, with its own compile and converge phase. If any embedded resources have been updated, the top-level lightweight resource is marked as updated, and any notifications set on it will be triggered normally. Within the embedded chef-client run, resources in the top-level resource collection are invisible to the embedded resources, so embedded resources are not able to notify resources in the top-level resource collection.

LWRP Class Hierarchy Changes
-----------------------------------------------------
In chef-client 11, lightweight resources resources now inherit from a ``LWRPBase`` resource instead of directly inheriting from ``Chef::Resource``. Likewise, lightweight resources providers inherit from a ``LWRPBase`` provider instead of ``Chef::Provider``. This should not impact existing code for lightweight resources.

Partial Support in Templates
-----------------------------------------------------
.. include:: ../../includes_template/includes_template_partials.rst

render Method
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_template/includes_template_partials_render_method.rst
 
chef-apply
-----------------------------------------------------
There is now a ``chef-apply RECIPE`` command that will run a single recipe with no ``JSON/run_list/config`` file required.

Miscellaneous
-----------------------------------------------------

* Locking is used to prevent simultaneous runs on UNIX-like systems
* ``knife search`` assumes node search when the object type is omitted
* ``knife search`` will search over roles, tags, FQDN, and IP addresses when the given query is not in Apache Solr format (does not contain a colon ``:`` character)
* knife essentials (``knife upload``, ``knife download``, ``knife diff``, and so on) have been merged into chef-client 11.




What's Fixed
=====================================================
The following bugs were fixed:

* `CHEF-581 <http://tickets.opscode.com/browse/CHEF-581>`_  --- Delayed scripts don't run on failure
* `CHEF-867 <http://tickets.opscode.com/browse/CHEF-867>`_  --- Use exclusive file locks with chef-client
* `CHEF-1804 <http://tickets.opscode.com/browse/CHEF-1804>`_  --- Values of nested Node attributes disappear after iterating
* `CHEF-2591 <http://tickets.opscode.com/browse/CHEF-2591>`_  --- Chef::ChecksumCache not working due to :skip_expires => true
* `CHEF-2627 <http://tickets.opscode.com/browse/CHEF-2627>`_  --- Knife SSH should return exit code based on whether or not ssh command is successful or not
* `CHEF-2792 <http://tickets.opscode.com/browse/CHEF-2792>`_  --- XSS vulnerability in messages field on login page
* `CHEF-2903 <http://tickets.opscode.com/browse/CHEF-2903>`_  --- Attribute files not loaded in deterministic order
* `CHEF-2923 <http://tickets.opscode.com/browse/CHEF-2923>`_  --- Cookbook Upload Fails due to Syntax Error in unrelated cookbook's metadata file
* `CHEF-3068 <http://tickets.opscode.com/browse/CHEF-3068>`_  --- Chef resources display incorrectly in log files on windows due to splitting on :
* `CHEF-3376 <http://tickets.opscode.com/browse/CHEF-3376>`_  --- Chef Should Load Cookbooks In Dependency Order
* `CHEF-3393 <http://tickets.opscode.com/browse/CHEF-3393>`_  --- Chef Encrypted Data Bag Error due to Different YAML Engines
* `CHEF-3467 <http://tickets.opscode.com/browse/CHEF-3467>`_  --- Permissions Not Inherited from Parent on Child Object cookbook_file (Windows)
* `CHEF-3477 <http://tickets.opscode.com/browse/CHEF-3477>`_  --- knife node show shows unexpected brackets for single-member arrays
* `CHEF-3480 <http://tickets.opscode.com/browse/CHEF-3480>`_  --- When Encrypting Data-Bag Items, Use Different IV Per Encrypt
* `CHEF-3555 <http://tickets.opscode.com/browse/CHEF-3555>`_  --- knife cookbook site install fails due to not allowing string format cookbook_path
* `CHEF-3561 <http://tickets.opscode.com/browse/CHEF-3561>`_  --- Error inspectors seem to quash template error contextual information
* `CHEF-3589 <http://tickets.opscode.com/browse/CHEF-3589>`_  --- Why Run code runs code in {{converge_by}} blocks after the provider action is complete
* `CHEF-3604 <http://tickets.opscode.com/browse/CHEF-3604>`_  --- Chef::Provider::Service::Init should pass why run assertions if a custom command is provided
* `CHEF-3617 <http://tickets.opscode.com/browse/CHEF-3617>`_  --- Chef::RunLock incorrectly assumes the full path to the run lock file exists before opening for writing
* `CHEF-3619 <http://tickets.opscode.com/browse/CHEF-3619>`_  --- Chef still has obsolete 'rake/rdoctask' require
* `CHEF-3632 <http://tickets.opscode.com/browse/CHEF-3632>`_  --- All providers have whyrun enabled by default due to RemoteDirectory
* `CHEF-3638 <http://tickets.opscode.com/browse/CHEF-3638>`_  --- knife cookbook upload with–all flag fails
* `CHEF-3639 <http://tickets.opscode.com/browse/CHEF-3639>`_  --- 'knife index rebuild' no longer works with Chef Server 11
* `CHEF-3640 <http://tickets.opscode.com/browse/CHEF-3640>`_  --- bookshelf is logging to the wrong directory
* `CHEF-3641 <http://tickets.opscode.com/browse/CHEF-3641>`_  --- lock down permissions on omnibus generated private keys
* `CHEF-3643 <http://tickets.opscode.com/browse/CHEF-3643>`_  --- WebUI: cookbook version show generates "undefined method 'close!' for nil:NilClass" error
* `CHEF-3647 <http://tickets.opscode.com/browse/CHEF-3647>`_  --- changing a user's password in chef-server-webui changes their public key to undefined
* `CHEF-3648 <http://tickets.opscode.com/browse/CHEF-3648>`_  --- WebUI: creating client fails with 'Could not create client: 500 "Internal Server Error"'
* `CHEF-3653 <http://tickets.opscode.com/browse/CHEF-3653>`_  --- Unable to show data bag items in webui
* `CHEF-3654 <http://tickets.opscode.com/browse/CHEF-3654>`_  --- Adding role to node run list in webui gives undefined method 'empty?' for nil:NilClass
* `CHEF-3655 <http://tickets.opscode.com/browse/CHEF-3655>`_  --- Webui node show run\_list: ERROR: Unable to create Chef::RunList::RunListItem from String
* `CHEF-3656 <http://tickets.opscode.com/browse/CHEF-3656>`_  --- Last check-in display shows > entity in webui for /status
* `CHEF-3657 <http://tickets.opscode.com/browse/CHEF-3657>`_  --- Unable to add cookbook version constraints to an environment via webui
* `CHEF-3658 <http://tickets.opscode.com/browse/CHEF-3658>`_  --- Admin clients should not be able to de-admin the last admin user
* `CHEF-3662 <http://tickets.opscode.com/browse/CHEF-3662>`_  --- knife client reregister fails against Chef 11 Server
* `CHEF-3666 <http://tickets.opscode.com/browse/CHEF-3666>`_  --- Postgresql recipe is overzealously guarding configuration files behind bootstrap variable
* `CHEF-3673 <http://tickets.opscode.com/browse/CHEF-3673>`_  --- Bookshelf URL is not configurable
* `CHEF-3674 <http://tickets.opscode.com/browse/CHEF-3674>`_  --- Psql doesn't work by default, since /opt/chef-server/embedded/bin is not in the path
* `CHEF-3675 <http://tickets.opscode.com/browse/CHEF-3675>`_  --- Bookshelf cannot be disabled
* `CHEF-3680 <http://tickets.opscode.com/browse/CHEF-3680>`_  --- json error: (eval):3:in 'keys'
* `CHEF-3688 <http://tickets.opscode.com/browse/CHEF-3688>`_  --- Stale attribute read protection does more harm than good
* `CHEF-3689 <http://tickets.opscode.com/browse/CHEF-3689>`_  --- Client registration fails on existing clients
* `CHEF-3699 <http://tickets.opscode.com/browse/CHEF-3699>`_  --- Getting ISE when depsolver runs
* `CHEF-3702 <http://tickets.opscode.com/browse/CHEF-3702>`_  --- Postgresql foreign key integrity error on cookbook upload in Erchef alpha
* `CHEF-3710 <http://tickets.opscode.com/browse/CHEF-3710>`_  --- chef\_wm: exception handling for bad\_headers in chef\_wm:malformed\_request/2
* `CHEF-3716 <http://tickets.opscode.com/browse/CHEF-3716>`_  --- Erchef 1.0.21 knife cookbook upload succeeds, but cookbook content gives 404 from chef-client
* `CHEF-3718 <http://tickets.opscode.com/browse/CHEF-3718>`_  --- peg 2.2.0 version of systemu for win ruby 1.9 compat
* `CHEF-3724 <http://tickets.opscode.com/browse/CHEF-3724>`_  --- node.recipe? appears to be broken
* `CHEF-3782 <http://tickets.opscode.com/browse/CHEF-3782>`_  --- Bad regular expression make sandbox test fail in pedant
* `CHEF-3783 <http://tickets.opscode.com/browse/CHEF-3783>`_  --- compatibility for chef/dsl/recipe not found in chef/mixin/recipe_definition\_dsl\_core.rb
* `CHEF-3792 <http://tickets.opscode.com/browse/CHEF-3792>`_  --- chef-apply is still referred to as chef-recipe in places
* `CHEF-3793 <http://tickets.opscode.com/browse/CHEF-3793>`_  --- knife is broken in latest Chef 11 client beta
* `CHEF-3799 <http://tickets.opscode.com/browse/CHEF-3799>`_  --- Cannot call puts on a VividMash
* `CHEF-3802 <http://tickets.opscode.com/browse/CHEF-3802>`_  --- omnibus package symlinks not created for chef-apply, chef-shell
* `CHEF-3806 <http://tickets.opscode.com/browse/CHEF-3806>`_  --- when setting node attributes, after a set\_unless call subsequent set calls behave like set\_unless (and correspondingly for other attribute levels)

What's Improved
=====================================================
The following improvements were made:

* `CHEF-707 <http://tickets.opscode.com/browse/CHEF-707>`_  --- Change "gid" to "group" for the User Resource
* `CHEF-2936 <http://tickets.opscode.com/browse/CHEF-2936>`_  --- Cookbook attribute file to have access to expanded attributes
* `CHEF-2984 <http://tickets.opscode.com/browse/CHEF-2984>`_  --- Remove moneta dependency
* `CHEF-3021 <http://tickets.opscode.com/browse/CHEF-3021>`_  --- Convert chef-server-webui from merb to Rails 3.2
* `CHEF-3197 <http://tickets.opscode.com/browse/CHEF-3197>`_  --- Undefined methods on a node should not be assumed to be attributes
* `CHEF-3249 <http://tickets.opscode.com/browse/CHEF-3249>`_  --- Chef support for template partials
* `CHEF-3385 <http://tickets.opscode.com/browse/CHEF-3385>`_  --- Remove support for multiple notifications in one call to Resource#notifies
* `CHEF-3392 <http://tickets.opscode.com/browse/CHEF-3392>`_  --- Serialize Encrypted Data-Bag Item Values with JSON Instead of YAML
* `CHEF-3438 <http://tickets.opscode.com/browse/CHEF-3438>`_  --- Allow Chef::REST.new() to read raw keys
* `CHEF-3487 <http://tickets.opscode.com/browse/CHEF-3487>`_  --- Refactor CookbookLoader to walk @repo\_paths only once
* `CHEF-3497 <http://tickets.opscode.com/browse/CHEF-3497>`_  --- Allow knife.rb to implicitly provide all knife related options
* `CHEF-3499 <http://tickets.opscode.com/browse/CHEF-3499>`_  --- Allow access to platform? and friends in attribute files
* `CHEF-3500 <http://tickets.opscode.com/browse/CHEF-3500>`_  --- ruby_block resource's action "create" is counter-intuitive
* `CHEF-3556 <http://tickets.opscode.com/browse/CHEF-3556>`_  --- Knife search should assume you're searching for nodes, and make a fuzzy query if the query is not in solr syntax
* `CHEF-3576 <http://tickets.opscode.com/browse/CHEF-3576>`_  --- support raspbian as a platform
* `CHEF-3603 <http://tickets.opscode.com/browse/CHEF-3603>`_  --- Chef::Provider::Service::Init should support specification of alternate 'init_command'
* `CHEF-3616 <http://tickets.opscode.com/browse/CHEF-3616>`_  --- Include cipher in Encrypted Data Bag Item v1 Format
* `CHEF-3628 <http://tickets.opscode.com/browse/CHEF-3628>`_  --- knife upload with no parameters should prompt before uploading EVERYTHING
* `CHEF-3663 <http://tickets.opscode.com/browse/CHEF-3663>`_  --- Knife's config file lookup doesn't work when the current directory or parent is a symlink
* `CHEF-3681 <http://tickets.opscode.com/browse/CHEF-3681>`_  --- the LWRP DSL should automatically create and converge a new run_context
* `CHEF-3715 <http://tickets.opscode.com/browse/CHEF-3715>`_  --- Remove caching of SHA256 sums in Chef::ChecksumCache

New Features
=====================================================
The following features were added:

* `CHEF-2004 <http://tickets.opscode.com/browse/CHEF-2004>`_  --- knife environment show should have an attribute selection option (-a / –attribute)
* `CHEF-3375 <http://tickets.opscode.com/browse/CHEF-3375>`_  --- remote_file support for URL lists to use as mirrors
* `CHEF-3520 <http://tickets.opscode.com/browse/CHEF-3520>`_  --- Bring knife-essentials commands into Chef proper
* `CHEF-3571 <http://tickets.opscode.com/browse/CHEF-3571>`_  --- Add a chef-apply ruby script into chef gem for running a single recipe without modifying the node's run\_list
