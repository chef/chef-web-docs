.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This |chef provisioning| driver-specific resource has the following properties:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Property
     - Description
   * - ``driver_options``
     - **Ruby Type:** Hash

       Use to specify driver options.
   * - ``name``
     - **Ruby Type:** String

       The name of the |vagrant| box.
   * - ``vagrant_provider``
     - **Ruby Type:** String

       The name of the provider for |vagrant|. Default value: ``virtualbox``.
   * - ``url``
     - **Ruby Type:** String

       The URL from which the |vagrant| box is downloaded.
