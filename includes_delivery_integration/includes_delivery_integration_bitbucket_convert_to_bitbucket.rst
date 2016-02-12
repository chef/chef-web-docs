.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To convert a project that is integrated with |chef delivery| to one that is integrated with |bitbucket|:

#. Ensure that a project repository exists in |bitbucket| with at least one commit.
#. Ensure that the service account used by |chef delivery| has full access to this project repository.
#. Ensure that team members who will use this project have read-only access to this project repository. (|chef delivery| will manage the creation and merging of pull requests.)
#. In the |chef delivery| web user interface, open the **Organizations** page.
#. Click the pencil button for the project to be updated.
#. Click the **Bitbucket** tab.
#. Enter the project key and the project repository name.
#. Click **Save and Close**.
