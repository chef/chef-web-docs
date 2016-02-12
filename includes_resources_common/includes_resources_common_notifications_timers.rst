.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use the following timers to specify when a notification is triggered:

``:delayed``
   Use to specify that a notification should be queued up, and then executed at the very end of a |chef client| run.

``:immediately``
   Use to specify that a notification should be run immediately, per resource notified.
