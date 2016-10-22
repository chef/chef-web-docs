.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A chef-client on which Reporting is configured always sends data to the Chef server. Users of the Chef management console web user interface must belong to the following group:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Group
     - Description
   * - ``reporting_readers``
     - Use to view and configure reports.

This group does not exist by default, even after Reporting has been installed to the Chef server. If this group is not created, all members of the organization will be unable to view reports.

.. SAVE FOR LATER
..
.. must belong to one (or both) of the following groups:
..
..   * - ``reporting_writers``
..     - (This group is not used by the current version of Reporting.)
