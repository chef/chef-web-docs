=====================================================
Install Private Supermarket
=====================================================

.. include:: ../../includes_supermarket/includes_supermarket.rst

.. include:: ../../includes_supermarket/includes_supermarket_private.rst

.. note:: .. include:: ../../includes_supermarket/includes_supermarket_private_source_code.rst

Requirements
=====================================================
.. include:: ../../includes_supermarket/includes_supermarket_private_requirements.rst

|chef identity_title|
=====================================================
.. include:: ../../includes_supermarket/includes_supermarket_private_ocid.rst

.. note:: The |supermarket| server must be able to reach (via HTTPS) the specified ``chef_server_url`` during |oauth| 2.0 negotiation. This type of issue is typically with name resolution and firewall rules.

Configure
-----------------------------------------------------
.. include:: ../../includes_supermarket/includes_supermarket_private_ocid_configure.rst

.. note:: The redirect URL specified for |chef identity| **MUST** match the fqdn hostname of the |supermarket| server. The URI must also be correct: ``/auth/chef_oauth2/callback``. Otherwise, an error message similar to ``The redirect uri included is not valid.`` will be shown.

Install Supermarket
=====================================================
.. include:: ../../includes_supermarket/includes_supermarket_private_install.rst

.. note:: In general, for production environments |chef| recommends to start running |supermarket| with small virtual machines, and then increase the size of the virtual machine as necessary. Put the ``/var/opt/supermarket`` directory on a separate disk, and then use LVM so that may be expanded.

Create a Wrapper
-----------------------------------------------------
.. include:: ../../includes_supermarket/includes_supermarket_private_install_wrapper_cookbook.rst

.. include:: ../../includes_supermarket/includes_supermarket_private_install_wrapper_cookbook_steps.rst

Define Attributes
-----------------------------------------------------
.. include:: ../../includes_supermarket/includes_supermarket_private_install_attributes.rst

Upload the Wrapper
-----------------------------------------------------
.. include:: ../../includes_supermarket/includes_supermarket_private_install_upload.rst

Bootstrap Supermarket
-----------------------------------------------------
.. include:: ../../includes_supermarket/includes_supermarket_private_install_bootstrap.rst

Connect to Supermarket
=====================================================
.. include:: ../../includes_supermarket/includes_supermarket_private_connect.rst

.. note:: The redirect URL specified for |chef identity| **MUST** match the fqdn hostname of the |supermarket| server. The URI must also be correct: ``/auth/chef_oauth2/callback``. Otherwise, an error message similar to ``The redirect uri included is not valid.`` will be shown.

Customize Supermarket
=====================================================
.. include:: ../../includes_supermarket/includes_supermarket_private_customize.rst

External Database
-----------------------------------------------------
.. include:: ../../includes_supermarket/includes_supermarket_private_customize_external_database.rst

External Cache
-----------------------------------------------------
.. include:: ../../includes_supermarket/includes_supermarket_private_customize_external_cache.rst

External Cookbook Storage
-----------------------------------------------------
.. include:: ../../includes_supermarket/includes_supermarket_private_customize_external_cookbook_storage.rst

Run Supermarket in |kitchen|
=====================================================
.. include:: ../../includes_supermarket/includes_supermarket_run_in_kitchen.rst

Proxies
-----------------------------------------------------
.. include:: ../../includes_supermarket/includes_supermarket_run_in_kitchen_behind_proxy.rst

|kitchen| Runs Slowly
-----------------------------------------------------
.. include:: ../../includes_supermarket/includes_supermarket_run_in_kitchen_slow.rst
