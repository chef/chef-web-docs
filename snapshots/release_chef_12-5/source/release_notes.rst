=====================================================
Release Notes: chef-client 12.5
=====================================================

.. tag chef

Chef is a powerful automation platform that transforms infrastructure into code. Whether you’re operating in the cloud, on-premises, or in a hybrid environment, Chef automates how infrastructure is configured, deployed, and managed across your network, no matter its size.

This diagram shows how you develop, test, and deploy your Chef code.

.. image:: ../../images/start_chef.svg
   :width: 700px
   :align: center

.. end_tag

What's New
=====================================================
The following items are new for chef-client 12.5 and/or are changes from previous versions. The short version:

* **New way to build custom resources** The process for extending the collection of resources that are built into Chef has been simplified. It is defined only in the ``/resources`` directory using a simplified syntax that easily leverages the built-in collection of resources. (All of the ways you used to build custom resources still work.)
* **"resource attributes" are now known as "resource properties"** In previous releases of Chef, resource properties are referred to as attributes, but this is confusing for users because nodes also have attributes. Starting with chef-client 12.5 release---and retroactively updated for all previous releases of the documentation---"resource attributes" are now referred to as "resource properties" and the word "attribute" now refers specifically to "node attributes".
* **ps_credential helper to embed usernames and passwords** Use the ``ps_credential`` helper on Microsoft Windows to create a ``PSCredential`` object---security credentials, such as a user name or password---that can be used in the **dsc_script** resource.
* **New Handler DSL** A new DSL exists to make it easier to use events that occur during the chef-client run from recipes. The ``on`` method is easily associated with events. The action the chef-client takes as a result of that event (when it occurs) is up to you.
* **The -j / --json-attributes supports policy revisions and environments** The JSON file used by the ``--json-attributes`` option for the chef-client may now contain the policy name and policy group associated with a policy revision or may contain the name of the environment to which the node is associated.
* **verify property now uses path, not file** The ``verify`` property, used by file-based resources such as **remote_file** and **file**, runs user-defined correctness checks against the proposed new file before making the change. For versions of the chef-client prior to 12.5, the name of the temporary file was stored as ``file``; starting with chef-client 12.5, use ``path``. This change is documented as a warning across all versions in any topic in which the ``version`` attribute is documented.
* **depth property added to deploy resource** The ``depth`` property allows the depth of a git repository to be truncated to the specified number of versions.
* **The knife ssl check subcommand supports SNI** Support for Server Name Indication (SNI) is added to the ``knife ssl check`` subcommand.
* **Chef Policy group and name can now be part of the node object** Chef policy is a beta feature of the chef-client that will eventually replace roles, environments or manually specifying the run_list. Policy group and name can now be stored as part of the node object rather than in the client.rb file. A recent version of the Chef server, such as 12.2.0 or higher, is needed to fully utilize this feature.

Custom Resources
-----------------------------------------------------
.. tag custom_resources_27

.. This file is hooked into a slide deck

A custom resource:

* Is a simple extension of Chef
* Is implemented as part of a cookbook
* Follows easy, repeatable syntax patterns
* Effectively leverages resources that are built into Chef
* Is reusable in the same way as resources that are built into Chef

For example, Chef includes built-in resources to manage files, packages, templates, and services, but it does not include a resource that manages websites.

.. end_tag

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag custom_resources_syntax

A custom resource is defined as a Ruby file and is located in a cookbook's ``/resources`` directory. This file

* Declares the properties of the custom resource
* Loads current properties, if the resource already exists
* Defines each action the custom resource may take

The syntax for a custom resource is. For example:

.. code-block:: ruby

   property :name, RubyType, default: 'value'

   load_current_value do
     # some Ruby
   end

   action :name do
    # a mix of built-in Chef resources and Ruby
   end

   action :name do
    # a mix of built-in Chef resources and Ruby
   end

where the first action listed is the default action.

