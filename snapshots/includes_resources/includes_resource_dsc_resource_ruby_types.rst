.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use the following Ruby types to define ``property_value``:

.. list-table::
   :widths: 250 250
   :header-rows: 1

   * - Ruby
     - Windows PowerShell
   * - ``Array``
     - ``Object[]``
   * - ``Chef::Util::Powershell:PSCredential``
     - ``PSCredential``
   * - ``FalseClass``
     - ``bool($false)``
   * - ``Fixnum``
     - ``Integer``
   * - ``Float``
     - ``Double``
   * - ``Hash``
     - ``Hashtable``
   * - ``TrueClass``
     - ``bool($true)``

These are converted into the corresponding Windows PowerShell type during the chef-client run.
