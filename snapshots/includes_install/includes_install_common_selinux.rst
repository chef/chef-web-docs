.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 

On CentOS and Red Hat Enterprise Linux systems, SELinux is enabled in enforcing mode by default. The Chef server does not have a profile available to run under SELinux. In order for the Chef server to run, SELinux must be disabled or set to ``Permissive`` mode.

To determine if SELinux is installed, run the following command:

.. code-block:: bash

   $ getenforce

If a response other than ``"Disabled"`` or ``"Permissive"`` is returned, SELinux must be disabled.

To set SELinux to ``Permissive`` mode, run:

.. code-block:: bash

   $ setenforce Permissive

and then check the status:

.. code-block:: bash

   $ getenforce
