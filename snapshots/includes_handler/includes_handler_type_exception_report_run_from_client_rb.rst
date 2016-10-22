.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A simple exception or report handler may be installed and configured at run-time. This requires editing of a node's client.rb file to add the appropriate setting and information about that handler to the client.rb or solo.rb files. Depending on the handler type, one (or more) of the following settings must be added:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``exception_handlers``
     - A list of exception handlers that are available to the chef-client during a chef-client run.
   * - ``report_handlers``
     - A list of report handlers that are available to the chef-client during a chef-client run.

When this approach is used, the client.rb file must also tell the chef-client how to install and run the handler. There is no default install location for handlers. The simplest way to distribute and install them is via RubyGems, though other methods such as GitHub or HTTP will also work. Once the handler is installed on the system, enable it in the client.rb file by requiring it. After the handler is installed, it may require additional configuration. This will vary from handler to handler. If a handler is a very simple handler, it may only require the creation of a new instance. For example, if a handler named ``MyOrg::EmailMe`` is hardcoded for all of the values required to send email, a new instance is required. And then the custom handler must be associated with each of the handler types for which it will run.

For example:

.. code-block:: ruby

   require 'rubygems'
   require '/var/chef/handlers/email_me'         # the installation path

   email_handler = MyOrg::EmailMe.new            # a simple handler

   start_handlers << email_handler               # run at the start of the run
   report_handlers << email_handler              # run at the end of a successful run
   exception_handlers << email_handler           # run at the end of a failed run
