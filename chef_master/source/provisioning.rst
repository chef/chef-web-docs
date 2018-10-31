=====================================================
Chef Provisioning
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/provisioning.rst>`__

.. tag provisioning_summary

Chef provisioning is a collection of resources that enable the creation of machines and machine infrastructures using the chef-client. It has a plugin model that allows bootstrap operations to be done against any infrastructure, such as VirtualBox, DigitalOcean, Amazon EC2, LXC, bare metal, and more.

Chef provisioning is built around two major components: the **machine** resource and drivers.

Chef provisioning is packaged in the Chef development kit. Chef provisioning is a framework that allows clusters to be managed by the chef-client and the Chef server in the same way nodes are managed: with recipes. Use Chef provisioning to describe, version, deploy, and manage clusters of any size and complexity using a common set of tools.

.. end_tag

In-Parallel Processing
=====================================================
.. tag provisioning_parallel

In certain situations Chef provisioning will run multiple **machine** processes in-parallel, as long as each of the individual **machine** resources have the same declared action. The **machine_batch** resource is used to run in-parallel processes.

Chef provisioning will processes resources in-parallel automatically, unless:

* The recipe contains complex scripts, such as when a **file** resource sits in-between two **machine** resources in a single recipe. In this situation, the resources will be run sequentially
* The actions specified for each individual **machine** resource are not identical; for example, if resource A is set to ``:converge`` and resource B is set to ``:destroy``, then they may not be processed in-parallel

To disable in-parallel processing, add the ``auto_machine_batch`` setting to the client.rb file, and then set it to ``false``.

For example, a recipe that looks like:

.. code-block:: ruby

   machine 'a'
   machine 'b'
   machine 'c'

will show output similar to:

.. code-block:: bash

   $ CHEF_DRIVER=fog:AWS chef-apply cluster.rb
   ...
   Converging 1 resources
   Recipe: @recipe_files::/Users/jkeiser/oc/environments/metal-test-local/cluster.rb
     * machine_batch[default] action converge
       - [a] creating machine a on fog:AWS:862552916454
       - [a]   key_name: "metal_default"
       - [a]   tags: {"Name"=>"a", ...}
       - [a]   name: "a"
       - [b] creating machine b on fog:AWS:862552916454
       - [b]   key_name: "metal_default"
       - [b]   tags: {"Name"=>"b", ...}
       - [b]   name: "b"
       - [c] creating machine c on fog:AWS:862552916454
       - [c]   key_name: "metal_default"
       - [c]   tags: {"Name"=>"c", ...}
       - [c]   name: "c"
       - [b] machine b created as i-eb778fb9 on fog:AWS:862552916454
       - create node b at http://localhost:8889
       -   add normal.tags = nil
       -   add normal.metal = {"location"=>{"driver_url"=>"fog:AWS:862552916454", ...}}
       - [a] machine a created as i-e9778fbb on fog:AWS:862552916454
       - create node a at http://localhost:8889
       -   add normal.tags = nil
       -   add normal.metal = {"location"=>{"driver_url"=>"fog:AWS:862552916454", ...}}
       - [c] machine c created as i-816d95d3 on fog:AWS:862552916454
       - create node c at http://localhost:8889
       -   add normal.tags = nil
       -   add normal.metal = {"location"=>{"driver_url"=>"fog:AWS:862552916454", ...}}
       - [b] waiting for b (i-eb778fb9 on fog:AWS:862552916454) to be ready ...
       - [c] waiting for c (i-816d95d3 on fog:AWS:862552916454) to be ready ...
       - [a] waiting for a (i-e9778fbb on fog:AWS:862552916454) to be ready ...
   ...
           Running handlers:
           Running handlers complete

           Chef Client finished, 0/0 resources updated in 4.053363945 seconds
       - [c] run 'chef-client -l auto' on c

   Running handlers:
   Running handlers complete
   Chef Client finished, 1/1 resources updated in 59.64014 seconds

At the end, it shows ``1/1 resources updated``. The three **machine** resources are replaced with a single **machine_batch** resource, which then runs each of the individual **machine** processes in-parallel.

.. end_tag

Drivers
=====================================================
The following drivers are available for Chef provisioning:

.. list-table::
   :widths: 120 400
   :header-rows: 1

   * - Driver
     - Description
   * - `Amazon Web Services <https://github.com/chef/chef-provisioning-aws>`__
     - A Chef provisioning driver for Amazon Web Services (AWS).
   * - `Fog <https://github.com/chef/chef-provisioning-fog>`__
     - A Chef provisioning driver for Fog.
   * - `OpenNebula <https://github.com/blackberry/chef-provisioning-opennebula>`__
     - A Chef provisioning driver for OpenNebula.
   * - `SSH <https://github.com/chef/chef-provisioning-ssh>`__
     - A Chef provisioning driver for SSH.
   * - `vSphere <https://github.com/chef-partners/chef-provisioning-vsphere>`__
     - A Chef provisioning driver for VMware vSphere.

