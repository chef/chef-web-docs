.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``vagrant_box`` driver-specific resource has the following actions:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Action
     - Description
   * - ``:create``
     - Default. Use to create a |vagrant| box by running the ``vagrant box add`` command.
   * - ``:delete``
     - Use to delete a |vagrant| box by running the ``vagrant box remove`` command.
   * - ``:nothing``
     - Use to do nothing.
