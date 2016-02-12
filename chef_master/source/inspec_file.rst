=====================================================
file
=====================================================

.. include:: ../../includes_inspec_resources/includes_inspec_resource_file.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

be_block_device
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_be_block_device.rst

be_character_device
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_be_character_device.rst

be_directory
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_be_directory.rst

be_executable
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_be_executable.rst

be_file
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_be_file.rst

be_grouped_into
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_be_grouped_into.rst

be_immutable
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_be_immutable.rst

be_linked_to
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_be_linked_to.rst

be_mounted
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_be_mounted.rst

be_owned_by
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_be_owned_by.rst

be_pipe
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_be_pipe.rst

be_readable
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_be_readable.rst

be_socket
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_be_socket.rst

be_symlink
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_be_symlink.rst

be_version
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_be_version.rst

be_writable
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_be_writable.rst

content
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_content.rst

exist
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_exist.rst

file_version
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_file_version.rst

group
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_group.rst

have_mode
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_have_mode.rst

link_path
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_link_path.rst

link_target
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_link_target.rst

md5sum
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_md5sum.rst

mode
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_mode.rst

mtime
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_mtime.rst

owner
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_owner.rst

product_version
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_product_version.rst

selinux_label
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_selinux_label.rst

sha256sum
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_sha256sum.rst
   
size
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_size.rst

type
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_file_matcher_type.rst

Examples
-----------------------------------------------------
|inspec examples|

**Test the contents of a file for MD5 requirements**

.. include:: ../../step_inspec/step_inspec_file_md5_contents.rst

**Test if a file exists**

.. include:: ../../step_inspec/step_inspec_file_exists.rst

**Test that a file does not exist**

.. include:: ../../step_inspec/step_inspec_file_does_not_exist.rst

**Test if a path is a directory**

.. include:: ../../step_inspec/step_inspec_file_is_directory.rst

**Test if a path is a file and not a directory**

.. include:: ../../step_inspec/step_inspec_file_is_file.rst

**Test if a file is a symbolic link**

.. include:: ../../step_inspec/step_inspec_file_is_symbolic_link.rst

**Test if a file is a character device**

.. include:: ../../step_inspec/step_inspec_file_is_character_device.rst

**Test if a file is a block device**

.. include:: ../../step_inspec/step_inspec_file_is_block_device.rst

**Test the mode for a file**

.. include:: ../../step_inspec/step_inspec_file_mode.rst

**Test the owner of a file**

.. include:: ../../step_inspec/step_inspec_file_owner.rst

**Test if a file is owned by the root user**

.. include:: ../../step_inspec/step_inspec_file_owned_by_root.rst

**Test the mtime for a file**

.. include:: ../../step_inspec/step_inspec_file_mtime.rst

**Test that a file's size is between 64 and 10240**

.. include:: ../../step_inspec/step_inspec_file_size_more_than_64.rst

**Test that a file's size is zero**

.. include:: ../../step_inspec/step_inspec_file_size_is_zero.rst

**Test that a file is not mounted**

.. include:: ../../step_inspec/step_inspec_file_not_mounted.rst

**Test an MD5 checksum**

.. include:: ../../step_inspec/step_inspec_file_md5_checksum.rst

**Test an SHA-256 checksum**

.. include:: ../../step_inspec/step_inspec_file_sha256_checksum.rst
