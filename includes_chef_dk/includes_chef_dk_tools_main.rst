.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The most important tools included in the |chef dk| are:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Tool
     - Description
   * - |berkshelf|
     - A dependency manager for cookbooks.
   * - |chef ctl|
     - A workflow tool for |chef|.
   * - |chef dk_title|
     - The |chef dk| omnibus package.
   * - |chef client|
     - The agent that runs |chef|.
   * - |chef vault|
     - Use to encrypt data bag items using the public keys of a list of nodes. This allows only those nodes to decrypt the encrypted values.
   * - |chef spec|
     - A unit testing framework that tests resources locally.
   * - |fauxhai|
     - A gem for mocking |ohai| data.
   * - |foodcritic|
     - A lint tool for static analysis of recipe code.
   * - |kitchen|
     - An integration testing framework tool that tests cookbooks across platforms.
   * - |kitchen_vagrant|
     - A |kitchen| driver for |vagrant|.
   * - |knife spork|
     - A workflow plugin for |knife| that helps groups of people work together in the same |chef repo| and |chef server|.
   * - |ruby|
     - The reference language for |chef|.
   * - |rubocop|
     - A static code analyzer for |ruby|.
