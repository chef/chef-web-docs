.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


|config rb client| 

* This file is loaded every time this executable is run
* On |unix|- and |linux|-based machines, the default location for this file is |path chef client rb|; on |windows| machines, the default location for this file is |path chef client rb windows|; use the ``--config`` option from the command line to change this location
* This file is not created by default
* When a |client rb| file is present in the default location, the settings contained within that |client rb| file will override the default configuration settings
