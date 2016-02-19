.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.



The maximum field length setting for |apache solr| should be greater than any expected node object file sizes in order for them to be successfully added to the search index. If a node object file is greater than the maximum field length, the node object will be indexed up to the maximum, but the part of the file past that limit will not be indexed. If this occurs, it will seem as if nodes disappear from the search index. To ensure that large node file sizes are indexed properly, verify the following configuration settings:

``nginx['client_max_body_size']``
   |nginx client_max_body_size| Default value: ``250m``.

and

``opscode-erchef']['max_request_size']``
   Default value: ``1000000``.

to ensure that those settings are not part of the reasons for incomplete indexing, and then update the following setting so that its value is greater than the expected node file sizes:

``opscode_solr4['max_field_length']``
   |solr_max_field_length| Default value: ``100000`` (increased from the |apache solr| default value of ``10000``).

Use the ``wc`` command to get the character count of a large node object file. For example:

.. code-block:: bash

   $ wc -w NODE_NAME.json

and then ensure there is a buffer beyond that value. For example, verify the size of the largest node object file:

.. code-block:: bash

   $ wc -w nodebsp2016.json

which returns ``154516``. Update the ``opscode_solr4['max_field_length']`` setting to have a value greater than the returned value. For example: ``180000``.
