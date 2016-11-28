

=====================================================
Organizations, Groups, and Users
=====================================================

.. tag server_rbac

The Chef server uses role-based access control (RBAC) to restrict access to objects---nodes, environments, roles, data bags, cookbooks, and so on. This ensures that only authorized user and/or chef-client requests to the Chef server are allowed. Access to objects on the Chef server is fine-grained, allowing access to be defined by object type, object, group, user, and organization. The Chef server uses permissions to define how a user may interact with an object, after they have been authorized to do so.

.. end_tag

.. tag server_rbac_components

The Chef server uses organizations, groups, and users to define role-based access control:

.. list-table::
   :widths: 100 420
   :header-rows: 1

   * - Feature
     - Description
   * - .. image:: ../../images/icon_server_organization.svg
          :width: 100px
          :align: center

     - An organization is the top-level entity for role-based access control in the Chef server. Each organization contains the default groups (``admins``, ``clients``, and ``users``, plus ``billing_admins`` for the hosted Chef server), at least one user and at least one node (on which the chef-client is installed). The Chef server supports multiple organizations. The Chef server includes a single default organization that is defined during setup. Additional organizations can be created after the initial setup and configuration of the Chef server.
   * - .. image:: ../../images/icon_server_groups.svg
          :width: 100px
          :align: center

     - .. tag server_rbac_groups

       A group is used to define access to object types and objects in the Chef server and also to assign permissions that determine what types of tasks are available to members of that group who are authorized to perform them. Groups are configured per-organization.

       Individual users who are members of a group will inherit the permissions assigned to the group. The Chef server includes the following default groups: ``admins``, ``clients``, and ``users``. For users of the hosted Chef server, an additional default group is provided: ``billing_admins``.

       .. end_tag

   * - .. image:: ../../images/icon_server_users.svg
          :width: 100px
          :align: center

     - A user is any non-administrator human being who will manage data that is uploaded to the Chef server from a workstation or who will log on to the Chef management console web user interface. The Chef server includes a single default user that is defined during setup and is automatically assigned to the ``admins`` group. 
   * - .. image:: ../../images/icon_chef_client.svg
          :width: 100px
          :align: center

     - .. tag server_rbac_clients

       A client is an actor that has permission to access the Chef server. A client is most often a node (on which the chef-client runs), but is also a workstation (on which knife runs), or some other machine that is configured to use the Chef server API. Each request to the Chef server that is made by a client uses a private key for authentication that must be authorized by the public key on the Chef server.

       .. end_tag

.. end_tag

.. tag server_rbac_workflow

When a user makes a request to the Chef server using the Chef server API, permission to perform that action is determined by the following process:

#. Check if the user has permission to the object type
#. If no, recursively check if the user is a member of a security group that has permission to that object 
#. If yes, allow the user to perform the action

Permissions are managed using the Chef management console add-on in the Chef server web user interface.

.. end_tag

Chef Push Jobs Groups
-----------------------------------------------------
.. tag push_jobs_1

Chef push jobs is an extension of the Chef server that allows jobs to be run against nodes independently of a chef-client run. A job is an action or a command to be executed against a subset of nodes; the nodes against which a job is run are determined by the results of a search query made to the Chef server.

Chef push jobs uses the Chef server API and a Ruby client to initiate all connections to the Chef server. Connections use the same authentication and authorization model as any other request made to the Chef server. A knife plugin is used to initiate job creation and job tracking.

.. end_tag

.. tag server_rbac_groups_push_jobs

It is possible to initiate jobs from the chef-client, such as from within a recipe based on an action to be determined as the recipe runs. For a chef-client to be able to create, initiate, or read jobs, the chef-client on which Chef push jobs is configured must belong to one (or both) of the following groups:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Group
     - Description
   * - ``pushy_job_readers``
     - Use to view the status of jobs.
   * - ``pushy_job_writers``
     - Use to create and initiate jobs.

These groups do not exist by default, even after Chef push jobs has been installed to the Chef server. If these groups are not created, only members of the ``admin`` security group will be able to create, initiate, and view jobs.

.. end_tag

