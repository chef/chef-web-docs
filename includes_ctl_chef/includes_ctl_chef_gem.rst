.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``chef gem`` subcommand is a wrapper around the ``gem`` command in |rubygems| and is used by |chef| to install |rubygems| into the |chef dk| development environment. All |knife| plugins, drivers for |kitchen|, and other |ruby| applications that are not packaged within the |chef dk| will be installed to the ``.chefdk`` path in the home directory: ``~/.chefdk/gem/ruby/ver.si.on/bin`` (where ``ver.si.on`` is the version of |ruby| that is packaged within the |chef dk|).
