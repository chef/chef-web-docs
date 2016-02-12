.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

An environment can be created in five different ways:

* Creating a |ruby| file in the environments sub-directory of the |chef repo| and then pushing it to the |chef server|
* Creating a |json| file directly in the |chef repo| and then pushing it to the |chef server|
* Using |knife|
* Using the |chef manage| web user interface
* Using the |chef server| REST API

Once an environment exists on the |chef server|, a node can be associated with that environment using the ``chef_environment`` method. 

