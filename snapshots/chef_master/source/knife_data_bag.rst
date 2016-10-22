=====================================================
knife data bag 
=====================================================

.. include:: ../../includes_data_bag/includes_data_bag.rst

.. include:: ../../includes_data_bag/includes_data_bag_encryption.rst

.. include:: ../../includes_knife/includes_knife_data_bag.rst

.. note:: .. include:: ../../includes_knife/includes_knife_common_see_common_options_link.rst

create
=====================================================
.. include:: ../../includes_knife/includes_knife_data_bag_create.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_knife/includes_knife_data_bag_create_syntax.rst

Options
-----------------------------------------------------
This argument has the following options:

``DATA_BAG_ITEM``
   The name of a specific item within a data bag.

``--secret SECRET``
   The encryption key that is used for values contained within a data bag item. If ``secret`` is not specified, the chef-client looks for a secret at the path specified by the ``encrypted_data_bag_secret`` setting in the client.rb file.

``--secret-file FILE``
   The path to the file that contains the encryption key.

.. note:: For encrypted data bag items, use *either* ``--secret`` or ``--secret-file``, not both.


.. note:: .. include:: ../../includes_knife/includes_knife_common_see_all_config_options.rst

Examples
-----------------------------------------------------
The following examples show how to use this knife subcommand:

**Create a data bag**

.. include:: ../../step_knife/step_knife_data_bag_create.rst

delete
=====================================================
.. include:: ../../includes_knife/includes_knife_data_bag_delete.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_knife/includes_knife_data_bag_delete_syntax.rst

Options
-----------------------------------------------------
.. include:: ../../includes_knife/includes_knife_data_bag_delete_options.rst

Examples
-----------------------------------------------------
The following examples show how to use this knife subcommand:

**Delete a data bag**

.. include:: ../../step_knife/step_knife_data_bag_delete.rst

**Delete a data bag item**

.. include:: ../../step_knife/step_knife_data_bag_delete_item.rst

edit
=====================================================
.. include:: ../../includes_knife/includes_knife_data_bag_edit.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_knife/includes_knife_data_bag_edit_syntax.rst

Options
-----------------------------------------------------
This argument has the following options:

``DATA_BAG_ITEM``
   The name of a specific item within a data bag.

``--secret SECRET``
   The encryption key that is used for values contained within a data bag item. If ``secret`` is not specified, the chef-client looks for a secret at the path specified by the ``encrypted_data_bag_secret`` setting in the client.rb file.

``--secret-file FILE``
   The path to the file that contains the encryption key.

.. note::  For encrypted data bag items, use *either* ``--secret`` or ``--secret-file``, not both.


.. note:: .. include:: ../../includes_knife/includes_knife_common_see_all_config_options.rst

Examples
-----------------------------------------------------
The following examples show how to use this knife subcommand:

**Edit a data bag**

.. include:: ../../step_knife/step_knife_data_bag_edit.rst

**Edit a data bag item**

.. include:: ../../step_knife/step_knife_data_bag_edit_item.rst

from file
=====================================================
.. include:: ../../includes_knife/includes_knife_data_bag_from_file.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_knife/includes_knife_data_bag_from_file_syntax.rst

Options
-----------------------------------------------------
This argument has the following options:

``-a``, ``--all``
   Upload all data bags found at the specified path.

``--secret SECRET``
   The encryption key that is used for values contained within a data bag item. If ``secret`` is not specified, the chef-client looks for a secret at the path specified by the ``encrypted_data_bag_secret`` setting in the client.rb file.

``--secret-file FILE``
   The path to the file that contains the encryption key.

.. note::  For encrypted data bag items, use *either* ``--secret`` or ``--secret-file``, not both.

.. note:: .. include:: ../../includes_knife/includes_knife_common_see_all_config_options.rst

Examples
-----------------------------------------------------
The following examples show how to use this knife subcommand:

**Create a data bag from a file**

.. include:: ../../step_knife/step_knife_data_bag_from_file_create.rst

**Create an encrypted data bag from a file**

.. include:: ../../step_knife/step_knife_data_bag_from_file_create_encrypted.rst

**Create an encrypted data bag for use with chef-client local mode**

.. include:: ../../step_knife/step_knife_data_bag_from_file_create_encrypted_local_mode.rst

list
=====================================================
.. include:: ../../includes_knife/includes_knife_data_bag_list.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_knife/includes_knife_data_bag_list_syntax.rst

Options
-----------------------------------------------------
.. include:: ../../includes_knife/includes_knife_data_bag_list_options.rst

Examples
-----------------------------------------------------
The following examples show how to use this knife subcommand:

**View a list of data bags**

.. include:: ../../step_knife/step_knife_data_bag_list.rst

show
=====================================================
.. include:: ../../includes_knife/includes_knife_data_bag_show.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_knife/includes_knife_data_bag_show_syntax.rst

Options
-----------------------------------------------------
This argument has the following options:

``DATA_BAG_ITEM``
   The name of a specific item within a data bag.

``--secret SECRET``
   The encryption key that is used for values contained within a data bag item. If ``secret`` is not specified, the chef-client looks for a secret at the path specified by the ``encrypted_data_bag_secret`` setting in the client.rb file.

``--secret-file FILE``
   The path to the file that contains the encryption key.

.. note::  For encrypted data bag items, use *either* ``--secret`` or ``--secret-file``, not both.


.. note:: .. include:: ../../includes_knife/includes_knife_common_see_all_config_options.rst

Examples
-----------------------------------------------------
The following examples show how to use this knife subcommand:

**Show a data bag**

.. include:: ../../step_knife/step_knife_data_bag_show.rst

**Show a data bag item**

.. include:: ../../step_knife/step_knife_data_bag_show_item.rst

**Show a data bag, encrypted**

.. include:: ../../step_knife/step_knife_data_bag_show_item_encrypted.rst

**Show a data bag, decrypted**

.. include:: ../../step_knife/step_knife_data_bag_show_item_decrypted.rst

**Show a data bag as JSON**

.. include:: ../../step_knife/step_knife_data_bag_show_as_json.rst
