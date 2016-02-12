.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

After the log files have been located, open them using a text editor to view the log file. The most common problem are below:

* Connectivity errors with the |chef server| caused by incorrect settings in the |client rb| file. Ensure that the ``chef_server_url`` value in the |client rb| file is the correct value and that it can be resolved.
* An invalid validator key has been specified. This will prevent the |chef client| from authenticating to the |chef server|. Ensure that the ``validaton_client_name`` value in the |client rb| file is the correct value
* The name of the node is the same as an existing node. Node names must be unique. Ensure that the name of the virtual machine in |azure| has a unique name.
* An error in one the run-list. The log file will specify the details about errors related to the run-list.
