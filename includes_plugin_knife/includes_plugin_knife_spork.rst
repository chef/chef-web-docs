.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``knife-spork`` plugin adds workflow that enables multiple developers to work on the same |chef server| and repository, but without stepping on each other's toes. This plugin is designed around the workflow at Etsy, where several people work in the same repository and |chef server| simultaneously. A quick overview of the arguments in this plugin (see the |github| documentation for full details):

``knife spork bump``
   Version cookbooks without updating the |metadata rb| file.

``knife spork check``
   View cookbook version numbers to avoid reuse of existing cookbook version numbers and to ensure that versioned changes are not overwritten.

``knife spork data bag``
   A collection of wrappers around the ``knife data bag`` group of commands. These behave exactly the same as the base commands, but also use the ``knife-spork`` API.

``knife spork environment``
   A collection of wrappers around the ``knife environment`` group of commands. These behave exactly the same as the base commands, but also use the ``knife-spork`` API.

``knife spork environment check``
   Validate that a local environment file is locked to versions that actually exist on the |chef server|.

``knife spork info``
   View a list of currently-loaded |knife| plugins.

``knife spork node``
   A collection of wrappers around the ``knife node`` group of commands. These behave exactly the same as the base commands, but also use the ``knife-spork`` API.

``knife spork omni``
   Combine ``knife-spork`` arguments into a single command.

``knife spork promote``
   Set a version constraint on an environment (or group of environments) for the named cookbook.

``knife spork role``
   A collection of wrappers around the ``knife role`` group of commands. These behave exactly the same as the base commands, but also use the ``knife-spork`` API.

``knife spork upload``
   Upload a cookbook to the |chef server| and freeze it.
