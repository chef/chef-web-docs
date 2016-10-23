.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The output format: ``doc`` (default) or ``min``.

* Use ``doc`` to print the progress of the chef-client run using full strings that display a summary of updates as they occur.
* Use ``min`` to print the progress of the chef-client run using single characters.

A summary of updates is printed at the end of the chef-client run. A dot (``.``) is printed for events that do not have meaningful status information, such as loading a file or synchronizing a cookbook. For resources, a dot (``.``) is printed when the resource is up to date, an ``S`` is printed when the resource is skipped by ``not_if`` or ``only_if``, and a ``U`` is printed when the resource is updated.

Other formatting options are available when those formatters are configured in the client.rb file using the ``add_formatter`` option.
