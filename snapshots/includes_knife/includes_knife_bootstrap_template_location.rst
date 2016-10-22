.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A custom bootstrap template file must be located in a ``bootstrap/`` directory, which is typically located within the ``~/.chef/`` directory on the local workstation.

Use the ``--bootstrap-template`` option with the ``knife bootstrap`` subcommand to specify the name of the bootstrap template file. This location is configurable when the following setting is added to the knife.rb file:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``knife[:bootstrap_template]``
     - The path to a template file to be used during a bootstrap operation.
