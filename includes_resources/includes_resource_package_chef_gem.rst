.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use the |resource chef_gem| resource to install a |gem| only for the instance of |ruby| that is dedicated to the |chef client|. When a package is installed from a local file, it must be added to the node using the |resource remote_file| or |resource cookbook_file| resources.

The |resource chef_gem| resource works with all of the same properties and options as the |resource package_gem| resource, but does not accept the ``gem_binary`` property because it always uses the ``CurrentGemEnvironment`` under which the |chef client| is running. In addition to performing actions similar to the |resource package_gem| resource, the |resource chef_gem| resource does the following:

* Runs its actions immediately, before convergence, allowing a |gem| to be used in a recipe immediately after it is installed
* Runs ``Gem.clear_paths`` after the action, ensuring that |gem| is aware of changes so that it can be required immediately after it is installed
