.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Versions and version constraints can be specified in a cookbook's metadata.rb file by using the following functions. Each function accepts a name and an optional version constraint; if a version constraint is not provided, ``>= 0.0.0`` is used as the default.

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Function
     - Description
   * - ``conflicts``
     - A cookbook conflicts with another cookbook or cookbook version. Use a version constraint to define constraints for cookbook versions: ``<`` (less than), ``<=`` (less than or equal to), ``=`` (equal to), ``>=`` (greater than or equal to), ``~>`` (approximately greater than), or ``>`` (greater than). This field requires that a cookbook with a matching name and version does not exist on the Chef server. When the match exists, the Chef server ensures that any conflicted cookbooks are not included with the set of cookbooks that are sent to the node when the chef-client runs. For example:

       .. code-block:: ruby

          conflicts 'apache2', '< 3.0'

       or:

       .. code-block:: ruby

          conflicts 'daemon-tools'

   * - ``depends``
     - Show that a cookbook has a dependency on another cookbook. Use a version constraint to define dependencies for cookbook versions: ``<`` (less than), ``<=`` (less than or equal to), ``=`` (equal to), ``>=`` (greater than or equal to; also known as "optimistically greater than", or "optimistic"), ``~>`` (approximately greater than; also known as "pessimistically greater than", or "pessimistic"), or ``>`` (greater than). This field requires that a cookbook with a matching name and version exists on the Chef server. When the match exists, the Chef server includes the dependency as part of the set of cookbooks that are sent to the node when the chef-client runs. It is very important that the ``depends`` field contain accurate data. If a dependency statement is inaccurate, the chef-client may not be able to complete the configuration of the system. For example:

       .. code-block:: ruby

          depends 'opscode-base'

       or:

       .. code-block:: ruby

          depends 'opscode-github', '> 1.0.0'

       or:

       .. code-block:: ruby

          depends 'runit', '~> 1.2.3'

   * - ``provides``
     - Add a recipe, definition, or resource that is provided by this cookbook, should the auto-populated list be insufficient.
   * - ``recommends``
     - Add a dependency on another cookbook that is recommended, but not required. A cookbook will still work even if recommended dependencies are not available.
   * - ``replaces``
     - Whether this cookbook should replace another (and can be used in-place of that cookbook).
   * - ``suggests``
     - Add a dependency on another cookbook that is suggested, but not required. This field is weaker than ``recommends``; a cookbook will still work even when suggested dependencies are not available.
   * - ``supports``
     - Show that a cookbook has a supported platform. Use a version constraint to define dependencies for platform versions: ``<`` (less than), ``<=`` (less than or equal to), ``=`` (equal to), ``>=`` (greater than or equal to), ``~>`` (approximately greater than), or ``>`` (greater than). To specify more than one platform, use more than one ``supports`` field, once for each platform.
