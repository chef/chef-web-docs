.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A custom bootstrap template file (``template_filename``) must be located in a ``bootstrap/`` directory, typically located within the ``~/.chef/`` directory.

Use the ``--distro`` option with the ``knife bootstrap`` subcommand to specify the bootstrap template file. This location is configurable when the following settings are added to the knife.rb file:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``knife[:distro]``
     - .. include:: ../../includes_knife/includes_knife_bootstrap_distro.rst
   * - ``knife[:template_file]``
     - The path to a template file to be used during a bootstrap operation. Do not use the ``--distro`` option when ``--template-file`` is specified.

