.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


|knife azure certificate|

The management certificate is required for secure communication with the |azure| platform via the REST APIs. To generate the management certificate (.pem file):

#. Download the settings file: http://go.microsoft.com/fwlink/?LinkId=254432.
#. Extract the data from the ``ManagementCertificate`` field into a separate file named ``cert.pfx``.
#. Decode the certificate file with the following command:

   .. code-block:: bash

      $ base64 -d cert.pfx > cert_decoded.pfx
#. Convert the decoded PFX file to a PEM file with the following command:

   .. code-block:: bash

      $ openssl pkcs12 -in cert_decoded.pfx -out managementCertificate.pem -nodes

.. note:: It is possible to generate certificates, and then upload them. See the following link for more information: www.windowsazure.com/en-us/manage/linux/common-tasks/manage-certificates/.










