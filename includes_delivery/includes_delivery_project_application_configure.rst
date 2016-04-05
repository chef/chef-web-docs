.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Project applications are defined in the ``pubish.rb`` recipe in a ``build-cookbook`` using the ``define_project_application`` helper method, and then in the ``deploy.rb`` recipe using the ``get_projet_application`` method. The publish phase happens at the end of the build stage. It is at this point where the project application version is pinned, uploaded to the |chef server| as a data bag item, and then used through the remaining stages.

.. note:: The ``define_project_application`` helper method is available from the ``delivery-sugar`` cookbook, which is a dependency of the ``delivery-truck`` cookbook. This helper is available when the ``publish.rb`` recipe has ``include_recipe 'delivery-truck::publish'`` defined.

To define a project application, do the following:

#. Open the ``publish.rb`` recipe in the ``build-cookbook`` and edit it to contain:

   .. code-block:: ruby

      define_project_application(
        <app_name>,
        <app_version>,
        [ 'attribute',
          'attribute',
          ... ]
      )

   where

   * ``<app_name>`` is the name of the project application
   * ``<app_version>`` is version number to which the project application is pinned
   * ``'attribute'`` is |ruby hash| of attributes associated with this version; each attribute is defined as a key-value pair: ``'key = value'``


#. Set up the ``build-cookbook`` to know about this application. Add the following to ``.delivery/build-cookbook/attributes/default.rb``:

   .. code-block:: ruby

      default['delivery']['project_apps'] = ['<app_name>', '<app_name>', ...]

   where ``<app_name>`` is a list of one (or more) applications this ``build-cookbook`` should be aware of.

   .. note:: If the ``/attributes/default.rb`` directory and/or file does not exist, create it.


#. Open the ``default.rb`` recipe in the ``build-cookbook`` and edit it to contain:

   .. code-block:: ruby

      { 'hash_of_attributes' } = get_project_application(<app_name>)

   where ``'hash_of_attributes'`` is a list of one (or more) attributes defined in the ``define_project_application`` block.

   .. note:: Do not pass ``'id'``, ``'version'``, or ``'name'`` as part of the ``'hash_of_attributes'`` as these are already defined in the ``define_project_application`` block, are pulled in automatically by the ``get_project_application`` helper method, and will overwrite any value specified in the |ruby hash|.

