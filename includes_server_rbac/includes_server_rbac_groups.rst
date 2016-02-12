.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A group is used to define access to object types and objects in the |chef server| and also to assign permissions that determine what types of tasks are available to members of that group who are authorized to perform them. Groups are configured per-organization.

Individual users who are members of a group will inherit the permissions assigned to the group. The |chef server| includes the following default groups: |webui group admins|, |webui group clients|, and |webui group users|. For users of the hosted |chef server|, an additional default group is provided: |webui group billing|.