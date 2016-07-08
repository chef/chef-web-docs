.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


|delivery| has the following infrastructure requirements:

  .. list-table::
     :widths: 150 100 100 100
     :header-rows: 1

     * - Function
       - vCPU
       - RAM
       - Free disk space (in /var)
     * - Provisioning Node
       - 1 (2.5GHz)
       - 1GB
       - 8GB
     * - Chef Automate Server
       - 4
       - 8GB
       - 80GB
     * - Chef Server (must be v12). See additional information in note, below.
       - 4
       - 8GB
       - 80GB
     * - Supermarket Server
       - 4
       - 8GB
       - 80GB
     * - Build Nodes (at least 3, one for each Verify phase: Lint, Syntax, and Functional)
       - 2
       - 4GB
       - 60GB
     * - Infrastructure Nodes (at least 4, one for each environment stage: Acceptance, Union, Rehearsal, and Delivered)
       - 2 (for test purposes)
       - 4GB (for test purposes)
       - 60GB (for test purposes)
