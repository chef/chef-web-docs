.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings for |ruby on rails|:

``supermarket['rails']['enable']``
   |enable service| Default value: ``true``.

``supermarket['rails']['log_directory']``
   |directory logs| |default_value_recommended| Default value: ``"#{node['supermarket']['log_directory']}/rails"``.

``supermarket['rails']['log_rotation']``
   |log_rotation| Default value: ``{ 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }``

``supermarket['rails']['port']``
   |port service| Default value: ``13000``.
