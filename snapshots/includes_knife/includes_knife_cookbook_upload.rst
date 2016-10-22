.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``upload`` argument to upload one or more cookbooks (and any files that are associated with those cookbooks) from a local repository to the Chef server. Only files that do not already exist on the Chef server will be uploaded.

.. note:: Use a chefignore file to prevent the upload of specific files and file types, such as temporary files or files placed in folders by version control systems. The chefignore file must be located in the root of the cookbook repository and must use rules similar to filename globbing (as defined by the Ruby ``File.fnmatch`` syntax).

.. note:: Empty directories are not uploaded to the Chef server. To upload an empty directory, create a "dot" file---e.g. ``.keep``---in that directory to ensure that the directory itself is not empty.