.. end_tag

.. tag custom_resources_syntax_example

For example, the ``site.rb`` file in the ``exampleco`` cookbook could be similar to:

.. code-block:: ruby

   property :homepage, String, default: '<h1>Hello world!</h1>'

   load_current_value do
     if ::File.exist?('/var/www/html/index.html')
       homepage IO.read('/var/www/html/index.html')
     end
   end

   action :create do
     package 'httpd'

     service 'httpd' do
       action [:enable, :start]
     end

     file '/var/www/html/index.html' do
       content homepage
     end
   end

   action :delete do
     package 'httpd' do
       action :delete
     end
   end

where

* ``homepage`` is a property that sets the default HTML for the ``index.html`` file with a default value of ``'<h1>Hello world!</h1>'``
* the (optional) ``load_current_value`` block loads the current values for all specified properties, in this example there is just a single property: ``homepage``
* the ``if`` statement checks to see if the ``index.html`` file is already present on the node. If that file is already present, its contents are loaded **instead** of the default value for ``homepage`` 
* the ``action`` block uses the built-in collection of resources to tell the chef-client how to install Apache, start the service, and then create the contents of the file located at ``/var/www/html/index.html``
* ``action :create`` is the default resource; ``action :delete`` must be called specifically (because it is not the default resource)

Once built, the custom resource may be used in a recipe just like the any of the resources that are built into Chef. The resource gets its name from the cookbook and from the file name in the ``/resources`` directory, with an underscore (``_``) separating them. For example, a cookbook named ``exampleco`` with a custom resource named ``site.rb`` is used in a recipe like this:

.. code-block:: ruby

   exampleco_site 'httpd' do
     homepage '<h1>Welcome to the Example Co. website!</h1>'
     action :create
   end

and to delete the exampleco website, do the following:

.. code-block:: ruby

   exampleco_site 'httpd' do
     action :delete
   end

.. end_tag

Custom Resource DSL
-----------------------------------------------------
.. tag dsl_custom_resource_9

Use the Custom Resource DSL to define property behaviors within custom resources, such as:

* Loading the value of a specific property
* Comparing the current property value against a desired property value
* Telling the chef-client when and how to make changes

.. end_tag

converge_if_changed
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag dsl_custom_resource_method_converge_if_changed

Use the ``converge_if_changed`` method inside an ``action`` block in a custom resource to compare the desired property values against the current property values (as loaded by the ``load_current_value`` method). Use the ``converge_if_changed`` method to ensure that updates only occur when property values on the system are not the desired property values and to otherwise prevent a resource from being converged.

To use the ``converge_if_changed`` method, wrap it around the part of a recipe or custom resource that should only be converged when the current state is not the desired state:

.. code-block:: ruby

   action :some_action do

     converge_if_changed do
       # some property
     end

   end

For example, a custom resource defines two properties (``content`` and ``path``) and a single action (``:create``). Use the ``load_current_value`` method to load the property value to be compared, and then use the ``converge_if_changed`` method to tell the chef-client what to do if that value is not the desired value:

.. code-block:: ruby

   property :content, String
   property :path, String, name_property: true

   load_current_value do
     if File.exist?(path)
       content IO.read(path)
     end
   end

   action :create do
     converge_if_changed do
       IO.write(path, content)
     end
   end

When the file does not exist, the ``IO.write(path, content)`` code is executed and the chef-client output will print something similar to:

.. code-block:: bash

   Recipe: recipe_name::block
     * resource_name[blah] action create
       - update my_file[blah]
       -   set content to "hola mundo" (was "hello world")

.. end_tag

Multiple Properties
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. tag dsl_custom_resource_method_converge_if_changed_multiple

The ``converge_if_changed`` method may be used multiple times. The following example shows how to use the ``converge_if_changed`` method to compare the multiple desired property values against the current property values (as loaded by the ``load_current_value`` method).

