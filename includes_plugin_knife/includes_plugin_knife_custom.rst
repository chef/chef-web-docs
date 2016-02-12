.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The |chef client| will load |knife| and |knife| plugin commands from the following locations:

* The home directory: ``~/.chef/plugins/knife/``
* A ``.chef/plugins/knife`` directory in the cookbook repository
* A plugin installed from |rubygems|. (For more information about releasing a plugin on |rubygems|, see: http://guides.rubygems.org/make-your-own-gem/.)

This approach allows |knife| plugins to be reused across projects in the home directory, kept in a repository that is accessible to other team members, and distributable to the community using |rubygems|.
