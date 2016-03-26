.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use the |resource registry_key| resource to create and delete registry keys in |windows|.

64-bit versions of |windows| have a 32-bit compatibility layer in the registry that reflects and redirects certain keys (and their sub-keys) into specific locations (or logical views) of the registry hive.

The |chef client| can access any reflected or redirected registry key. The machine architecture of the system that |chef client| is running on is used as the default (i.e., non-redirected) location. If it is required to access the redirected ``SysWow64`` location, the architecture must be specified explicitly. Usually, this is only necessary to retain compatibility with 32-bit applications running on a 64-bit OS.

Both 32-bit (i.e., all versions prior to 12.9) and 64-bit versions of |chef client| generally behave the same, except that it is only possible to read or write from a redirected registry location when the |chef client| is running on a 64-bit OS.

For more information, see: |url msdn_registry_key|.
