.. THIS PAGE IS IDENTICAL TO docs.chef.io/chef_client.html BY DESIGN
.. THIS PAGE DOCUMENTS chef-client version 12.0

=====================================================
chef-client
=====================================================

.. include:: ../../includes_chef_client/includes_chef_client.rst

.. note:: The chef-client executable can be run as a daemon.

Node Types
=====================================================

.. include:: ../../includes_node/includes_node.rst

.. include:: ../../includes_node/includes_node_types.rst

.. include:: ../../includes_node/includes_node_components.rst

The chef-client Run
=====================================================
.. include:: ../../includes_chef_client/includes_chef_client_run.rst

chef-validator
-----------------------------------------------------
.. include:: ../../includes_security/includes_security_chef_validator.rst

.. include:: ../../includes_security/includes_security_chef_validator_context.rst

SSL Certificates
-----------------------------------------------------
.. include:: ../../includes_node/includes_node_certificate.rst

Signed Header Authentication
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_security/includes_security_signed_header_authentication.rst


audit-mode
=====================================================
.. include:: ../../includes_chef_client/includes_chef_client_audit_mode.rst

Use following option to run the chef-client in audit-mode mode:

``--audit-mode MODE``
   Enable audit-mode. Set to ``audit-only`` to skip the converge phase of the chef-client run and only perform audits. Possible values: ``audit-only``, ``disabled``, and ``enabled``. Default value: ``disabled``.

The Audit Run
-----------------------------------------------------
.. include:: ../../includes_chef_client/includes_chef_client_audit_mode_run.rst


About Bootstrap Operations
=====================================================

.. include:: ../../includes_install/includes_install_chef_client.rst

.. include:: ../../includes_chef_client/includes_chef_client_bootstrap_node.rst

.. include:: ../../includes_chef_client/includes_chef_client_bootstrap_stages.rst

