.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The |chef repo| is the location in which the following data objects are stored: 

* Cookbooks (including recipes, versions, cookbook attributes, resources, providers, libraries, and templates)
* Roles
* Data bags
* Environments
* Configuration files (for clients, workstations, and servers) 

The |chef repo| is located on a workstation and should be synchronized with a version control system, such as |git|. All of the data in the |chef repo| should be treated like source code. 

|knife| is used to upload data to the |chef server| from the |chef repo|. Once uploaded, that data is used by the |chef client| to manage all of the nodes that are registered with the |chef server| and to ensure that the correct cookbooks, environments, roles, and other settings are applied to nodes correctly. 

