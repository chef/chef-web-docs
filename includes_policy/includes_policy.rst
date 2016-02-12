.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Policy settings are used to map business and operational requirements, process, and workflow to settings and objects stored on the |chef server|:

* Roles define server types, such as "web server" or "database server"
* Environments define process, such as "dev", "staging", or "production"
* Certain types of data---passwords, user account data, and other sensitive items---can be placed in data bags, which are located in a secure sub-area on the |chef server| that can only be accessed by nodes that authenticate to the |chef server| with the correct |ssl| certificates
* The cookbooks (and cookbook versions) in which organization-specific configuration policies are maintained


