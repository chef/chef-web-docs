.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use a comment to document the behavior of the rules. A comment starts with a double forward slash---``//``---and continues to the end of the line on which the comment started. For example:

.. code-block:: ruby

   rules 'user-agent matching'
     rule on action
     when
       // this rule always matches
       true
     then
       // raise an audit for every action
       ':info('This rule matches all actions')
     end
   end
