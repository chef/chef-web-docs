.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This argument has the following options:

``-a``, ``--azure-affinity-group GROUP``
   |azure affinity_group| Required when not using ``--azure-service-location``.

``--auto-update-client``
   |auto_update_client| This option may only be used when ``--bootstrap-protocol`` is set to ``cloud-api``. Default value: ``false``.

``--azure-availability-set NAME``
   |azure availability_set|

``--azure-dns-name DNS_NAME``
   |azure dns_name|

``--azure-network-name NETWORK_NAME``
   |azure network_name|

``--azure-publish-settings-file FILE_NAME``
   |file azure_publish_settings|

``--azure-storage-account STORAGE_ACCOUNT_NAME``
   |storage account| A storage account name may be between 3 and 24 characters (lower-case letters and numbers only) and must be unique within |azure|.

``--azure-subnet-name SUBNET_NAME``
   |azure subnet_name|

``--azure-vm-name NAME``
   |azure virtual_machine_name|

``--azure-vm-ready-timeout TIMEOUT``
   |azure vm_timeout_ready| Default value: ``10``.

``--azure-vm-startup-timeout TIMEOUT``
   |azure vm_timeout_startup| Default value: ``15``.

``--bootstrap-protocol PROTOCOL``
   |bootstrap protocol| Default value: ``winrm``.

   .. include:: ../../includes_plugin_knife/includes_plugin_knife_azure_server_create_cloud_api.rst

``--bootstrap-version VERSION``
   |bootstrap version|

``-c``, ``--azure-connect-to-existing-dns``
   |azure connect_to_existing_dns|

``--cert-passphrase PASSWORD``
   |password certificate_ssl|

``--cert-path PATH``
   |path certificate_ssl|

``-d DISTRO``, ``--distro DISTRO``
   |distro|

``-H HOST_NAME``, ``--azure_host_name HOST_NAME``
   |name virtual_machine|

``--hint HINT_NAME[=HINT_FILE]``
   |hint|

   .. include:: ../../includes_ohai/includes_ohai_hints.rst

   |hint_file| |hint_name| |hint_multiple|

``--host-name HOST_NAME``
   |azure_host_name|

``-I IMAGE``, ``--azure-source-image IMAGE``
   |source-image|

``--identity-file IDENTITY_FILE``
   |identity-file|

``--identity-file_passphrase PASSWORD``
   |identity_file_passphrase|

``-j JSON_ATTRIBS``, ``--json-attributes JSON_ATTRIBS``
   |json first_run_string|

``-m LOCATION``, ``--azure-service-location LOCATION``
   |media location| Required when not using ``--azure-affinity-group``.

``-N NAME``, ``--node-name NAME``
   |name node| Node names, when used with |azure|, must be 91 characters or shorter.

``--[no-]host-key-verify``
   |no_host_key_verify| Default setting: ``--host-key-verify``.

``-o DISK_NAME``, ``--azure-os-disk-name DISK_NAME``
   |os-disk-name|

``-p FILE_NAME``, ``--azure-mgmt-cert FILE_NAME``
   |azure_pem_filename|

``-P PASSWORD``, ``--ssh-password PASSWORD``
   |ssh_password|

``--prerelease``
   |prerelease|

``-r RUN_LIST``, ``--run-list RUN_LIST``
   |run-list|

``-R ROLE_NAME``, ``--role-name ROLE_NAME``
   |role-name|

``--ssh-port PORT``
   |ssh_port| Default value: ``22``.

``-t PORT_LIST``, ``--tcp-endpoints PORT_LIST``
   |tcp_ports|

``--template-file TEMPLATE``
   |path bootstrap_template|

``--thumbprint THUMBPRINT``
   |thumbprint|

``-u PORT_LIST``, ``---udp-endpoints PORT_LIST``
   |udp_ports|

``--verify-ssl-cert``
   |ssl_certificate|

``--windows-auth-timeout MINUTES``
   |timeout auth_windows| Default value: ``25``.

``-x USER_NAME``, ``--ssh-user USER_NAME``
   |ssh_user|

``-z SIZE``, ``--azure-vm-size SIZE``
   |role-size| Default value: ``Small``.
