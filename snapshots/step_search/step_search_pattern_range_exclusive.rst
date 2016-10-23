.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A data bag named ``sample`` contains four data bag items: ``abc``, ``bar``, ``baz``, and ``quz``. All of the items that are exclusive to ``bar`` and ``foo`` can be searched for using an exclusive search pattern.

To search using an exclusive range, enter the following:

.. code-block:: bash

   $ knife search sample "id:{bar TO foo}"

where curly braces (``{ }``) are used to define the range.
   
