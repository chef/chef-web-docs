.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following examples show how the logic works for adding a string using a hash::

   role_or_environment 1 { :x => '1', :y => '2' }
   +
   role_or_environment 2 { :z => '3' }
   =
   { :x => '1', :y => '2', :z => '3' }

For adding a string using an array::

   role_or_environment 1 [ '1', '2' ]
   +
   role_or_environment 2 [ '3' ]
   =
   [ '1', '2', '3' ]

For adding a string using a multi-level hash::

   role_or_environment 1 { :x => { :y => '2' } }
   +
   role_or_environment 2 { :x => { :z => '3' } }
   =
   { :x => { :y => '2', :z => '3' } }

For adding a string using a multi-level array::

   role_or_environment 1 [ [ 1, 2 ] ]
   +
   role_or_environment 2 [ [ 3 ] ]
   =
   [ [ 1, 2 ], [ 3 ] ]
