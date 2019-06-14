=====================================================
Authentication, Authorization
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/auth.rst>`__

.. tag chef_auth

All communication with the Chef Infra Server must be authenticated using the Chef Infra Server API, which is a REST API that allows requests to be made to the Chef Infra Server. Only authenticated requests will be authorized. Most of the time, and especially when using knife, the Chef Infra Client, or the Chef Infra Server web interface, the use of the Chef Infra Server API is transparent. In some cases, the use of the Chef Infra Server API requires more detail, such as when making the request in Ruby code, with a knife plugin, or when using cURL.

.. end_tag

Authentication
=====================================================
.. tag chef_auth_authentication

The authentication process ensures the Chef Infra Server responds only to requests made by trusted users. Public key encryption is used by the Chef Infra Server. When a node and/or a workstation is configured to run the Chef Infra Client, both public and private keys are created. The public key is stored on the Chef Infra Server, while the private key is returned to the user for safe keeping. (The private key is a .pem file located in the ``.chef`` directory or in ``/etc/chef``.)

Both the Chef Infra Client and knife use the Chef Infra Server API when communicating with the Chef Infra Server. The chef-validator uses the Chef Infra Server API, but only during the first Chef Infra Client run on a node.

Each request to the Chef Infra Server from those executables sign a special group of HTTP headers with the private key. The Chef Infra Server then uses the public key to verify the headers and verify the contents.

.. end_tag

chef-validator
-----------------------------------------------------
.. tag security_chef_validator

Every request made by the Chef Infra Client to the Chef Infra Server must be an authenticated request using the Chef Infra Server API and a private key. When the Chef Infra Client makes a request to the Chef Infra Server, the Chef Infra Client authenticates each request using a private key located in ``/etc/chef/client.pem``.

.. end_tag

.. tag security_chef_validator_context

However, during the first Chef Infra Client run, this private key does not exist. Instead, the Chef Infra Client will attempt to use the private key assigned to the chef-validator, located in ``/etc/chef/validation.pem``. (If, for any reason, the chef-validator is unable to make an authenticated request to the Chef Infra Server, the initial Chef Infra Client run will fail.)

During the initial Chef Infra Client run, the Chef Infra Client will register with the Chef Infra Server using the private key assigned to the chef-validator, after which the Chef Infra Client will obtain a ``client.pem`` private key for all future authentication requests to the Chef Infra Server.

After the initial Chef Infra Client run has completed successfully, the chef-validator is no longer required and may be deleted from the node. Use the ``delete_validation`` recipe found in the ``chef-client`` cookbook (https://github.com/chef-cookbooks/chef-client) to remove the chef-validator.

.. end_tag

During a Chef Infra Client Run
-----------------------------------------------------
.. tag security_key_pairs_chef_client

RSA public key-pairs are used to authenticate the Chef Infra Client with the Chef Infra Server every time a Chef Infra Client needs access to data that is stored on the Chef Infra Server. This prevents any node from accessing data that it shouldn't and it ensures that only nodes that are properly registered with the Chef Infra Server can be managed.

.. end_tag

Knife
-----------------------------------------------------
.. tag security_key_pairs_knife

RSA public key-pairs are used to authenticate knife with the Chef Infra Server every time knife attempts to access the Chef Infra Server. This ensures that each instance of knife is properly registered with the Chef Infra Server and that only trusted users can make changes to the data.

.. end_tag

knife can also use the ``knife exec`` subcommand to make specific, authenticated requests to the Chef Infra Server. knife plugins can also make authenticated requests to the Chef Infra Server by leveraging the ``knife exec`` subcommand.

API Requests
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag plugin_knife_summary

A knife plugin is a set of one (or more) subcommands that can be added to knife to support additional functionality that is not built-in to the base set of knife subcommands. Many of the knife plugins are built by members of the Chef community and several of them are built and maintained by Chef.

.. end_tag

.. tag plugin_knife_using_authenticated_requests

A knife plugin can be used to make authenticated API requests to the Chef Infra Server using the following methods:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Method
     - Description
   * - ``rest.delete_rest``
     - Use to delete an object from the Chef Infra Server.
   * - ``rest.get_rest``
     - Use to get the details of an object on the Chef Infra Server.
   * - ``rest.post_rest``
     - Use to add an object to the Chef Infra Server.
   * - ``rest.put_rest``
     - Use to update an object on the Chef Infra Server.

For example:

.. code-block:: ruby

   module MyCommands
     class MyNodeDelete < Chef::Knife
       #An implementation of knife node delete
       banner 'knife my node delete [NODE_NAME]'

       def run
         if name_args.length < 1
           show_usage
           ui.fatal("You must specify a node name.")
           exit 1
         end
         nodename = name_args[0]
         api_endpoint = "nodes/#{nodename}"
         # Again, we could just call rest.delete_rest
         nodey = rest.get_rest(api_endpoint)
         ui.confirm("Do you really want to delete #{nodey}")
         nodey.destroy
       end
     end
   end

.. end_tag

From the Web Interface
-----------------------------------------------------
The Chef Infra Server user interface uses the Chef Infra Server API to perform most operations. This ensures that authentication requests to the Chef Infra Server are authorized. This authentication process is handled automatically and is not something that users of the hosted Chef Infra Server will need to manage. For the on-premises Chef Infra Server, the authentication keys used by the web interface will need to be maintained by the individual administrators who are responsible for managing the server.

Other Options
-----------------------------------------------------
The most common ways to interact with the Chef Infra Server using the Chef Infra Server API abstract the API from the user. That said, the Chef Infra Server API can be interacted with directly. The following sections describe a few of the ways that are available for doing that.

cURL
+++++++++++++++++++++++++++++++++++++++++++++++++++++
An API request can be made using cURL, which is a Bash shell script that requires two utilities: awk and openssl. The following example shows how an authenticated request can be made using the Chef Infra Server API and cURL:

.. code-block:: bash

   #!/usr/bin/env bash

   _chef_dir () {
     # Helper function:
     # Recursive function that searches for chef configuration directory
     # It looks upward from the cwd until it hits /.  If no directory is found,
     # ~/.chef is chosen if it exists
     # You could simply hard-code the path below

     if [ "$PWD" = "/" ]; then
     if [ -d ".chef" ]; then
       echo "/.chef"
         elif [ -d "$HOME/.chef" ]; then
           echo "$HOME/.chef"
         fi
       return
     fi

     if [ -d '.chef' ];then
       echo "${PWD}/.chef"
     else
       (cd ..; _chef_dir)
     fi
   }

   _chomp () {
     # helper function to remove newlines
     awk '{printf "%s", $0}'
   }

   chef_api_request() {
     # This is the meat-and-potatoes, or rice-and-vegetables, your preference really.

     local method path body timestamp chef_server_url client_name hashed_body hashed_path
     local canonical_request headers auth_headers

     chef_server_url="https://api.opscode.com/organizations/my_org"
     # '/organizations/ORG_NAME' is needed
     if echo $chef_server_url | grep -q "/organizations/" ; then
       endpoint=/organizations/${chef_server_url#*/organizations/}${2%%\?*}
     else
       endpoint=${2%%\?*}
     fi
     path=${chef_server_url}$2
     client_name="chef_user"
     method=$1
     body=$3

     hashed_path=$(echo -n "$endpoint" | openssl dgst -sha1 -binary | openssl enc -base64)
     hashed_body=$(echo -n "$body" | openssl dgst -sha1 -binary | openssl enc -base64)
     timestamp=$(date -u "+%Y-%m-%dT%H:%M:%SZ")

     canonical_request="Method:$method\nHashed Path:$hashed_path\nX-Ops-Content-Hash:$hashed_body\nX-Ops-Timestamp:$timestamp\nX-Ops-UserId:$client_name"
     headers="-H X-Ops-Timestamp:$timestamp \
       -H X-Ops-Userid:$client_name \
       -H X-Chef-Version:0.10.4 \
       -H Accept:application/json \
       -H X-Ops-Content-Hash:$hashed_body \
       -H X-Ops-Sign:version=1.0"

     auth_headers=$(printf "$canonical_request" | openssl rsautl -sign -inkey \
       "$(_chef_dir)/${client_name}.pem" | openssl enc -base64 | _chomp |  awk '{ll=int(length/60);i=0; \
       while (i<=ll) {printf " -H X-Ops-Authorization-%s:%s", i+1, substr($0,i*60+1,60);i=i+1}}')

     case $method in
       GET)
         curl_command="curl $headers $auth_headers $path"
         $curl_command
         ;;
       *)
         echo "Unknown Method. I only know: GET" >&2
         return 1
         ;;
       esac
     }

    chef_api_request "$@"

After saving this shell script to a file named ``chef_api_request``, use it similar to the following:

.. code-block:: bash

   $ bash chef_api_request GET "/clients"

PyChef
+++++++++++++++++++++++++++++++++++++++++++++++++++++
An API request can be made using PyChef, which is a Python library that meets the ``Mixlib::Authentication`` requirements so that it can easily interact with the Chef Infra Server. The following example shows how an authenticated request can be made using the Chef Infra Server API and PyChef:

.. code-block:: python

   from chef import autoconfigure, Node

   api = autoconfigure()
   n = Node('web1')
   print n['fqdn']
   n['myapp']['version'] = '1.0'
   n.save()

and the following example shows how to make API calls directly:

.. code-block:: python

   from chef import autoconfigure

   api = autoconfigure()
   print api.api_request('GET', '/clients')

The previous examples assume that the current working directory is such that PyChef can find a valid configuration file in the same manner as the Chef Infra Client or knife. For more about PyChef, see: https://github.com/coderanger/pychef.

Ruby
+++++++++++++++++++++++++++++++++++++++++++++++++++++
On a system with the Chef Infra Client installed, use Ruby to make an authenticated request to the Chef Infra Server:

.. code-block:: ruby

   require 'chef/config'
   require 'chef/log'
   require 'chef/rest'

   chef_server_url = 'https://chefserver.com'
   client_name = 'clientname'
   signing_key_filename = '/path/to/pem/for/clientname'

   rest = Chef::REST.new(chef_server_url, client_name, signing_key_filename)
   puts rest.get_rest('/clients')

or:

.. code-block:: ruby

   require 'mixlib/cli'
   require 'chef'
   require 'chef/node'
   require 'chef/mixin/xml_escape'
   require 'json'

   config_file = 'c:/chef/client.rb'
   Chef::Config.from_file(config_file)
   Chef::Log.level = Chef::Config[:log_level]

   def Usage()
     puts '/etc/chef/client.rb' # The config file location, e.g. ~/home/.chef/config.rb etc
     config_file = gets.chomp
     if (!File.exist?(config_file))
       puts 'config_file #{config_file} does not exist. Exiting.\n'
       exit
     end
     STDOUT.puts <<-EOF
       Choose options e.g. 1

       1 Display all nodes per environment
       2 Display all nodes in detail (can be slow if there a large number of nodes)
       9 Exit
     EOF
   end

   def ExecuteUserChoice()
     testoption = gets.chomp
     case testoption
     when '1'
       Execute(method(:DisplayNodesPerEnv))
     when '2'
       Execute(method(:DisplayNodesDetail))
     when '9'
       puts 'exit'
     else
       puts 'Unknown option #{testoption}. Exiting\n'
       exit
     end
   end

   def DisplayNodesPerEnv()
     Chef::Environment.list(false).each do |envr|
       print 'ENVIRONMENT: ', envr[0], '\n'
       Chef::Node.list_by_environment(envr[0], false).each do |node_info|
         print '\tNODE: ', node_info[0], '\n'
         print '\t\tURL: ', node_info[1], '\n'
       end
     end
   end

   def DisplayNodesDetail()
     Chef::Node.list(true).each do |node_array|
       node = node_array[1]
       print '#{node.name}\n'
       print '\t#{node[:fqdn]}\n'
       print '\t#{node[:kernel][:machine]}\n'
       print '\t#{node[:kernel][:os]}\n'
       print '\t#{node[:platform]}\n'
       print '\t#{node[:platform_version]}\n'
       print '\t#{node.chef_environment}\n'
       print '\t#{node.run_list.roles}\n'
     end
   end

   def Execute(option)
     begin
       profilestart = Time.now
       option.call()
       profileend = Time.now
       timeofrun = profileend - profilestart
       print 'Time taken = #{timeofrun}'
     rescue Exception => ex
       print 'Error calling chef API'
       print ex.message
       print ex.backtrace.join('\n')
     end
   end

   Usage()
   ExecuteUserChoice()

Another way Ruby can be used with the Chef Infra Server API is to get objects from the Chef Infra Server, and then interact with the returned data using Ruby methods. Whenever possible, the Chef Infra Server API will return an object of the relevant type. The returned object is then available to be called by other methods. For example, the ``api.get`` method can be used to return a node named ``foobar``, and then ``.destroy`` can be used to delete that node:

.. code-block:: none

   silly_node = api.get('/nodes/foobar')
   silly_node.destroy

Debug Authentication Issues
-----------------------------------------------------
In some cases, the Chef Infra Client may receive a 401 response to the authentication request and a 403 response to an authorization request. An authentication error error may look like the following:

.. code-block:: bash

   [Wed, 05 Oct 2011 15:43:34 -0700] INFO: HTTP Request Returned 401
   Unauthorized: Failed to authenticate as node_name. Ensure that your node_name and client key are correct.

To debug authentication problems, determine which Chef Infra Client is attempting to authenticate. This is often found in the log messages for that Chef Infra Client. Debug logging can be enabled on a Chef Infra Client using the following command:

   .. code-block:: bash

      $ chef-client -l debug

   When debug logging is enabled, a log entry will look like the following:

   .. code-block:: bash

      [Wed, 05 Oct 2011 22:05:35 +0000] DEBUG: Signing the request as NODE_NAME

If the authentication request occurs during the initial Chef Infra Client run, the issue is most likely with the private key.

If the authentication is happening on the node, there are a number of common causes:

* The ``client.pem`` file is incorrect. This can be fixed by deleting the ``client.pem`` file and re-running the Chef Infra Client. When the Chef Infra Client re-runs, it will re-attempt to register with the Chef Infra Server and generate the correct key.
* A ``node_name`` is different from the one used during the initial Chef Infra Client run. This can happen for a number of reasons. For example, if the client.rb file does not specify the correct node name and the host name has recently changed. This issue can be resolved by explicitly setting the node name in the client.rb file or by using the ``-N`` option for the Chef Infra Client executable.
* The system clock has drifted from the actual time by more than 15 minutes. This can be fixed by syncing the clock with an Network Time Protocol (NTP) server.

Authorization
=====================================================
The Chef Infra Server uses a role-based access control (RBAC) model to ensure that users may only perform authorized actions.

Chef Server
-----------------------------------------------------
.. tag server_rbac

The Chef Infra Server uses role-based access control (RBAC) to restrict access to objects---nodes, environments, roles, data bags, cookbooks, and so on. This ensures that only authorized user and/or Chef Infra Client requests to the Chef Infra Server are allowed. Access to objects on the Chef Infra Server is fine-grained, allowing access to be defined by object type, object, group, user, and organization. The Chef Infra Server uses permissions to define how a user may interact with an object, after they have been authorized to do so.

.. end_tag

.. tag server_rbac_components

The Chef Infra Server uses organizations, groups, and users to define role-based access control:

.. list-table::
   :widths: 100 420
   :header-rows: 1

   * - Feature
     - Description
   * - .. image:: ../../images/icon_server_organization.svg
          :width: 100px
          :align: center

     - An organization is the top-level entity for role-based access control in the Chef Infra Server. Each organization contains the default groups (``admins``, ``clients``, and ``users``, plus ``billing_admins`` for the hosted Chef Infra Server), at least one user and at least one node (on which the Chef Infra Client is installed). The Chef Infra Server supports multiple organizations. The Chef Infra Server includes a single default organization that is defined during setup. Additional organizations can be created after the initial setup and configuration of the Chef Infra Server.
   * - .. image:: ../../images/icon_server_groups.svg
          :width: 100px
          :align: center

     - .. tag server_rbac_groups

       A group is used to define access to object types and objects in the Chef Infra Server and also to assign permissions that determine what types of tasks are available to members of that group who are authorized to perform them. Groups are configured per-organization.

       Individual users who are members of a group will inherit the permissions assigned to the group. The Chef Infra Server includes the following default groups: ``admins``, ``clients``, and ``users``. For users of the hosted Chef Infra Server, an additional default group is provided: ``billing_admins``.

       .. end_tag

   * - .. image:: ../../images/icon_server_users.svg
          :width: 100px
          :align: center

     - A user is any non-administrator human being who will manage data that is uploaded to the Chef Infra Server from a workstation or who will log on to the Chef management console web user interface. The Chef Infra Server includes a single default user that is defined during setup and is automatically assigned to the ``admins`` group.
   * - .. image:: ../../images/icon_chef_client.svg
          :width: 100px
          :align: center

     - .. tag server_rbac_clients

       A client is an actor that has permission to access the Chef Infra Server. A client is most often a node (on which the Chef Infra Client runs), but is also a workstation (on which knife runs), or some other machine that is configured to use the Chef Infra Server API. Each request to the Chef Infra Server that is made by a client uses a private key for authentication that must be authorized by the public key on the Chef Infra Server.

       .. end_tag

.. end_tag

.. tag server_rbac_workflow

When a user makes a request to the Chef Infra Server using the Chef Infra Server API, permission to perform that action is determined by the following process:

#. Check if the user has permission to the object type
#. If no, recursively check if the user is a member of a security group that has permission to that object
#. If yes, allow the user to perform the action

Permissions are managed using the Chef management console add-on in the Chef Infra Server web user interface.

.. end_tag

Object Permissions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag server_rbac_permissions_object

The Chef Infra Server includes the following object permissions:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Permission
     - Description
   * - **Delete**
     - Use the **Delete** permission to define which users and groups may delete an object. This permission is required for any user who uses the ``knife [object] delete [object_name]`` argument to interact with objects on the Chef Infra Server.
   * - **Grant**
     - Use the **Grant** permission to define which users and groups may configure permissions on an object. This permission is required for any user who configures permissions using the **Administration** tab in the Chef management console.
   * - **Read**
     - Use the **Read** permission to define which users and groups may view the details of an object. This permission is required for any user who uses the ``knife [object] show [object_name]`` argument to interact with objects on the Chef Infra Server.
   * - **Update**
     - Use the **Update** permission to define which users and groups may edit the details of an object. This permission is required for any user who uses the ``knife [object] edit [object_name]`` argument to interact with objects on the Chef Infra Server and for any Chef Infra Client to save node data to the Chef Infra Server at the conclusion of a Chef Infra Client run.

.. end_tag

Global Permissions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag server_rbac_permissions_global

The Chef Infra Server includes the following global permissions:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Permission
     - Description
   * - **Create**
     - Use the **Create** global permission to define which users and groups may create the following server object types: cookbooks, data bags, environments, nodes, roles, and tags. This permission is required for any user who uses the ``knife [object] create`` argument to interact with objects on the Chef Infra Server.
   * - **List**
     - Use the **List** global permission to define which users and groups may view the following server object types: cookbooks, data bags, environments, nodes, roles, and tags. This permission is required for any user who uses the ``knife [object] list`` argument to interact with objects on the Chef Infra Server.

These permissions set the default permissions for the following Chef Infra Server object types: clients, cookbooks, data bags, environments, groups, nodes, roles, and sandboxes.

.. end_tag

Client Key Permissions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. note:: This is only necessary after migrating a client from one Chef Infra Server to another. Permissions must be reset for client keys after the migration.

.. tag server_rbac_clients

A client is an actor that has permission to access the Chef Infra Server. A client is most often a node (on which the Chef Infra Client runs), but is also a workstation (on which knife runs), or some other machine that is configured to use the Chef Infra Server API. Each request to the Chef Infra Server that is made by a client uses a private key for authentication that must be authorized by the public key on the Chef Infra Server.

.. end_tag

.. tag server_rbac_permissions_key

Keys should have ``DELETE``, ``GRANT``, ``READ`` and ``UPDATE`` permissions.

Use the following code to set the correct permissions:

.. code-block:: ruby

   #!/usr/bin/env ruby
   require 'chef/knife'

   #previously knife.rb
   Chef::Config.from_file(File.join(Chef::Knife.chef_config_dir, 'knife.rb'))

   rest = Chef::ServerAPI.new(Chef::Config[:chef_server_url])

   Chef::Node.list.each do |node|
     %w{read update delete grant}.each do |perm|
       ace = rest.get("nodes/#{node[0]}/_acl")[perm]
       ace['actors'] << node[0] unless ace['actors'].include?(node[0])
       rest.put("nodes/#{node[0]}/_acl/#{perm}", perm => ace)
       puts "Client \"#{node[0]}\" granted \"#{perm}\" access on node \"#{node[0]}\""
     end
   end

Save it as a Ruby script---``chef_server_permissions.rb``, for example---in the ``.chef/scripts`` directory located in the chef-repo, and then run a knife command similar to:

.. code-block:: bash

   $ knife exec chef_server_permissions.rb

.. end_tag

Default Groups
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The Chef Infra Server includes the following default groups:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Group
     - Description
   * - ``admins``
     - The ``admins`` group defines the list of users who have administrative rights to all objects and object types for a single organization.
   * - ``billing_admins``
     - The ``billing_admins`` group defines the list of users who have permission to manage billing information. This permission exists only for the hosted Chef Infra Server.
   * - ``clients``
     - The ``clients`` group defines the list of nodes on which a Chef Infra Client is installed and under management by Chef. In general, think of this permission as "all of the non-human actors---the Chef Infra Client, in nearly every case---that get data from, and/or upload data to, the Chef server". Newly-created Chef Infra Client instances are added to this group automatically.
   * - ``public_key_read_access``
     - The ``public_key_read_access`` group defines which users and clients have read permissions to key-related endpoints in the Chef Infra Server API.
   * - ``users``
     - The ``users`` group defines the list of users who use knife and the Chef management console to interact with objects and object types. In general, think of this permission as "all of the non-admin human actors who work with data that is uploaded to and/or downloaded from the Chef server".

Multiple Organizations
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag server_rbac_orgs_multi

A single instance of the Chef Infra Server can support many organizations. Each organization has a unique set of groups and users. Each organization manages a unique set of nodes, on which a Chef Infra Client is installed and configured so that it may interact with a single organization on the Chef Infra Server.

.. image:: ../../images/server_rbac_orgs_groups_and_users.png

A user may belong to multiple organizations under the following conditions:

* Role-based access control is configured per-organization
* For a single user to interact with the Chef Infra Server using knife from the same chef-repo, that user may need to edit their config.rb file prior to that interaction

.. end_tag

.. tag server_rbac_orgs_multi_use

Using multiple organizations within the Chef Infra Server ensures that the same toolset, coding patterns and practices, physical hardware, and product support effort is being applied across the entire company, even when:

* Multiple product groups must be supported---each product group can have its own security requirements, schedule, and goals
* Updates occur on different schedules---the nodes in one organization are managed completely independently from the nodes in another
* Individual teams have competing needs for object and object types---data bags, environments, roles, and cookbooks are unique to each organization, even if they share the same name

.. end_tag

Many Users, Same Repo
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. tag chef_repo_many_users_same_knife

The config.rb configuration can include arbitrary Ruby code to extend configuration beyond static values. This can be used to load environmental variables from the workstation. This makes it possible to write a single config.rb file that can be used by all users within your organization. This single file can also be checked into your chef-repo, allowing users to load different config.rb files based on which chef-repo they execute the commands from. This can be especially useful when each chef-repo points to a different chef server or organization.

Example config.rb:

.. code-block:: none

   current_dir = File.dirname(__FILE__)
     user = ENV['OPSCODE_USER'] || ENV['USER']
     node_name                user
     client_key               "#{ENV['HOME']}/chef-repo/.chef/#{user}.pem"
     validation_client_name   "#{ENV['ORGNAME']}-validator"
     validation_key           "#{ENV['HOME']}/chef-repo/.chef/#{ENV['ORGNAME']}-validator.pem"
     chef_server_url          "https://api.opscode.com/organizations/#{ENV['ORGNAME']}"
     syntax_check_cache_path  "#{ENV['HOME']}/chef-repo/.chef/syntax_check_cache"
     cookbook_path            ["#{current_dir}/../cookbooks"]
     cookbook_copyright       "Your Company, Inc."
     cookbook_license         "Apache-2.0"
     cookbook_email           "cookbooks@yourcompany.com"

     # Amazon AWS
     knife[:aws_access_key_id] = ENV['AWS_ACCESS_KEY_ID']
     knife[:aws_secret_access_key] = ENV['AWS_SECRET_ACCESS_KEY']
.. end_tag

Chef Infra Server API
=====================================================
.. tag api_chef_server_summary

The Chef Infra Server API is a REST API that provides access to objects on the Chef Infra Server, including nodes, environments, roles, cookbooks (and cookbook versions), and to manage an API client list and the associated RSA public key-pairs.

.. end_tag

Authentication Headers
-----------------------------------------------------
.. tag api_chef_server_headers

Authentication to the Chef Infra Server occurs when a specific set of HTTP headers are signed using a private key that is associated with the machine from which the request is made. The request is authorized if the Chef Infra Server can verify the signature using the public key. Only authorized actions are allowed.

.. note:: Most authentication requests made to the Chef Infra Server are abstracted from the user. Such as when using knife or the Chef Infra Server user interface. In some cases, such as when using the ``knife exec`` subcommand, the authentication requests need to be made more explicitly, but still in a way that does not require authentication headers. In a few cases, such as when using arbitrary Ruby code or cURL, it may be necessary to include the full authentication header as part of the request to the Chef Infra Server.

.. end_tag

Header Format
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag api_chef_server_headers_format

By default, all hashing is done using SHA-1 and encoded in Base64. Base64 encoding should have line breaks every 60 characters. Each canonical header should be encoded in the following format:

.. code-block:: none

   Method:HTTP_METHOD
   Hashed Path:HASHED_PATH
   X-Ops-Content-Hash:HASHED_BODY
   X-Ops-Timestamp:TIME
   X-Ops-UserId:USERID

where:

* ``HTTP_METHOD`` is the method used in the API request (``GET``, ``POST``, and so on)
* ``HASHED_PATH`` is the path of the request: ``/organizations/NAME/name_of_endpoint``. The ``HASHED_PATH`` must be hashed using SHA-1 and encoded using Base64, must not have repeated forward slashes (``/``), must not end in a forward slash (unless the path is ``/``), and must not include a query string.
* The private key must be an RSA key in the SSL ``.pem`` file format. This signature is then broken into character strings (of not more than 60 characters per line) and placed in the header.

The Chef Infra Server decrypts this header and ensures its content matches the content of the non-encrypted headers that were in the request. The timestamp of the message is checked to ensure the request was received within a reasonable amount of time. One approach generating the signed headers is to use `mixlib-authentication <https://github.com/chef/mixlib-authentication>`_, which is a class-based header signing authentication object similar to the one used by the Chef Infra Client.