Driver-specific Resources
-----------------------------------------------------
.. tag resources_provisioning

A driver-specific resource is a statement of configuration policy that:

* Describes the desired state for a configuration item that is created using Chef provisioning
* Declares the steps needed to bring that item to the desired state
* Specifies a resource type---such as ``package``, ``template``, or ``service``
* Lists additional details (also known as properties), as necessary
* Are grouped into recipes, which describe working configurations

.. end_tag

Machine Resources
=====================================================
.. tag resources_common

A resource is a statement of configuration policy that:

* Describes the desired state for a configuration item
* Declares the steps needed to bring that item to the desired state
* Specifies a resource type---such as ``package``, ``template``, or ``service``
* Lists additional details (also known as resource properties), as necessary
* Are grouped into recipes, which describe working configurations

.. end_tag

load_balancer
-----------------------------------------------------
.. tag resource_load_balancer_summary

Use the **load_balancer** resource to create or destroy a load balancer.

.. end_tag

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_load_balancer_syntax

The syntax for using the **load_balancer** resource in a recipe is as follows:

.. code-block:: ruby

   load_balancer 'name' do
     attribute 'value' # see properties section below
     ...
     action :action # see actions section below
   end

where

* ``load_balancer`` tells the chef-client to use the ``Chef::Provider::LoadBalancer`` provider during the chef-client run
* ``name`` is the name of the resource block
* ``attribute`` is zero (or more) of the properties that are available for this resource
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state

.. end_tag

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_load_balancer_actions

This resource has the following actions:

``:create``
   Default.

``:destroy``

``:nothing``
   .. tag resources_common_actions_nothing

   Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the Chef Client run.

   .. end_tag

.. end_tag

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_load_balancer_attributes

This resource has the following properties:

``driver``
   **Ruby Type:** Chef::Provisioning::Driver

   Use to specify the driver to be used for provisioning.

``ignore_failure``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Continue running a recipe if a resource fails for any reason.

``load_balancer_options``
   ...

``machines``
   ...

``name``
   **Ruby Type:** String

   The name of the load balancer.

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

``retries``
   **Ruby Type:** Integer | **Default Value:** ``0``

   The number of times to catch exceptions and retry the resource.

``retry_delay``
   **Ruby Type:** Integer | **Default Value:** ``2``

   The retry delay (in seconds).

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

.. end_tag

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This resource has the following providers:

``Chef::Provider::LoadBalancer``, ``load_balancer``
   The default provider for all recipes.

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.

machine
-----------------------------------------------------
.. tag resource_machine_summary

Use the **machine** resource to define one (or more) machines, and then converge entire clusters of machines. This allows clusters to be maintained in a version control system and to be defined using multi-machine orchestration scenarios. For example, spinning up small test clusters and using them for continuous integration and local testing, building clusters that auto-scale, moving a set of machines in one cluster to another, building images, and so on.

Each machine is declared as a separate application topology, defined using operating system- and provisioner-independent files. Recipes (defined in cookbooks) are used to manage them. The chef-client is used to converge the individual nodes (machines) within the cluster.

.. end_tag

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_machine_syntax

The syntax for using the **machine** resource in a recipe is as follows:

.. code-block:: ruby

   machine 'name' do
     attribute 'value' # see properties section below
     ...
     action :action # see actions section below
   end

where

* ``machine`` tells the chef-client to use the ``Chef::Provider::Machine`` provider during the chef-client run
* ``name`` is the name of the resource block and also the name of the machine
* ``attribute`` is zero (or more) of the properties that are available for this resource
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state

.. end_tag

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_machine_actions

This resource has the following actions:

``:allocate``
   Use to create a machine, return its machine identifier, and then (depending on the provider) boot the machine to an image. This reserves the machine with the provider and subsequent ``:allocate`` actions against this machine no longer need to create the machine, just update it.

