.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Every |chef provisioning| |amazon aws| driver-specific resource has the following actions:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Action
     - Description
   * - ``:create``
     - Default. Use to create the specified object in |amazon aws|.
   * - ``:destroy``
     - Use to destroy the specified object in |amazon aws|.
   * - ``:purge``
     - Use to remove chargable items related to an object in |amazon aws|.
   * - ``:nothing``
     - Use to do nothing.
