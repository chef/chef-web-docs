.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

|berkshelf| is a dependency manager for certain cookbook workflows. |berkshelf| stores every version of a cookbook that has ever been installed. It is located on the local disk that contains cookbooks uploaded to the |chef server| and their dependencies. By default, |berkshelf| is located at ``~/.berkshelf``, but this may be modified by setting the ``BERKSHELF_PATH`` environment variable.

.. note:: The |berkshelf| workflow is an older pattern of cookbook management that stores all the cookbooks within local directories using a ``{name}-{version}`` naming convention and does not place any cookbooks within the ``/cookbooks`` directory in the |chef repo|.
