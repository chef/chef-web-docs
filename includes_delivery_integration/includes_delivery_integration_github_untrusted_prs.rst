.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


By default all pull requests from |github| users that are not linked with a |chef delivery| user will be ignored.

To accept pull requests from an unlinked user you may add the ``untrusted_github_user`` using the command below.

.. code-block:: bash

   $ sudo delivery-ctl create-user $DELIVERY_ENTERPRISE untrusted_github_user --roles=committer

A pull request opened by a |github| user who is not linked with a |chef delivery| user will be labeled as ``Quarantined``. A change for this pull request owned by ``untrusted_github_user`` will be created but the **Verify** stage will not be triggered. An authorized user may review the pull request and add a comment with ``@delivery review`` command to reassign the change to their user account and trigger the **Verify** stage.
