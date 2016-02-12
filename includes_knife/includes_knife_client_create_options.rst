.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This argument has the following options:

``-a``, ``--admin``
   |admin client|  |knife open_source_only|

``-f FILE``, ``--file FILE``
   |file private_key|

``-k``, ``--prevent-keygen``
   |key prevent_keygen|

   .. note:: .. include:: ../../includes_notes/includes_notes_knife_prevent_keygen.rst

``-p FILE``, ``--public-key FILE``
   |file public_key| This option may not be passed in the same command with ``--prevent-keygen``. |key generated_if_not_passed|

``--validator``
   |create chef_validator| Default value: ``true``.