.. code-block:: ruby

   property :path, String, name_property: true
   property :content, String
   property :mode, String

   load_current_value do
     if File.exist?(path)
       content IO.read(path)
       mode File.stat(path).mode
     end
   end

   action :create do
     converge_if_changed :content do
       IO.write(path, content)
     end
     converge_if_changed :mode do
       File.chmod(mode, path)
     end
   end

where

* ``load_current_value`` loads the property values for both ``content`` and ``mode``
* A ``converge_if_changed`` block tests only ``content``
* A ``converge_if_changed`` block tests only ``mode``

The chef-client will only update the property values that require updates and will not make changes when the property values are already in the desired state

.. end_tag

default_action
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag dsl_custom_resource_method_default_action

The default action in a custom resource is, by default, the first action listed in the custom resource. For example, action ``aaaaa`` is the default resource:

.. code-block:: ruby

   property :name, RubyType, default: 'value'

   ...

   action :aaaaa do
    # the first action listed in the custom resource
   end

   action :bbbbb do
    # the second action listed in the custom resource
   end

The ``default_action`` method may also be used to specify the default action. For example:

.. code-block:: ruby

   property :name, RubyType, default: 'value'

   default_action :aaaaa

   action :aaaaa do
    # the first action listed in the custom resource
   end

   action :bbbbb do
    # the second action listed in the custom resource
   end

defines action ``aaaaa`` as the default action. If ``default_action :bbbbb`` is specified, then action ``bbbbb`` is the default action. Use this method for clarity in custom resources, if deliberately stating the default resource is desired, or to specify a default action that is not listed first in the custom resource.

.. end_tag

load_current_value
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag dsl_custom_resource_method_load_current_value

Use the ``load_current_value`` method to load the specified property values from the node, and then use those values when the resource is converged. This method may take a block argument.

Use the ``load_current_value`` method to guard against property values being replaced. For example:

.. code-block:: ruby

   action :some_action do

     load_current_value do
       if File.exist?('/var/www/html/index.html')
         homepage IO.read('/var/www/html/index.html')
       end
       if File.exist?('/var/www/html/404.html')
         page_not_found IO.read('/var/www/html/404.html')
       end
     end

   end

This ensures the values for ``homepage`` and ``page_not_found`` are not changed to the default values when the chef-client configures the node.

.. end_tag

new_resource.property
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag dsl_custom_resource_method_new_resource

Custom resources are designed to use core resources that are built into Chef. In some cases, it may be necessary to specify a property in the custom resource that is the same as a property in a core resource, for the purpose of overriding that property when used with the custom resource. For example:

.. code-block:: ruby

   resource_name :node_execute

   property :command, kind_of: String, name_property: true
   property :version, kind_of: String

   # Useful properties from the `execute` resource
   property :cwd, kind_of: String
   property :environment, kind_of: Hash, default: {}
   property :user, kind_of: [String, Integer]
   property :sensitive, kind_of: [TrueClass, FalseClass], default: false

   prefix = '/opt/languages/node'

   load_current_value do
     current_value_does_not_exist! if node.run_state['nodejs'].nil?
     version node.run_state['nodejs'][:version]
   end

   action :run do
     execute 'execute-node' do
       cwd cwd
       environment environment
       user user
       sensitive sensitive
       # gsub replaces 10+ spaces at the beginning of the line with nothing
       command <<-CODE.gsub(/^ {10}/, '')
         #{prefix}/#{version}/#{command}
       CODE
     end
   end

where the ``property :cwd``, ``property :environment``, ``property :user``, and ``property :sensitive`` are identical to properties in the **execute** resource, embedded as part of the ``action :run`` action. Because both the custom properties and the **execute** properties are identical, this will result in an error message similar to:

.. code-block:: ruby

   ArgumentError
   -------------
   wrong number of arguments (0 for 1)

To prevent this behavior, use ``new_resource.`` to tell the chef-client to process the properties from the core resource instead of the properties in the custom resource. For example:

.. code-block:: ruby

   resource_name :node_execute

   property :command, kind_of: String, name_property: true
   property :version, kind_of: String

   # Useful properties from the `execute` resource
   property :cwd, kind_of: String
   property :environment, kind_of: Hash, default: {}
   property :user, kind_of: [String, Integer]
   property :sensitive, kind_of: [TrueClass, FalseClass], default: false

   prefix = '/opt/languages/node'

   load_current_value do
     current_value_does_not_exist! if node.run_state['nodejs'].nil?
     version node.run_state['nodejs'][:version]
   end

   action :run do
     execute 'execute-node' do
       cwd new_resource.cwd
       environment new_resource.environment
       user new_resource.user
       sensitive new_resource.sensitive
       # gsub replaces 10+ spaces at the beginning of the line with nothing
       command <<-CODE.gsub(/^ {10}/, '')
         #{prefix}/#{new_resource.version}/#{new_resource.command}
       CODE
     end
   end

where ``cwd new_resource.cwd``, ``environment new_resource.environment``, ``user new_resource.user``, and ``sensitive new_resource.sensitive`` correctly use the properties of the **execute** resource and not the identically-named override properties of the custom resource.

.. end_tag

property
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag dsl_custom_resource_method_property

Use the ``property`` method to define properties for the custom resource. The syntax is:

.. code-block:: ruby

   property :name, ruby_type, default: 'value', parameter: 'values'

where

* ``:name`` is the name of the property
* ``ruby_type`` is the optional Ruby type, such as ``String``, ``Integer``, ``TrueClass``, or ``FalseClass``
* ``default: 'value'`` is the optional default value loaded into the resource
* ``parameter: 'values'`` are optional validation parameters and values

For example, the following properties define ``username`` and ``password`` properties with no default values specified:

.. code-block:: ruby

   property :username, String
   property :password, String

.. end_tag

desired_state
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. tag dsl_custom_resource_method_property_desired_state

Add ``desired_state:`` to get or set the list of desired state properties for a resource, which describe the desired state of the node, such as permissions on an existing file. This value may be ``true`` or ``false``.

* When ``true``, the state of the system will determine the value.
* When ``false``, the values defined by the recipe or custom resource will determine the value, i.e. "the desired state of this system includes setting the value defined in this custom resource or recipe"

For example, the following properties define the ``owner``, ``group``, and ``mode`` properties for a file that already exists on the node, and with ``desired_state`` set to ``false``:

.. code-block:: ruby

   property :owner, String, default: 'root', desired_state: false
   property :group, String, default: 'root', desired_state: false
   property :mode, String, default: '0755', desired_state: false

.. end_tag

identity
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. tag dsl_custom_resource_method_property_identity

Add ``identity:`` to set a resource to a particular set of properties. This value may be ``true`` or ``false``.

* When ``true``, data for that property is returned as part of the resource data set and may be available to external applications, such as reporting
* When ``false``, no data for that property is returned.

If no properties are marked ``true``, the property that defaults to the ``name`` of the resource is marked ``true``.

For example, the following properties define ``username`` and ``password`` properties with no default values specified, but with ``identity`` set to ``true`` for the user name:

.. code-block:: ruby

   property :username, String, identity: true
   property :password, String

.. end_tag

Block Arguments
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. tag dsl_custom_resource_method_property_block_argument

Any properties that are marked ``identity: true`` or ``desired_state: false`` will be available from ``load_current_value``. If access to other properties of a resource is needed, use a block argument that contains all of the properties of the requested resource. For example:

.. code-block:: ruby

   resource_name :file

   load_current_value do |desired|
     puts "The user typed content = #{desired.content} in the resource"
   end

.. end_tag

property_is_set?
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag dsl_custom_resource_method_property_is_set

Use the ``property_is_set?`` method to check if the value for a property is set. The syntax is:

.. code-block:: ruby

   property_is_set?(:property_name)

The ``property_is_set?`` method will return ``true`` if the property is set.

For example, the following custom resource creates and/or updates user properties, but not their password. The ``property_is_set?`` method checks if the user has specified a password and then tells the chef-client what to do if the password is not identical:

.. code-block:: ruby

   action :create do
     converge_if_changed do
       system("rabbitmqctl create_or_update_user #{username} --prop1 #{prop1} ... ")
     end

     if property_is_set?(:password)
       if system("rabbitmqctl authenticate_user #{username} #{password}") != 0 do
         converge_by "Updating password for user #{username} ..." do
       system("rabbitmqctl update_user #{username} --password #{password}")
     end
   end

.. end_tag

provides
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag dsl_custom_resource_method_provides

Use the ``provides`` method to associate a custom resource with the Recipe DSL on different operating systems. When multiple custom resources use the same DSL, specificity rules are applied to determine the priority, from highest to lowest:

#. provides :resource_name, platform_version: ‘0.1.2’
#. provides :resource_name, platform: ‘platform_name’
#. provides :resource_name, platform_family: ‘platform_family’
#. provides :resource_name, os: ‘operating_system’
#. provides :resource_name

For example:

.. code-block:: ruby

    provides :my_custom_resource, platform: 'redhat' do |node|
      node['platform_version'].to_i >= 7
    end

    provides :my_custom_resource, platform: 'redhat'

    provides :my_custom_resource, platform_family: 'rhel'

    provides :my_custom_resource, os: 'linux'

    provides :my_custom_resource

This allows you to use multiple custom resources files that provide the same resource to the user, but for different operating systems or operation system versions. With this you can eliminate the need for platform or platform version logic within your resources.

.. end_tag

override
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. tag dsl_custom_resource_method_provides_override

Chef will warn you if the Recipe DSL is provided by another custom resource or built-in resource. For example:

.. code-block:: ruby

   class X < Chef::Resource
     provides :file
   end

   class Y < Chef::Resource
     provides :file
   end

This will emit a warning that ``Y`` is overriding ``X``. To disable this warning, use ``override: true``:

.. code-block:: ruby

   class X < Chef::Resource
     provides :file
   end

   class Y < Chef::Resource
     provides :file, override: true
   end

.. end_tag

reset_property
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag dsl_custom_resource_method_reset_property

Use the ``reset_property`` method to clear the value for a property as if it had never been set, and then use the default value. For example, to clear the value for a property named ``password``:

.. code-block:: ruby

   reset_property(:password)

.. end_tag

Definition vs. Resource
-----------------------------------------------------
.. tag definition_example

The following examples show:

#. A definition
#. The same definition rewritten as a custom resource
#. The same definition, rewritten again to use a :doc:`common resource property </resource_common>`

.. end_tag

As a Definition
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag definition_example_as_definition

The following definition processes unique hostnames and ports, passed on as parameters:

.. code-block:: ruby

   define :host_porter, :port => 4000, :hostname => nil do
     params[:hostname] ||= params[:name]

     directory '/etc/#{params[:hostname]}' do
       recursive true
     end

     file '/etc/#{params[:hostname]}/#{params[:port]}' do
       content 'some content'
     end
   end

.. end_tag

As a Resource
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag definition_example_as_resource

The definition is improved by rewriting it as a custom resource:

.. code-block:: ruby

   property :port, Integer, default: 4000
   property :hostname, String, name_property: true

   action :create do

     directory "/etc/#{hostname}" do
       recursive true
     end

     file "/etc/#{hostname}/#{port}" do
       content 'some content'
     end

   end

Once built, the custom resource may be used in a recipe just like the any of the resources that are built into Chef. The resource gets its name from the cookbook and from the file name in the ``/resources`` directory, with an underscore (``_``) separating them. For example, a cookbook named ``host`` with a custom resource in the ``/resources`` directory named ``porter.rb``. Use it in a recipe like this:

