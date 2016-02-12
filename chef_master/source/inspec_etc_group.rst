=====================================================
etc_group
=====================================================

.. include:: ../../includes_inspec_resources/includes_inspec_resource_etc_group.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_etc_group_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

gids
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_etc_group_matcher_gids.rst

groups
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_etc_group_matcher_groups.rst

users
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_etc_group_matcher_users.rst

where
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_etc_group_matcher_where.rst

Examples
-----------------------------------------------------
|inspec examples|

**Test group identifiers (GIDs) for duplicates**

.. include:: ../../step_inspec/step_inspec_etc_group_duplicate_gids.rst

**Test all groups to see if a specific user belongs to one (or more) groups**

.. include:: ../../step_inspec/step_inspec_etc_group_all_groups_for_user.rst

**Test all groups for a specific user name**

.. include:: ../../step_inspec/step_inspec_etc_group_user_name.rst

**Filter a list of groups for a specific user**

.. include:: ../../step_inspec/step_inspec_etc_group_user.rst
