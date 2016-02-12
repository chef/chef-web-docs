.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Runs as root. Use the default recipe to install on the build nodes dependencies required for the phase recipes to execute successfully. For example, if you needed to build and test |docker| containers, this is the recipe where you would install |docker|. It will be run prior to running a phase recipe.