``:converge``
   Default. Use to create a machine, return its machine identifier, boot the machine to an image with the specified parameters and transport, install the chef-client, and then converge the machine.

``:converge_only``
   Use to converge a machine, but only if the machine is in a ready state.

``:destroy``
   Use to destroy a machine.

``:nothing``
   .. tag resources_common_actions_nothing

   Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the Chef Client run.

   .. end_tag

``:ready``
   Use to create a machine, return its machine identifier, and then boot the machine to an image with the specified parameters and transport. This machine is in a ready state and may be connected to (via SSH or other transport).

``:setup``
   Use to create a machine, return its machine identifier, boot the machine to an image with the specified parameters and transport, and then install the chef-client. This machine is in a ready state, has the chef-client installed, and all of the configuration data required to apply the run-list to the machine.

``:stop``
   Use to stop a machine.

.. end_tag

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_machine_attributes

This resource has the following properties:

``admin``
   **Ruby Type:** true, false

   Use to specify whether the chef-client is an API client.

``allow_overwrite_keys``
   **Ruby Type:** true, false

   Use to overwrite the key on a machine when it is different from the key specified by ``source_key``.

``attribute``
   Use to specify an attribute, and then modify that attribute with the specified value. The following patterns may be used to specify the value.

   .. code-block:: ruby

      attribute <name>, <value>

   .. code-block:: ruby

      attribute [<path>], <value>

   The following example will set attribute ``a`` to ``b``:

   .. code-block:: ruby

      attribute 'a', 'b'

   The following example will set attribute ``node['a']['b']['c']`` to ``d`` and will ignore attributes ``a.b.x``, ``a.b.y``, etc.:

   .. code-block:: ruby

      attribute %w[a b c], 'd'

   The following example is similar to ``%w[a b c], 'd'``:

   .. code-block:: ruby

      attribute 'a', { 'b' => { 'c' => 'd' } }

   Each modified attribute should be specified individually. This attribute should not be used in the same recipe as ``attributes``.

``attributes``
   Use to specify a Hash that contains all of the normal attributes to be applied to a machine. This attribute should not be used in the same recipe as ``attribute``.

``chef_config``
   **Ruby Type:** String

   Use to specify a string that contains extra configuration settings for a machine.

``chef_environment``
   The name of the environment.

``chef_server``
   **Ruby Type:** Hash

   The URL for the Chef server.

``complete``
   Use to specify if all of the normal attributes specified by this resource represent a complete specification of normal attributes for a machine. When ``true``, any attributes not specified will be reset to their default values. For example, if a **machine** resource is empty and sets ``complete`` to ``true``, all existing attributes will be reset:

   .. code-block:: ruby

      machine "foo" do
        complete "true"
      end

``converge``
   **Ruby Type:** true, false

   Use to manage convergence when used with the ``:create`` action. Set to ``false`` to prevent convergence. Set to ``true`` to force convergence. When ``nil``, the machine will converge only if something changes.

``driver``
   **Ruby Type:** Chef::Provisioning::Driver

   Use to specify the URL for the driver to be used for provisioning.

``files``
   **Ruby Type:** Hash

   A list of files to upload. Syntax: ``REMOTE_PATH => LOCAL_PATH_OR_HASH``.

   For example:

   .. code-block:: ruby

      files '/remote/path.txt' => '/local/path.txt'

   or:

   .. code-block:: ruby

      files '/remote/path.txt' => {
        :local_path => '/local/path.txt'
      }

   or:

   .. code-block:: ruby

      files '/remote/path.txt' => { :content => 'foo' }

``from_image``
   **Ruby Type:** String

   Use to specify an image created by the **machine_image** resource.

``ignore_failure``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Continue running a recipe if a resource fails for any reason.

``machine_options``
   **Ruby Type:** Hash

   A Hash that is specifies driver options.

``name``
   **Ruby Type:** String

   The name of the machine.

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

``ohai_hints``
   **Ruby Type:** Hash

   An Ohai hint to be set on the target node. For example: ``'ec2' => { 'a' => 'b' } creates file ec2.json with json contents { 'a': 'b' }``.

``private_key_options``
   **Ruby Type:** Hash

   Use to generate a private key of the desired size, type, and so on.

``public_key_format``
   **Ruby Type:** String | **Default Value:** ``pem``

   Use to specify the format of a public key. Possible values: ``pem`` and ``der``.

``public_key_path``
   **Ruby Type:** String

   The path to a public key.

