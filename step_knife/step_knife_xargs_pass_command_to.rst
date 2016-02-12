.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following examples show various ways of listing all nodes on the server, and then using |perl| to replace ``grantmc`` with ``gmc``:

.. code-block:: bash

   $ knife list 'nodes/*' | knife xargs "perl -i -pe 's/grantmc/gmc'"

or without quotes and the backslash escaped:

.. code-block:: bash

   $ knife list /nodes/\* | knife xargs "perl -i -pe 's/grantmc/gmc'"

or by using the ``--pattern`` option:

.. code-block:: bash

   $ knife xargs --pattern '/nodes.*' "perl -i -pe 's/grantmc/gmc'"
