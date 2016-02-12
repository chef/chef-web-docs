.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This |chef provisioning| driver-specific resource has the following properties:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Property
     - Description
   * - ``allow_overwrite``
     - **Ruby Type:** TrueClass, FalseClass

       Use to allow overwriting an existing key pair.
   * - ``driver``
     - **Ruby Type:** Chef::Provisioning::Driver

       |driver_provisioning|
   * - ``private_key_options``
     - **Ruby Type:** Hash

       A |ruby hash| that defines a list of parameters used when generating a private key.
   * - ``private_key_path``
     - **Ruby Type:** String

       Use to specify the location from which the private key is generated. If this value is not specified, the private key will be generated.
   * - ``public_key_path``
     - **Ruby Type:** String

       Use to specify the location from which the public key is generated. If this value is not specified, the public key will be generated.
