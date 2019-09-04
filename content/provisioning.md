+++
title = "Chef Provisioning"
draft = false

aliases = "/provisioning.html"


  
    
    
    
    
+++    

[\[edit on
GitHub\]](https://github.com/chef/chef-web-docs/blob/master/chef_master/source/provisioning.rst)

<meta name="robots" content="noindex">

{{% EOL_provisioning %}}

{{% provisioning_summary %}}

In-Parallel Processing
======================

In certain situations Chef Provisioning will run multiple **machine**
processes in-parallel, as long as each of the individual **machine**
resources have the same declared action. The **machine_batch** resource
is used to run in-parallel processes.

Chef Provisioning will processes resources in-parallel automatically,
unless:

-   The recipe contains complex scripts, such as when a **file**
    resource sits in-between two **machine** resources in a single
    recipe. In this situation, the resources will be run sequentially
-   The actions specified for each individual **machine** resource are
    not identical; for example, if resource A is set to `:converge` and
    resource B is set to `:destroy`, then they may not be processed
    in-parallel

To disable in-parallel processing, add the `auto_machine_batch` setting
to the client.rb file, and then set it to `false`.

For example, a recipe that looks like:

``` ruby
machine 'a'
machine 'b'
machine 'c'
```

will show output similar to:

``` bash
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
```

At the end, it shows `1/1 resources updated`. The three **machine**
resources are replaced with a single **machine_batch** resource, which
then runs each of the individual **machine** processes in-parallel.

Drivers
=======

The following drivers are available for Chef Provisioning:

<table>
<colgroup>
<col style="width: 23%" />
<col style="width: 76%" />
</colgroup>
<thead>
<tr class="header">
<th>Driver</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><a href="https://github.com/chef/chef-provisioning-aws">Amazon Web Services</a></td>
<td>A Chef Provisioning driver for Amazon Web Services (AWS).</td>
</tr>
<tr class="even">
<td><a href="https://github.com/chef/chef-provisioning-fog">Fog</a></td>
<td>A Chef Provisioning driver for Fog.</td>
</tr>
<tr class="odd">
<td><a href="https://github.com/blackberry/chef-provisioning-opennebula">OpenNebula</a></td>
<td>A Chef Provisioning driver for OpenNebula.</td>
</tr>
<tr class="even">
<td><a href="https://github.com/chef/chef-provisioning-ssh">SSH</a></td>
<td>A Chef Provisioning driver for SSH.</td>
</tr>
<tr class="odd">
<td><a href="https://github.com/chef-partners/chef-provisioning-vsphere">vSphere</a></td>
<td>A Chef Provisioning driver for VMware vSphere.</td>
</tr>
</tbody>
</table>

Driver-specific Resources
-------------------------

A driver-specific resource is a statement of configuration policy that:

-   Describes the desired state for a configuration item that is created
    using Chef Provisioning
-   Declares the steps needed to bring that item to the desired state
-   Specifies a resource type---such as `package`, `template`, or
    `service`
-   Lists additional details (also known as properties), as necessary
-   Are grouped into recipes, which describe working configurations

Machine Resources
=================

A resource is a statement of configuration policy that:

-   Describes the desired state for a configuration item
-   Declares the steps needed to bring that item to the desired state
-   Specifies a resource type---such as `package`, `template`, or
    `service`
-   Lists additional details (also known as resource properties), as
    necessary
-   Are grouped into recipes, which describe working configurations

load_balancer
--------------

Use the **load_balancer** resource to create or destroy a load
balancer.

### Syntax

The syntax for using the **load_balancer** resource in a recipe is as
follows:

``` ruby
load_balancer 'name' do
  attribute 'value' # see properties section below
  ...
  action :action # see actions section below
end
```

where

-   `load_balancer` tells Chef Infra Client to use the
    `Chef::Provider::LoadBalancer` provider during a Chef Infra Client
    run
-   `name` is the name of the resource block
-   `attribute` is zero (or more) of the properties that are available
    for this resource
-   `action` identifies which steps Chef Infra Client will take to bring
    the node into the desired state

### Actions

This resource has the following actions:

`:create`

:   Default.

`:destroy`

`:nothing`

:   {{% resources_common_actions_nothing %}}

### Properties

This resource has the following properties:

`driver`

:   **Ruby Type:** Chef::Provisioning::Driver

    Use to specify the driver to be used for provisioning.

`load_balancer_options`

:   ...

`machines`

:   ...

`name`

:   **Ruby Type:** String

    The name of the load balancer.

machine
-------

Use the **machine** resource to define one (or more) machines, and then
converge entire clusters of machines. This allows clusters to be
maintained in a version control system and to be defined using
multi-machine orchestration scenarios. For example, spinning up small
test clusters and using them for continuous integration and local
testing, building clusters that auto-scale, moving a set of machines in
one cluster to another, building images, and so on.

Each machine is declared as a separate application topology, defined
using operating system- and provisioner-independent files. Recipes
(defined in cookbooks) are used to manage them. Chef Infra Client is
used to converge the individual nodes (machines) within the cluster.

### Syntax

The syntax for using the **machine** resource in a recipe is as follows:

``` ruby
machine 'name' do
  attribute 'value' # see properties section below
  ...
  action :action # see actions section below
end
```

where

-   `machine` tells Chef Infra Client to use the
    `Chef::Provider::Machine` provider during a Chef Infra Client run
-   `name` is the name of the resource block and also the name of the
    machine
-   `attribute` is zero (or more) of the properties that are available
    for this resource
-   `action` identifies which steps Chef Infra Client will take to bring
    the node into the desired state

### Actions

This resource has the following actions:

`:allocate`

:   Use to create a machine, return its machine identifier, and then
    (depending on the provider) boot the machine to an image. This
    reserves the machine with the provider and subsequent `:allocate`
    actions against this machine no longer need to create the machine,
    just update it.

`:converge`

:   Default. Use to create a machine, return its machine identifier,
    boot the machine to an image with the specified parameters and
    transport, install Chef Infra Client, and then converge the machine.

`:converge_only`

:   Use to converge a machine, but only if the machine is in a ready
    state.

`:destroy`

:   Use to destroy a machine.

`:nothing`

:   {{% resources_common_actions_nothing %}}

`:ready`

:   Use to create a machine, return its machine identifier, and then
    boot the machine to an image with the specified parameters and
    transport. This machine is in a ready state and may be connected to
    (via SSH or other transport).

`:setup`

:   Use to create a machine, return its machine identifier, boot the
    machine to an image with the specified parameters and transport, and
    then install Chef Infra Client. This machine is in a ready state,
    has Chef Infra Client installed, and all of the configuration data
    required to apply the run-list to the machine.

`:stop`

:   Use to stop a machine.

### Properties

This resource has the following properties:

`admin`

:   **Ruby Type:** true, false

    Use to specify whether Chef Infra Client is an API client.

`allow_overwrite_keys`

:   **Ruby Type:** true, false

    Use to overwrite the key on a machine when it is different from the
    key specified by `source_key`.

`attribute`

:   Use to specify an attribute, and then modify that attribute with the
    specified value. The following patterns may be used to specify the
    value.

    ``` ruby
    attribute <name>, <value>
    ```

    ``` ruby
    attribute [<path>], <value>
    ```

    The following example will set attribute `a` to `b`:

    ``` ruby
    attribute 'a', 'b'
    ```

    The following example will set attribute `node['a']['b']['c']` to
    `d` and will ignore attributes `a.b.x`, `a.b.y`, etc.:

    ``` ruby
    attribute %w[a b c], 'd'
    ```

    The following example is similar to `%w[a b c], 'd'`:

    ``` ruby
    attribute 'a', { 'b' => { 'c' => 'd' } }
    ```

    Each modified attribute should be specified individually. This
    attribute should not be used in the same recipe as `attributes`.

`attributes`

:   Use to specify a Hash that contains all of the normal attributes to
    be applied to a machine. This attribute should not be used in the
    same recipe as `attribute`.

`chef_config`

:   **Ruby Type:** String

    Use to specify a string that contains extra configuration settings
    for a machine.

`chef_environment`

:   The name of the environment.

`chef_server`

:   **Ruby Type:** Hash

    The URL for the Chef Infra Server.

`complete`

:   Use to specify if all of the normal attributes specified by this
    resource represent a complete specification of normal attributes for
    a machine. When `true`, any attributes not specified will be reset
    to their default values. For example, if a **machine** resource is
    empty and sets `complete` to `true`, all existing attributes will be
    reset:

    ``` ruby
    machine "foo" do
      complete "true"
    end
    ```

`converge`

:   **Ruby Type:** true, false

    Use to manage convergence when used with the `:create` action. Set
    to `false` to prevent convergence. Set to `true` to force
    convergence. When `nil`, the machine will converge only if something
    changes.

`driver`

:   **Ruby Type:** Chef::Provisioning::Driver

    Use to specify the URL for the driver to be used for provisioning.

`files`

:   **Ruby Type:** Hash

    A list of files to upload. Syntax:
    `REMOTE_PATH => LOCAL_PATH_OR_HASH`.

    For example:

    ``` ruby
    files '/remote/path.txt' => '/local/path.txt'
    ```

    or:

    ``` ruby
    files '/remote/path.txt' => {
      :local_path => '/local/path.txt'
    }
    ```

    or:

    ``` ruby
    files '/remote/path.txt' => { :content => 'foo' }
    ```

`from_image`

:   **Ruby Type:** String

    Use to specify an image created by the **machine_image** resource.

`machine_options`

:   **Ruby Type:** Hash

    A Hash that is specifies driver options.

`name`

:   **Ruby Type:** String

    The name of the machine.

`ohai_hints`

:   **Ruby Type:** Hash

    An Ohai hint to be set on the target node. For example:
    `'ec2' => { 'a' => 'b' } creates file ec2.json with json contents { 'a': 'b' }`.

`private_key_options`

:   **Ruby Type:** Hash

    Use to generate a private key of the desired size, type, and so on.

`public_key_format`

:   **Ruby Type:** String | **Default Value:** `pem`

    Use to specify the format of a public key. Possible values: `pem`
    and `der`.

`public_key_path`

:   **Ruby Type:** String

    The path to a public key.

`raw_json`

:   The machine as JSON data. For example:

    ``` javascript
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
    ```

`recipe`

:   Use to add a recipe to the run-list for a machine. Use this property
    multiple times to add multiple recipes to a run-list. Use this
    property along with `role` to define a run-list. The order in which
    the `recipe` and `role` properties are specified will determine the
    order in which they are added to the run-list. This property should
    not be used in the same recipe as `run_list`. For example:

    ``` ruby
    recipe 'foo'
    role 'bar'
    recipe 'baz'
    ```

`remove_recipe`

:   Use to remove a recipe from the run-list for the machine.

`remove_role`

:   Use to remove a role from the run-list for the machine.

`remove_tag`

:   Use to remove a tag.

`role`

:   Use to add a role to the run-list for the machine. Use this property
    multiple times to add multiple roles to a run-list. Use this
    property along with `recipe` to define a run-list. The order in
    which the `recipe` and `role` properties are specified will
    determine the order in which they are added to the run-list. This
    property should not be used in the same recipe as `run_list`. For
    example:

    ``` ruby
    recipe 'foo'
    role 'bar'
    recipe 'baz'
    ```

`run_list`

:   An array of strings that specifies the run-list to apply to a
    machine. This property should not be used in the same recipe as
    `recipe` and `role`. For example:

    ``` ruby
    [ 'recipe[COOKBOOK::RECIPE]','COOKBOOK::RECIPE','role[NAME]' ]
    ```

`source_key`

:   Use to copy a private key, but apply a different `format` and
    `password`. Use in conjunction with `source_key_pass_phrase`<span
    class="title-ref"> and </span><span
    class="title-ref">source_key_path</span>\`.

`source_key_pass_phrase`

:   **Ruby Type:** String

    The pass phrase for the private key. Use in conjunction with
    `source_key`<span class="title-ref"> and </span><span
    class="title-ref">source_key_path</span>\`.

`source_key_path`

:   **Ruby Type:** String

    The path to the private key. Use in conjunction with
    `source_key`<span class="title-ref"> and </span><span
    class="title-ref">source_key_pass_phrase</span>\`.

`tag`

:   Use to add a tag.

`tags`

:   Use to add one (or more) tags. This will remove any tag currently
    associated with the machine. For example: `tags :a, :b, :c`.

`validator`

:   **Ruby Type:** true, false

    Use to specify if Chef Infra Client is a chef-validator.

### Examples

**Build machines dynamically**

``` ruby
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
```

**Get a remote file onto a new machine**

A deployment process requires more than just setting up machines. For
example, files may need to be copied to machines from remote locations.
The following example shows how to use the **remote_file** resource to
grab a tarball from a URL, create a machine, copy that tarball to the
machine, and then get that machine running by using a recipe that
installs and configures that tarball on the machine:

``` ruby
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
```

**Build machines that depend on each other**

The following example shows how to create two identical machines, both
of which cannot exist without the other. The first **machine** resource
block creates the first machine by omitting the recipe that requires the
other machine to be defined. The second resource block creates the
second machine; because the first machine exists, both recipes can be
run. The third resource block applies the second recipe to the first
machine:

``` ruby
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
```

**Use a loop to build many machines**

``` ruby
1.upto(10) do |i|
  machine "hadoop#{i}" do
    recipe 'hadoop'
  end
end
```

**Converge multiple machine types, in-parallel**

The **machine_batch** resource can be used to converge multiple machine
types, in-parallel, even if each machine type has different drivers. For
example:

``` ruby
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
```

**Build a machine from a machine image**

``` ruby
machine_image 'web_image' do
  recipe 'apache2'
end

machine 'web_machine' do
 from_image 'web_image'
end
```

machine_batch
--------------

Use the **machine_batch** resource to explicitly declare a parallel
process when building machines.

### Syntax

The syntax for using the **machine_batch** resource in a recipe is as
follows:

``` ruby
machine_batch 'name' do
  attribute 'value' # see properties section below
  ...
  action :action # see actions section below
end
```

where

-   `machine_batch` tells Chef Infra Client to use the
    `Chef::Provider::MachineBatch` provider during a Chef Infra Client
    run
-   `name` is the name of the resource block
-   `attribute` is zero (or more) of the properties that are available
    for this resource
-   `action` identifies which steps Chef Infra Client will take to bring
    the node into the desired state

### Actions

This resource has the following actions:

`:allocate`

`:converge`

:   Default.

`:converge_only`

`:destroy`

`:nothing`

:   {{% resources_common_actions_nothing %}}

`:ready`

`:setup`

`:stop`

### Properties

This resource has the following attributes:

`chef_server`

:   **Ruby Type:** Hash

    The URL for the Chef Infra Server.

`driver`

:   **Ruby Type:** Chef::Provisioning::Driver

    Use to specify the driver to be used for provisioning.

`files`

:   ...

`from_recipe`

:   ...

`machine_options`

:   ...

`machines`

:   ...

`max_simultaneous`

:   ...

### Examples

**Set up multiple machines, in-parallel**

``` ruby
machine_batch do
  action :setup
  machines 'a', 'b', 'c', 'd', 'e'
end
```

**Converge multiple machines, in-parallel**

``` ruby
machine_batch do
  action :converge
  machines 'a', 'b', 'c', 'd', 'e'
end
```

**Stop multiple machines, in-parallel**

``` ruby
machine_batch do
  action :stop
  machines 'a', 'b', 'c', 'd', 'e'
end
```

**Destroy multiple machines, in-parallel**

``` ruby
machine_batch do
  action :delete
  machines 'a', 'b', 'c', 'd', 'e'
end
```

**Converge multiple machine types, in-parallel**

The **machine_batch** resource can be used to converge multiple machine
types, in-parallel, even if each machine type has different drivers. For
example:

``` ruby
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
```

machine_execute
----------------

Use the **machine_execute** resource to run a command on a remote
machine in much the same way the **execute** resource is used to run a
command on a local machine.

### Syntax

The syntax for using the **machine_execute** resource in a recipe is as
follows:

``` ruby
machine_execute 'name' do
  attribute 'value' # see properties section below
  ...
  action :action # see actions section below
end
```

where

-   `machine_execute` tells Chef Infra Client to use the
    `Chef::Provider::MachineExecute` provider during a Chef Infra Client
    run
-   `name` is the name of the resource block; when the `command`
    property is not specified as part of a recipe, `name` is also the
    command to be run
-   `attribute` is zero (or more) of the properties that are available
    for this resource
-   `action` identifies which steps Chef Infra Client will take to bring
    the node into the desired state

### Actions

This resource has the following actions:

`:nothing`

:   {{% resources_common_actions_nothing %}}

`:run`

:   Default. Use to run a machine.

### Properties

This resource has the following properties:

`chef_server`

:   **Ruby Type:** Hash

    The URL for the Chef Infra Server.

`command`

:   **Ruby Type:** String

    The name of the command to be executed. Default value: the `name` of
    the resource block. See "Syntax" section above for more information.

`driver`

:   **Ruby Type:** Chef::Provisioning::Driver

    Use to specify the driver to be used for provisioning.

`live_stream`

:   **Ruby Type:** true, false | **Default Value:** `false`

`machine`

:   **Ruby Type:** String

    Use to specify the machine type.

machine_file
-------------

Use the **machine_file** resource to manage a file on a remote machine
in much the same way the **file** resource is used to manage a file on a
local machine.

### Syntax

The syntax for using the **machine_file** resource in a recipe is as
follows:

``` ruby
machine_file 'name' do
  attribute 'value' # see properties section below
  ...
  action :action # see actions section below
end
```

where

-   `machine_file` tells Chef Infra Client to use the
    `Chef::Provider::MachineFile` provider during a Chef Infra Client
    run
-   `name` is the name of the resource block; when the `path` property
    is not specified as part of a recipe, `name` is also the path to a
    file
-   `attribute` is zero (or more) of the properties that are available
    for this resource
-   `action` identifies which steps Chef Infra Client will take to bring
    the node into the desired state

### Actions

This resource has the following actions:

`:delete`

:   Use to delete a file from a machine.

`:download`

:   Use to download a file from a machine.

`:nothing`

:   {{% resources_common_actions_nothing %}}

`:upload`

:   Default. Use to upload a file to a machine.

### Properties

This resource has the following properties:

`chef_server`

:   **Ruby Type:** Hash

    The URL for the Chef Infra Server.

`content`

:   A string that is written to the file. The contents of this property
    replace any previous content when this property has something other
    than the default value. The default behavior will not modify
    content.

`driver`

:   **Ruby Type:** Chef::Provisioning::Driver

    Use to specify the driver to be used for provisioning.

`group`

:   **Ruby Type:** String

    A string or ID that identifies the group owner by group name,
    including fully qualified group names such as `domain\group` or
    `group@domain`. If this value is not specified, existing groups
    remain unchanged and new group assignments use the default `POSIX`
    group (if available).

`local_path`

:   **Ruby Type:** String

    The local path to a file.

`machine`

:   **Ruby Type:** String

    Use to specify the machine type.

`mode`

:   **Ruby Type:** String

    If `mode` is not specified and if the file already exists, the
    existing mode on the file is used. If `mode` is not specified, the
    file does not exist, and the `:create` action is specified, Chef
    Infra Client assumes a mask value of `'0777'` and then applies the
    umask for the system on which the file is to be created to the
    `mask` value. For example, if the umask on a system is `'022'`, Chef
    Infra Client uses the default value of `'0755'`.

    The behavior is different depending on the platform.

    UNIX- and Linux-based systems: A quoted 3-5 character string that
    defines the octal mode that is passed to chmod. For example:
    `'755'`, `'0755'`, or `00755`. If the value is specified as a quoted
    string, it works exactly as if the `chmod` command was passed. If
    the value is specified as an integer, prepend a zero (`0`) to the
    value to ensure that it is interpreted as an octal number. For
    example, to assign read, write, and execute rights for all users,
    use `'0777'` or `'777'`; for the same rights, plus the sticky bit,
    use `01777` or `'1777'`.

    Microsoft Windows: A quoted 3-5 character string that defines the
    octal mode that is translated into rights for Microsoft Windows
    security. For example: `'755'`, `'0755'`, or `00755`. Values up to
    `'0777'` are allowed (no sticky bits) and mean the same in Microsoft
    Windows as they do in UNIX, where `4` equals `GENERIC_READ`, `2`
    equals `GENERIC_WRITE`, and `1` equals `GENERIC_EXECUTE`. This
    property cannot be used to set `:full_control`. This property has no
    effect if not specified, but when it and `rights` are both
    specified, the effects are cumulative.

### Examples

**Get a remote file onto a new machine**

A deployment process requires more than just setting up machines. For
example, files may need to be copied to machines from remote locations.
The following example shows how to use the **remote_file** resource to
grab a tarball from a URL, create a machine, copy that tarball to the
machine, and then get that machine running by using a recipe that
installs and configures that tarball on the machine:

``` ruby
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
```

machine_image
--------------

Use the **machine_image** resource to define a machine image. This
image may then be used by the **machine** resource when building
machines.

### Syntax

The syntax for using the **machine_image** resource in a recipe is as
follows:

``` ruby
machine_image 'name' do
  attribute 'value' # see properties section below
  ...
  action :action # see actions section below
end
```

where

-   `machine_image` tells Chef Infra Client to use the
    `Chef::Provider::MachineImage` provider during a Chef Infra Client
    run
-   `name` is the name of the resource block and also the name of the
    machine image
-   `attribute` is zero (or more) of the properties that are available
    for this resource
-   `action` identifies which steps Chef Infra Client will take to bring
    the node into the desired state

### Actions

This resource has the following actions:

`:archive`

:   Use to archive a machine image.

`:create`

:   Default. Use to create a machine image.

`:destroy`

:   Use to destroy a machine image.

`:nothing`

:   {{% resources_common_actions_nothing %}}

### Properties

This resource has the following properties:

`attributes`

:   Use to specify a hash of attributes to be applied to the machine
    image.

`chef_environment`

:   The name of the environment.

`complete`

:   Use to specify if all of the attributes specified in `attributes`
    represent a complete specification for the machine image. When true,
    any attributes not specified in `attributes` will be reset to their
    default values.

`image_options`

:   **Ruby Type:** Hash

    Use to specify options that are used with this machine image.

`name`

:   The name of the machine image.

`raw_json`

:   The machine image as JSON data. For example:

    ``` javascript
    {

    }
    ```

`recipe`

:   Use to add a recipe to the run-list for the machine image. Each
    `recipe` adds a single recipe to the run-list. The order in which
    `recipe` defines the run-list is the order in which Chef will
    execute the run-list on the machine image.

`remove_recipe`

:   Use to remove a recipe from the run-list for the machine image.

`remove_role`

:   Use to remove a role from the run-list for the machine image.

`role`

:   Use to add a role to the run-list for the machine image.

`run_list`

:   Use to specify the run-list to be applied to the machine image. See
    [About Run Lists](/run_lists/) for more information.

`tags`

:   Use to specify the list of tags to be applied to the machine image.
    Any tag not specified in this list will be removed.

### Examples

**Build a machine from a machine image**

``` ruby
machine_image 'web_image' do
  recipe 'apache2'
end

machine 'web_machine' do
 from_image 'web_image'
end
```

AWS Driver Resources
====================

A driver-specific resource is a statement of configuration policy that:

-   Describes the desired state for a configuration item that is created
    using Chef Provisioning
-   Declares the steps needed to bring that item to the desired state
-   Specifies a resource type---such as `package`, `template`, or
    `service`
-   Lists additional details (also known as properties), as necessary
-   Are grouped into recipes, which describe working configurations

The following Chef Provisioning driver-specific resources are available
for Amazon Web Services (AWS):

-   `aws_auto_scaling_group`
-   `aws_cache_cluster`
-   `aws_cache_replication_group`
-   `aws_cache_subnet_group`
-   `aws_cloudsearch_domain`
-   `aws_dhcp_options`
-   `aws_ebs_volume`
-   `aws_eip_address`
-   `aws_image`
-   `aws_instance`
-   `aws_internet_gateway`
-   `aws_key_pair`
-   `aws_launch_configuration`
-   `aws_load_balancer`
-   `aws_network_acl`
-   `aws_network_interface`
-   `aws_rds_instance`
-   `aws_rds_subnet_group`
-   `aws_route_table`
-   `aws_s3_bucket`
-   `aws_security_group`
-   `aws_server_certificate`
-   `aws_sns_topic`
-   `aws_sqs_queue`
-   `aws_subnet`
-   `aws_vpc`

For more information about these driver-specific resources, see [AWS
Driver Resources](/provisioning_aws/).

Fog Driver Resources
====================

A driver-specific resource is a statement of configuration policy that:

-   Describes the desired state for a configuration item that is created
    using Chef Provisioning
-   Declares the steps needed to bring that item to the desired state
-   Specifies a resource type---such as `package`, `template`, or
    `service`
-   Lists additional details (also known as properties), as necessary
-   Are grouped into recipes, which describe working configurations

The following Chef Provisioning driver-specific resources are available
for Fog:

-   `fog_key_pair`

For more information about these driver-specific resources, see [Fog
Driver Resources](/provisioning_fog/).
