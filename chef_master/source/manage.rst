=====================================================
Chef Manage
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/manage.rst>`__

.. tag chef_automate_mark

.. image:: ../../images/chef_automate_full.png
   :width: 40px
   :height: 17px

.. end_tag

.. tag manage_summary

The Chef management console enables the management of nodes, data bags, roles, environments, and cookbooks by using a web user interface. In addition, access to nodes, data bags, roles, environments, and cookbooks is configurable using role-based access control (RBAC).

.. end_tag

.. note:: .. tag chef_subscriptions

          This feature is included as part of the Chef Automate license agreement and is `available via subscription <https://www.chef.io/pricing/>`_.

          .. end_tag

Nodes
=====================================================
.. tag node

A node is any machine---physical, virtual, cloud, network device, etc.---that is under management by Chef.

.. end_tag

The Chef management console provides ways for users to `delete nodes and reset their private keys </server_manage_nodes.html#manage>`_, `edit node attributes </server_manage_nodes.html#node-attributes>`_, `manage the run-lists </server_manage_nodes.html#run-lists>`_, `configure user and group permissions </server_manage_nodes.html#permissions>`_, and `manage tags </server_manage_nodes.html#manage-tags>`_.

.. image:: ../../images/step_manage_webui_nodes.png

Search
-----------------------------------------------------
.. tag search

Search indexes allow queries to be made for any type of data that is indexed by the Chef server, including data bags (and data bag items), environments, nodes, and roles. A defined query syntax is used to support search patterns like exact, wildcard, range, and fuzzy. A search is a full-text query that can be done from several locations, including from within a recipe, by using the ``search`` subcommand in knife, the ``search`` method in the Recipe DSL, the search box in the Chef management console, and by using the ``/search`` or ``/search/INDEX`` endpoints in the Chef server API. The search engine is based on Apache Solr and is run from the Chef server.

.. end_tag

.. note:: The syntax for search queries in the Chef management console is identical to the syntax for search queries used with knife, the command line tool used to manage objects on the Chef server.

Query Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag search_query_syntax

A search query is comprised of two parts: the key and the search pattern. A search query has the following syntax:

.. code-block:: ruby

   key:search_pattern

where ``key`` is a field name that is found in the JSON description of an indexable object on the Chef server (a role, node, client, environment, or data bag) and ``search_pattern`` defines what will be searched for, using one of the following search patterns: exact, wildcard, range, or fuzzy matching. Both ``key`` and ``search_pattern`` are case-sensitive; ``key`` has limited support for multiple character wildcard matching using an asterisk ("*") (and as long as it is not the first character).

.. end_tag

Keys
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag search_key

A field name/description pair is available in the JSON object. Use the field name when searching for this information in the JSON object. Any field that exists in any JSON description for any role, node, chef-client, environment, or data bag can be searched.

.. end_tag

Nested Fields
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
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

About Patterns
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag search_pattern

A search pattern is a way to fine-tune search results by returning anything that matches some type of incomplete search query. There are four types of search patterns that can be used when searching the search indexes on the Chef server: exact, wildcard, range, and fuzzy.

.. end_tag

Exact Matching
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. tag search_pattern_exact

An exact matching search pattern is used to search for a key with a name that exactly matches a search query. If the name of the key contains spaces, quotes must be used in the search pattern to ensure the search query finds the key. The entire query must also be contained within quotes, so as to prevent it from being interpreted by Ruby or a command shell. The best way to ensure that quotes are used consistently is to quote the entire query using single quotes (' ') and a search pattern with double quotes (" ").

.. end_tag

Wildcard Matching
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. tag search_pattern_wildcard

A wildcard matching search pattern is used to query for substring matches that replace zero (or more) characters in the search pattern with anything that could match the replaced character. There are two types of wildcard searches:

* A question mark (``?``) can be used to replace exactly one character (as long as that character is not the first character in the search pattern)
* An asterisk (``*``) can be used to replace any number of characters (including zero)

.. end_tag

Range Matching
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. tag search_pattern_range

A range matching search pattern is used to query for values that are within a range defined by upper and lower boundaries. A range matching search pattern can be inclusive or exclusive of the boundaries. Use square brackets ("[ ]") to denote inclusive boundaries and curly braces ("{ }") to denote exclusive boundaries and with the following syntax:

