=====================================================
Release Notes: |chef client| 11.0
=====================================================

.. include:: ../../includes_chef/includes_chef.rst

The following items are new for |chef client| 11.0 and/or are changes from |chef client| 10.x.

What's New for |chef client| and |chef solo|
=====================================================
The following changes have been made to |chef client| and |chef solo|. Some of these changes may break recipes (or may change their behavior); other changes may affect workflow or scripts.

|shef| is now |chef shell|
-----------------------------------------------------
|shef| has been renamed to |chef shell| (CHEF-2925). Recipe mode and attributes mode must now be entered using the ``recipe_mode`` and ``attributes_mode`` commands.

Search query syntax changes
-----------------------------------------------------
.. include:: ../../includes_search/includes_search_10-latest_query_syntax_newlines.rst

Node attribute changes
-----------------------------------------------------
In order to fix bugs and surprising behaviors with attributes, the implementation of ``Chef::Node::Attribute`` has been completely overhauled. The APIs for reading and writing values are now completely separate.

LWRPs AND Recipes Both Now Automatically Qualify loaded Gems
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Previously, in Chef 10, one could do the following in a recipe:

.. code-block:: ruby

   require 'win32/registry'
   registry = Win32::Registry::HKEY_LOCAL_MACHINE

In |chef client| 11 you must add "::" to the beginning to avoid the automatic addition of a "Chef::" qualifier.

.. code-block:: ruby

   registry = ::Win32::Registry::HKEY_LOCAL_MACHINE

Implicit writes removed
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Node attributes may no longer be set without specifying which precedence level to set. The following example is no longer valid:

.. code-block:: ruby

   node[:my_attribute] = "value"
   node.my_attribute_2 = "value"

When a precedence level was not specified, ``normal`` was assumed. For |chef client| 11, the following example replaces the previous example:

.. code-block:: ruby

   node.normal[:my_attribute] = "value"
   node.normal.my_attribute_2 = "value"

Even with this change, please take a moment to consider if a cookbook should be using default-level attributes instead. In general, normal-level attributes are only required when a value needs to persist across |chef client| runs (such as auto-generated passwords) or when a node is a "special snowflake".

attribute="value" required
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following example is no longer valid:

.. code-block:: ruby

   node.default.my_attribute("value")

The following example replaces the previous example:

.. code-block:: ruby

   node.default.my_attribute = "value"

|knife| Output Changes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Previously, |knife| was adding the ID field to search results for node attributes. With |chef client| 11, |knife| groups search results by the name of the node. For example, the old output looks something like:

.. code-block:: bash

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

.. code-block:: bash

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

This may require that search queries be updated for |chef client| 11.

This change also affects |ohai| plugin output.For example, the old output looks something like:

.. code-block:: ruby

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

.. code-block:: ruby

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
Role and environment default and override attributes are visible in attributes files. In |chef client| 11, several changes have been made to attributes to enable you to include more complex logic in your attributes files. Though you should still try to keep your attributes files simple, you can effectively generate attributes composed of other attributes or based on a node's platform in attribute files now.

Computing attributes from attributes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
In |chef client| 10 (and earlier), code like the following will not work if you intend to modify the "source" attributes from roles or environments:

.. code-block:: ruby

   node.default[:app][:name] = "my_app"
   node.default[:app][:env] = "development"
   
   # In Chef 10.x, this will be the wrong value if you overwrite
   # node.default[:app][:name] or :env with roles.
   #
   # In Chef 11, it works correctly with role attributes.
   node.default[:app][:database] ="#{node.app.name}_#{node.app.env}"

In |chef client| 10 (and earlier), default and override attributes are stored as a single nested hash, and role and environment attributes are applied to the node after attribute files are evaluated so that role and environment attributes can overwrite attributes from attributes files. In |chef client| 11, the above code will work as you expect, because role and environment attributes are stored separately from attributes from cookbooks, and are applied when the run_list is expanded (before any cookbook code is run).

Setting attributes by platform
+++++++++++++++++++++++++++++++++++++++++++++++++++++
In |chef client| 11, ``Chef::Node`` now includes the platform introspection mixin, so you can use the following methods in attributes files:

.. code-block:: ruby

   node.platform?(:platform1, :platform2)
   node.value_for_platform()
   node.platform_family?(:family1, :family2)
   node.value_for_platform_family()

Behavioral changes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
In |chef client| 10, you can set a default or override attribute in a recipe, and it will overwrite the default/override value from any role/environment/attribute file. In |chef client| 11, node.default always sets a cookbook-level default, and node.override always sets a cookbook-level override. Since cookbook-level attributes have lower precedence than role or environment attributes, a default or override attribute set in a recipe will not overwrite a value set by a role or environment.

For example, given code like this:

.. code-block:: ruby

   # In a role.rb file:
   default_attributes "app_name" => "from-role"
   
   # In a recipe file:
   node.default["app_name"] = "from-recipe"

