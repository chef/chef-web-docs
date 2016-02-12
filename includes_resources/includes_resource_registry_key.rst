.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use the |resource registry_key| resource to create and delete registry keys in |windows|.

64-bit versions of |windows| have a 32-bit compatibility layer in the registry that reflects and redirects certain keys (and their sub-keys) into specific locations. By default, the registry functionality will default to the machine architecture of the system that is being configured. The |chef client| can access any reflected or redirected registry key. The |chef client| can write to any 64-bit registry location. (This behavior is not affected by the |chef client| running as a 32-bit application.) For more information, see: |url msdn_registry_key|.
