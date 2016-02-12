.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The |chef dk| defines a common workflow for cookbook development:

#. Create a skeleton cookbook. This is a cookbook with the standard files already included. The package manager is often |berkshelf|, which is included as part of the |chef dk|, plus a revision control system, typically |git|. |berkshelf| helps manage cookbooks and cookbook dependencies.

#. Create a virtual machine environment using |kitchen|. This is the environment that will be used to develop the cookbook, including the location in which automated testing and debugging of that cookbook will be done as it is being developed.

#. Write the recipes for the cookbook and debug those recipes as they are being written. This is typically an iterative process, where cookbook are tested as they are developed, bugs are fixed quickly, and then cookbooks are tested again. A text editor---|sublime|, |vim|, TextMate, EditPad, or any other preferred text editor---is used to author the files in the cookbook. 

#. Perform acceptance tests. These tests are not done in a development environment, but rather are done against a full |chef server| using an environment that matches the production environment as closely as possible.

#. When the cookbooks pass all the acceptance tests and have been verified to work in the desired manner, deploy the cookbooks to the production environment.
