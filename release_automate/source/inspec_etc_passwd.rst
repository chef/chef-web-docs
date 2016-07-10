=====================================================
passwd
=====================================================

.. include:: ../../includes_inspec_resources/includes_inspec_resource_etc_passwd.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_etc_passwd_syntax.rst

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

There are two groupings, depending on if filtering is associated with a user identifier.

passwd
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following matchers may be used when filtering is not associated with a user identifier:

gids
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_inspec_resources/includes_inspec_resource_etc_passwd_matcher_gids.rst

passwords
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_inspec_resources/includes_inspec_resource_etc_passwd_matcher_passwords.rst

uids
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_inspec_resources/includes_inspec_resource_etc_passwd_matcher_uids.rst

users
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_inspec_resources/includes_inspec_resource_etc_passwd_matcher_usernames.rst

passwd.uid(filter)
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following matchers may be used when filtering is associated with a user identifier:

count
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_inspec_resources/includes_inspec_resource_etc_passwd_matcher_count.rst

uid
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_inspec_resources/includes_inspec_resource_etc_passwd_matcher_uid.rst

username
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_inspec_resources/includes_inspec_resource_etc_passwd_matcher_username.rst

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test usernames and UIDs**

.. include:: ../../step_inspec/step_inspec_etc_passwd_uids.rst

**Select one user and test for multiple occurrences**

.. include:: ../../step_inspec/step_inspec_etc_passwd_multiple_users.rst
