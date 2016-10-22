.. THIS PAGE DOCUMENTS Enterprise Chef server version 11.0

=====================================================
orgmapper
=====================================================

orgmapper is a tool that can be used with a non-hosted Chef server to provide administrative access to back-end objects. orgmapper can be a dangerous tool and should be used carefully. In general, anything that needs to be done around automating user creation, making permissions changes, and so on, can be done more easily using the ``knife-acl`` plugin and by using the Chef server web interface.

.. warning:: This tool is deprecated.

Examples
=====================================================
The following examples show how to use orgmapper:

**Start orgmapper**

.. include:: ../../step_orgmapper/step_orgmapper_start.rst

**Find users in an organization**

.. include:: ../../step_orgmapper/step_orgmapper_find_user_by_org.rst

**Find organizations for a user**

.. include:: ../../step_orgmapper/step_orgmapper_find_org_by_user.rst

**Find a user name based on email address**

.. include:: ../../step_orgmapper/step_orgmapper_find_user_by_email.rst

**Associate a user to an organization**

.. include:: ../../step_orgmapper/step_orgmapper_associate_user_to_org.rst

**Add a user to organization's admin group**

.. include:: ../../step_orgmapper/step_orgmapper_add_user_to_admin_group.rst

**Remove a user from organization's admin group**

.. include:: ../../step_orgmapper/step_orgmapper_remove_user_from_admin_group.rst

**Delete a user**

.. include:: ../../step_orgmapper/step_orgmapper_delete_user.rst

