=====================================================
Chef Analytics Rules
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/analytics_rules.rst>`__

.. tag analytics_legacy

.. note:: This documentation is meant to support existing Chef customers using Analytics.

          If you are a new Chef customer, or are looking to gain better insight into your fleet, try `Chef Automate </chef_automate.html>`__. You'll get a graphical interface and query language that gives you insight into operational, compliance, and workflow events. Download Chef Automate `here <https://downloads.chef.io/automate>`__.


.. end_tag

.. tag analytics_rules_summary

Chef Analytics includes a powerful rules processing system that allows notifications to be generated based on observed events in the data stream, such as:

* Cookbook uploads
* Modifications to environments
* Machines on which chef-client runs have failed
* Machines on which audit-mode runs have failed
* Resources that were updated as a result of a chef-client run

Notifications may be sent to any email address, a chat service like HipChat or Slack, or to a webhook-based service for generic integrations.

.. end_tag

.. note:: .. tag chef_subscriptions

          This feature is included as part of the Chef Automate license agreement and is `available via subscription <https://www.chef.io/pricing/>`_.

          .. end_tag

Rule Syntax
=====================================================
.. tag analytics_rules_syntax

The syntax for a Chef Analytics rule is as follows:

.. code-block:: none

   rules 'name'
     with priority=n
     rule 'name' on message_type
     when
       // comment
       function()
     then
       // comment
       function()
     otherwise
       // comment
       function()
     end

     rule ...
       ...
     end

     ...
   end

where:

* ``rules`` defines a rules group which is comprised of individual rules (``rule``)
* ``rule`` defines an individual rule; each rule must be contained in its own ``rule`` block
* ``with priority=n`` is a positive or negative integer that defines the relative priority of a rules group as compared to all other rules groups
* ``'name'`` is name of the rule group and/or the name of the rule; required for ``rules``, optional for each ``rule``
* ``message_type`` is one of the following: ``action``, ``run_control``, ``run_control_group``, ``run_converge``, ``run_resource``, or ``run_start``
* ``when`` is a series of evaluations that result in ``true`` or ``false``
* ``then`` is a comma-separated group of statements that are used to test data
* ``otherwise`` is a comma-separated group of statements that are used to test data
* ``function()`` is a statement that tests a value in the JSON object; functions may be one of ``array:contains()``, ``alert:<level>()``, ``datetime:component()``, ``get()``, ``log()``, or ``mustache_template()``. (See "Functions" below for more information about the individual functions.)
* A comment starts with two forward slashes--``//``---and continues to the end of the line on which the comment begins
* Whitespace is ignored by the rules parser unless it contained within single- or double-quoted strings. For example, the parser will preserve the white space in ``'white space'`` and ``"white space"``

.. end_tag

.. _analytics_rules-message-types:

Message Types
-----------------------------------------------------
.. tag analytics_rules_syntax_message_types

Each individual ``rule`` must be associated with a specific message type. As a rule is triggered during the chef-client run, a message is sent to the Chef Analytics server. A rule may be configured to send notifications about a message to recipients that are located outside of the Chef Analytics server.

A message type must be one of the following:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Message Type
     - Description
   * - ``action``
     - Use to build rules for messages about actions that occur on the Chef server.
   * - ``run_control``
     - Use to build rules for a single audit to be evaluated.
   * - ``run_control_group``
     - Use to build rules for a group of audits to be evaluated.
   * - ``run_converge``
     - Use to build rules for messages that are sent at the end of a chef-client run.
   * - ``run_resource``
     - Use to build rules for messages that are sent as each resource is converged during a chef-client run.
   * - ``run_start``
     - Use to build rules for messages that are sent at the start of a chef-client run.

.. end_tag

when
-----------------------------------------------------
Use ``when`` to define an expression. Multiple expressions may be joined using ``and`` and ``or``. Expressions may be grouped using parentheses (``( )``). Expressions may use nested function calls on either side of the expression. The following operators may be used:

.. list-table::
   :widths: 20 400
   :header-rows: 1

   * - Operator
     - Description
   * - ``=``
     - equal to
   * - ``!=``
     - not equal to
   * - ``>``
     - greater than
   * - ``<``
     - less than
   * - ``>=``
     - greater than or equal to; also known as "optimistically greater than", or "optimistic"
   * - ``<=``
     - less than or equal to
   * - ``=~``
     - a regular expression
   * - ``not``
     - negates the expression

For example:

