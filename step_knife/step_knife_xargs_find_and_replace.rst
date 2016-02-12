.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following example will go through all nodes on the server, and then replace the word ``foobar`` with ``baz``:

.. code-block:: bash

   $ knife xargs --pattern /nodes/* "perl -i -pe 's/foobar/baz'"
