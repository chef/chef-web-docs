.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


RSA public key-pairs are used to authenticate the |chef client| with the |chef server| every time a |chef client| needs access to data that is stored on the |chef server|. This prevents any node from accessing data that it shouldn't and it ensures that only nodes that are properly registered with the |chef server| can be managed.
