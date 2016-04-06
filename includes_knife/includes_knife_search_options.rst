.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This subcommand has the following options:

``-a ATTR``, ``--attribute ATTR``
   |attribute_show|

``-b ROW``, ``--start ROW``
   |start|

``-f FILTER``, ``--filter-result FILTER``
   Use to filter the search output based on the pattern that match the specified ``FILTER``. Only attributes in the |``FILTER`` will be returned. For example: ``\"ServerName=name, Kernel=kernel.version\``.

   .. note:: .. include:: ../../includes_notes/includes_notes_filter_search_vs_partial_search.rst

``-i``, ``--id-only``
   |id_only|

``INDEX``
   |search_index| Default index: ``node``.

``-l``, ``--long``
   |show_all_attributes|

``-m``, ``--medium``
   |medium|

``-o SORT``, ``--sort SORT``
   |sort|

``-q SEARCH_QUERY``, ``--query SEARCH_QUERY``
   |query|

``-r``, ``--run-list``
   |run_list indicator|

``-R INT``, ``--rows INT``
   |rows|

``SEARCH_QUERY``
   |search_query|
