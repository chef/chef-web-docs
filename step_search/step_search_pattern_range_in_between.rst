.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A data bag named ``sample`` contains four data bag items: ``abc``, ``bar``, ``baz``, and ``quz``. All of the items in-between ``bar`` and ``foo``, inclusive, can be searched for using an inclusive search pattern.

To search using an inclusive range, enter the following:

.. code-block:: bash

   $ knife search sample "id:[bar TO foo]"

where square brackets (``[ ]``) are used to define the range.

     
