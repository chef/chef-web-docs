.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use following |client rb| settings to manage |ssl| certificate preferences:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``local_key_generation``
     - |generate local_keys| Default value: ``true``.
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
       
       Depending on how |open ssl| is configured, the ``ssl_ca_path`` may need to be specified. Default value: ``:verify_peer``.
   * - ``verify_api_cert``
     - |ssl_verify_mode_verify_api_cert| Default value: ``false``.
