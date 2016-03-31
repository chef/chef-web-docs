.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following sections describe the various settings that are available in the |chef compliance rb| file.

When changes are made to the |chef compliance rb| file the |chef compliance| server must be reconfigured by running the following command:

.. code-block:: bash

   $ chef-compliance-ctl reconfigure

.. warning:: All of the following settings should be specified without using the equals symbol (``=``). For example:

   .. code-block:: ruby

      verify_tls false

This configuration file has the following settings:

``core.licensed_node_count``
   The number of node licenses. Default value: ``25``.
