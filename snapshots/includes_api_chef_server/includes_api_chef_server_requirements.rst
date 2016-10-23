.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The Chef server API has the following requirements:

* Access to a Chef server running version 0.10.x or above
* The ``Accept`` header must be set to ``application/json``
* For ``PUT`` and ``POST`` requests, the ``Content-Type`` header must be set to ``application/json``
* The ``X-Chef-Version`` header must be set to the version of the Chef server API that is being used
* A request must be signed using ``Mixlib::Authentication``
* A request must be well-formatted. The easiest way to ensure a well-formatted request is to use the ``Chef::REST`` library
