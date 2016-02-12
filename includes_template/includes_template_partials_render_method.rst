.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``render`` method in a template to reference a partial template file:

.. code-block:: ruby

   <%= render "partial_name.txt.erb", :option => {} %>

where ``partial_name`` is the name of the partial template file and ``:option`` is one (or more) of the following:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Option
     - Description
   * - ``:cookbook``
     - By default, a partial template file is assumed to be located in the cookbook that contains the top-level template. Use this option to specify the path to a different cookbook
   * - ``:local``
     - Indicates that the name of the partial template file should be interpreted as a path to a file in the local file system or looked up in a cookbook using the normal rules for template files. Set to ``true`` to interpret as a path to a file in the local file system and to ``false`` to use the normal rules for template files
   * - ``:source``
     - By default, a partial template file is identified by its file name. Use this option to specify a different name or a local path to use (instead of the name of the partial template file)
   * - ``:variables``
     - A hash of ``variable_name => value`` that will be made available to the partial template file. When this option is used, any variables that are defined in the top-level template that are required by the partial template file must have them defined explicitly using this option

For example:

.. code-block:: ruby

   <%= render "simple.txt.erb", :variables => {:user => Etc.getlogin }, :local => true %>
