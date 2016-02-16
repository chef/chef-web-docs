.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A |solr rb| file is used to specify the configuration details for |chef solr|, |chef solr indexer|, and |chef solr rebuild|. This file is the default configuration file and is loaded every time these executable are run. The |chef solr| and |chef solr indexer| executables can be run as a daemon. (The |chef solr rebuild| executable cannot be run as an daemon.) 

The configuration file is located at: |path chef solr rb|. When a |apache solr| configuration file is present in this directory, the settings contained within that file will override the default configuration settings.