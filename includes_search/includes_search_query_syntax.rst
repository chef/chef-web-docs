.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


|search query syntax| A search query has the following syntax:

.. code-block:: ruby

   key:search_pattern

where ``key`` is a field name that is found in the |json| description of an indexable object on the |chef server| (a role, node, client, environment, or data bag) and ``search_pattern`` defines what will be searched for, using one of the following search patterns: exact, wildcard, range, or fuzzy matching. Both ``key`` and ``search_pattern`` are case-sensitive; ``key`` has limited support for multiple character wildcard matching using an asterisk ("*") (and as long as it is not the first character).