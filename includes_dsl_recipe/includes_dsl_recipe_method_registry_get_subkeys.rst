.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use the ``registry_get_subkeys`` method to get a list of sub-keys that are present for a |windows| registry setting. 

.. note:: .. include:: ../../includes_notes/includes_notes_registry_key_not_if_only_if.rst

The syntax for the ``registry_get_subkeys`` method is as follows:

.. code-block:: ruby

   subkey_array = registry_get_subkeys(KEY_PATH, ARCHITECTURE)

where:

* ``KEY_PATH`` is the path to the registry key. |key_name resource registry_key hives|
* ``ARCHITECTURE`` is one of the following values: ``:x86_64``, ``:i386``, or ``:machine``. |architecture registry_key machine|

The results of ``registry_get_subkeys`` is an array of sub-keys.

.. note:: .. include:: ../../includes_notes/includes_notes_registry_key_architecture.rst
