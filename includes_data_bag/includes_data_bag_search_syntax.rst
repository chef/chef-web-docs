.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

In some situations, it may not be possible to know exactly which data bags (or data bag items) should be used. Or in other situations, loading all of the data in a data bag might be the desired result. Use the search index to find data that is stored in one or more data bags in the environment and use the various search patterns to fine-tune the search queries. Any data that is returned as the result of a search query can then be loaded by a recipe. Use the following syntax when searching for data in a data bag:

.. code-block:: ruby

   search(name_of_data_bag, search_query)

For example, to find every admin in a data bag named ``admins``:

.. code-block:: ruby

   search(:admins, '*:*')

Or, to search for an administrator with an ID of ``justin``:

.. code-block:: ruby

   search(:admins, 'id:justin')

Or, to search for all administrators with a group ID of ``ops``:

.. code-block:: ruby

   search(:admins, 'gid:ops')

Or, to search for all administrators with an ID that begins with the letter ``j``:

.. code-block:: ruby

   search(:admins, 'id:j*')

Once returned, this data can be used as if it were a |ruby hash|. For example:

.. code-block:: bash

   justin = search(:admins, "id:justin").first
   # => variable 'justin' is set to the justin data bag item
   justin["gid"]
   # => "ops"
   justin["shell"]
   # => "/bin/ssh"
