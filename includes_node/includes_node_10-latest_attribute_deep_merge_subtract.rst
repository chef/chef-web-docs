.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A special knockout prefix---``!merge``---could be used with attribute values to make the deep merge algorithm remove values from arrays. This feature is seldom used, often confusing, and its use greatly increased the time and space complexity of the deep merge implementation. 

For example, substituting an existing string in an array::

   role_or_environment 1 [ '1', '2' ]
   +
   role_or_environment 2 [ '!merge:2', '3' ]
   =
   [ '1', '3' ]

The ``!merge`` knockout prefix is removed from the |chef client|, starting with version 11.0.0 and any use of the ``!merge`` knockout prefix will trigger an error upon merge. A better way to handle selectively removing elements from arrays is to place this type of logic in an attributes file.
