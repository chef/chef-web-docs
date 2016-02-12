.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Versions and version constraints can be specified in a cookbook's |metadata rb| file by using the following functions. Each function accepts a name and an optional version constraint; if a version constraint is not provided, ``>= 0.0.0`` is used as the default.

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Function
     - Description
   * - ``conflicts``
     - |metadata rb conflicts| For example:

       .. code-block:: ruby

          conflicts 'apache2', '< 3.0'

       or:

       .. code-block:: ruby

          conflicts 'daemon-tools'

   * - ``depends``
     - |metadata rb depends| For example:

       .. code-block:: ruby

          depends 'opscode-base'

       or:

       .. code-block:: ruby

          depends 'opscode-github', '> 1.0.0'

       or:

       .. code-block:: ruby

          depends 'runit', '~> 1.2.3'

   * - ``provides``
     - |metadata rb provides|
   * - ``recommends``
     - |metadata rb recommends|
   * - ``replaces``
     - |metadata rb replaces|
   * - ``suggests``
     - |metadata rb suggests|
   * - ``supports``
     - |metadata rb supports|
