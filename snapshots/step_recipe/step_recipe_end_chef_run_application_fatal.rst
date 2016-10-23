.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A chef-client run is stopped after a fatal message is sent to the logger and ``STDERR``. For example:

.. code-block:: ruby

   Chef::Application.fatal!("log_message", error_code) if condition

where ``condition`` defines when a ``"log_message"`` and an ``error_code`` are sent to the logger and ``STDERR``, after which the chef-client will exit. The ``error_code`` itself is arbitrary and is assigned by the individual who writes the code that triggers the fatal message. Assigning an error code is optional, but they can be useful during log file analysis.

This approach is used within the chef-client itself to help ensure consistent messaging around certain behaviors. That said, this approach is not recommended for use within recipes and cookbooks and should only be used when the other approaches are not applicable.

.. note:: This approach should be used carefully when the chef-client is run as a daemonized service. Some services---such as a runit service---should restart, but others---such as an init.d services---likely will not.
