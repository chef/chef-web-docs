.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use the ``registry_value_exists?`` method to find out if a registry key value exists. Use ``registry_data_exists?`` to test for the type and data of a registry key value.

.. note:: .. include:: ../../includes_notes/includes_notes_registry_key_not_if_only_if.rst

The syntax for the ``registry_value_exists?`` method is as follows:

.. code-block:: ruby

   registry_value_exists?(
     KEY_PATH, 
     { :name => 'NAME' }, 
     ARCHITECTURE
   )

where:

* ``KEY_PATH`` is the path to the registry key. |key_name resource registry_key hives|
* ``{ :name => 'NAME' }`` is a hash that contains the name of the registry key value; if either ``:type`` or ``:value`` are specified in the hash, they are ignored
* |values resource registry_key types|
* ``ARCHITECTURE`` is one of the following values: ``:x86_64``, ``:i386``, or ``:machine``. |architecture registry_key machine|

This method will return ``true`` or ``false``.

.. note:: .. include:: ../../includes_notes/includes_notes_registry_key_architecture.rst
