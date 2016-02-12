.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

|knife| can encrypt and decrypt data bag items when the ``knife data bag`` sub-command is run with the ``create``, ``edit``, ``from file``, or ``show`` arguments and the following options:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Option
     - Description
   * - ``--secret SECRET``
     - |secret| |secret_config|
   * - ``--secret-file FILE``
     - |secret_file|