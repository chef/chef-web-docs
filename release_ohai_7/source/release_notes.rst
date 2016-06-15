=====================================================
Release Notes: |ohai| 7
=====================================================

.. include:: ../../includes_ohai/includes_ohai.rst

.. Adopted Platforms
.. =====================================================
.. .. include:: ../../includes_adopted_platforms/includes_adopted_platforms_ohai.rst

What's New
=====================================================
|ohai| 7 collects all of the same information that |ohai| 6 collected and |ohai| 7 introduces two major changes. The short version:

* **New DSL** New features like ``collect_data()`` blocks and ``depends`` / ``provides`` statements make it easier to build plugins for platform-specific situations.
* **Attribute name-based user interaction** Only specify the name of the attribute; |ohai| 7 will figure out which plugins are required to collect that data. 

|ohai| 6 vs. |ohai| 7 Plugins
-----------------------------------------------------
.. include:: ../../includes_ohai/includes_ohai_migrate_plugins_6_to_7.rst

The |ohai| 7 DSL
-----------------------------------------------------
|ohai| 6 had a key architectural limitation that treated a plugin as a monolithic block of code. This blocked the ability to implement improvements, such as differentiating data that was collected by |ohai| as critical or optional. |ohai| 7 introduces a new DSL that makes it easier to write custom plugins with better code organization.

Two important pieces of this DSL:

* ``collect_data()`` blocks enable better organization for platform-specific situations
* ``depends`` and ``provides`` statements enable easier dependency management among plugins

Attribute name-based user interaction
-----------------------------------------------------
|ohai| 6 required users to know the file path for each plugin in order to use it. |ohai| 7 only requires users to know the attribute for which |ohai| should collect data. |ohai| 7 will figure out where the required plugins are located.

Disable plugins
-----------------------------------------------------
.. include:: ../../includes_config/includes_config_rb_ohai.rst

Use the following setting to disable plugins:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``Ohai::Config[:disabled_plugins]``
     - |disable plugin_ohai| For example:

       .. code-block:: ruby

          Ohai::Config[:disabled_plugins] = [:MyPlugin]

       or:

       .. code-block:: ruby

          Ohai::Config[:disabled_plugins] = [:MyPlugin, :MyPlugin, :MyPlugin]

       or to disable both |ohai| 6 and |ohai| 7 versions:

       .. code-block:: ruby

          Ohai::Config[:disabled_plugins] = [:MyPlugin, :MyPlugin, "my_ohai_6_plugin"]
