=====================================================
Integrate Chef Automate with |github|
=====================================================

.. include:: ../../includes_chef_automate/includes_chef_automate_mark.rst 

You may integrate |automate| and |github enterprise| or a project that is hosted at |github com|. If you do this, you will be able to use |github| as a **Source Code Provider** when creating a project. Additionally, when adding users to |delivery|, to integrate them to a |github| project, you must first complete the integration between |delivery| and |github|.

.. note:: This procedure is for |delivery| deployments that will use |github enterprise| or |github com| as the source control manager. |delivery| also comes with default |git| capabilities that do not require the |github| |oauth| application.

This guide assumes you have successfully set up the following:

* A |automate| server set up
* User accounts in |github enterprise| and |delivery| with matching usernames
* Have established SSL trust between |automate| and |github enterprise| servers

Trust SSL Certificate
=====================================================
.. include:: ../../includes_delivery_integration/includes_delivery_integration_github_ssl_trust.rst

|debian|
-----------------------------------------------------
.. include:: ../../includes_delivery_integration/includes_delivery_integration_github_ssl_trust_debian.rst

RHEL, Centos
-----------------------------------------------------
.. include:: ../../includes_delivery_integration/includes_delivery_integration_github_ssl_trust_rhel_centos.rst

Create |github| OAuth App
=====================================================
.. include:: ../../includes_delivery_integration/includes_delivery_integration_github_create_oauth_app.rst

Add App to Chef Automate
=====================================================
.. include:: ../../includes_delivery_integration/includes_delivery_integration_github_add_to_delivery.rst

Request |github| Token
=====================================================
.. include:: ../../includes_delivery_integration/includes_delivery_integration_github_request_token.rst

Create a Project
=====================================================
.. include:: ../../includes_delivery_integration/includes_delivery_integration_github_create_project.rst 

Add Linked Users
=====================================================
.. include:: ../../includes_delivery_integration/includes_delivery_integration_github_add_linked_users.rst

Initialize a Project
=====================================================
.. include:: ../../includes_delivery_integration/includes_delivery_integration_github_initialize_project.rst

Handle Untrusted PRs
=====================================================
.. include:: ../../includes_delivery_integration/includes_delivery_integration_github_untrusted_prs.rst