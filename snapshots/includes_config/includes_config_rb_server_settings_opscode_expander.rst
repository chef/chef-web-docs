.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings for ``opscode-expander``:

``opscode_expander['consumer_id']``
   The identity of the consumer to which messages are published. Default value: ``default``.

``opscode_expander['dir']``
   The working directory. The default value is the recommended value. Default value:

   .. code-block:: ruby

      /var/opt/opscode/opscode-expander

``opscode_expander['enable']``
   Enable a service. Default value: ``true``.

``opscode_expander['ha']``
   Run the Chef server in a high availability topology. When ``topology`` is set to ``ha``, this setting defaults to ``true``. Default value: ``false``.

``opscode_expander['log_directory']``
   The directory in which log data is stored. The default value is the recommended value. Default value:

   .. code-block:: ruby

      /var/log/opscode/opscode-expander

``opscode_expander['log_rotation']``
   The log rotation policy for this service. Log files are rotated when they exceed ``file_maxbytes``. The maximum number of log files in the rotation is defined by ``num_to_keep``. Default value:

   .. code-block:: ruby

      { 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }

``opscode_expander['nodes']``
   The number of allowed worker processes. Default value: ``2``.

``opscode_expander['reindexer_log_directory']``
   The directory in which ``opscode-expander-reindexer`` logs files are located. Default value:

   .. code-block:: ruby

      /var/log/opscode/opscode-expander-reindexer
