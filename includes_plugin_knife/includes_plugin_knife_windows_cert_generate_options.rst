.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This argument has the following options:

``-cp PASSWORD``, ``--cert-passphrase PASSWORD``
   |password certificate_ssl|

``-cv MONTHS``, ``--cert-validity MONTHS``
   |ssl_certificate length_months| Default value: ``24``.

``-h HOST_NAME``, ``--hostname HOST_NAME``
   |listener_hostname| For example, ``--hostname something.mydomain.com`` or ``*.mydomain.com``. Default value: ``*``.

``-k LENGTH``, ``--key-length LENGTH``
   |key length| Default value: ``2048``.

``-o PATH``, ``--output-file PATH``
   |path output_file| For example: ``--output-file /home/.winrm/server_cert`` will create ``server_cert.b64``, ``server_cert.pem``, and ``server_cert.pfx`` in the ``server_cert`` directory. Default location: ``current_directory/winrmcert``.
