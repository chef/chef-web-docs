.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This behavior creates issues for notifications, because notifications that are triggered embedded resources are not able to notify anything that has already finished processing. This behavior is changed in the 11.0.0 (and later) versions of the |chef client| with the addition of the ``use_inline_resources`` method to the `provider DSL <https://docs.chef.io/lwrp_custom_provider.html#use-inline-resources>`_.