.. code-block:: ruby

   host_porter node['hostname'] do
     port 4000
   end

or:

.. code-block:: ruby

   host_porter 'www1' do
     port 4001
   end

.. end_tag

Common Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag definition_example_as_resource_with_common_properties

Unlike definitions, custom resources are able to use :doc:`common resource properties </resource_common>`. For example, ``only_if``:

.. code-block:: ruby

   host_porter 'www1' do
     port 4001
     only_if '{ node['hostname'] == 'foo.bar.com' }'
   end

.. end_tag

ps_credential Helper
-----------------------------------------------------
.. tag resource_dsc_script_helper_ps_credential

Use the ``ps_credential`` helper to embed a ``PSCredential`` object---`a set of security credentials, such as a user name or password <https://technet.microsoft.com/en-us/magazine/ff714574.aspx>`__---within a script, which allows that script to be run using security credentials.

For example, assuming the ``CertificateID`` is configured in the local configuration manager, the ``SeaPower1@3`` object is created and embedded within the ``seapower-user`` script:

.. code-block:: ruby

   dsc_script 'seapower-user' do
     code <<-EOH
       User AlbertAtom
       {
         UserName = 'AlbertAtom'
         Password = #{ps_credential('SeaPower1@3')}
       }
    EOH
    configuration_data <<-EOH
      @{
        AllNodes = @(
          @{
            NodeName = "localhost";
            CertificateID = 'A8D1234559F349F7EF19104678908F701D4167'
          }
        )
      }
    EOH
  end

.. end_tag

Handler DSL
-----------------------------------------------------
.. tag dsl_handler_9

Use the Handler DSL to attach a callback to an event. If the event occurs during the chef-client run, the associated callback is executed. For example:

* Sending email if a chef-client run fails
* Sending a notification to chat application if an audit run fails
* Aggregating statistics about resources updated during a chef-client runs to StatsD

.. end_tag

on Method
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag dsl_handler_method_on

Use the ``on`` method to associate an event type with a callback. The callback defines what steps are taken if the event occurs during the chef-client run and is defined using arbitrary Ruby code. The syntax is as follows:

.. code-block:: ruby

   Chef.event_handler do
     on :event_type do
       # some Ruby
     end
   end

where

* ``Chef.event_handler`` declares a block of code within a recipe that is processed when the named event occurs during a chef-client run
* ``on`` defines the block of code that will tell the chef-client how to handle the event
* ``:event_type`` is a valid exception event type, such as ``:run_start``, ``:run_failed``, ``:converge_failed``, ``:resource_failed``, or ``:recipe_not_found``

For example:

.. code-block:: bash

   Chef.event_handler do
     on :converge_start do
       puts "Ohai! I have started a converge."
     end
   end

.. end_tag

Example: Send Email
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag dsl_handler_slide_send_email

Use the ``on`` method to create an event handler that sends email when the chef-client run fails. This will require:

* A way to tell the chef-client how to send email
* An event handler that describes what to do when the ``:run_failed`` event is triggered
* A way to trigger the exception and test the behavior of the event handler

.. end_tag

.. note:: See :doc:`dsl_handler` for more information about using event handlers in recipes.

**Define How Email is Sent**

.. tag dsl_handler_slide_send_email_library

Use a library to define the code that sends email when a chef-client run fails. Name the file ``helper.rb`` and add it to a cookbook's ``/libraries`` directory:

.. code-block:: ruby

   require 'net/smtp'

   module HandlerSendEmail
     class Helper

       def send_email_on_run_failure(node_name)

         message = "From: Chef <chef@chef.io>\n"
         message << "To: Grant <grantmc@chef.io>\n"
         message << "Subject: Chef run failed\n"
         message << "Date: #{Time.now.rfc2822}\n\n"
         message << "Chef run failed on #{node_name}\n"
         Net::SMTP.start('localhost', 25) do |smtp|
           smtp.send_message message, 'chef@chef.io', 'grantmc@chef.io'
         end    
       end
     end
   end

