.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


|berkshelf| can include multiple |supermarket| instances for dependency resolution. Cookbook dependency resolution is performed from the top down. The first source defined in the |berksfile| will be searched for the cookbook before the second source.

The |berksfile| first looks for the cookbook on the private |supermarket| and, if not discovered there, then looks on the public |supermarket|.

.. code-block:: ruby

   source 'https://your_private_supermarket_url'
   source 'https://supermarket.chef.io'