``raw_json``
   The machine as JSON data. For example:

   .. code-block:: javascript

      {
        "name": "node1",
        "chef_environment": "_default",
        "json_class": "Chef::Node",
        "automatic": {
          "languages": {
            "ruby": {
              ...
            },
          ...
        ...
      }

``recipe``
   Use to add a recipe to the run-list for a machine. Use this property multiple times to add multiple recipes to a run-list. Use this property along with ``role`` to define a run-list. The order in which the ``recipe`` and ``role`` properties are specified will determine the order in which they are added to the run-list. This property should not be used in the same recipe as ``run_list``. For example:

   .. code-block:: ruby

      recipe 'foo'
      role 'bar'
      recipe 'baz'

``remove_recipe``
   Use to remove a recipe from the run-list for the machine.

``remove_role``
   Use to remove a role from the run-list for the machine.

``remove_tag``
   Use to remove a tag.

``retries``
   **Ruby Type:** Integer | **Default Value:** ``0``

   The number of times to catch exceptions and retry the resource.

``retry_delay``
   **Ruby Type:** Integer | **Default Value:** ``2``

   The retry delay (in seconds).

``role``
   Use to add a role to the run-list for the machine. Use this property multiple times to add multiple roles to a run-list. Use this property along with ``recipe`` to define a run-list. The order in which the ``recipe`` and ``role`` properties are specified will determine the order in which they are added to the run-list. This property should not be used in the same recipe as ``run_list``. For example:

   .. code-block:: ruby

      recipe 'foo'
      role 'bar'
      recipe 'baz'

``run_list``
   An array of strings that specifies the run-list to apply to a machine. This property should not be used in the same recipe as ``recipe`` and ``role``. For example:

   .. code-block:: ruby

      [ 'recipe[COOKBOOK::RECIPE]','COOKBOOK::RECIPE','role[NAME]' ]

``source_key``
   Use to copy a private key, but apply a different ``format`` and ``password``. Use in conjunction with ``source_key_pass_phrase``` and ``source_key_path``.

``source_key_pass_phrase``
   **Ruby Type:** String

   The pass phrase for the private key. Use in conjunction with ``source_key``` and ``source_key_path``.

``source_key_path``
   **Ruby Type:** String

   The path to the private key. Use in conjunction with ``source_key``` and ``source_key_pass_phrase``.

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

``tag``
   Use to add a tag.

``tags``
   Use to add one (or more) tags. This will remove any tag currently associated with the machine. For example: ``tags :a, :b, :c``.

``validator``
   **Ruby Type:** true, false

   Use to specify if the chef-client is a chef-validator.

.. end_tag

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This resource has the following providers:

``Chef::Provider::Machine``, ``machine``
   The default provider for all recipes.

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Build machines dynamically**

.. tag resource_machines_build_machines_dynamically

.. To build machines dynamically:

.. code-block:: ruby

   machine 'mario' do
     recipe 'postgresql'
     recipe 'mydb'
     tag 'mydb_master'
   end

   num_webservers = 1

   1.upto(num_webservers) do |i|
     machine "luigi#{i}" do
       recipe 'apache'
       recipe 'mywebapp'
     end
   end

.. end_tag

**Get a remote file onto a new machine**

.. tag resource_machine_file_get_remote_file

A deployment process requires more than just setting up machines. For example, files may need to be copied to machines from remote locations. The following example shows how to use the **remote_file** resource to grab a tarball from a URL, create a machine, copy that tarball to the machine, and then get that machine running by using a recipe that installs and configures that tarball on the machine:

.. code-block:: ruby

   remote_file 'mytarball.tgz' do
     url 'https://myserver.com/mytarball.tgz'
   end

   machine 'x'
     action :allocate
   end

   machine_file '/tmp/mytarball.tgz' do
     machine 'x'
     local_path 'mytarball.tgz'
     action :upload
   end

   machine 'x' do
     recipe 'untarthatthing'
     action :converge
   end

.. end_tag

**Build machines that depend on each other**

.. tag resource_machines_codependent_servers

The following example shows how to create two identical machines, both of which cannot exist without the other. The first **machine** resource block creates the first machine by omitting the recipe that requires the other machine to be defined. The second resource block creates the second machine; because the first machine exists, both recipes can be run. The third resource block applies the second recipe to the first machine:

.. code-block:: ruby

   machine 'server_a' do
     recipe 'base_recipes'
   end

   machine 'server_b' do
     recipe 'base_recipes'
     recipe 'theserver'
   end

   machine 'server_a' do
     recipe 'theserver'
   end

.. end_tag

**Use a loop to build many machines**

.. tag resource_machines_use_a_loop_to_create_many_machines

.. To create multiple machines using a loop:

.. code-block:: ruby

   1.upto(10) do |i|
     machine "hadoop#{i}" do
       recipe 'hadoop'
     end
   end

.. end_tag

**Converge multiple machine types, in-parallel**

.. tag resource_machine_batch_multiple_machine_types

The **machine_batch** resource can be used to converge multiple machine types, in-parallel, even if each machine type has different drivers. For example:

.. code-block:: ruby

   machine_batch do
     machine 'db' do
       recipe 'mysql'
     end
     1.upto(50) do |i|
       machine "#{web}#{i}" do
         recipe 'apache'
       end
     end
   end

.. end_tag

**Build a machine from a machine image**

.. tag resource_machine_image_add_apache_to_image

.. To add Apache to a machine image, and then build a machine:

.. code-block:: ruby

   machine_image 'web_image' do
     recipe 'apache2'
   end

   machine 'web_machine' do
    from_image 'web_image'
   end

.. end_tag

machine_batch
-----------------------------------------------------
.. tag resource_machine_batch_summary

Use the **machine_batch** resource to explicitly declare a parallel process when building machines.

.. end_tag

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_machine_batch_syntax

The syntax for using the **machine_batch** resource in a recipe is as follows:

.. code-block:: ruby

   machine_batch 'name' do
     attribute 'value' # see properties section below
     ...
     action :action # see actions section below
   end

where

* ``machine_batch`` tells the chef-client to use the ``Chef::Provider::MachineBatch`` provider during the chef-client run
* ``name`` is the name of the resource block
* ``attribute`` is zero (or more) of the properties that are available for this resource
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state

.. end_tag

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_machine_batch_actions

This resource has the following actions:

``:allocate``

``:converge``
   Default.

``:converge_only``

``:destroy``

``:nothing``
   .. tag resources_common_actions_nothing

   Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the Chef Client run.

   .. end_tag

``:ready``

``:setup``

``:stop``

.. end_tag

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_machine_batch_attributes

This resource has the following attributes:

``chef_server``
   **Ruby Type:** Hash

   The URL for the Chef server.

``driver``
   **Ruby Type:** Chef::Provisioning::Driver

   Use to specify the driver to be used for provisioning.

``files``
   ...

``from_recipe``
   ...

``ignore_failure``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Continue running a recipe if a resource fails for any reason.

``machine_options``
   ...

``machines``
   ...

``max_simultaneous``
   ...

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

``retries``
   **Ruby Type:** Integer | **Default Value:** ``0``

   The number of times to catch exceptions and retry the resource.

``retry_delay``
   **Ruby Type:** Integer | **Default Value:** ``2``

   The retry delay (in seconds).

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

.. end_tag

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This resource has the following providers:

``Chef::Provider::MachineBatch``, ``machine_batch``
   The default provider for all recipes.

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Set up multiple machines, in-parallel**

.. tag resource_machine_batch_setup_n_machines

.. To setup multiple machines in-parallel:

.. code-block:: ruby

   machine_batch do
     action :setup
     machines 'a', 'b', 'c', 'd', 'e'
   end

.. end_tag

**Converge multiple machines, in-parallel**

.. tag resource_machine_batch_converge_n_machines

.. To converge multiple machines in-parallel:

.. code-block:: ruby

   machine_batch do
     action :converge
     machines 'a', 'b', 'c', 'd', 'e'
   end

.. end_tag

**Stop multiple machines, in-parallel**

.. tag resource_machine_batch_stop_n_machines

.. To stop multiple machines in-parallel:

.. code-block:: ruby

   machine_batch do
     action :stop
     machines 'a', 'b', 'c', 'd', 'e'
   end

.. end_tag

**Destroy multiple machines, in-parallel**

.. tag resource_machine_batch_destroy_n_machines

.. To delete multiple machines in-parallel:

.. code-block:: ruby

   machine_batch do
     action :delete
     machines 'a', 'b', 'c', 'd', 'e'
   end

.. end_tag

**Converge multiple machine types, in-parallel**

.. tag resource_machine_batch_multiple_machine_types

The **machine_batch** resource can be used to converge multiple machine types, in-parallel, even if each machine type has different drivers. For example:

.. code-block:: ruby

   machine_batch do
     machine 'db' do
       recipe 'mysql'
     end
     1.upto(50) do |i|
       machine "#{web}#{i}" do
         recipe 'apache'
       end
     end
   end

.. end_tag

machine_execute
-----------------------------------------------------
.. tag resource_machine_execute_summary

Use the **machine_execute** resource to run a command on a remote machine in much the same way the **execute** resource is used to run a command on a local machine.

.. end_tag

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_machine_execute_syntax

The syntax for using the **machine_execute** resource in a recipe is as follows:

.. code-block:: ruby

   machine_execute 'name' do
     attribute 'value' # see properties section below
     ...
     action :action # see actions section below
   end

where

* ``machine_execute`` tells the chef-client to use the ``Chef::Provider::MachineExecute`` provider during the chef-client run
* ``name`` is the name of the resource block; when the ``command`` property is not specified as part of a recipe, ``name`` is also the command to be run
* ``attribute`` is zero (or more) of the properties that are available for this resource
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state

.. end_tag

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_machine_execute_actions

This resource has the following actions:

``:nothing``
   .. tag resources_common_actions_nothing

   Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the Chef Client run.

   .. end_tag

``:run``
   Default. Use to run a machine.

.. end_tag

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_machine_execute_attributes

This resource has the following properties:

``chef_server``
   **Ruby Type:** Hash

   The URL for the Chef server.

``command``
   **Ruby Type:** String

   The name of the command to be executed. Default value: the ``name`` of the resource block. See "Syntax" section above for more information.

``driver``
   **Ruby Type:** Chef::Provisioning::Driver

   Use to specify the driver to be used for provisioning.

``ignore_failure``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Continue running a recipe if a resource fails for any reason.

``live_stream``
   **Ruby Type:** true, false | **Default Value:** ``false``

``machine``
   **Ruby Type:** String

   Use to specify the machine type.

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

``retries``
   **Ruby Type:** Integer | **Default Value:** ``0``

   The number of times to catch exceptions and retry the resource.

``retry_delay``
   **Ruby Type:** Integer | **Default Value:** ``2``

   The retry delay (in seconds).

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

.. end_tag

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This resource has the following providers:

``Chef::Provider::MachineExecute``, ``machine_execute``
   The default provider for all recipes.

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.

machine_file
-----------------------------------------------------
.. tag resource_machine_file_summary

Use the **machine_file** resource to manage a file on a remote machine in much the same way the **file** resource is used to manage a file on a local machine.

.. end_tag

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_machine_file_syntax

The syntax for using the **machine_file** resource in a recipe is as follows:

.. code-block:: ruby

   machine_file 'name' do
     attribute 'value' # see properties section below
     ...
     action :action # see actions section below
   end

where

* ``machine_file`` tells the chef-client to use the ``Chef::Provider::MachineFile`` provider during the chef-client run
* ``name`` is the name of the resource block; when the ``path`` property is not specified as part of a recipe, ``name`` is also the path to a file
* ``attribute`` is zero (or more) of the properties that are available for this resource
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state

.. end_tag

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_machine_file_actions

This resource has the following actions:

``:delete``
   Use to delete a file from a machine.

``:download``
   Use to download a file from a machine.

``:nothing``
   .. tag resources_common_actions_nothing

   Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the Chef Client run.

   .. end_tag

``:upload``
   Default. Use to upload a file to a machine.

.. end_tag

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_machine_file_attributes

This resource has the following properties:

``chef_server``
   **Ruby Type:** Hash

   The URL for the Chef server.

``content``
   A string that is written to the file. The contents of this property replace any previous content when this property has something other than the default value. The default behavior will not modify content.

``driver``
   **Ruby Type:** Chef::Provisioning::Driver

   Use to specify the driver to be used for provisioning.

``group``
   **Ruby Type:** String

   A string or ID that identifies the group owner by group name, including fully qualified group names such as ``domain\group`` or ``group@domain``. If this value is not specified, existing groups remain unchanged and new group assignments use the default ``POSIX`` group (if available).

``ignore_failure``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Continue running a recipe if a resource fails for any reason.

``local_path``
   **Ruby Type:** String

   The local path to a file.

``machine``
   **Ruby Type:** String

   Use to specify the machine type.

``mode``
   **Ruby Type:** String

   If ``mode`` is not specified and if the file already exists, the existing mode on the file is used. If ``mode`` is not specified, the file does not exist, and the ``:create`` action is specified, the chef-client assumes a mask value of ``'0777'`` and then applies the umask for the system on which the file is to be created to the ``mask`` value. For example, if the umask on a system is ``'022'``, the chef-client uses the default value of ``'0755'``.

   The behavior is different depending on the platform.

   UNIX- and Linux-based systems: A quoted 3-5 character string that defines the octal mode that is passed to chmod. For example: ``'755'``, ``'0755'``, or ``00755``. If the value is specified as a quoted string, it works exactly as if the ``chmod`` command was passed. If the value is specified as an integer, prepend a zero (``0``) to the value to ensure that it is interpreted as an octal number. For example, to assign read, write, and execute rights for all users, use ``'0777'`` or ``'777'``; for the same rights, plus the sticky bit, use ``01777`` or ``'1777'``.

   Microsoft Windows: A quoted 3-5 character string that defines the octal mode that is translated into rights for Microsoft Windows security. For example: ``'755'``, ``'0755'``, or ``00755``. Values up to ``'0777'`` are allowed (no sticky bits) and mean the same in Microsoft Windows as they do in UNIX, where ``4`` equals ``GENERIC_READ``, ``2`` equals ``GENERIC_WRITE``, and ``1`` equals ``GENERIC_EXECUTE``. This property cannot be used to set ``:full_control``. This property has no effect if not specified, but when it and ``rights`` are both specified, the effects are cumulative.

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

``owner``
   **Ruby Type:** String

   A string or ID that identifies the group owner by user name, including fully qualified user names such as ``domain\user`` or ``user@domain``. If this value is not specified, existing owners remain unchanged and new owner assignments use the current user (when necessary).

``path``
   **Ruby Type:** String

   The full path to the file, including the file name and its extension. Default value: the ``name`` of the resource block. See "Syntax" section above for more information.

   Microsoft Windows: A path that begins with a forward slash (``/``) will point to the root of the current working directory of the chef-client process. This path can vary from system to system. Therefore, using a path that begins with a forward slash (``/``) is not recommended.

``retries``
   **Ruby Type:** Integer | **Default Value:** ``0``

   The number of times to catch exceptions and retry the resource.

``retry_delay``
   **Ruby Type:** Integer | **Default Value:** ``2``

   The retry delay (in seconds).

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

.. end_tag

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This resource has the following providers:

``Chef::Provider::MachineFile``, ``machine_file``
   The default provider for all recipes.

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Get a remote file onto a new machine**

.. tag resource_machine_file_get_remote_file

A deployment process requires more than just setting up machines. For example, files may need to be copied to machines from remote locations. The following example shows how to use the **remote_file** resource to grab a tarball from a URL, create a machine, copy that tarball to the machine, and then get that machine running by using a recipe that installs and configures that tarball on the machine:

.. code-block:: ruby

   remote_file 'mytarball.tgz' do
     url 'https://myserver.com/mytarball.tgz'
   end

   machine 'x'
     action :allocate
   end

   machine_file '/tmp/mytarball.tgz' do
     machine 'x'
     local_path 'mytarball.tgz'
     action :upload
   end

   machine 'x' do
     recipe 'untarthatthing'
     action :converge
   end

.. end_tag

machine_image
-----------------------------------------------------
.. tag resource_machine_image_summary

Use the **machine_image** resource to define a machine image. This image may then be used by the **machine** resource when building machines.

.. end_tag

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_machine_image_syntax

The syntax for using the **machine_image** resource in a recipe is as follows:

.. code-block:: ruby

   machine_image 'name' do
     attribute 'value' # see properties section below
     ...
     action :action # see actions section below
   end

where

* ``machine_image`` tells the chef-client to use the ``Chef::Provider::MachineImage`` provider during the chef-client run
* ``name`` is the name of the resource block and also the name of the machine image
* ``attribute`` is zero (or more) of the properties that are available for this resource
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state

.. end_tag

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_machine_image_actions

This resource has the following actions:

``:archive``
   Use to archive a machine image.

``:create``
   Default. Use to create a machine image.

``:destroy``
   Use to destroy a machine image.

``:nothing``
   .. tag resources_common_actions_nothing

   Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the Chef Client run.

   .. end_tag

.. end_tag

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag resource_machine_image_attributes

This resource has the following properties:

``attributes``
   Use to specify a hash of attributes to be applied to the machine image.

``chef_environment``
   The name of the environment.

``complete``
   Use to specify if all of the attributes specified in ``attributes`` represent a complete specification for the machine image. When true, any attributes not specified in ``attributes`` will be reset to their default values.

``ignore_failure``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Continue running a recipe if a resource fails for any reason.

``image_options``
   **Ruby Type:** Hash

   Use to specify options that are used with this machine image.

``name``
   The name of the machine image.

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

``raw_json``
   The machine image as JSON data. For example:

   .. code-block:: javascript

      {

      }

``recipe``
   Use to add a recipe to the run-list for the machine image. Each ``recipe`` adds a single recipe to the run-list. The order in which ``recipe`` defines the run-list is the order in which Chef will execute the run-list on the machine image.

``remove_recipe``
   Use to remove a recipe from the run-list for the machine image.

``remove_role``
   Use to remove a role from the run-list for the machine image.

``retries``
   **Ruby Type:** Integer | **Default Value:** ``0``

   The number of times to catch exceptions and retry the resource.

``retry_delay``
   **Ruby Type:** Integer | **Default Value:** ``2``

   The retry delay (in seconds).

``role``
   Use to add a role to the run-list for the machine image.

``run_list``
   Use to specify the run-list to be applied to the machine image.

   .. tag node_run_list

   A run-list defines all of the information necessary for Chef to configure a node into the desired state. A run-list is:

   * An ordered list of roles and/or recipes that are run in the exact order defined in the run-list; if a recipe appears more than once in the run-list, the chef-client will not run it twice
   * Always specific to the node on which it runs; nodes may have a run-list that is identical to the run-list used by other nodes
   * Stored as part of the node object on the Chef server
   * Maintained using knife and then uploaded from the workstation to the Chef server, or maintained using Chef Automate

   .. end_tag

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

``tags``
   Use to specify the list of tags to be applied to the machine image. Any tag not specified in this list will be removed.

.. end_tag

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This resource has the following providers:

``Chef::Provider::MachineImage``, ``machine_image``
   The default provider for all recipes.

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Build a machine from a machine image**

.. tag resource_machine_image_add_apache_to_image

.. To add Apache to a machine image, and then build a machine:

.. code-block:: ruby

   machine_image 'web_image' do
     recipe 'apache2'
   end

   machine 'web_machine' do
    from_image 'web_image'
   end

.. end_tag

AWS Driver Resources
=====================================================
.. tag resources_provisioning

A driver-specific resource is a statement of configuration policy that:

* Describes the desired state for a configuration item that is created using Chef provisioning
* Declares the steps needed to bring that item to the desired state
* Specifies a resource type---such as ``package``, ``template``, or ``service``
* Lists additional details (also known as properties), as necessary
* Are grouped into recipes, which describe working configurations

.. end_tag

The following Chef provisioning driver-specific resources are available for Amazon Web Services (AWS):

* ``aws_auto_scaling_group``
* ``aws_cache_cluster``
* ``aws_cache_replication_group``
* ``aws_cache_subnet_group``
* ``aws_cloudsearch_domain``
* ``aws_dhcp_options``
* ``aws_ebs_volume``
* ``aws_eip_address``
* ``aws_image``
* ``aws_instance``
* ``aws_internet_gateway``
* ``aws_key_pair``
* ``aws_launch_configuration``
* ``aws_load_balancer``
* ``aws_network_acl``
* ``aws_network_interface``
* ``aws_rds_instance``
* ``aws_rds_subnet_group``
* ``aws_route_table``
* ``aws_s3_bucket``
* ``aws_security_group``
* ``aws_server_certificate``
* ``aws_sns_topic``
* ``aws_sqs_queue``
* ``aws_subnet``
* ``aws_vpc``

For more information about these driver-specific resources, see `AWS Driver Resources </provisioning_aws.html>`__.

Fog Driver Resources
=====================================================
.. tag resources_provisioning

A driver-specific resource is a statement of configuration policy that:

* Describes the desired state for a configuration item that is created using Chef provisioning
* Declares the steps needed to bring that item to the desired state
* Specifies a resource type---such as ``package``, ``template``, or ``service``
* Lists additional details (also known as properties), as necessary
* Are grouped into recipes, which describe working configurations

.. end_tag

The following Chef provisioning driver-specific resources are available for Fog:

* ``fog_key_pair``

For more information about these driver-specific resources, see `Fog Driver Resources </provisioning_fog.html>`__.
