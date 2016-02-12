.. THIS PAGE DOCUMENTS Enterprise Chef server version 11.0

=====================================================
Security
=====================================================

.. include:: ../../includes_server_security/includes_server_security_ssl.rst

.. warning:: The |fqdn| for the |chef server| should not exceed 64 characters when using |open ssl|. |open ssl| requires the ``CN`` in a certificate to be no longer than 64 characters.

.. warning:: By default, the |chef server| uses the |fqdn| to determine the common name (``CN``). If the |fqdn| of the |chef server| is longer than 64 characters, the ``reconfigure`` command will not fail, but an empty certificate file will be created. |nginx| will not start if a certificate file is empty.

SSL Certificates
=====================================================
.. include:: ../../includes_server_security/includes_server_security_ssl_cert_custom.rst

For more information about the server configuration file, see :doc:`private-chef.rb </config_rb_chef_server_enterprise>`.

|chef analytics_title|
-----------------------------------------------------
.. include:: ../../includes_server_security/includes_server_security_ssl_cert_custom_analytics.rst

Regenerate Certificates
-----------------------------------------------------
.. include:: ../../includes_server_security/includes_server_security_ssl_cert_regenerate.rst

SSL Protocols
=====================================================
.. include:: ../../includes_server_tuning/includes_server_tuning_nginx.rst

|chef client_title| Settings
=====================================================
The |client rb| file has the following settings for configuring |ssl| for |chef client| interaction with the |chef server|:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``ssl_ca_file``
     - |ssl_ca_file|
   * - ``ssl_ca_path``
     - |ssl_ca_path|
   * - ``ssl_client_cert``
     - |ssl_client_cert| Default value: ``nil``.
   * - ``ssl_client_key``
     - |ssl_client_key| Default value: ``nil``.
   * - ``ssl_verify_mode``
     - |ssl_verify_mode|
       
       * |ssl_verify_mode_verify_none|
       * |ssl_verify_mode_verify_peer| This is the recommended setting.
       
       Depending on how |open ssl| is configured, the ``ssl_ca_path`` may need to be specified.
   * - ``verify_api_cert``
     - |ssl_verify_mode_verify_api_cert| Default value: ``false``.

