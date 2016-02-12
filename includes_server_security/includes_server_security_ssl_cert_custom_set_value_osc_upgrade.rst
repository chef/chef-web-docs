.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


After an upgrade to |chef server| 12 from |chef server osc|, you may continue using the |ssl| certificates that were used with |chef server osc| with |chef server| 12. There are two options: move the |ssl| certificates to a new directory in |chef server| 12 or adding two settings to the |chef server rb| file, and then specifying the paths to the directory in which the |ssl| certificate files are located.
