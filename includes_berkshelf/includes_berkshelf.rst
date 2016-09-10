.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

|berkshelf| is a dependency manager for community cookbooks that stores every version of a cookbook that has ever been installed. It is located on the local disk that contains cookbooks uploaded to the |chef server| and their dependencies. By default, |berkshelf| is located at ``~/.berkshelf``, but this may be modified by setting the ``BERKSHELF_PATH`` environment variable.

.. note:: The |berkshelf| is an alternate pattern of cookbook storage that places all its cookbooks within directories that follow the ``{name}-{version}`` convention, rather than placing all of the cookbooks within ``/cookbooks`` in the |chef repo|.
