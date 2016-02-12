.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the following steps to create a change in |chef delivery|:

#. Create and check out a topic branch for the change, based on the current state of your project's pipeline (usually from ``master``). For example: ``git checkout -b great-feature``.
#. Make and commit changes to the project as normal.
#. Submit the change to |chef delivery| with the command ``delivery review``. This command will open a URL at which details and progress of the change may be viewed from the |chef delivery| webui.
#. Verification of changes will begin automatically and a corresponding pull request will be opened in |bitbucket|.
