=====================================================
Release Notes: |chef client| 12.9
=====================================================

.. include:: ../../includes_chef/includes_chef.rst

What's New
=====================================================
The following items are new for |chef client| 12.9 and/or are changes from previous versions. The short version:

* **xxxxx** xxxxx
* **New property for the mdadm resource** Use the ``mdadm_defaults`` property to set the default values for ``chunk`` and ``metadata`` to ``nil``, which allows |mdadm| to apply its own default values.
* **File redirection in Windows for 32-bit applications** Files on |windows| that are managed by the |resource file| and |resource directory| resources are subject to file redirection, depending if the |chef client| is 64-bit or 32-bit.
* **Registry key redirection in Windows for 32-bit applications** Registry keys on |windows| that are managed by the |resource registry_key| resource are subject to key redirection, depending if the |chef client| is 64-bit or 32-bit.

xxxxx
-----------------------------------------------------
xxxxx

xxxxx
+++++++++++++++++++++++++++++++++++++++++++++++++++++
xxxxx


File Redirection in Windows
-----------------------------------------------------
.. include:: ../../includes_resources_common/includes_resources_common_windows_file_redirection.rst

Key Redirection in Windows
-----------------------------------------------------
.. include:: ../../includes_resources/includes_notes_registry_key_redirection.rst

Changelog
=====================================================
https://github.com/chef/chef/blob/master/CHANGELOG.md
