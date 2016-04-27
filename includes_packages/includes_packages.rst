.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Packages for |chef inc| products may be installed using platform-native package repositories or the |omnitruck| install script. Both installation methods support the following release channels:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Channel
     - Description
   * - ``stable``
     - A build from this channel is an "official" release that has passed full user acceptance testing. Artifacts in this channel are retained indefinitely.
   * - ``current``
     - A build from this channel is an "integration" build that has passed basic automated testing. Artifacts in this channel are retained for 30 days and then removed automatically.

|company_name| recommends using the stable channel when installing any of these products on production systems.
