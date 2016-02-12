.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This custom resource has the following properties:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Property
     - Description
   * - ``description``
     - |description interface|
   * - ``duplex``
     - |duplex mode| Default value: ``auto``.
   * - ``enable``
     - |use interface| Default value: ``true``.
   * - ``mtu``
     - |maximum_transmission_unit|
   * - ``name``
     - |name interface|
   * - ``speed``
     - |speed interface| Default value: ``auto``. Setting the speed attribute to the default value of ``auto`` causes the device to use the existing configuration for the speed statement and does not explicitly configure anything for the interface speed.
