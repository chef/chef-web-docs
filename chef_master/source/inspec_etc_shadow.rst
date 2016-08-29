=====================================================
shadow
=====================================================

.. include:: ../../includes_inspec_resources/includes_inspec_resource_etc_shadow.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_etc_shadow_syntax.rst

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

There are two groupings, depending on if filtering is associated with a user identifier.

count
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_etc_shadow_matcher_count.rst

expiry_dates
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_etc_shadow_matcher_expiry_dates.rst

inactive_days
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_etc_shadow_matcher_inactive_days.rst

last_changes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_etc_shadow_matcher_last_changes.rst

max_days
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_etc_shadow_matcher_max_days.rst

min_days
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_etc_shadow_matcher_min_days.rst

passwords
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_etc_shadow_matcher_passwords.rst

users
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_etc_shadow_matcher_users.rst

warn_days
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_etc_shadow_matcher_warn_days.rst

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test for a forbidden user**

.. include:: ../../step_inspec/step_inspec_etc_shadow_forbidden_user.rst

**Test that a user appears one time**

.. include:: ../../step_inspec/step_inspec_etc_shadow_user_appears_once.rst
