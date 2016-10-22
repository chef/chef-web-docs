.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A wildcard matching pattern can be used for substring matches that replace zero (or more) characters. There are two types of wildcard patterns:

* A question mark ("?") can be used to replace exactly one character (as long as that character is not the first character)
* An asterisk ("*") can be used to replace any number of characters (including zero)

Wildcard patterns must be escaped (using a backslash) so that the wildcard itself can reach the Chef server. If they are not escaped, the wildcard is expanded into the actual filenames and knife will not know the wildcard was intended to be used. For example, if the Chef server has data bags named ``aardvarks``, ``anagrams``, and ``arp_tables``, but the local file system only has ``aardvarks`` and ``anagrams``, escaping vs. not escaping the wildcard pattern will yield different results:

.. code-block:: bash

   $ knife list data_bags/a\*

asks the Chef server for everything starting with the letter "a" and will return:

.. code-block:: bash

   $ aardvarks/ anagrams/ arp_tables/

But, the following:

.. code-block:: bash

   $ knife list data_bags/a*

will return:

.. code-block:: bash

   $ aardvarks/ anagrams/

Which is the same as entering:

.. code-block:: bash

   $ knife list data_bags/aardvarks data_bags/anagrams

to return:

.. code-block:: bash

   $ aardvarks/ anagrams/
