.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A rule that always fire for the specified message type:

.. code-block:: ruby

   rule "test_rule" on action
   when
     true
   then
     notify("some_alias")
   end

where every ``action`` will notify ``"some_alias"``.