In |chef client| 10, the value of node"app_name" will be "from-recipe" and in |chef client| 11, the value will be "from-role" (assuming there are no competing normal or override attributes).

Likewise, if you take any action based on the value of attributes when evaluating attributes files, be aware that attributes from roles and environments will now be used to compute the attribute value.

node.run_state[:seen_recipes] Replaced
-----------------------------------------------------
In |chef client| 10 and lower, you could see which recipes had been evaluated by looking at ``node.run_state[:seen_recipes]``. ``Chef::Node`` was not the correct place to track this information, and the previous implementation resulted in bugs where a recipe like ``nginx::default`` could be loaded after ``nginx``, even though they are the same recipe.

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
.. include:: ../../includes_node/includes_node_10-latest_attribute_deep_merge_subtract.rst

Chef::REST#run_request Removed
-----------------------------------------------------
The ``Chef::REST#run_request`` method is removed. Use ``api_request`` or ``streaming_request`` for low-level access, or (better) use the higher-level ``GET``, ``PUT``, ``POST``, ``DELETE``, and ``HEAD`` methods.


Delayed Notifications Changes
-----------------------------------------------------
In |chef client| 10 (and earlier), delayed notifications are lost when Chef does not converge successfully.

This fixes addresses the following scenario:

#. The |chef client| reconfigures a service
#. A delayed notification to restart the service is queued
#. An unrelated resource fails and halts the |chef client| run
#. Subsequent |chef client| runs don't restart the service because it hasn't been reconfigured during that run.

In |chef client| 11, delayed notifications will run after the |chef client| run fails, and will be executed even if other delayed notifications fail. Conversely, if the |chef client| fails to configure a service and a restart action has been queued for that service, the service will be restarted and will probably be broken.

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
.. include:: ../../includes_data_bag/includes_data_bag_10-latest_changes_in_11.rst

Diagnosing Compatibility Errors
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_data_bag/includes_data_bag_10-latest_changes_in_11_diagnose_errors.rst

How to Upgrade
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_data_bag/includes_data_bag_10-latest_changes_in_11_upgrade.rst

Server Versions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_data_bag/includes_data_bag_10-latest_changes_in_11_server_versions.rst


Non-recipe File Evaluation Includes Dependencies
---------------------------------------------------------------
.. include:: ../../includes_chef_solo/includes_chef_solo_10-latest_file_evaluation.rst

|knife| Configuration Parameter Changes
-----------------------------------------------------
.. include:: ../../includes_plugin_knife/includes_plugin_knife_custom_parameters.rst

Remote File Mirror Support May Break Subclasses	
---------------------------------------------------------------
.. include:: ../../includes_resources/includes_resource_10-latest_remote_file_attributes_source_as_string.rst

What's New for the |chef server|
=====================================================
The following items are new for |chef server| 11 and/or are changes from earlier versions of the |chef server|.

The /clients endpoint returns |json| with a |json| class for edit (PUT) operations
----------------------------------------------------------------------------------
In |chef client| 10 (and earlier), the server's response to a ``PUT`` to ``/clients/:client_name`` does not include the ``json_class`` key, though other calls, such as ``GET``, do include this key. The client-side |json| implementation uses the presence of the ``json_class`` key as an indication that it should "inflate" the response into an instance of that class (otherwise, a plain hash object is returned). As a result, code that modifies a client (such as requesting a new key from the server) and parses the response with the |ruby| 'json' library must be modified to accept a ``Chef::ApiClient`` or a hash.

This change breaks the ``knife client reregister`` command in |chef client| 10-16 (and earlier). Forward compatibility is introduced in |chef client| 10-18.

The admin and validator flags are exclusive
-----------------------------------------------------
In |chef client| 11, clients may not be both admins and validators at the same time. In the current alpha release, you can set the admin flag on the validator but it has no effect. In a future release, you may receive an error when attempting to set the validator flag on a client, or when attempting to create a client with both flags set.

.. note:: Exact behavior may change before release or in a minor version release after |chef client| 11.

Strict checking of top-level |json| keys
-----------------------------------------------------
All API endpoints that process requests to create or update an object validate that the |json| sent by the client does not contain unknown top-level keys. A 400 error response will be returned if unknown top-level keys are encountered.

Creating an empty sandbox is now a 400 error
-----------------------------------------------------
Sandboxes are used as part of the protocol for uploading cookbook content. An empty sandbox cannot be used for anything. Creating such a sandbox may indicate a logic error in client code and is (mildly) wasteful of server resources.

Error messages included in server error responses have changed
---------------------------------------------------------------
As part of the move to |erchef|, error messages have been made more consistent. Code depending on specific error message text may be broken by these changes.

Some error codes have changes
-----------------------------------------------------
In a number of cases, |erchef| returns a more specific error status than earlier versions of the |chef server|. For example, returning 400 instead of 500 for some bad request data situations.

The ``chef-server`` cookbook has been completely rewritten to support an omnibus |chef server| install

