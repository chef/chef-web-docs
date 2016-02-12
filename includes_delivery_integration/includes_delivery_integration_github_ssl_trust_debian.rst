.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


For the |debian| platform, do the following:

#. Log into the |chef delivery_short| server as root.
#. Run the following command:

   .. code-block:: bash

      cd /usr/local/share/ca-certificates

#. Run the following command:

   .. code-block:: bash

      openssl s_client -showcerts -connect {your-ghe-server}:443 </dev/null 2>/dev/null|openssl x509 -outform PEM >{your-ghe-server}.crt

#. Run the following command:

   .. code-block:: bash

      update-ca-certificates
