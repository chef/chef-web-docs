.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use ``standalone_comments`` to parse comments as a line, otherwise inline comments are allowed:

.. code-block:: ruby

   'key = value # comment'
   params['key'] = 'value # comment'


Use ``standalone_comments: false``, to parse the following:

.. code-block:: ruby

   'key = value # comment'
   params['key'] = 'value'
