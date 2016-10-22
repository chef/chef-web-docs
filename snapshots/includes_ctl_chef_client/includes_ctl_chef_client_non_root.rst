.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


In large, distributed organizations the ability to modify the configuration of systems is sometimes segmented across teams, often with varying levels of access to those systems. For example, core application services may be deployed to systems by a central server provisioning team, and then developers on different teams build tooling to support specific applications. In this situation, a developer only requires limited access to machines and only needs to perform the operations that are necessary to deploy tooling for a specific application.

The default configuration of the chef-client assumes that it is run as the root user. This affords the chef-client the greatest flexibility when managing the state of any object. However, the chef-client may be run as a non-root user---i.e. "run as a user with limited system privileges"---which can be useful when the objects on the system are available to other user accounts. 

When the chef-client is run as a non-root user the chef-client can perform any action allowed to that user, as long as that action does not also require elevated privileges (such as sudo or pbrun). Attempts to manage any object that requires elevated privileges will result in an error. For example, when the chef-client is run as a non-root user that is unable to create or modify users, the **user** resource will not work.