.. code-block:: ruby

   boundary TO boundary

where ``TO`` is required (and must be capitalized).

.. end_tag

Fuzzy Matching
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. tag search_pattern_fuzzy

A fuzzy matching search pattern is used to search based on the proximity of two strings of characters. An (optional) integer may be used as part of the search query to more closely define the proximity. A fuzzy matching search pattern has the following syntax:

.. code-block:: ruby

   "search_query"~edit_distance

where ``search_query`` is the string that will be used during the search and ``edit_distance`` is the proximity. A tilde ("~") is used to separate the edit distance from the search query.

.. end_tag

About Operators
+++++++++++++++++++++++++++++++++++++++++++++++++++++
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

.. tag search_boolean_operators_andnot

Operators must be in ALL CAPS. Parentheses can be used to group clauses and to form sub-queries.

.. warning:: Using ``AND NOT`` together may trigger an error. For example:

   .. code-block:: bash

      ERROR: knife search failed: invalid search query:
      'datacenter%3A123%20AND%20NOT%20hostname%3Adev-%20AND%20NOT%20hostanem%3Asyslog-'
      Parse error at offset: 38 Reason: Expected one of \ at line 1, column 42 (byte 42) after AND

   Use ``-`` instead of ``NOT``. For example:

   .. code-block:: bash

      $ knife search sample "id:foo AND -id:bar"

.. end_tag

Special Characters
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag search_special_characters

A special character can be used to fine-tune a search query and to increase the accuracy of the search results. The following characters can be included within the search query syntax, but each occurrence of a special character must be escaped with a backslash (``\``), also (``/``) must be escaped against the Elasticsearch:

.. code-block:: ruby

   +  -  &&  | |  !  ( )  { }  [ ]  ^  "  ~  *  ?  :  \  /

For example:

.. code-block:: ruby

   \(1\+1\)\:2

.. end_tag

Reports
=====================================================
.. tag reporting_summary

Use Reporting to keep track of what happens during the execution of chef-client runs across all of the machines that are under management by Chef. Reports can be generated for the entire organization and they can be generated for specific nodes.

Reporting data is collected during the chef-client run and the results are posted to the Chef server at the end of the chef-client run at the same time the node object is uploaded to the Chef server.

.. end_tag

The Chef management console provides ways for users to `configure the timeframe </server_manage_reports.html#configure-reports>`_ around which a report is built, and then to `review the reports </server_manage_reports.html#view-reports>`_ that are available for that timeframe.

.. image:: ../../images/step_manage_webui_reports.png

Policy
=====================================================
.. tag policy_summary

Policy maps business and operational requirements, process, and workflow to settings and objects stored on the Chef server:

* Roles define server types, such as "web server" or "database server"
* Environments define process, such as "dev", "staging", or "production"
* Certain types of data---passwords, user account data, and other sensitive items---can be placed in data bags, which are located in a secure sub-area on the Chef server that can only be accessed by nodes that authenticate to the Chef server with the correct SSL certificates
* The cookbooks (and cookbook versions) in which organization-specific configuration policies are maintained

.. end_tag

The Chef management console provides ways for users to manage `data bags </server_manage_data_bags.html>`__, `environments </server_manage_environments.html>`__, `roles </server_manage_roles.html>`__, `cookbooks </server_manage_cookbooks.html>`__, `clients </server_manage_clients.html>`__, and `managing tags </server_manage_nodes.html#manage-tags.html>`__.

.. image:: ../../images/step_manage_webui_policy.png

Admin
=====================================================
Organizations, users, and groups can be managed from the Chef management console, including role-based access control for any user and group to any of the objects saved to the Chef server.

.. tag server_rbac

The Chef server uses role-based access control (RBAC) to restrict access to objects---nodes, environments, roles, data bags, cookbooks, and so on. This ensures that only authorized user and/or chef-client requests to the Chef server are allowed. Access to objects on the Chef server is fine-grained, allowing access to be defined by object type, object, group, user, and organization. The Chef server uses permissions to define how a user may interact with an object, after they have been authorized to do so.

.. end_tag

.. image:: ../../images/step_manage_webui_admin.png

