.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

DRBD configuration allows for custom handlers when a ``split-brain`` event happens. The basic handler sends a notification email to a configurable email address so the issue can be investigated.

The ``drbd.conf`` file that is used with the Chef server specifies other built-in actions that may be taken in certain fault scenarios:

.. code-block:: none

   after-sb-0pri discard-younger-primary;
   after-sb-1pri discard-secondary;
   after-sb-2pri call-pri-lost-after-sb;

What this means:

* after-sb-0pri: A ``split-brain`` event has been detected and neither node is the primary node. The ``discard-younger-primary`` action will roll back any changes made on the last host that was the primary node.
* after-sb-1pri: A ``split-brain`` event has been detected and only one node believes that it was the primary node when the event happened. The ``discard-secondary`` action will continue operations on the primary node and will assume that the secondary node was lost.
* after-sb-2pri: A ``split-brain`` event has been detected and both nodes believed they were primary nodes. The ``call-pri-lost-after-sb`` action will attempt to apply the ``discard-younger-primary`` from the ``0pri`` configuration to determine which host should be the primary node. Once determined, the other host takes action to become the secondary node.
