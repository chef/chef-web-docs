==========================================================================
|kitchen yml|
==========================================================================

.. include:: ../../includes_test_kitchen/includes_test_kitchen.rst

.. include:: ../../includes_test_kitchen/includes_test_kitchen_yml.rst

.. note:: This topic details functionality that is packaged with |chef dk|. See http://kitchen.ci/docs/getting-started/ for more information about |kitchen|.

Syntax
==========================================================================
.. include:: ../../includes_test_kitchen/includes_test_kitchen_yml_syntax.rst

Provisioner Settings
==========================================================================
.. include:: ../../includes_test_kitchen/includes_test_kitchen_yml_provisioner.rst

.. note:: There are two community provisioners for |kitchen|: `kitchen-dsc <https://github.com/smurawski/kitchen-dsc>`__ and `kitchen-pester <https://github.com/smurawski/kitchen-pester>`__.

Work with Proxies
--------------------------------------------------------------------------
.. include:: ../../includes_test_kitchen/includes_test_kitchen_yml_syntax_proxy.rst

|chef client| Settings
==========================================================================
.. include:: ../../includes_test_kitchen/includes_test_kitchen_yml_chef_client.rst

Driver Settings
==========================================================================
.. include:: ../../includes_test_kitchen/includes_test_kitchen_yml_driver.rst

Bento
--------------------------------------------------------------------------
.. include:: ../../includes_bento/includes_bento.rst

Drivers
--------------------------------------------------------------------------
.. include:: ../../includes_test_kitchen/includes_test_kitchen_drivers.rst

kitchen-vagrant
--------------------------------------------------------------------------
.. include:: ../../includes_test_kitchen/includes_test_kitchen_driver_vagrant.rst

.. include:: ../../includes_test_kitchen/includes_test_kitchen_driver_vagrant_settings.rst

.. include:: ../../includes_test_kitchen/includes_test_kitchen_driver_vagrant_config.rst

Examples
==========================================================================
The following examples show actual |kitchen yml| files used in |company_name|-maintained cookbooks.

|chef|, |chef dk_title|
--------------------------------------------------------------------------
.. include:: ../../includes_test_kitchen/includes_test_kitchen_yml_example_chef_dk.rst

|chef client|, |chef client_audit|
--------------------------------------------------------------------------
.. include:: ../../includes_test_kitchen/includes_test_kitchen_yml_example_audit_mode.rst

mysql Cookbook
--------------------------------------------------------------------------
.. include:: ../../includes_test_kitchen/includes_test_kitchen_yml_example_mysql.rst

chef-client Cookbook
--------------------------------------------------------------------------
.. include:: ../../includes_test_kitchen/includes_test_kitchen_yml_example_chef_client.rst

chef-splunk Cookbook
--------------------------------------------------------------------------
.. include:: ../../includes_test_kitchen/includes_test_kitchen_yml_example_chef_splunk.rst

yum Cookbook
--------------------------------------------------------------------------
.. include:: ../../includes_test_kitchen/includes_test_kitchen_yml_example_yum.rst

Platform Attributes
--------------------------------------------------------------------------
.. include:: ../../includes_test_kitchen/includes_test_kitchen_yml_example_frontend_backend.rst