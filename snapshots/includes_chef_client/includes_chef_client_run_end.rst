.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Sometimes it may be necessary to stop processing a recipe and/or stop processing the entire chef-client run. There are a few ways to do this:

* Use the ``return`` keyword to stop processing a recipe based on a condition, but continue processing the chef-client run 
* Use the ``raise`` keyword to stop a chef-client run by triggering an unhandled exception
* Use a ``rescue`` block in Ruby code
* Use an `exception handler <https://docs.chef.io/handlers.html>`_
* Use ``Chef::Application.fatal!`` to log a fatal message to the logger and ``STDERR``, and then stop the chef-client run


