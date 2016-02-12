.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

|erchef| is a complete rewrite of the core API for the |chef server|, which allows it to be faster and more scalable than previous versions. The API itself is still compatible with the original |ruby|-based |chef server|, which means that cookbooks and recipes that were authored for the |ruby|-based |chef server| will continue to work on the |erlang|-based |chef server|. The |chef client| is still written in |ruby|.

.. note:: Even though the |chef server| is authored in |erlang|, writing code in |erlang| is NOT a requirement for using |chef|.
