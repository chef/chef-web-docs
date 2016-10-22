.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 

The installation process for the Chef server requires the use of at least two user and group identifiers (UIDs and GIDs). These are used to create the ``opscode`` and ``opscode-pgsql`` users and their default groups.

.. note:: The creation of required user and group identifiers is done **automatically** during the installation process for the Chef server; however, the following user and group accounts **may** be created in advance of installing the Chef server if specific UIDs and GIDs are preferred. The user **and** group must be created as a pair to satisfy reconfiguration requirements.

   * A local user account named ``opscode`` under which services will run
   * A local user account named ``opscode-pgsql`` that is used by PostgreSQL
   * A group account for each user account, one named ``opscode`` and the other named ``opscode-pgsql`` under which services will run

.. warning:: If the UID and GID of ``opscode`` and ``opscode-pgsql`` do not match on both backend Chef server machines, a high availability configuration will not run correctly.

   The embedded Chef server cookbooks can handle two cases:

   * Both ``opscode`` and ``opscode-pgsql`` user and group not found on the new server
   * Both ``opscode`` and ``opscode-pgsql`` user and group found on the new server

   Having only the group and not the corresponding users present during a chef-server-ctl reconfigure is unsupported and may lead to an error in the reconfiguration run.

   To determine the current range of IDs, run the following command:

   .. code-block:: bash

      $ grep -E '(UID|GID)' /etc/login.defs

   The defaults for CentOS and Red Hat Enterprise Linux systems look like this:

   .. code-block:: bash

      UID_MIN             500
      UID_MAX           60000
      GID_MIN             500
      GID_MAX           60000

   If the defaults have been changed for any reason, and if that change would result in less than 2 UID/GIDs being available to the ``useradd`` program, edit ``/etc/login.defs`` with changes to make at least 2 more UIDs and GIDs available for association. The currently used ID ranges for UIDs and GIDs can be found in ``/etc/passwd`` and ``/etc/group``, respectively.

   If the ``opscode`` and ``opscode-pgsql`` user and group identifiers exist prior to installing the Chef server, the Chef server installation process will use the existing identifiers instead of creating them.
