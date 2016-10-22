=====================================================
Release Notes: Ohai 7
=====================================================

.. include:: ../../includes_ohai/includes_ohai.rst

.. Adopted Platforms
.. =====================================================
.. .. include:: ../../includes_adopted_platforms/includes_adopted_platforms_ohai.rst

What's New
=====================================================
Ohai 7 collects all of the same information that Ohai 6 collected and Ohai 7 introduces two major changes. The short version:

* **New DSL** New features like ``collect_data()`` blocks and ``depends`` / ``provides`` statements make it easier to build plugins for platform-specific situations.
* **Attribute name-based user interaction** Only specify the name of the attribute; Ohai 7 will figure out which plugins are required to collect that data. 

Ohai 6 vs. Ohai 7 Plugins
-----------------------------------------------------
.. include:: ../../includes_ohai/includes_ohai_migrate_plugins_6_to_7.rst

The Ohai 7 DSL
-----------------------------------------------------
Ohai 6 had a key architectural limitation that treated a plugin as a monolithic block of code. This blocked the ability to implement improvements, such as differentiating data that was collected by Ohai as critical or optional. Ohai 7 introduces a new DSL that makes it easier to write custom plugins with better code organization.

Two important pieces of this DSL:

* ``collect_data()`` blocks enable better organization for platform-specific situations
* ``depends`` and ``provides`` statements enable easier dependency management among plugins

Attribute name-based user interaction
-----------------------------------------------------
Ohai 6 required users to know the file path for each plugin in order to use it. Ohai 7 only requires users to know the attribute for which Ohai should collect data. Ohai 7 will figure out where the required plugins are located.

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
     - An array of Ohai plugins to be disabled on a node. For example:

       .. code-block:: ruby

          Ohai::Config[:disabled_plugins] = [:MyPlugin]

       or:

       .. code-block:: ruby

          Ohai::Config[:disabled_plugins] = [:MyPlugin, :MyPlugin, :MyPlugin]

       or to disable both Ohai 6 and Ohai 7 versions:

       .. code-block:: ruby

          Ohai::Config[:disabled_plugins] = [:MyPlugin, :MyPlugin, "my_ohai_6_plugin"]
