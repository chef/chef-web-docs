.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

You must associate a |github| user with a |chef delivery| user in order to successfully create changes from |github| pull requests.

To onboard a user for an integrated |github enterprise| project or one that is hosted at |github com|:

#. Have the user that you want to add clone the repo for the project you want them to join. Ensure that they have write permissions to the repo if you want to allow them to submit pull requests.
#. Add or edit any users who are managed by the LDAP integration.
#. From a local checkout of a |chef delivery| project, run the appropriate |chef delivery| command that associates a |github| user with a |chef delivery| user.

   .. note:: The |chef delivery_cli| commands are for a user to link their own account to |github|, or others if the user has the **Admin** role; ``api`` is an argument to the |chef delivery_cli| CLI command. The ``delivery-ctl`` command can only be run by an administrator from the |chef delivery| server and can affect any user.

   For |github enterprise|:

   .. code-block:: bash

      $ delivery api put users/$DELIVERY_USERNAME/set-oauth-alias --data='{"app_name":"github-enterprise","alias":"$GITHUB_USERNAME"}'

   For |github|:

   .. code-block:: bash

      $ delivery api put users/$DELIVERY_USERNAME/set-oauth-alias --data='{"app_name":"github","alias":"$GITHUB_USERNAME"}'

   *Or*, as an administrator, run the command line tool ``delivery-ctl``. The command uses the enterprise name you set when configuring |chef delivery|. The username can be an LDAP username (if LDAP integration has been completed), or an internal username:

    For |github enterprise|:

    .. code-block:: bash

       $ delivery-ctl link-github-enterprise-user $DELIVERY_ENTERPRISE_NAME $DELIVERY_USERNAME $GITHUB_USERNAME

    For |github|:

   .. code-block:: bash

      $ delivery-ctl link-github-user $DELIVERY_ENTERPRISE_NAME $DELIVERY_USERNAME $GITHUB_USERNAME

The associated user can now checkout the repository, make changes on a feature branch and submit the changes for review.

Note the following constraints:

* You may not link two |github| accounts to a single |chef delivery| user.
* Two users may not share a |github| account
