.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use ``mustache_template()`` to render an expression that is defined in a |mustache| template. If the |mustache| template is invalid, an error is logged and the expression will return an empty, non-null string.

The syntax for this function:

.. code-block:: ruby

   mustache_template('message_type = {{message.json_attribute}}')

where:

* ``message_type`` is a string that represents the message type
* ``message`` is the |json| message to be passed in
* ``json_attribute`` is a user-defined value in the |json| object

For example:

.. code-block:: ruby

   rule 'test_rule' on action 
     when
       true
     then
       set(#foo, mustache_template('Organization = {{message.organization_name}}.'))
   end

For more information on the |mustache| template format, see https://mustache.github.io.