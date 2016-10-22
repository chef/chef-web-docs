.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

``Chef::Log`` extends ``Mixlib::Log`` and will print log entries to the default logger that is configured for the machine on which the chef-client is running. (To create a log entry that is built into the resource collection, use the **log** resource instead of ``Chef::Log``.)

The following log levels are supported:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Log Level
     - Syntax
   * - Debug
     - ``Chef::Log.debug('string')``
   * - Error
     - ``Chef::Log.error('string')``
   * - Fatal
     - ``Chef::Log.fatal('string')``
   * - Info
     - ``Chef::Log.info('string')``
   * - Warn
     - ``Chef::Log.warn('string')``

.. note:: The parentheses are optional, e.g. ``Chef::Log.info 'string'`` may be used instead of ``Chef::Log.info('string')``.
