.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

* Avoid hyphens and other non-alphanumeric characters in cookbook names.  :doc:`Custom resource </custom_resources>` names are generated from the cookbook name and the resource file name, with any non-alphanumeric characters replaced by underscores (``_``). As a result, those resources' names may be different from what you expect, making them especially error-prone.
* All organization application cookbooks should be prefixed with a short organizational prefix, such as ``sm`` for "SecondMarket" (e.g.  ``smpostgresql``).
