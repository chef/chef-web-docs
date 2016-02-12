.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


|chef analytics| tracks all of this data in real-time, which then helps you answer the following types of questions:

* Which object changed?
* What type of change was made?
* When was this change made?
* Who changed it?

For example, |chef analytics| can tell you things like:

* The date and time on which a specific user uploaded a cookbook from their local workstation to the |chef server|
* The date and time at which a cookbook stopped working
* The changes that were made to the system immediately before that cookbook stopped working

This type of information can be used to quickly identify where in the overall system something changed, which in turn helps identify what went wrong, and then helps show your organization what the resolution should be.

|chef analytics| can also tell you things like:

* What happened just before one (or more) |chef client| runs started failing?
* Which versions of |ssh| are on which machines?
* Is each system updated for the latest patch?
* When did the depsolver break? Which changes happened immediately prior?

Because |chef analytics| tracks all of this in real-time, your organization will be able to use |chef analytics| to react to events as they happen and to more quickly resolve issues that may arise.