.. code-block:: ruby

   rule on action when
     max(1000, data.some_value) = 1000
   then
     set(#some_value, data.some_other_value)
   end

or:

.. code-block:: ruby

   rule on action when
     some_value > 1000 and 
       (max(data.some_other_value, max(100,data.max_field)) = 1000 or data.foo='Some Value')
   then
     set(#some_value, data.some_other_value)
   end

Expressions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
An expression defines a specific test in a rule and uses fields within the expression that are specific to the message type for the rule. For example:

.. code-block:: ruby

   total_resource_count > 1 and
   updated_resource_count > 0

.. code-block:: ruby

   array:contains(run_list, 'role[opscode-reporting]')

where both ``total_resource_count``, ``updated_resource_count``, and ``run_list`` are the :ref:`fields specific to a message type <analytics_rules-message-types>`.

then
-----------------------------------------------------
Use the ``then`` statement to specify what to do when a rule in the ``when`` statement is matched. For example:

.. code-block:: ruby

   rule on action when
     data.name='app1'
   then
     set(#foo, '100')  
   end

When the name matches ``app1``, ``#foo`` will be set to ``100``.

otherwise
-----------------------------------------------------
Use the ``otherwise`` statement to specify what to do when a rule in the ``when`` statement is matched, but is not handled by the ``then`` statement. For example:

.. code-block:: ruby

   rule on action when
     data.name='app1'
   then
     set(#foo, '100')  
   otherwise
     set(#foo, '200")  
   end

When the name matches ``app1``, ``#foo`` will be set to ``100`` and if the name does not match ``app1``, ``#foo`` will be set to ``200``.

with priority
-----------------------------------------------------
Use the ``with priority`` statement to specify a positive or negative integer that defines the relative priority of a rules group as compared to all other rules groups. For example:

.. code-block:: ruby

   rules 'rule name'
     with priority=100
       rule on action ...
     ...
   end

A rules group with a higher integer value will have priority over any rules groups with lower integer values.

Comments
-----------------------------------------------------
Use a comment to document the behavior of the rules. A comment starts with a double forward slash---``//``---and continues to the end of the line on which the comment started. For example:

.. code-block:: javascript

   rules 'user-agent matching'
     rule on action
     when
       // this rule always matches
       true
     then
       // raise an audit for every action
       alert:info('This rule matches all actions')
     end
   end

Whitespace
-----------------------------------------------------
Whitespace is ignored by the rules parser unless it is contained within single- or double-quotes. For example, the following rules are parsed the same way:

.. code-block:: ruby

   rules 'rule'
     rule on action
     when
       true
     then
       alert:info('string')
     end
   end

and:

.. code-block:: ruby

   rules 'rule' rule on action when true then audit:info('string') end end

The rules parser does not ignore spaces that are contained within single- or double-quotes. For example

.. code-block:: ruby

   'This is a string. The parser will not ignore the whitespace.'

or:

.. code-block:: ruby

   "This is a string. The parser will not ignore the whitespace."

Strings
-----------------------------------------------------
A string must be contained in single- or double-quotes and may contain any valid UTF-8 character. For example, a single-quoted string:

.. code-block:: ruby

   'A string.'

or a double-quoted string:

.. code-block:: ruby

   "A string."

or a valid UTF-8 character:

.. code-block:: ruby

   "ᚠᛇᚻ᛫ᛒᛦᚦ᛫ᚠᚱᚩᚠᚢᚱ᛫ᚠᛁᚱᚪ᛫ᚷᛖᚻᚹᛦᛚᚳᚢᛗ"

Use a backslash---``\``---to escape single-quotes that must appear within a single-quoted string. For example:

.. code-block:: ruby

   'This is a string with \'escaped single quotes\'.'

to escape double-quotes that must appear within a double-quoted string:

.. code-block:: ruby

   "This is a string with \"escaped double quotes\"."

Single-quotes that appear within a double-quoted string do not need to be escaped. Double-quotes that appear in a single-quoted string do not need to be escaped.

For example:

.. code-block:: javascript

   rules 'string example'
     rule on action
     when
       // this rule always matches
       true
     then
       // single quoted string, 
       alert:info('This rule matches all \'action\' messages')
     end
   end

Numbers
-----------------------------------------------------
Numbers may be positive or negative integers or floating point values.

* The valid range for integers is ``-9223372036854775808`` to ``9223372036854775807``
* The valid range for floating point numbers is ``4.9E-324`` to ``1.7976931348623157E308``; scientific notation is not supported and rounding will occur outside of this range

Numbers may be compared with the following operators:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Operator
     - Description
   * - ``=``
     - Equality.
   * - ``!=``
     - Inequality.
   * - ``>``
     - Greater than.
   * - ``>=``
     - Greater than equal.
   * - ``<``
     - Less than.
   * - ``<=``
     - Less than equal.

.. note:: If a number is compared to a non-number, the rule will not match and an error is logged.

For example, all of the following are valid numbers:

.. code-block:: ruby

   1

or:

.. code-block:: ruby

   -99999999

or:

.. code-block:: ruby

   1.99999

or:

.. code-block:: ruby

   -999999.000123

For example:

.. code-block:: bash

   rules 'Match control groups with failures'
     rule on run control group
       when
         name = 'mysql audit' and number_failed > 0
       then
         alert:error('Control group failures detected')
     end
   end

Regular Expressions
-----------------------------------------------------
Use a regular expression to define a search pattern to match against a rule. Use the ``=~`` operator to define the regular expression:

.. code-block:: ruby

   string_to_match =~ regular_expression

For example:

.. code-block:: javascript

   rules 'regex demo'
     rule on action
       when
         // match if the user_agent starts with the string 'Chef Manage'
         user_agent =~ 'Chef Manage.*'
       or 
         // match 1 or more lower case characters followed by a single digit
         entity_name =~ '[a-z]+\d'
       then
         notify('my_webhook')
     end
   end

Use the following to match constructs:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Construct
     - Description
   * - ``x``
     - Use to match the ``x`` character.
   * - ``\``
     - Use to match the backslash character.
   * - ``\t``
     - Use to match the tab character (``'\u0009'``).
   * - ``\n``
     - Use to match the newline (line feed) character (``'\u000A'``).
   * - ``\r``
     - Use to match the carriage-return character (``'\u000D'``).

Use the following to match characters:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Characters
     - Description
   * - ``[abc]``
     - Use to match a, b, or c.
   * - ``[^abc]``
     - Use to match any character except a, b, or c.
   * - ``[a-zA-Z]``
     - Use to match a through z or A through Z, inclusive.
   * - ``.``
     - Use to match any character or a line terminator.
   * - ``\d``
     - Use to match a digit. For example: ``[0-9]``.
   * - ``\D``
     - Use to match a non-digit. For example: ``[^0-9]``.
   * - ``\s``
     - Use to match a whitespace character. For example: ``[ \t\n\x0B\f\r]``.
   * - ``\S``
     - Use to match a non-whitespace character. For example: ``[^\s]``.
   * - ``\w``
     - Use to match a word character. For example: ``[a-zA-Z_0-9]``.
   * - ``\W``
     - Use to match a non-word character. For example: ``[^\w]``.

Use the following to match boundaries:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Boundary
     - Description
   * - ``^``
     - Use to match the beginning of a line.
   * - ``$``
     - Use to match the end of a line.
   * - ``\b``
     - Use to match a word boundary.
   * - ``\B``
     - Use to match a non-word boundary.

Nested Fields, Arrays
-----------------------------------------------------
Some messages that contain nested fields or arrays.

* Use dot syntax---``.foo``---to access integer values in nested fields.
* Use square bracket syntax---``[index]``---to access integer values in arrays.

.. note:: If the field does not exist, the rule will return false.

For example, accessing integer values in a nested field:

.. code-block:: javascript

   rules 'Control group matches'
     rule on run control group
       when
         run.chef_server_fqdn = 'mysql.production.foo.com'
       or
         // any node_name with 'production' in it's name
         run.node_name =~ '.*production.*'
       then
         alert:info('production control group match')
     end
   end

And accessing integer values in an array:

.. code-block:: javascript

   rules 'Run resource matches'
     rule on run resource
       when
         converge.run_list[0] = 'role[opscode-reporting]'
       or
         some_other.property[0].another_property[99] != 100
       then
         alert:error('Run resource match')
     end
   end

Message Fields
=====================================================

The following sections describe the fields that may be used for each of
the specific message types.

actions
-----------------------------------------------------
The following fields are available for the ``action`` message type:

.. list-table::
   :widths: 120 60 320
   :header-rows: 1

   * - Field
     - Type
     - Description
   * - ``entity_name``
     - string
     - The name of the entity. For example: ``'app1'``.
   * - ``entity_type``
     - string
     - The type of entity. For example: ``'node'``.
   * - ``id``
     - string
     - The globally-unique identifier for this message. For example: ``'12345678-9012-3456-7890-12345678901211'``.
   * - ``organization_name``
     - string
     - The short name of the organization to which the node belongs. For example: ``'chef'``.
   * - ``parent_name``
     - string
     - The name of the parent entity. For example: ``'apache2'``.
   * - ``parent_type``
     - string
     - The type of entity of the parent entity. For example: ``'cookbook'``.
   * - ``recorded_at``
     - string
     - The ISO timestamp at which the action occurred. For example: ``'2014-06-05T10:34:35Z'``.
   * - ``remote_hostname``
     - string
     - The IP address from which the action was initiated. For example: ``'127.0.0.1'``.
   * - ``remote_request_id``
     - string
     - The request identifier generated by the remote client. For example: ``'12345678-9012-3456-7890-12345678901211'``.
   * - ``request_id``
     - string
     - The Chef server request identifier. For example: ``'tG3MRbYB7NFWjFU8shs1YeSxq8CIIMJudpnHJXDnWEWzFSVW'``.
   * - ``requestor_name``
     - string
     - The name of the chef-client or user that initiated the action. For example: ``'grantmc'``.
   * - ``requestor_type``
     - string
     - Indicates if the requestor was a chef-client or a user. For example: ``'user'``.
   * - ``service_hostname``
     - string
     - The FQDN for the Chef server against which the instance is running. For example: ``'api.chef.io'``.
   * - ``task``
     - string
     - The description of the action that was performed. For example: ``delete``.
   * - ``user_agent``
     - string
     - The User-Agent of the requestor. For example: ``'Chef Client/12.0.2 (ruby-2.0.0-p598; x86_64-linux; +http://chef.io)'``.

run_control
-----------------------------------------------------
The following fields are available for the ``run_control`` message type:

.. list-table::
   :widths: 120 60 320
   :header-rows: 1

   * - Field
     - Type
     - Description
   * - ``context``
     - array
     - 
   * - ``control_group``
     - object
     - A JSON object that contains the control group identifier, the name of the control group, the number of tests that passed and failed, and its final status.
   * - ``control_group.control_group_id``
     - string
     - The identifier of the control group object. For example: ``'12345678-9012-3456-7890-12345678901211'``.
   * - ``control_group.name``
     - string
     - The name of the control group. For example: ``'mysql audit'``.
   * - ``control_group.number_failed``
     - integer
     - The number of tests within the control group that failed. For example: ``7``.
   * - ``control_group.number_succeeded``
     - integer
     - The number of tests within the control group that passed. For example: ``4``.
   * - ``control_group.status``
     - string
     - The status of the control group. For example: ``'success'``.
   * - ``details``
     - ["string", "null"] 
     - Details about the control object.
   * - ``id``
     - string
     - The globally-unique identifier for this message. For example: ``'12345678-9012-3456-7890-12345678901211'``.
   * - ``name``
     - string
     - The name of the control object. For example: ``'should be installed'``.
   * - ``organization_name``
     - string
     - The short name of the organization to which the node belongs. For example: ``'chef'``.
   * - ``resource_name``
     - ["string", "null"]
     - The name of the resource in which the control object is present. For example: ``'mysql'``.
   * - ``resource_type``
     - ["string", "null"]
     - The resource type for the control object. For example: ``'Package'``.
   * - ``run``
     - object
     - A JSON object that contains run data, including the chef-client run identifier, the FQDN for the Chef server, the name of the node, and the times at which the chef-client started and finished.
   * - ``run.chef_server_fqdn``
     - string
     - The FQDN for the Chef server against which the instance is running. For example: ``'api.chef.io'``.
   * - ``run.end_time``
     - string
     - The ISO timestamp at which the chef-client run finished. For example: ``'2014-06-05T10:39:43Z'``.
   * - ``run.node_name``
     - string
     - The name of the node on which the chef-client run occurred. For example: ``'grantmc01-abc'``.
   * - ``run.run_id``
     - string
     - The internal message identifier for the chef-client run. For example: ``'12345678-9012-3456-7890-12345678901211'``.
   * - ``run.start_time``
     - string
     - The ISO timestamp at which the chef-client run started. For example: ``'2014-06-05T10:34:35Z'``.
   * - ``sequence_number``
     - integer
     - The sequence number at which the resource converged. For example: ``2``.
   * - ``status``
     - string
     - The status of the control object. For example: ``'success'``.

run_control_group
-----------------------------------------------------
The following fields are available for the ``run_control_group`` message type:

.. list-table::
   :widths: 120 60 320
   :header-rows: 1

   * - Field
     - Type
     - Description
   * - ``error``
     - string
     - The error reported by the chef-client. For example:

       .. code-block:: javascript

          "error": {
            "class": "#<TypeError: user[chef] (/var/file.rb line 56) has error",
            "message": "user[chef] (/var/file.rb line 87) has error",
            "backtrace": "[\"/opt/chef/embedded/.../chef/unix.rb:103 \"]",
            "description": {
              "title": "Errorexecutingaction`create`onresource'user[chef]'",
              "sections": [
                { "TypeError": "can'tconvertArrayintoString" },
                { "CookbookTrace: ": "/var/chef/file.rb: 11: action: create\n" }
              ]
            }
          }

   * - ``id``
     - string
     - The globally-unique identifier for this message. For example: ``'12345678-9012-3456-7890-12345678901211'``.
   * - ``name``
     - string
     - The name of the control group object. For example: ``'mysql audit'``.
   * - ``number_failed``
     - integer
     - The number of tests within the control group that failed. For example: ``7``.
   * - ``number_succeeded``
     - integer
     - The number of tests within the control group that passed. For example: ``4``.
   * - ``organization_name``
     - string
     - The short name of the organization to which the node belongs. For example: ``'chef'``.
   * - ``run``
     - object
     - A JSON object that contains run data, including the chef-client run identifier, the FQDN for the Chef server, the name of the node, and the times at which the chef-client started and finished.
   * - ``run.chef_server_fqdn``
     - string
     - The FQDN for the Chef server against which the instance is running. For example: ``'api.chef.io'``.
   * - ``run.end_time``
     - string
     - The ISO timestamp at which the chef-client run finished. For example: ``'2014-06-05T10:39:43Z'``.
   * - ``run.node_name``
     - string
     - The name of the node on which the chef-client run occurred. For example: ``'grantmc01-abc'``.
   * - ``run.run_id``
     - string
     - The internal message identifier for the chef-client run. For example: ``'12345678-9012-3456-7890-12345678901211'``.
   * - ``run.start_time``
     - string
     - The ISO timestamp at which the chef-client run started. For example: ``'2014-06-05T10:34:35Z'``.
   * - ``status``
     - string
     - The status of the control object. For example: ``'failure'``.

run_converge
-----------------------------------------------------
The following fields are available for the ``run_converge`` message type:

.. list-table::
   :widths: 120 60 320
   :header-rows: 1

   * - Field
     - Type
     - Description
   * - ``chef_server_fqdn``
     - string
     - The FQDN for the Chef server against which the instance is running. For example: ``'api.chef.io'``.
   * - ``end_time``
     - string
     - The ISO timestamp at which the chef-client run finished. For example: ``'2014-06-05T10:39:43Z'``.
   * - ``error``
     - object
     - The details of errors that occurred during the chef-client run, if present. For example:

       .. code-block:: javascript

          "error": {
            "class": "#<TypeError: user[chef] (/var/file.rb line 87) has error",
            "message": "user[chef] (/var/file.rb line 87) has error",
            "backtrace": "[\"/opt/chef/embedded/.../chef/unix.rb:103 \"]",
            "description": {
              "title": "Errorexecutingaction`create`onresource'user[chef]'",
              "sections": [
                { "TypeError": "can'tconvertArrayintoString" },
                { "CookbookTrace: ": "/var/chef/file.rb: 11: action: create\n" }
              ]
            }
          }

   * - ``id``
     - string
     - The internal message identifier for the chef-client run. For example: ``'12345678-9012-3456-7890-12345678901211'``.
   * - ``node_name``
     - string
     - The name of the node on which the chef-client run occurred. For example: ``'grantmc01-abc'``.
   * - ``organization_name``
     - string
     - The short name of the organization to which the node belongs. For example: ``'chef'``.
   * - ``resources``
     - array
     - An array of resources that were converged during the chef-client run.
   * - ``run_id``
     - string
     - The identifier for the chef-client run. For example: ``'67890123-4567-8901-2345-67890123456789'``.
   * - ``run_list``
     - array
     - The run-list used during the chef-client run. For example: ``[ 'role[opscode-reporting]' ]``.
   * - ``start_time``
     - string
     - The ISO timestamp at which the chef-client run started. For example: ``'2014-06-05T10:34:35Z'``.
   * - ``status``
     - string
     - The status of the chef-client run. For example: ``'success'``.
   * - ``total_resource_count``
     - integer
     - The total number of resources in the resource collection for the chef-client run. For example: ``4``.
   * - ``updated_resource_count``
     - integer
     - The total number of resources that were updated during the chef-client run. For example: ``2``.

run_resource
-----------------------------------------------------
The following fields are available for the ``run_resource`` message type:

.. list-table::
   :widths: 120 60 320
   :header-rows: 1

   * - Field
     - Type
     - Description
   * - ``converge``
     - object
     - A JSON object that contains the status of the chef-client run, the name of the organization, the run-list, total resource count, updated resource count, the run identifier, and the times at which the chef-client started and finished.
   * - ``converge.end_time``
     - string
     - The ISO timestamp at which the chef-client run finished. For example: ``'2014-06-05T10:39:43Z'``.
   * - ``converge.id``
     - string
     - The internal message identifier for the chef-client run. For example: ``'12345678-9012-3456-7890-12345678901211'``.
   * - ``converge.organization_name``
     - string
     - The name of the organization to which the node belongs. For example: ``'chef'``.
   * - ``converge.run_list``
     - array
     - The run-list used during the chef-client run. For example: ``[ 'role[opscode-reporting]' ]``.
   * - ``converge.start_time``
     - string
     - The ISO timestamp at which the chef-client run started. For example: ``'2014-06-05T10:34:35Z'``.
   * - ``converge.status``
     - string
     - The status of the chef-client run. For example: ``'success'``.
   * - ``converge.total_resource_count``
     - integer
     - The total number of resources that were converged during the chef-client run. For example: ``4``.
   * - ``converge.updated_resource_count``
     - integer
     - The total number of resources that were updated during the chef-client run. For example: ``2``.
   * - ``cookbook_name``
     - string
     - The name of the cookbook that initiated the changes made by this chef-client run. For example: ``'chef_handler'``.
   * - ``cookbook_version``
     - string
     - The version of the cookbook initiated the changes made by this chef-client run. For example: ``'0.2.3'``.
   * - ``delta``
     - string
     - The difference between the initial and final value of resource. For example:

       .. code-block:: none

          --- /etc/motd.tail
          2013-06-30 17:41:31.667050237 -0600\n
          +++ /tmp/chef-rendered-template 18:11:54.7 -0600\n
          @@ -3,7 +3,7 @@\n
          Chef-Client - jenkins\n
          Hostname: jenkins.int.housepub.org\n
          Chef Server: https://api.chef.io/orgs/org\n
          -Last Run: 2013-06-30 17:41:31 -0600\n
          +Last Run:2013-06-30 18:11:54 -0600\n
          \n
          Roles:\n
          debian

   * - ``duration``
     - string
     - The duration of the chef-client run. For example: ``'1200'``.
   * - ``final_state``
     - object
     - A JSON object that contains the final state of the resource, including a checksum, owner, group, and mode.
   * - ``id``
     - string
     - The internal message identifier for the chef-client run. For example: ``'12345678-9012-3456-7890-12345678901211'``.
   * - ``initial_state``
     - object
     - A JSON object that contains the initial state of the resource, including a checksum, owner, group, and mode.
   * - ``resource_id``
     - string
     - The resource identifier. For example: ``'/var/cache/mod_auth_openid/mod_auth_openid.db'``.
   * - ``resource_name``
     - string
     - The name of the resource. For example: ``'/var/cache/mod_auth_openid/mod_auth_openid.db'``.
   * - ``resource_result``
     - string
     - The resource result. For example: ``'delete'``.
   * - ``resource_type``
     - string
     - The resource type. For example: ``'file'``.
   * - ``run``
     - object
     - A JSON object that contains run data, including the chef-client run identifier, the FQDN for the Chef server, the name of the node, and the times at which the chef-client started and finished.
   * - ``run.chef_server_fqdn``
     - string
     - The FQDN for the Chef server against which the instance is running. For example: ``'api.chef.io'``.
   * - ``run.end_time``
     - string
     - The ISO timestamp at which the chef-client run finished. For example: ``'2014-06-05T10:39:43Z'``.
   * - ``run.node_name``
     - string
     - The name of the node on which the chef-client run occurred. For example: ``'grantmc01-abc'``.
   * - ``run.run_id``
     - string
     - The identifier for the chef-client run. For example: ``'67890123-4567-8901-2345-67890123456789'``.
   * - ``run.start_time``
     - string
     - The ISO timestamp at which the chef-client run started. For example: ``'2014-06-05T10:34:35Z'``.
   * - ``sequence_number``
     - integer
     - The sequence number at which the resource converged. For example: ``0``.

run_start
-----------------------------------------------------
The following fields are available for the ``run_start`` message type:

.. list-table::
   :widths: 120 60 320
   :header-rows: 1

   * - Field
     - Type
     - Description
   * - ``chef_server_fqdn``
     - string
     - The FQDN for the Chef server against which the instance is running. For example: ``'api.chef.io'``.
   * - ``id``
     - string
     - The internal message identifier for the chef-client run. For example: ``'12345678-9012-3456-7890-12345678901211'``.
   * - ``node_name``
     - string
     - The name of the node on which the chef-client run occurred. For example: ``'grantmc01-abc'``.
   * - ``organization_name``
     - string
     - The short name of the organization to which the node belongs. For example: ``'chef'``.
   * - ``run_id``
     - string
     - The identifier for the chef-client run. For example: ``'67890123-4567-8901-2345-67890123456789'``.
   * - ``start_time``
     - string
     - The ISO timestamp at which the chef-client run started. For example: ``'2014-06-05T10:34:35Z'``.

Functions
=====================================================
Use a function to help specify how rules are applied. A function may be used in ``when``, ``then``, and ``otherwise`` sections in rules. A function has the following syntax:

.. code-block:: ruby

   function_name(param1, param2, paramN)

.. note:: A function that is defined in the ``when`` section of a rule MUST return a Boolean value, or it will fail.

alert:<level>()
-----------------------------------------------------
Use ``alert:<level>()`` to generate an audit.

The syntax for this function:

.. code-block:: ruby

   alert:<level>(description)

where:

* ``<level>`` is the audit level: ``error``, ``info``, or ``warn``
* ``description`` is a user-defined value (and may be a Mustache template)

array:contains()
-----------------------------------------------------
Use ``array:contains()`` to look for an attribute in the JSON object, and then determine its value.

The syntax for this function:

.. code-block:: ruby

   array:contains(field, valueToFind)

where:

* ``field`` is an attribute in the JSON object
* ``valueToFind`` is the value for that attribute

For example:

.. code-block:: ruby

   array:contains(organization_name = 'ponyville')

datetime:component()
-----------------------------------------------------
Use ``datetime:component()`` to specify the date and time at which a rule is applied.

The syntax for this function:

.. code-block:: ruby

   datetime:component(field, 'dateTimeComponent')

where:

* ``field`` is an attribute in the JSON object
* ``dateTimeComponent`` must be one of the following (lower or uppercase) as a quoted string: ``era``, ``year_of_era``, ``century_of_era``, ``year_of_century``, ``year``, ``day_of_year``, ``month_of_year``, ``day_of_month``, ``weekyear_of_century``, ``weekyear``, ``week_of_weekyear``, ``day_of_week``, ``halfday_of_day``, ``hour_of_halfday``, ``clockhour_of_halfday``, ``clockhour_of_day``, ``hour_of_day``, ``minute_of_day``, ``minute_of_hour``, ``second_of_day``, ``second_of_minute``, ``millis_of_day``, or ``millis_of_second``

For example:

.. code-block:: ruby

   datetime:component(adate, 'era')

get()
-----------------------------------------------------
Use ``get()`` to identify a field, and then identify an associated value.

The syntax for this function:

.. code-block:: ruby

   get(variableToGet, valueToSet OR defaultIfMissing)

where:

* ``variableToGet`` specifies the field to look for
* ``valueToSet`` specifies the value to use
* ``defaultIfMissing`` specifies to use the default value if there is no user-defined value

For example:

.. code-block:: ruby

   rule on action when
     get(foo, false) = false
   then
     notify('some_alias')
   end

will pass if ``foo`` is missing in the JSON object.

log()
-----------------------------------------------------
Use ``log()`` to generate a message using the configured logger as a string.

The syntax for this function:

.. code-block:: ruby

   log(messageToLog)

where:

* ``messageToLog`` is the message that is added to the log

For example:

.. code-block:: ruby

   log('Added rule for org <obj.organization_name>')

mustache_template()
-----------------------------------------------------
Use ``mustache_template()`` to render an expression that is defined in a Mustache template. If the Mustache template is invalid, an error is logged and the expression will return an empty, non-null string.

The syntax for this function:

.. code-block:: ruby

   mustache_template('message_type = {{message.json_attribute}}')

where:

* ``message_type`` is a string that represents the message type
* ``message`` is the JSON message to be passed in
* ``json_attribute`` is a user-defined value in the JSON object

For example:

.. code-block:: ruby

   rule 'test_rule' on action 
     when
       true
     then
       set(#foo, mustache_template('Organization = {{message.organization_name}}.'))
   end

For more information on the Mustache template format, see https://mustache.github.io.

notify()
-----------------------------------------------------
Use ``notify()`` to configure notifications for a rule. Notifications may be sent with the following notification types: email, webhook, HipChat, and Splunk.

The syntax for this function:

.. code-block:: ruby

   notify(notificationName, stringTemplate)

where:

* ``notificationName`` is the name of the notification to trigger.
* ``stringTemplate`` is an optional Mustache template that defines the notification. The template must evaluate to a valid JSON string.

Field names in the Mustache template must be prefixed by ``message.``, e.g. ``{{message.reported_at}}`` using :ref:`a valid field name for the message type <analytics_rules-message-types>`. For more information on the Mustache template format, see https://mustache.github.io.

For example:

.. code-block:: ruby

   rules 'Send notification'
     rule on action
       when
         organization_name = 'ponyville' and
         (entity_type = 'foo' or entity_type = 'bar') and
         remote_hostname =~ '33\.3[0-9].*'
       then
         set value #foo = '100'
         set value #xyz = 'test'
         notify('slack', '{
           "text": "{{message.requestor_name}} did something at {{message.recorded_at}}!"
         }')
     end
   end

set()
-----------------------------------------------------
Use ``set()`` to set a user-defined value in the JSON object. A user-defined value always begins with ``#``. Prepend values saved by the ``set()`` function with ``user_defined_values`` to access them later from a ``notify()`` or ``alert()`` function.  Values that are not user-defined may not be modified.

The syntax for this function:

.. code-block:: ruby

   set(#variableToSet, valueToSet)

where:

* ``variableToSet`` is the location of a user-defined value
* ``valueToSet`` is the value

For example:

.. code-block:: ruby

   set(#organization_name, 'ponyville')

Later on in the same rule or another rule in the same group, do:

.. code-block:: ruby

   alert:warn("Check out the org name {{user_defined_values.#organization_name}}")

Examples
=====================================================
The following examples show how to define Chef Analytics rules.

Always Run a Rule
-----------------------------------------------------
A rule that always fire for the specified message type:

.. code-block:: ruby

   rule "test_rule" on action
   when
     true
   then
     notify("some_alias")
   end

where every ``action`` will notify ``"some_alias"``.

Raise Audit
-----------------------------------------------------
.. tag analytics_rules_raise_audit

The following rule raises an alert when a ``run_control_group`` fails, signifying that one or more controls failed:

.. code-block:: javascript

    rules "throw errors on control group failure"
     rule on run_converge
     when
       true
     then
       alert:info("Run converge detected at {{ message.end_time }} ")
     end

     rule on run_control_group
     when
       true
     then
       // the run_control_group name will appear in double quotes
       alert:info("Run control group \"{{ message.name }}\" failed on {{ message.run.node_name }}")
     end
   end

.. end_tag

.. _analytics_rules_send_a_notification:

Send a Notification
-----------------------------------------------------
Using the ``notify()`` function, notifications can be sent when a rule's conditions are met.

Once you've created a notification you'll use its name as the first argument given to the ``notify()`` function. For example, suppose you've created a notification with the name ``email-admins``:

.. image:: ../../images/analytics_email_notification_name.png

This notification could then be triggered by creating a rule that calls ``notify()``, e.g.:

.. code-block:: ruby

   notify("email-admins", "Your message here.")

The below rule would trigger this notification for every ``run_start`` message:

.. code-block:: ruby

   rule "Email notification" on run_start
   when
     true
   then
     notify("email-admins", "Run started on {{message.node_name}}")
   end

Regular Expressions
-----------------------------------------------------
.. tag analytics_rules_regular_expression

The following rule shows using a regular expression:

.. code-block:: none

   rules "user-agent matching"
     rule on action
     when
       get(#user_agent, false) != false
     then
       log("Something else set #user_agent")
     end

     rule on action
     when
       // match if the user_agent starts with the string "Chef Manage"
       user_agent =~ "Chef Manage.*"
     then
       // if #user_agent has been set before
       // this command will overwrite it's value
     set(#user_agent, "Chef Manage")
     end

     rule on action
     when
       // match if the user_agent starts with the string "Chef Client"
       user_agent =~ "Chef Client.*"
     then
       set(#user_agent, "Chef Client")
     end

     rule on action
     when
       get(#user_agent, false) != false
     then
       alert:info("User agent {{user_defined_values.#user_agent}}")
     end
   end

.. end_tag

Notify on Port 23
-----------------------------------------------------
The following rule shows how to define a rule that sends a notification when a machine is listening for connections on port 23:

.. code-block:: ruby

   rules "pci check telnet port"
     rule on run_control
     when
       name = "should be listening" and
       resource_type = "port" and
       resource_name = 23 and
       status != "success"
     then
       alert:error("Encrypt all non-console administrative access such as browser/Web-based management tools.")
       notify("some_alias", "A machine is listening for connections on port 23!")
     end
   end

User-defined Values
-----------------------------------------------------
The following rule sets, and then uses a user-defined value:

.. code-block:: none

   rules "user-agent matching"
     rule on action
     when
       entity_name = "app1"
     then
       set(#foo, requestor_name)
     otherwise
       set(#bar, task)
     end

     // ... other rules could go here

     rule on action
     when
       // #foo might be undefined, so use get()
       // to supply a default value of false to perform the
       // test
       get(#foo, false) != false
     then
       alert:info(#foo)
     end
   end

Verify Dates
-----------------------------------------------------
The following rule checks the day of the week on which an action runs:

.. code-block:: none

   rules "Check deploy day of week"
     rule "my rule" on action
     when
       // DAY_OF_WEEK uses 1 -> 7 for Monday -> Sunday
       datetime:component(recorded_at, "DAY_OF_WEEK") >= 5
     then
       // set a user defined value
       set(#alert, 'action detected on a Friday, Saturday, or Sunday'), 
     end
   end

Verify Resource Updates
-----------------------------------------------------
.. tag analytics_rules_verify_resource_updates

The following rule verifies if resources have been updated on a ``run_converge``:

.. code-block:: ruby

   rules "Match a run converge"
     rule on run_converge
     when
       total_resource_count > 1 and 
       updated_resource_count > 0
     then
       alert:info("Run converge detected at {{ message.end_time }} ")
     end
   end

.. end_tag

Verify Run-lists
-----------------------------------------------------
.. tag analytics_rules_verify_run_lists

The following rule verifies if a specific role appears in a run-list:

.. code-block:: ruby

   rules "Check a converge run_list"
     rule on run_converge
     when
       array:contains(run_list, 'role[opscode-reporting]')
     then
       alert:info("run_list contains role[opscode-reporting]")
     end
   end

.. end_tag