.. end_tag

**Add the Handler**

.. tag dsl_handler_slide_send_email_handler

Invoke the library helper in a recipe:

.. code-block:: ruby

   Chef.event_handler do
     on :run_failed do
       HandlerSendEmail::Helper.new.send_email_on_run_failure(
         Chef.run_context.node.name
       )
     end
   end

* Use ``Chef.event_handler`` to define the event handler
* Use the ``on`` method to specify the event type

Within the ``on`` block, tell the chef-client how to handle the event when it's triggered.

.. end_tag

**Test the Handler**

.. tag dsl_handler_slide_send_email_test

Use the following code block to trigger the exception and have the chef-client send email to the specified email address:

.. code-block:: ruby

   ruby_block 'fail the run' do
     block do
       fail 'deliberately fail the run'
     end
   end

.. end_tag

New Resource Properties
-----------------------------------------------------
The following property is new for the **deploy** resource:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Property
     - Description
   * - ``depth``
     - **Ruby Type:** Integer

       The depth of a git repository, truncated to the specified number of revisions.

Specify Policy Revision
-----------------------------------------------------
Use the following command to specify a policy revision:

.. code-block:: bash

   $ chef client -j JSON

where the JSON file is similar to:

.. code-block:: javascript

   {
     "policy_name": "appserver",
     "policy_group": "staging"
   }

Or use the following settings to specify a policy revision in the client.rb file:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``policy_group``
     - The name of a policy, as identified by the ``name`` setting in a Policyfile.rb file.
   * - ``policy_name``
     - The name of a policy group that exists on the Chef server.

New Configuration Settings
-----------------------------------------------------
The following settings are new for the client.rb file and enable the use of policy files:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``named_run_list``
     - The run-list associated with a policy file.
   * - ``policy_group``
     - The name of a policy, as identified by the ``name`` setting in a Policyfile.rb file. (See "Specify Policy Revision" in this readme for more information.)
   * - ``policy_name``
     - The name of a policy group that exists on the Chef server. (See "Specify Policy Revision" in this readme for more information.)

chef-client Options
-----------------------------------------------------
The following options are new or updated for the chef-client executable and enable the use of policy files:

``-n NAME``, ``--named-run-list NAME``
   The run-list associated with a policy file.

``-j PATH``, ``--json-attributes PATH``
   This option now supports using a JSON file to associate a policy revision.

   .. tag policy_ctl_run_list

   .. This file documents specifc behavior related to the -j option in the chef-client, chef-solo, and chef-shell executables.

   Use this option to use policy files by specifying a JSON file that contains the following settings:

   .. list-table::
      :widths: 200 300
      :header-rows: 1

      * - Setting
        - Description
      * - ``policy_group``
        - The name of a policy, as identified by the ``name`` setting in a Policyfile.rb file.
      * - ``policy_name``
        - The name of a policy group that exists on the Chef server.

   For example:

   .. code-block:: javascript

      {
        "policy_name": "appserver",
        "policy_group": "staging"
      }

   .. end_tag

   This option also supports using a JSON file to associate an environment:

   .. tag ctl_chef_client_environment

   Use this option to set the ``chef_environment`` value for a node.

   .. note:: Any environment specified for ``chef_environment`` by a JSON file will take precedence over an environment specified by the ``--environment`` option when both options are part of the same command.

   For example, run the following:

   .. code-block:: bash

      $ chef-client -j /path/to/file.json

   where ``/path/to/file.json`` is similar to:

   .. code-block:: javascript

      {
        "chef_environment": "pre-production"
      }

   This will set the environment for the node to ``pre-production``.

   .. end_tag

Changelog
=====================================================
https://github.com/chef/chef/blob/master/CHANGELOG.md