Enable SHA-256
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Chef Server versions 12.4.0 and above support signing protocol version 1.3, which adds support for SHA-256 algorithms. It can be enabled on Chef Infra Client via the ``client.rb`` file:

.. code-block:: ruby

   authentication_protocol_version = '1.3'

And on Chef knife via ``config.rb``:

.. code-block:: ruby

   knife[:authentication_protocol_version] = '1.3'

.. end_tag

Required Headers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following authentication headers are required:

.. list-table::
   :widths: 130 400
   :header-rows: 1

   * - Feature
     - Description
   * - ``Accept``
     - .. tag api_chef_server_headers_accept

       The format in which response data from the Chef Infra Server is provided. This header must be set to ``application/json``.

       .. end_tag

   * - ``Host``
     - .. tag api_chef_server_headers_host

       The host name (and port number) to which a request is sent. (Port number ``80`` does not need to be specified.) For example: ``api.opscode.com`` (which is the same as ``api.opscode.com:80``) or ``api.opscode.com:443``.

       .. end_tag

   * - ``X-Chef-Version``
     - .. tag api_chef_server_headers_x_chef_version

       The version of the Chef Infra Client executable from which a request is made. This header ensures that responses are in the correct format. For example: ``12.0.2`` or ``11.16.x``.

       .. end_tag

   * - ``X-Ops-Authorization-N``
     - .. tag api_chef_server_headers_x_ops_authorization

       One (or more) 60 character segments that comprise the canonical header. A canonical header is signed with the private key used by the client machine from which the request is sent, and is also encoded using Base64. If more than one segment is required, each should be named sequentially, e.g. ``X-Ops-Authorization-1``, ``X-Ops-Authorization-2``, ``X-Ops-Authorization-N``, where ``N`` represents the integer used by the last header that is part of the request.

       .. end_tag

   * - ``X-Ops-Content-Hash``
     - .. tag api_chef_server_headers_x_ops_content_hash

       The body of the request. The body should be hashed using SHA-1 and encoded using Base64. All hashing is done using SHA-1 and encoded in Base64. Base64 encoding should have line breaks every 60 characters.

       .. end_tag

   * - ``X-Ops-Sign``
     - .. tag api_chef_server_headers_x_ops_sign

       Set this header to the following value: ``version=1.0``.

       .. end_tag

   * - ``X-Ops-Timestamp``
     - .. tag api_chef_server_headers_x_ops_timestamp

       The timestamp, in ISO-8601 format and with UTC indicated by a trailing ``Z`` and separated by the character ``T``. For example: ``2013-03-10T14:14:44Z``.

       .. end_tag

   * - ``X-Ops-UserId``
     - .. tag api_chef_server_headers_x_ops_userid

       The name of the API client whose private key will be used to create the authorization header.

       .. end_tag

