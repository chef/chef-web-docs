.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 

On |centos| and |redhat enterprise linux| systems, |selinux| is enabled in enforcing mode by default. The |chef server| does not have a profile available to run under |selinux|. In order for the |chef server| to run, |selinux| must be disabled or set to ``Permissive`` mode.

To determine if |selinux| is installed, run the following command:

.. code-block:: bash

   $ getenforce

If a response other than ``"Disabled"`` or ``"Permissive"`` is returned, |selinux| must be disabled.

To set |selinux| to ``Permissive`` mode, run:

.. code-block:: bash

   $ setenforce Permissive

and then check the status:

.. code-block:: bash

   $ getenforce
