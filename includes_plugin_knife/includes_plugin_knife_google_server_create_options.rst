.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This argument has the following options:

``--bootstrap-version VERSION``
   |bootstrap version|

``-d DISTRO``, ``--distro DISTRO``
   |distro|

``-f CREDENTIAL_FILE``, ``--gce-credential-file CREDENTIAL_FILE``
   |credential_file google|

``--gce-boot-disk-name DISK``
   |google_boot_disk_name|

``--gce-boot-disk-size SIZE``
   |google_boot_disk_size| Default value: ``10``.

``--gce-image-project-id IMAGE_PROJECT_ID``
   |google_image_project_id|

``--gce-metadata Key=Value[,Key=Value...]``
   |google_compute_metadata|

``--gce-public-ip IP_ADDRESS``
   |google_compute_public_ip| Options: ``EPHEMERAL``, a static IP address, or ``NONE``. Default value: ``EPHEMERAL``.

``--gce-server-connect-ip PUBLIC``
   |google_compute_server_connect_ip| Default value: ``PUBLIC``.

``--gce-service-account-name NAME``
   |google_service_account_name| Default value: ``'default'``.

``--gce-service-account-scopes SCOPE1, SCOPE2, SCOPE3``
   |google_service_account_scope|

``--hint HINT_NAME[=HINT_FILE]``
   |hint|

   .. include:: ../../includes_ohai/includes_ohai_hints.rst

   |hint_file| |hint_name| |hint_multiple|

``--[no-]host-key-verify``
   |no_host_key_verify| Default setting: ``--host-key-verify``.

``-i IDENTITY_FILE``, ``--identity-file IDENTITY_FILE``
   |identity-file|

``-I IMAGE``, ``--gce-image IMAGE``
   |google_image| Default: ``gcompute8-standard``.

``-j JSON_ATTRIBS``, ``--json-attributes JSON_ATTRIBS``
   |json first_run_string|

``-m MACHINE_TYPE``, ``--gce-machine MACHINE_TYPE``
   |google_compute_machine_type|

``-n NETWORK_NAME``, ``--gce-network NETWORK_NAME``
   |google_compute_network|

``-N NODE_NAME``, ``--node-name NODE_NAME``
   |name node|

``--[no-]gce-auto-server-restart``
   |google_auto_server_restart| Default value: ``true``.

``--[no-]gce-auto-server-migrate``
   |google_auto_server_migrate| Default value: ``true``.

``-p PORT``, ``--ssh-port PORT``
   |ssh_port| Default value: ``22``.

``-P PASSWORD``, ``--ssh-password PASSWORD``
   |ssh_password|

``--prerelease``
   |prerelease|

``-r RUN_LIST``, ``--run-list RUN_LIST``
   |run-list|

``--secret SECRET``
   |secret|

``--secret-file FILE``
   |secret_file|

``-T TAG1,TAG2,TAG3``, ``--gce-tags TAG1,TAG2,TAG3``
   |google_compute_tags|

``--template-file TEMPLATE``
   |path bootstrap_template|

``-u USER_DATA_FILE``, ``--user-data USER_DATA_FILE``
   |google_compute_user_data|

``-w GATEWAY``, ``--ssh-gateway GATEWAY``
   |ssh_gateway|

``-x USER_NAME``, ``--ssh-user USER_NAME``
   |ssh_user|

``-Z ZONE``, ``--gce-zone ZONE``
   |zone google|
