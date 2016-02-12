.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use the ``registry_value_exists?`` method to find out if a |windows| registry key has values set (name, type, and data).  

.. note:: .. include:: ../../includes_notes/includes_notes_registry_key_not_if_only_if.rst

The syntax for the ``registry_value_exists?`` method is as follows:

.. code-block:: ruby

   registry_value_exists?(
     KEY_PATH, 
     { :name => 'NAME', :type => TYPE, :data => VALUE }, 
     ARCHITECTURE
   )

where:

* ``KEY_PATH`` is the path to the registry key. |key_name resource registry_key hives|
* ``{ :name => 'NAME', :type => TYPE, :data => VALUE }`` is a hash that contains the name, type, and value of the registry setting
* |values resource registry_key types|
* ``ARCHITECTURE`` is one of the following values: ``:x86_64``, ``:i386``, or ``:machine``. |architecture registry_key machine|

This method will return ``true`` or ``false``.  

.. note:: .. include:: ../../includes_notes/includes_notes_registry_key_architecture.rst
