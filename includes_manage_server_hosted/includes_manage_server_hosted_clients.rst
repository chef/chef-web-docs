.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The **Management Console** allows users to create, read, edit, and delete API clients.
 
On Hosted Chef, "API Clients" are entities that are similar to Users, except that clients are always scoped to your organization and only have access to the Hosted Chef API. API Clients are used by chef-client to authenticate when connecting to Hosted Chef. Typically, there is one client for each node under management.

When you first sign up, a "validator" client is created for your organization named ORGANIZATION-validator.pem. This "validator" client can be used to create new clients for your organization via the Hosted Chef API. If the "validator" client is deleted for any reason, you will need to recreate it to authenticate new nodes. Be careful not to let this happen, if it does, following directions in the `Organization not found <https://learnchef.opscode.com/errors-and-problems/401-unauthorized/>`_ section will recreate it.

Anyone in possession of a client's private key can do anything on your Hosted Chef account that the client is authorized to do, so be sure to protect you clients' private keys. These keys are typically created the first time a given chef-client connects to Hosted Chef, and stored locally on the node.

You can also manage clients with the command line tool Knife.
