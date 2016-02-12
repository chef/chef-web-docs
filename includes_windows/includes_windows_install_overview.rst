.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The |chef client| can be installed on machines running |windows| in the following ways:

* By using the `knife windows <https://docs.chef.io/plugin_knife_windows.html>`_ plugin to bootstrap the |chef client|; this process requires the target node be available via |ssh| (port 22) or by using the HTTP or HTTPS ports that are required by |windows remote management|
* By downloading the |chef client| to the target node, and then running the |microsoft installer package| locally
* By using an existing process already in place for managing |windows| machines, such as |windows server system_center|

To run the |chef client| at periodic intervals (so that it can check in with the |chef server| automatically), configure the |chef client| to run as a service or as a scheduled task. (The |chef client| can be configured to run as a service during the setup process.)





