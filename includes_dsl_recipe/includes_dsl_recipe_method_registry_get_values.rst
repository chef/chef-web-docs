.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use the ``registry_get_values`` method to get the values (name, type, and data) for a |windows| registry key.

.. note:: .. include:: ../../includes_notes/includes_notes_registry_key_not_if_only_if.rst

The syntax for the ``registry_get_values`` method is as follows:

.. code-block:: ruby

   subkey_array = registry_get_values(KEY_PATH, ARCHITECTURE)

where:

* ``KEY_PATH`` is the path to the registry key. |key_name resource registry_key hives|
* ``ARCHITECTURE`` is one of the following values: ``:x86_64``, ``:i386``, or ``:machine``. |architecture registry_key machine|

The results of ``registry_get_values`` is an array of values.

.. note:: .. include:: ../../includes_notes/includes_notes_registry_key_architecture.rst
