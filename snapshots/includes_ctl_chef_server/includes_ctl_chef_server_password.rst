.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``password`` subcommand is used to change a user's password. When Active Directory or LDAP is enabled, this command enables (or disables) the system recovery password for that user. For example:

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-server-ctl password USERNAME

This subcommand has the following options:

``--disable``
   Use this option to disable a user's system recovery password.

**Examples**

For example, to change a user's password, enter:

.. code-block:: bash

   $ chef-server-ctl password adamjacobs

and then enter the password and confirm it:

.. code-block:: bash

   Enter the new password:  ******
   Enter the new password again:  ******

to return:

.. code-block:: bash

   Password for adamjacobs successfully set.

To disable a system recovery password:

.. code-block:: bash

   $ chef-server-ctl password adamjacobs --disable

to return:

.. code-block:: bash

   Password for adamjacobs successfully disabled for System Recovery.
