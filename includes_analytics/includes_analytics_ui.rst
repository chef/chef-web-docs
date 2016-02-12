.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The |chef analytics| user interface allows you to:

* View actions on any |chef| object. See changes to a node or role to track down bugs.
* View actions for an organization. See all the actions in a production organization to measure the level of change at different times of the day and week.
* Navigate to the |chef manage| console. There's one-click to access an object in the management console from the |chef analytics| page.
* Fan-out messages for distribution. Send notifications from |chef| to |hipchat| when cookbooks or roles have been uploaded.
* Distinguish between |knife|, |chef client|, and other clients. View the different types of client applications accessing the |chef server| to spot unusual or unexpected behavior.
* Correlate calls from a single client invocation. Group all the items that happened during a single client (e.g. |chef client|, |knife|) invocation.
* Browse actions for after-the-fact investigation. A persistent log can be saved on demand for auditing purposes or for analyzing information after an event has occurred. All messages are immutable. Non-modifiable messages are delivered reliably to the actions database. They can be used as a trusted source of data about changes to your infrastructure.

.. image:: ../../images/actions_log_ui.png