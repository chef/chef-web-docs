.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This subcommand has the following options:

``-a ATTR``, ``--attribute ATTR``
   The attribute (or attributes) to show.

``-b ROW``, ``--start ROW``
   The row at which return results begin.

``-i``, ``--id-only``
   Show only matching object IDs.

``INDEX``
   The name of the index to be queried: ``client``, ``environment``, ``node``, ``role``, or ``DATA_BAG_NAME``. Default index: ``node``.

``-l``, ``--long``
   Display all attributes in the output and show the output as JSON.

``-m``, ``--medium``
   Display normal attributes in the output and to show the output as JSON.

``-o SORT``, ``--sort SORT``
   The order in which search results are to be sorted.

``-q SEARCH_QUERY``, ``--query SEARCH_QUERY``
   Protect search queries that start with a hyphen (-). A ``-q`` query may be specified as an argument or an option, but not both.

``-r``, ``--run-list``
   Show only the run-list.

``-R INT``, ``--rows INT``
   The number of rows to be returned.

``SEARCH_QUERY``
   The search query used to identify a list of items on a Chef server. This option uses the same syntax as the ``search`` subcommand.
