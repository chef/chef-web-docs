.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``"build_nodes"`` section may also specify build nodes by stages and/or platform:

.. code-block:: javascript

   {
     ...
       "build_nodes": {
         "default"    : ["name:builder"],
         "unit"       : ["name:builder AND platform_family:platform"],
         "..."        : ["name:builder AND platform_family:platform"]
       }
     ...
   }

For example:

.. code-block:: javascript

   {
     ...
       "build_nodes": {
         "default"    : ["name:builder*.foo.com"],
         "unit"       : ["name:builder*.foo.com AND platform_family:debian"],
         "syntax"     : ["name:builder*.foo.com AND platform_family:rhel"],
         "publish"    : ["name:builder*.foo.com AND platform_family:debian", "name:builder*.foo.com AND platform_family:rhel"]
       }
     ...
   }