Example
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag api_chef_server_headers_example

The following example shows an authentication request:

.. code-block:: none

   GET /organizations/NAME/nodes HTTP/1.1
     Accept: application/json
     Accept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3
     X-Ops-Sign: algorithm=sha1;version=1.0;
     X-Ops-Userid: user_id
     X-Ops-Timestamp: 2014-12-12T17:13:28Z
     X-Ops-Content-Hash: 2jmj7l5rfasfgSw0ygaVb/vlWAghYkK/YBwk=
     X-Ops-Authorization-1: BE3NnBritishaf3ifuwLSPCCYasdfXaRN5oZb4c6hbW0aefI
     X-Ops-Authorization-2: sL4j1qtEZzi/2WeF67UuytdsdfgbOc5CjgECQwqrym9gCUON
     X-Ops-Authorization-3: yf0p7PrLRCNasdfaHhQ2LWSea+kTcu0dkasdfvaTghfCDC57
     X-Ops-Authorization-4: 155i+ZlthfasfasdffukusbIUGBKUYFjhbvcds3k0i0gqs+V
     X-Ops-Authorization-5: /sLcR7JjQky7sdafIHNfsBQrISktNPower1236hbFIayFBx3
     X-Ops-Authorization-6: nodilAGMb166@haC/fttwlWQ2N1LasdqqGomRedtyhSqXA==
     Host: api.opscode.com:443
     X-Ops-Server-API-Info: 1
     X-Chef-Version: 12.0.2
     User-Agent: Chef Knife/12.0.2 (ruby-2.1.1-p320; ohai-8.0.0; x86_64-darwin12.0.2; +http://chef.io)

.. end_tag

Endpoints
-----------------------------------------------------
.. tag api_chef_server_endpoints

Each organization-specific authentication request must include ``/organizations/NAME`` as part of the name for the endpoint. For example, the full endpoint for getting a list of roles:

.. code-block:: none

   GET /organizations/NAME/roles

where ``ORG_NAME`` is the name of the organization.

.. end_tag

For more information about the Chef Infra Server API endpoints see the `Chef Infra Server API </api_chef_server.html>`_ documentation.