knife reindex is not supported in |chef server_title| 11
--------------------------------------------------------
You can trigger a reindex of object data using ``chef-server-ctl reindex`` while logged into the |chef server|. The |knife| command is still present in the |chef client| 11 for use with the earlier version of the |chef server|.

OpenId support has been removed
-----------------------------------------------------
Support for |open id| is no longer available to the |chef client|.


The Ruby server code has been removed
-----------------------------------------------------
As part of the move to Erchef, the Ruby API server code along with classes not needed by the client-side have been removed from the main |chef repo|.

knife cookbook delete --purge is ignored by |chef server_title| 11
------------------------------------------------------------------
In |chef server| 11, the server keeps track of which cookbooks use a given piece of cookbook content (via checksum). When a cookbook version is deleted, associated content will be deleted if not referenced by another cookbook version object. Therefore, there is no need for a purge operation when using the |chef server| 11.


Other Notable Changes
=====================================================
Changes that are not expected to be breaking, but are notable improvements.

Output Formatters are the Default Output when Running in the Console
---------------------------------------------------------------------
In |chef server| 11, when output is to a TTY, the |chef client| will automatically use output formatters to display information about what it's doing. To accommodate this, the default log level is now ``auto``, which evaluates to ``warn`` when running with a TTY (so log messages will not obscure the output formatter output), and ``info`` when running without a TTY (so you get important information about changes being made to the system when output formatters are not active).

If you prefer one type of output over the other, you can force the |chef client| to use output formatters or logger output with ``--force-formatter`` or ``--force-logger``.

.. note:: In previous versions, bootstrapping templates would generally configure the log level to ``info`` in the |client rb| file. You may wish to change this to ``auto`` or remove the setting from your config file entirely.

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
In |chef client| 11, there is an optional "inline compilation" mode for lightweight resources, which is intended to make notifications work correctly for lightweight resources.

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
Inline compilation is enabled by calling ``use_inline_resources`` at the top of your lightweight provider file. When this is enabled, the code in your action block is executed in a self contained |chef client| run, with its own compile and converge phase. If any embedded resources have been updated, the top-level lightweight resource is marked as updated, and any notifications set on it will be triggered normally. Within the embedded |chef client| run, resources in the top-level resource collection are invisible to the embedded resources, so embedded resources are not able to notify resources in the top-level resource collection.

LWRP Class Hierarchy Changes
-----------------------------------------------------
In |chef client| 11, lightweight resources resources now inherit from a ``LWRPBase`` resource instead of directly inheriting from ``Chef::Resource``. Likewise, lightweight resources providers inherit from a ``LWRPBase`` provider instead of ``Chef::Provider``. This should not impact existing code for lightweight resources.

Partial Support in Templates
-----------------------------------------------------
.. include:: ../../includes_template/includes_template_partials.rst

render Method
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_template/includes_template_partials_render_method.rst
 
|chef apply|
-----------------------------------------------------
There is now a ``chef-apply RECIPE`` command that will run a single recipe with no ``JSON/run_list/config`` file required.

Miscellaneous
-----------------------------------------------------

* Locking is used to prevent simultaneous runs on |unix|-like systems
* |subcommand knife search| assumes node search when the object type is omitted
* |subcommand knife search| will search over roles, tags, |fqdn|, and IP addresses when the given query is not in |apache solr| format (does not contain a colon ``:`` character)
* |knife| essentials (|subcommand knife upload|, |subcommand knife download|, |subcommand knife diff|, and so on) have been merged into |chef client| 11.




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
* `CHEF-3655 <http://tickets.opscode.com/browse/CHEF3655>`_  --- Webui node show run\_list: ERROR: Unable to create Chef::RunList::RunListItem from String
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
* `CHEF-3663 <http://tickets.opscode.com/browse/CHEF-xxxxx>`_  --- Knife's config file lookup doesn't work when the current directory or parent is a symlink
* `CHEF-3681 <http://tickets.opscode.com/browse/CHEF-3681>`_  --- the LWRP DSL should automatically create and converge a new run_context
* `CHEF-3715 <http://tickets.opscode.com/browse/CHEF-3715>`_  --- Remove caching of SHA256 sums in Chef::ChecksumCache

New Features
=====================================================
The following features were added:

* `CHEF-2004 <http://tickets.opscode.com/browse/CHEF-2004>`_  --- knife environment show should have an attribute selection option (-a / –attribute)
* `CHEF-3375 <http://tickets.opscode.com/browse/CHEF-3375>`_  --- remote_file support for URL lists to use as mirrors
* `CHEF-3520 <http://tickets.opscode.com/browse/CHEF-3520>`_  --- Bring knife-essentials commands into Chef proper
* `CHEF-3571 <http://tickets.opscode.com/browse/CHEF-3571>`_  --- Add a chef-apply ruby script into chef gem for running a single recipe without modifying the node's run\_list
