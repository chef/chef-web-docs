.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The chefignore file is used to tell knife which cookbook files in the chef-repo should be ignored when uploading data to the Chef server. The type of data that should be ignored includes swap files, version control data, build output data, and so on. The chefignore file uses the ``File.fnmatch`` Ruby syntax to define the ignore patterns using ``*``, ``**``, and ``?`` wildcards.

* A pattern is relative to the cookbook root
* A pattern may contain relative directory names
* A pattern may match all files in a directory

The chefignore file is located at the root of the ``/cookbooks`` subdirectory in the chef-repo. It should contain sections similar to the following:

.. code-block:: none

   # section
   *ignore_pattern

   # section
   ignore_pattern*
   
   # section
   **ignore_pattern

   # section
   ignore_pattern**
   
   # section
   ?ignore_pattern

   # section
   ignore_pattern?
