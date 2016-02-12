.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

You may integrate |chef delivery| and |github enterprise| or a project that is hosted at |github com|. If you do this, you will be able to use |github| as a **Source Code Provider** when creating a project. Additionally, when adding users to |chef delivery|, to integrate them to a |github| project, you must first complete the integration between |chef delivery| and |github|.

.. note:: This procedure is for |chef delivery| deployments that will use |github enterprise| or |github com| as the source control manager. |chef delivery| also comes with default |git| capabilities that do not require the |github| |oauth| application.

This guide assumes you have successfully set up the following:

* A |chef delivery| cluster using the ``delivery-cluster`` cookbook (https://github.com/opscode-cookbooks/delivery-cluster)
* User accounts in |github enterprise| and |chef delivery| with matching usernames
* Have established SSL trust between |chef delivery| and |github enterprise| servers
