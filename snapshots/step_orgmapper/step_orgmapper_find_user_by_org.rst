.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To find users in an organization:

.. code-block:: ruby

   orgmapper:0 > OrganizationUser.users_for_organization(ORGS['ORGNAME']).collect do |orguser|
     Mixlib::Authorization::Models::User.get(orguser).username
   end

where ``ORGNAME`` is the name of the organization.
