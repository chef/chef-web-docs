.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


If an organization is using an internal certificate authority, then the root certificate will not appear in any ``cacerts.pem`` file that ships by default with operating systems and web browsers. Because of this, no currently deployed system will be able to verify certificates that are issued in this manner. To allow other systems to trust certificates from an internal certificate authority, this root certificate will need to be configured so that other systems can follow the chain of authority back to the root certificate. (An intermediate certificate is not enough becuase the root certificate is not already globally known.)

To use an internal certificate authority, append both the server and root certificates into a single ``.crt`` file. For example:

.. code-block:: bash

   $ cat server.crt root.crt >> /var/opt/opscode/nginx/ca/FQDN.crt
