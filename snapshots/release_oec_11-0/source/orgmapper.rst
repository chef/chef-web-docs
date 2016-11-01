

=====================================================
orgmapper
=====================================================

orgmapper is a tool that can be used with a non-hosted Chef server to provide administrative access to back-end objects. orgmapper can be a dangerous tool and should be used carefully. In general, anything that needs to be done around automating user creation, making permissions changes, and so on, can be done more easily using the ``knife-acl`` plugin and by using the Chef server web interface.

.. warning:: This tool is deprecated.

Examples
=====================================================
The following examples show how to use orgmapper:

**Start orgmapper**

.. tag orgmapper_start

.. To start orgmapper:

Log in to the server that is hosting the back-end. (In a high availability configuration, this should be the current primary server in that configuration.)

.. code-block:: bash

   $ /opt/opscode/bin/orgmapper

Next, query organizations, users, and so on similar to the following examples

.. code-block:: ruby

   orgmapper:0 > pp ORGS.all

or:

.. code-block:: ruby

   orgmapper:0 > pp ORGS['ORGNAME']

or:

.. code-block:: ruby

   orgmapper:0 > pp USERS.all

or:

.. code-block:: ruby

   orgmapper:0 > pp USERS['USER']

where (in each of the previous examples) ``ORGNAME`` is the name of the organization and ``USER`` is the name of the user.

.. end_tag

**Find users in an organization**

.. tag orgmapper_find_user_by_org

.. To find users in an organization:

.. code-block:: ruby

   orgmapper:0 > OrganizationUser.users_for_organization(ORGS['ORGNAME']).collect do |orguser|
     Mixlib::Authorization::Models::User.get(orguser).username
   end

where ``ORGNAME`` is the name of the organization.

.. end_tag

**Find organizations for a user**

.. tag orgmapper_find_org_by_user

.. To find an organization by user name:

.. code-block:: ruby

   orgmapper:0 > OrganizationUser.organizations_for_user(USERS['USERNAME']).collect do |orguser|
     Mixlib::Authorization::Models::Organization.get(orguser).name
   end

where ``USERNAME`` is the name of the user.

.. end_tag

**Find a user name based on email address**

.. tag orgmapper_find_user_by_email

.. To find a user based on an email address:

.. code-block:: ruby

   orgmapper:0 > USERS.select{|u| u.email == 'user@company.com'}

where ``user@company.com`` is the email address for the user.

.. end_tag

**Associate a user to an organization**

.. tag orgmapper_associate_user_to_org

.. To associate a user to an orgazation:

Ensure that the user and organization already exist and then do something like:

.. code-block:: ruby

   orgmapper:0 > OrgMapper::Associator.associate_user(ORGS['ORGNAME'], USERS['USERNAME'])

where ``ORGNAME`` is the name of the organization and ``USERNAME`` is the name of the user.

.. end_tag

**Add a user to organization's admin group**

.. tag orgmapper_add_user_to_admin_group

.. To add a user to an organization's admin group:

.. code-block:: ruby

   orgmapper:0> g = ORGS['ORGNAME'].groups['admins']
   orgmapper:0> g.add_actor(USERS['USERNAME'])
   orgmapper:0> g.save

where ``ORGNAME`` is the name of the organization and ``USERNAME`` is the name of the user.

.. end_tag

**Remove a user from organization's admin group**

.. tag orgmapper_remove_user_from_admin_group

.. To remove a user from an organization's admin group:

.. code-block:: ruby

   orgmapper:0> ORGS['ORGNAME'].remove_user_from_group('USERNAME', 'admins')

.. end_tag

**Delete a user**

.. tag orgmapper_delete_user

.. To delete a user:

.. code-block:: ruby

   orgmapper:0 > USERS.mapper.destroy(USERS['USERNAME'])

where ``USERNAME`` is replaced by the user name that will be deleted.

.. end_tag

