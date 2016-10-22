.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To find an organization by user name:

.. code-block:: ruby

   orgmapper:0 > OrganizationUser.organizations_for_user(USERS['USERNAME']).collect do |orguser|
     Mixlib::Authorization::Models::Organization.get(orguser).name
   end

where ``USERNAME`` is the name of the user.
