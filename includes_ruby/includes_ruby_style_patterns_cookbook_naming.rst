.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

* Avoid dashes in cookbook names. This is because many custom resources use the cookbook name as part of the resource name, so the method names themselves can become awkward, but also ``-`` cannot be part of a symbol in |ruby| and the presence of dashes in cookbook names may trigger undesired errors later on in the process
* All organization application cookbooks should be prefixed with a short organizational prefix, such as 'sm' for 'SecondMarket' (e.g. 'smpostgresql')
