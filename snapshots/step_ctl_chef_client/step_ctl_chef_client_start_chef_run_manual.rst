.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To start a chef-client run manually, enter something like:

.. code-block:: bash

   $ ps auxw|grep chef-client

to return something like:

.. code-block:: bash

   root           66066   0.9  0.0  2488880    264 s001  S+   10:26AM   0:03.05
   /System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/bin/ruby /usr/bin/chef-client -i 3600 -s 20

and then enter:

.. code-block:: bash

   $ sudo kill -USR1 66066





