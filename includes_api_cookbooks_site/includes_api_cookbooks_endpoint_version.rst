.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A cookbook version always takes the form x.y.z, where x, y, and z are decimal numbers that are used to represent major (x), minor (y), and patch (z) versions. A two-part version (x.y) is also allowed. When passing a cookbook version using this method, underscores ("_") should be used as the separator between versions. For example, a cookbook with a version 1.0.1 would be 1_0_1.

The ``/cookbooks/[VERSION]`` endpoint has the following methods: ``DELETE`` and ``GET``.
