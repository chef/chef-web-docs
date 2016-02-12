.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``listener create``, ``cert generate``, and ``cert install`` arguments to create a new listener and assign it a newly-generated |ssl| certificate. First, make sure that |windows remote management| is enabled on the machine:

.. code-block:: bash

   $ winrm quickconfig

Create the |ssl| certificate

.. code-block:: bash

   $ knife windows cert generate --domain myorg.org --output-file $env:userprofile/winrmcerts/winrm-ssl

This command may be run on any machine and will output three file types: ``.b64``, ``.pem``, and ``.pfx``.

Next, create the |ssl| listener:

.. code-block:: bash

   $ knife windows listener create --hostname *.myorg.org --cert-install $env:userprofile/winrmcerts/winrm-ssl.pfx

This will use the same ``.pfx`` file that was output by the ``cert generate`` argument. If the command is run on a different machine from that which generated the certificates, the required certificate files must first be transferred securely to the system on which the listener will be created. (Use the ``cert install`` argument to install a certificate on a machine.)

The |ssl| listener is created and should be listening on TCP port ``5986``, which is the default |windows remote management| |ssl| port.
