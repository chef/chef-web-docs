.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


.. warning:: The direct use of ``updated_by_last_action`` is deprecated; any provider that is using this method must be updated to use the ``use_inline_resources`` method instead. For actions that modify the system state, define them with core Chef resources or group them within ``converge_by`` blocks.
