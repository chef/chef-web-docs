.. THIS PAGE IS LOCATED AT THE /release/analytics/ PATH.

=====================================================
chef-client
=====================================================

.. include:: ../../includes_analytics/includes_analytics_legacy.rst 

.. include:: ../../includes_chef_client/includes_chef_client.rst

.. warning:: This topic discusses the chef-client only from the context of Chef Analytics. For more information about the chef-client, see https://docs.chef.io/chef_client.html.

audit-mode
=====================================================
.. include:: ../../includes_chef_client/includes_chef_client_audit_mode.rst

Use following option to run the chef-client in audit-mode mode:

``--audit-mode MODE``
   Enable audit-mode. Set to ``audit-only`` to skip the converge phase of the chef-client run and only perform audits. Possible values: ``audit-only``, ``disabled``, and ``enabled``. Default value: ``disabled``.

The Audit Run
-----------------------------------------------------
.. include:: ../../includes_chef_client/includes_chef_client_audit_mode_run.rst
