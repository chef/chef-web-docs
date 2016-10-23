.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This argument has the following options:

``DATA_BAG_ITEM``
   The name of a specific item within a data bag.

``--secret SECRET``
   The encryption key that is used for values contained within a data bag item.

``--secret-file FILE``
   The path to the file that contains the encryption key.

.. note::  For encrypted data bag items, use *either* ``--secret`` or ``--secret-file``, not both.

