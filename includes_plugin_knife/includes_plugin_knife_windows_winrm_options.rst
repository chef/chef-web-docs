.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This argument has the following options:

``-a ATTR``, ``--attribute ATTR``
   |attribute ssh| The default attribute is the |fqdn| of the host. Other possible values include a public IP address, a private IP address, or a hostname.

``-f CA_TRUST_FILE``, ``--ca-trust-file CA_TRUST_FILE``
   Optional. |ca_trust_file|

``-i IDENTITY_FILE``, ``--identity-file IDENTITY_FILE``
   |keytab-file|

``--keytab-file KEYTAB_FILE``
   |keytab-file|

``-m``, ``--manual-list``
   |manual_list|

``-p PORT``, ``--winrm-port PORT``
   |winrm_port| |winrm_port_knife| Default: ``5986`` when ``--winrm-transport`` is set to ``ssl``, otherwise ``5985``.

``-P PASSWORD``, ``--winrm-password PASSWORD``
   |winrm_password|

``-R KERBEROS_REALM``, ``--kerberos-realm KERBEROS_REALM``
   Optional. |kerberos-realm|

``--returns CODES``
   |returns|

``-S KERBEROS_SERVICE``, ``--kerberos-service KERBEROS_SERVICE``
   Optional. |kerberos-service|

``SEARCH_QUERY``
   |search_query ssh|

``SSH_COMMAND``
   |ssh_command|

``--session-timeout MINUTES``
   |winrm_session_timeout|

``-t TRANSPORT``, ``--winrm-transport TRANSPORT``
   |winrm_transport| Possible values: ``ssl`` or ``plaintext``.

``--winrm-authentication-protocol PROTOCOL``
   |winrm_auth_protocol| Possible values: ``basic``, ``kerberos`` or ``negotiate``. Default value: ``negotiate``.

``--winrm-ssl-verify-mode MODE``
   |winrm_ssl_verify_mode| Possible values: ``verify_none`` or ``verify_peer``. Default value: ``verify_peer``.

``-x USERNAME``, ``--winrm-user USERNAME``
   |winrm_user|
