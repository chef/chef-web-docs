.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This argument has the following options:

``-c CERT_PATH``, ``--cert-install CERT_PATH``
   |path certificate_windows_store|

``-cp PASSWORD``, ``--cert-passphrase PASSWORD``
   |password certificate_ssl|

``-h HOST_NAME``, ``--hostname HOST_NAME``
   |listener_hostname| For example, ``--hostname something.mydomain.com`` or ``*.mydomain.com``. Default value: ``*``.

``-p PORT``, ``--port PORT``
   |winrm_port| Default value: ``5986``.

``-t THUMBPRINT``, ``--cert-thumbprint THUMBPRINT``
   |thumbprint| Required when the ``--cert-install`` option is not part of a command.
