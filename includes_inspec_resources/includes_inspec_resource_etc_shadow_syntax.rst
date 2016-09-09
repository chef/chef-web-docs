.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A ``shadow`` |inspec resource| block declares one (or more) users and associated user information to be tested:

.. code-block:: ruby

   describe shadow do
     its('users') { should_not include 'forbidden_user' }
   end

or with a filter:

.. code-block:: ruby

   describe shadow.uid(filter) do
     its('users') { should cmp 'root' }
     its('count') { should eq 1 }
   end

where

* ``homes``, ``gids``, ``passwords``, ``shells``, ``uids``, and ``users`` are valid accessors for ``passwd``
* ``filter`` one (or more) arguments, for example: ``passwd.users(/name/)`` used to define filtering; ``filter`` may take any of the following arguments: ``count`` (retrieves the number of entries), ``lines`` (provides raw ``passwd`` lines), and ``params`` (returns an array of maps for all entries)
