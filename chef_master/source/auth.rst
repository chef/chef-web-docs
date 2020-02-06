=====================================================
Authentication
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/auth.rst>`__

.. tag chef_auth

All communication with the Chef Infra Server must be authenticated using the Chef Infra Server API, which is a REST API that allows requests to be made to the Chef Infra Server. Only authenticated requests will be authorized. Most of the time, and especially when using knife, Chef Infra Client, or the Chef Infra Server web interface, the use of the Chef Infra Server API is transparent. In some cases, the use of the Chef Infra Server API requires more detail, such as when making the request in Ruby code, with a knife plugin, or when using cURL.

.. end_tag

.. tag chef_auth_authentication

The authentication process ensures the Chef Infra Server responds only to requests made by trusted users. Public key encryption is used by the Chef Infra Server. When a node and/or a workstation is configured to run Chef Infra Client, both public and private keys are created. The public key is stored on the Chef Infra Server, while the private key is returned to the user for safe keeping. (The private key is a .pem file located in the ``.chef`` directory or in ``/etc/chef``.)

Both Chef Infra Client and knife use the Chef Infra Server API when communicating with the Chef Infra Server. The chef-validator uses the Chef Infra Server API, but only during the first Chef Infra Client run on a node.

Each request to the Chef Infra Server from those executables sign a special group of HTTP headers with the private key. The Chef Infra Server then uses the public key to verify the headers and verify the contents.

.. end_tag

Public and Private Keys
=====================================================

.. tag security_chef_validator

Every request made by Chef Infra Client to the Chef Infra Server must be an authenticated request using the Chef Infra Server API and a private key. When Chef Infra Client makes a request to the Chef Infra Server, Chef Infra Client authenticates each request using a private key located in ``/etc/chef/client.pem``.

.. end_tag

Chef Infra Server Key Use
-----------------------------------------------------
.. tag chef_auth_authentication

The authentication process ensures the Chef Infra Server responds only to requests made by trusted users. Public key encryption is used by the Chef Infra Server. When a node and/or a workstation is configured to run Chef Infra Client, both public and private keys are created. The public key is stored on the Chef Infra Server, while the private key is returned to the user for safe keeping. (The private key is a .pem file located in the ``.chef`` directory or in ``/etc/chef``.)

Both Chef Infra Client and knife use the Chef Infra Server API when communicating with the Chef Infra Server. The chef-validator uses the Chef Infra Server API, but only during the first Chef Infra Client run on a node.

Each request to the Chef Infra Server from those executables sign a special group of HTTP headers with the private key. The Chef Infra Server then uses the public key to verify the headers and verify the contents.

.. end_tag

Chef Infra Client
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag security_key_pairs_chef_client

Chef Infra Client authenticates with the Chef Infra Server using RSA public key-pairs each time a Chef Infra Client needs access to data that is stored on the Chef Infra Server. This prevents any node from accessing data that it shouldn't and it ensures that only nodes that are properly registered with the Chef Infra Server can be managed.

.. end_tag

Knife
+++++++++++++++++++++++++++++++++++++++++++++++++++++
RSA public key-pairs are used to authenticate knife with the Chef Infra Server every time knife attempts to access the Chef Infra Server. This ensures that each instance of knife is properly registered with the Chef Infra Server and that only trusted users can make changes to the data.


Knife can also use the ``knife exec`` subcommand to make specific, authenticated requests to the Chef Infra Server. knife plugins can also make authenticated requests to the Chef Infra Server by leveraging the ``knife exec`` subcommand.

chef-validator
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag security_chef_validator_context

However, during the first Chef Infra Client run, this private key does not exist. Instead, Chef Infra Client attempts to use the private key assigned to the chef-validator, located in ``/etc/chef/validation.pem``. (If, for any reason, the chef-validator is unable to make an authenticated request to the Chef Infra Server, the initial Chef Infra Client run will fail.)

During the initial Chef Infra Client run, Chef Infra Client registers itself with the Chef Infra Server using the private key assigned to the chef-validator, after which Chef Infra Client will obtain a ``client.pem`` private key for all future authentication requests to the Chef Infra Server.

After the initial Chef Infra Client run has completed successfully, the chef-validator is no longer required and may be deleted from the node. Use the ``delete_validation`` recipe found in the ``chef-client`` cookbook (https://github.com/chef-cookbooks/chef-client) to remove the chef-validator.

.. end_tag

Chef Infra Server Key Storage
-----------------------------------------------------
Keys are stored in different locations, depending on if the location is a node or a workstation.

Nodes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Each node stores its private key locally. This private key is generated as part of the bootstrap process that initially installs Chef Infra Client on the node. The first time Chef Infra Client runs on that node, it uses the chef-validator to authenticate, but then on each subsequent run it uses the private key generated for that client by the Chef Infra Server.

Workstations
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Each workstation stores its private key in the chef-repo. This private key is generated by the Chef Infra Server and must be download from the server and copied to the ``.chef`` directory in the chef-repo. If a new private key is required, simply regenerate it from the Chef Infra Server and re-copy it to the chef-repo.

.. tag chef_repo_description

The chef-repo is a directory on your workstation that stores everything you need to define your infrastructure with Chef Infra:

* Cookbooks (including recipes, attributes, custom resources, libraries, and templates)
* Data bags
* Policyfiles

The chef-repo directory should be synchronized with a version control system, such as git. All of the data in the chef-repo should be treated like source code.

You'll use the ``chef`` and ``knife ``commands to upload data to the Chef Infra Server from the chef-repo directory. Once uploaded, Chef Infra Client uses that data to manage the nodes registered with the Chef Infra Server and to ensure that it applies the right cookbooks, policyfiles, and settings to the right nodes in the right order.

.. end_tag

.. tag all_directory_chef

The .chef directory is a hidden directory that is used to store validation key files and optionally a `config.rb </config_rb.html>`__ file.

.. end_tag

Chef Infra Server API Authentication
-----------------------------------------------------

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
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The Chef Infra Server user interface uses the Chef Infra Server API to perform most operations. This ensures that authentication requests to the Chef Infra Server are authorized. This authentication process is handled automatically and is not something that users of the hosted Chef Infra Server will need to manage. For the on-premises Chef Infra Server, the authentication keys used by the web interface will need to be maintained by the individual administrators who are responsible for managing the server.

Other Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The most common ways to interact with the Chef Infra Server using the Chef Infra Server API abstract the API from the user. That said, the Chef Infra Server API can be interacted with directly. The following sections describe a few of the ways that are available for doing that.

cURL
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
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
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
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

The previous examples assume that the current working directory is such that PyChef can find a valid configuration file in the same manner as Chef Infra Client or knife. For more about PyChef, see: https://github.com/coderanger/pychef.

Ruby
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
On a system with Chef Infra Client installed, use Ruby to make an authenticated request to the Chef Infra Server:

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
In some cases, Chef Infra Client may receive a 401 response to the authentication request and a 403 response to an authorization request. An authentication error error may look like the following:

.. code-block:: bash

   [Wed, 05 Oct 2011 15:43:34 -0700] INFO: HTTP Request Returned 401
   Unauthorized: Failed to authenticate as node_name. Ensure that your node_name and client key are correct.

To debug authentication problems, determine which Chef Infra Client is attempting to authenticate. This is often found in the log messages for that Chef Infra Client. Debug logging can be enabled on a Chef Infra Client using the following command:

.. code-block:: bash

   chef-client -l debug

When debug logging is enabled, a log entry will look like the following:

.. code-block:: bash

   [Wed, 05 Oct 2011 22:05:35 +0000] DEBUG: Signing the request as NODE_NAME

If the authentication request occurs during the initial Chef Infra Client run, the issue is most likely with the private key.

If the authentication is happening on the node, there are a number of common causes:

* The ``client.pem`` file is incorrect. This can be fixed by deleting the ``client.pem`` file and re-running Chef Infra Client. When Chef Infra Client re-runs, it will re-attempt to register with the Chef Infra Server and generate the correct key.
* A ``node_name`` is different from the one used during the initial Chef Infra Client run. This can happen for a number of reasons. For example, if the client.rb file does not specify the correct node name and the host name has recently changed. This issue can be resolved by explicitly setting the node name in the client.rb file or by using the ``-N`` option for the Chef Infra Client executable.
* The system clock has drifted from the actual time by more than 15 minutes. This can be fixed by syncing the clock with an Network Time Protocol (NTP) server.

Authorization
=====================================================
For more information about Chef Infra Server Authorization, see `Organizations and Groups </server_orgs.html>`__.

Chef Infra Server API
=====================================================
For more information about using the Chef Infra Server API endpoints see `Chef Infra Server API </api_chef_server.html>`__.
