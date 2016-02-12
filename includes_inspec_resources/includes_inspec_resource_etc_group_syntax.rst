.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A ``etc_group`` |inspec resource| block declares a collection of properties to be tested:

.. code-block:: ruby

   describe etc_group('path') do
     its('matcher') { should eq 'some_value' }
   end

or:

.. code-block:: ruby

   describe etc_group.where(item: 'value', item: 'value') do
     its('gids') { should_not contain_duplicates }
     its('groups') { should include 'user_name' }
     its('users') { should include 'user_name' }
   end

where

* ``('path')`` is the non-default path to the ``inetd.conf`` file
* ``.where()`` may specify a specific item and value, to which the matchers are compared
* ``'gids'``, ``'groups'``, and ``'users'`` are valid matchers for this |inspec resource|
