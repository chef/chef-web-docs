=====================================================
About Nodes
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/nodes.rst>`__

.. tag node

A node is any machine---physical, virtual, cloud, network device, etc.---that is under management by Chef.

.. end_tag

.. tag node_types

The types of nodes that can be managed by Chef include, but are not limited to, the following:

.. list-table::
   :widths: 100 420
   :header-rows: 1

   * - Node Type
     - Description
   * - .. image:: ../../images/icon_node_type_server.svg
          :width: 100px
          :align: center

     - A physical node is typically a server or a virtual machine, but it can be any active device attached to a network that is capable of sending, receiving, and forwarding information over a communications channel. In other words, a physical node is any active device attached to a network that can run a Chef Infra Client and also allow that Chef Infra Client to communicate with a Chef Infra Server.
   * - .. image:: ../../images/icon_node_type_cloud_public.svg
          :width: 100px
          :align: center

     - A cloud-based node is hosted in an external cloud-based service, such as Amazon Web Services (AWS), OpenStack, Rackspace, Google Compute Engine, or Microsoft Azure. Plugins are available for knife that provide support for external cloud-based services. knife can use these plugins to create instances on cloud-based services. Once created, the Chef Infra Client can be used to deploy, configure, and maintain those instances.
   * - .. image:: ../../images/icon_node_virtual_machine.svg
          :width: 100px
          :align: center

     - A virtual node is a machine that runs only as a software implementation, but otherwise behaves much like a physical machine.
   * - .. image:: ../../images/icon_node_type_network_device.svg
          :width: 100px
          :align: center

     - A network node is any networking device---a switch, a router---that is being managed by a Chef Infra Client, such as networking devices by Juniper Networks, Arista, Cisco, and F5. Use Chef to automate common network configurations, such as physical and logical Ethernet link properties and VLANs, on these devices.
   * - .. image:: ../../images/icon_node_type_container.svg
          :width: 100px
          :align: center

     - Containers are an approach to virtualization that allows a single operating system to host many working configurations, where each working configuration---a container---is assigned a single responsibility that is isolated from all other responsibilities. Containers are popular as a way to manage distributed and scalable applications and services.

.. end_tag

The key components of nodes that are under management by Chef include:

.. list-table::
   :widths: 100 420
   :header-rows: 1

   * - Component
     - Description
   * - .. image:: ../../images/icon_chef_client.svg
          :width: 100px
          :align: center

     - .. tag chef_client_summary

       Chef Infra Client is an agent that runs locally on every node that is under management by Chef Infra Server. When a Chef Infra Client is run, it will perform all of the steps that are required to bring the node into the expected state, including:

       * Registering and authenticating the node with the Chef Infra Server
       * Building the node object
       * Synchronizing cookbooks
       * Compiling the resource collection by loading each of the required cookbooks, including recipes, attributes, and all other dependencies
       * Taking the appropriate and required actions to configure the node
       * Looking for exceptions and notifications, handling each as required

       .. end_tag

       .. tag security_key_pairs_chef_client

       RSA public key-pairs are used to authenticate the Chef Infra Client with the Chef Infra Server every time a Chef Infra Client needs access to data that is stored on the Chef Infra Server. This prevents any node from accessing data that it shouldn't and it ensures that only nodes that are properly registered with the Chef Infra Server can be managed.

       .. end_tag

   * - .. image:: ../../images/icon_ohai.svg
          :width: 100px
          :align: center

     - .. tag ohai_summary

       Ohai is a tool that is used to collect system configuration data, which is provided to the Chef Infra Client for use within cookbooks. Ohai is run by the Chef Infra Client at the beginning of every Chef run to determine system state. Ohai includes many built-in plugins to detect common configuration details as well as a plugin model for writing custom plugins.

       The types of attributes Ohai collects include but are not limited to:

       * Operating System
       * Network
       * Memory
       * Disk
       * CPU
       * Kernel
       * Host names
       * Fully qualified domain names
       * Virtualization
       * Cloud provider metadata

       Attributes that are collected by Ohai are automatic level attributes, in that these attributes are used by the Chef Infra Client to ensure that these attributes remain unchanged after the Chef Infra Client is done configuring the node.

       .. end_tag

About Run-lists
-----------------------------------------------------
.. tag node_run_list

A run-list defines all of the information necessary for Chef to configure a node into the desired state. A run-list is:

* An ordered list of roles and/or recipes that are run in the exact order defined in the run-list; if a recipe appears more than once in the run-list, the Chef Infra Client will not run it twice
* Always specific to the node on which it runs; nodes may have a run-list that is identical to the run-list used by other nodes
* Stored as part of the node object on the Chef server
* Maintained using knife and then uploaded from the workstation to the Chef Infra Server, or maintained using Chef Automate

.. end_tag

Run-list Format
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag node_run_list_format

A run-list must be in one of the following formats: fully qualified, cookbook, or default. Both roles and recipes must be in quotes, for example:

.. code-block:: ruby

   'role[NAME]'

or

.. code-block:: ruby

   'recipe[COOKBOOK::RECIPE]'

Use a comma to separate roles and recipes when adding more than one item the run-list:

.. code-block:: ruby

   'recipe[COOKBOOK::RECIPE],COOKBOOK::RECIPE,role[NAME]'

.. end_tag

Empty Run-lists
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag node_run_list_empty

Use an empty run-list to determine if a failed Chef Infra Client run has anything to do with the recipes that are defined within that run-list. This is a quick way to discover if the underlying cause of a Chef Infra Client run failure is a configuration issue. If a failure persists even if the run-list is empty, check the following:

* Configuration settings in the config.rb file
* Permissions for the user to both the Chef Infra Server and to the node on which the Chef Infra Client run is to take place

.. end_tag


About Node Names
=====================================================
The name of a node is required as part of the authentication process to the Chef Infra Server. The name of each node must be unique within an organization, but otherwise can be any string that matches the following regular expression::

   /^[\-[:alnum:]_:.]+$/

The name of a node can be obtained from the ``node_name`` attribute in the client.rb file or by allowing Ohai to collect this data during the Chef Infra Client run. When Ohai collects this data during the Chef Infra Client run, it uses the FQDN name of the node (which is always unique within an organization) as the name of the node.

Using the FQDN as the node name, and then allowing Ohai to collect this information during each Chef Infra Client run, is the recommended approach and the easiest way to ensure that the names of all nodes across the organization are unique.

Manage Nodes
=====================================================

.. This section is just tossed in here to keep track of it. Probably needs a super-heavy edit. And much of it probably lives elsewhere.

There are several ways to manage nodes directly: via knife, Chef Automate, or by using command-line tools that are specific to Chef Infra Client.

* knife can be used to create, edit, view, list, tag, and delete nodes.
* knife plug-ins can be used to create, edit, and manage nodes that are located on cloud providers.
* Chef Automate can be used to create, edit, view, list, tag, and delete nodes. In addition, node attributes can be modified and nodes can be moved between environments.
* The Chef Infra Client can be used to manage node data using the command line and JSON files. Each JSON file contains a hash, the elements of which are added as node attributes. In addition, the ``run_list`` setting allows roles and/or recipes to be added to the node.
* chef-solo can be used to manage node data using the command line and JSON files. Each JSON file contains a hash, the elements of which are added as node attributes. In addition, the ``run_list`` setting allows roles and/or recipes to be added to the node.
* The command line can also be used to edit JSON files and files that are related to third-party services, such as Amazon EC2, where the JSON files can contain per-instance metadata that is stored in a file on-disk and then read by chef-solo or Chef Infra Client as required.

Node Objects
=====================================================

For the Chef Infra Client, two important aspects of nodes are groups of attributes and run-lists. An attribute is a specific piece of data about the node, such as a network interface, a file system, the number of clients a service running on a node is capable of accepting, and so on. A run-list is an ordered list of recipes and/or roles that are run in an exact order. The node object consists of the run-list and node attributes, which is a JSON file that is stored on the Chef Infra Server. The Chef Infra Client gets a copy of the node object from the Chef Infra Server during each Chef Infra Client run and places an updated copy on the Chef Infra Server at the end of each Chef Infra Client run.

.. tag node_attribute

An attribute is a specific detail about a node. Attributes are used by the Chef Infra Client to understand:

* The current state of the node
* What the state of the node was at the end of the previous Chef Infra Client run
* What the state of the node should be at the end of the current Chef Infra Client run

Attributes are defined by:

* The state of the node itself
* Cookbooks (in attribute files and/or recipes)
* Roles
* Environments

During every Chef Infra Client run, the Chef Infra Client builds the attribute list using:

* Data about the node collected by Ohai
* The node object that was saved to the Chef Infra Server at the end of the previous Chef Infra Client run
* The rebuilt node object from the current Chef Infra Client run, after it is updated for changes to cookbooks (attribute files and/or recipes), roles, and/or environments, and updated for any changes to the state of the node itself

After the node object is rebuilt, all of the attributes are compared, and then the node is updated based on attribute precedence. At the end of every Chef Infra Client run, the node object that defines the current state of the node is uploaded to the Chef Infra Server so that it can be indexed for search.

.. end_tag

Attributes
=====================================================
.. tag node_attribute_when_to_use

An attribute is a specific detail about a node, such as an IP address, a host name, a list of loaded kernel modules, the version(s) of available programming languages that are available, and so on. An attribute may be unique to a specific node or it can be identical across every node in the organization. Attributes are most commonly set from a cookbook, by using knife, or are retrieved by Ohai from each node prior to every Chef Infra Client run. All attributes are indexed for search on the Chef Infra Server. Good candidates for attributes include:

* any cross-platform abstraction for an application, such as the path to a configuration file
* default values for tunable settings, such as the amount of memory assigned to a process or the number of workers to spawn
* anything that may need to be persisted in node data between Chef Infra Client runs

In general, attribute precedence is set to enable cookbooks and roles to define attribute defaults, for normal attributes to define the values that should be specific for a node, and for override attributes to force a certain value, even when a node already has that value specified.

One approach is to set attributes at the same precedence level by setting attributes in a cookbook's attribute files, and then also setting the same default attributes (but with different values) using a role. The attributes set in the role will be deep merged on top of the attributes from the attribute file, and the attributes set by the role will take precedence over the attributes specified in the cookbook's attribute files.

.. end_tag

.. tag node_attribute_when_to_use_unless_variants

Another (much less common) approach is to set a value only if an attribute has no value. This can be done by using the ``_unless`` variants of the attribute priority methods:

* ``default_unless``
* ``set_unless`` (``normal_unless`` is an alias of ``set_unless``; use either alias to set an attribute with a normal attribute precedence.)

    .. note:: This method was deprecated in Chef Client 12.12 and will be removed in Chef Client 14. Please use ``default_unless`` or ``override_unless`` instead.

* ``override_unless``

.. note:: Use the ``_unless`` variants carefully (and only when necessary) because when they are used, attributes applied to nodes may become out of sync with the values in the cookbooks as these cookbooks are updated. This approach can create situations where two otherwise identical nodes end up having slightly different configurations and can also be a challenge to debug.

.. end_tag

.. note:: .. tag notes_see_attributes_overview

          Attributes can be configured in cookbooks (attribute files and recipes), roles, and environments. In addition, Ohai collects attribute data about each node at the start of the Chef Infra Client run. See `Attributes </attributes.html>`__ for more information about how all of these attributes fit together.

          .. end_tag

Attribute Types
-----------------------------------------------------
.. tag node_attribute_type

The Chef Infra Client uses six types of attributes to determine the value that is applied to a node during the Chef Infra Client run. In addition, the Chef Infra Client sources attribute values from up to five locations. The combination of attribute types and sources allows for up to 15 different competing values to be available to the Chef Infra Client during the Chef Infra Client run:

.. end_tag

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Attribute Type
     - Description
   * - ``default``
     - .. tag node_attribute_type_default

       A ``default`` attribute is automatically reset at the start of every Chef Infra Client run and has the lowest attribute precedence. Use ``default`` attributes as often as possible in cookbooks.

       .. end_tag

   * - ``force_default``
     - .. tag node_attribute_type_force_default
     
       Use the ``force_default`` attribute to ensure that an attribute defined in a cookbook (by an attribute file or by a recipe) takes precedence over a ``default`` attribute set by a role or an environment.

       .. end_tag

   * - ``normal``
     - .. tag node_attribute_type_normal

       A ``normal`` attribute is a setting that persists in the node object. A ``normal`` attribute has a higher attribute precedence than a ``default`` attribute.

       .. end_tag

   * - ``override``
     - .. tag node_attribute_type_override

       An ``override`` attribute is automatically reset at the start of every Chef Infra Client run and has a higher attribute precedence than ``default``, ``force_default``, and ``normal`` attributes. An ``override`` attribute is most often specified in a recipe, but can be specified in an attribute file, for a role, and/or for an environment. A cookbook should be authored so that it uses ``override`` attributes only when required.

       .. end_tag

   * - ``force_override``
     - .. tag node_attribute_type_force_override

       Use the ``force_override`` attribute to ensure that an attribute defined in a cookbook (by an attribute file or by a recipe) takes precedence over an ``override`` attribute set by a role or an environment.

       .. end_tag
       
   * - ``automatic``
     - .. tag node_attribute_type_automatic

       An ``automatic`` attribute contains data that is identified by Ohai at the beginning of every Chef Infra Client run. An ``automatic`` attribute cannot be modified and always has the highest attribute precedence.

       .. end_tag

Attribute Persistence
-----------------------------------------------------
.. tag node_attribute_persistence

At the beginning of a Chef Infra Client run, all attributes except for normal attributes are reset. The Chef Infra Client rebuilds them using automatic attributes collected by Ohai at the beginning of the Chef Infra Client run and then using default and override attributes that are specified in cookbooks or by roles and environments. All attributes are then merged and applied to the node according to attribute precedence. At the conclusion of the Chef Infra Client run, the attributes that were applied to the node are saved to the Chef Infra Server as part of the node object.

.. end_tag

Attribute Precedence
-----------------------------------------------------
.. tag node_attribute_precedence

Attributes are always applied by the Chef Infra Client in the following order:

#. A ``default`` attribute located in a cookbook attribute file
#. A ``default`` attribute located in a recipe
#. A ``default`` attribute located in an environment
#. A ``default`` attribute located in a role
#. A ``force_default`` attribute located in a cookbook attribute file
#. A ``force_default`` attribute located in a recipe
#. A ``normal`` attribute located in a cookbook attribute file
#. A ``normal`` attribute located in a recipe
#. An ``override`` attribute located in a cookbook attribute file
#. An ``override`` attribute located in a recipe
#. An ``override`` attribute located in a role
#. An ``override`` attribute located in an environment
#. A ``force_override`` attribute located in a cookbook attribute file
#. A ``force_override`` attribute located in a recipe
#. An ``automatic`` attribute identified by Ohai at the start of the Chef Infra Client run

where the last attribute in the list is the one that is applied to the node.

.. note:: The attribute precedence order for roles and environments is reversed for ``default`` and ``override`` attributes. The precedence order for ``default`` attributes is environment, then role. The precedence order for ``override`` attributes is role, then environment. Applying environment ``override`` attributes after role ``override`` attributes allows the same role to be used across multiple environments, yet ensuring that values can be set that are specific to each environment (when required). For example, the role for an application server may exist in all environments, yet one environment may use a database server that is different from other environments.

Attribute precedence, viewed from the same perspective as the overview diagram, where the numbers in the diagram match the order of attribute precedence:

.. image:: ../../images/overview_chef_attributes_precedence.png

Attribute precedence, when viewed as a table:

.. image:: ../../images/overview_chef_attributes_table.png

.. end_tag

Blacklist Attributes
-----------------------------------------------------
.. tag node_attribute_blacklist

.. warning:: When attribute blacklist settings are used, any attribute defined in a blacklist will not be saved and any attribute that is not defined in a blacklist will be saved. Each attribute type is blacklisted independently of the other attribute types. For example, if ``automatic_attribute_blacklist`` defines attributes that will not be saved, but ``normal_attribute_blacklist``, ``default_attribute_blacklist``, and ``override_attribute_blacklist`` are not defined, then all normal attributes, default attributes, and override attributes will be saved, as well as the automatic attributes that were not specifically excluded through blacklisting.

Attributes that should not be saved by a node may be blacklisted in the client.rb file. The blacklist is a Hash of keys that specify each attribute to be filtered out.

Attributes are blacklisted by attribute type, with each attribute type being blacklisted independently. Each attribute type---``automatic``, ``default``, ``normal``, and ``override``---may define blacklists by using the following settings in the client.rb file:

.. list-table::
   :widths: 200 300
   :header-rows: 1


   * - Setting
     - Description
   * - ``automatic_attribute_blacklist``
     - A hash that blacklists ``automatic`` attributes, preventing blacklisted attributes from being saved. For example: ``['network/interfaces/eth0']``. Default value: ``nil``, all attributes are saved. If the array is empty, all attributes are saved.
   * - ``default_attribute_blacklist``
     - A hash that blacklists ``default`` attributes, preventing blacklisted attributes from being saved. For example: ``['filesystem/dev/disk0s2/size']``. Default value: ``nil``, all attributes are saved. If the array is empty, all attributes are saved.
   * - ``normal_attribute_blacklist``
     - A hash that blacklists ``normal`` attributes, preventing blacklisted attributes from being saved. For example: ``['filesystem/dev/disk0s2/size']``. Default value: ``nil``, all attributes are saved. If the array is empty, all attributes are saved.
   * - ``override_attribute_blacklist``
     - A hash that blacklists ``override`` attributes, preventing blacklisted attributes from being saved. For example: ``['map - autohome/size']``. Default value: ``nil``, all attributes are saved. If the array is empty, all attributes are saved.

.. warning:: The recommended practice is to use only ``automatic_attribute_blacklist`` for blacklisting attributes. This is primarily because automatic attributes generate the most data, but also that normal, default, and override attributes are typically much more important attributes and are more likely to cause issues if they are blacklisted incorrectly.

For example, automatic attribute data similar to:

.. code-block:: javascript

   {
     "filesystem" => {
       "/dev/disk0s2" => {
         "size" => "10mb"
       },
       "map - autohome" => {
         "size" => "10mb"
       }
     },
     "network" => {
       "interfaces" => {
         "eth0" => {...},
         "eth1" => {...},
       }
     }
   }

To blacklist the ``filesystem`` attributes and allow the other attributes to be saved, update the client.rb file:

.. code-block:: ruby

   automatic_attribute_blacklist ['filesystem']

When a blacklist is defined, any attribute of that type that is not specified in that attribute blacklist **will** be saved. So based on the previous blacklist for automatic attributes, the ``filesystem`` and ``map - autohome`` attributes will not be saved, but the ``network`` attributes will.

For attributes that contain slashes (``/``) within the attribute value, such as the ``filesystem`` attribute ``'/dev/diskos2'``, use an array. For example:

.. code-block:: ruby

   automatic_attribute_blacklist [['filesystem','/dev/diskos2']]

.. end_tag

Whitelist Attributes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag node_attribute_whitelist

.. warning:: When attribute whitelist settings are used, only the attributes defined in a whitelist will be saved and any attribute that is not defined in a whitelist will not be saved. Each attribute type is whitelisted independently of the other attribute types. For example, if ``automatic_attribute_whitelist`` defines attributes to be saved, but ``normal_attribute_whitelist``, ``default_attribute_whitelist``, and ``override_attribute_whitelist`` are not defined, then all normal attributes, default attributes, and override attributes are saved, as well as the automatic attributes that were specifically included through whitelisting.

Attributes that should be saved by a node may be whitelisted in the client.rb file. The whitelist is a hash of keys that specifies each attribute to be saved.

Attributes are whitelisted by attribute type, with each attribute type being whitelisted independently. Each attribute type---``automatic``, ``default``, ``normal``, and ``override``---may define whitelists by using the following settings in the client.rb file:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``automatic_attribute_whitelist``
     - A hash that whitelists ``automatic`` attributes, preventing non-whitelisted attributes from being saved. For example: ``['network/interfaces/eth0']``. Default value: ``nil``, all attributes are saved. If the hash is empty, no attributes are saved.
   * - ``default_attribute_whitelist``
     - A hash that whitelists ``default`` attributes, preventing non-whitelisted attributes from being saved. For example: ``['filesystem/dev/disk0s2/size']``. Default value: ``nil``, all attributes are saved. If the hash is empty, no attributes are saved.
   * - ``normal_attribute_whitelist``
     - A hash that whitelists ``normal`` attributes, preventing non-whitelisted attributes from being saved. For example: ``['filesystem/dev/disk0s2/size']``. Default value: ``nil``, all attributes are saved. If the hash is empty, no attributes are saved.
   * - ``override_attribute_whitelist``
     - A hash that whitelists ``override`` attributes, preventing non-whitelisted attributes from being saved. For example: ``['map - autohome/size']``. Default value: ``nil``, all attributes are saved. If the hash is empty, no attributes are saved.

.. warning:: The recommended practice is to only use ``automatic_attribute_whitelist`` to whitelist attributes. This is primarily because automatic attributes generate the most data, but also that normal, default, and override attributes are typically much more important attributes and are more likely to cause issues if they are whitelisted incorrectly.

For example, automatic attribute data similar to:

.. code-block:: javascript

   {
     "filesystem" => {
       "/dev/disk0s2" => {
         "size" => "10mb"
       },
       "map - autohome" => {
         "size" => "10mb"
       }
     },
     "network" => {
       "interfaces" => {
         "eth0" => {...},
         "eth1" => {...},
       }
     }
   }

To whitelist the ``network`` attributes and prevent the other attributes from being saved, update the client.rb file:

.. code-block:: ruby

   automatic_attribute_whitelist ['network/interfaces/']

When a whitelist is defined, any attribute of that type that is not specified in that attribute whitelist **will not** be saved. So based on the previous whitelist for automatic attributes, the ``filesystem`` and ``map - autohome`` attributes will not be saved, but the ``network`` attributes will.

Leave the value empty to prevent all attributes of that attribute type from being saved:

.. code-block:: ruby

   automatic_attribute_whitelist []

For attributes that contain slashes (``/``) within the attribute value, such as the ``filesystem`` attribute ``'/dev/diskos2'``, use an array. For example:

.. code-block:: ruby

   automatic_attribute_whitelist [['filesystem','/dev/diskos2']]

.. end_tag
