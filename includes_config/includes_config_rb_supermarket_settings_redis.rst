.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings for |redis|:

``supermarket['redis']['bind']``
   |bind redis| Default value: ``'127.0.0.1'``.

``supermarket['redis']['directory']``
   |directory generic| |default_value_recommended| Default value: ``"#{node['supermarket']['var_directory']}/redis"``.

``supermarket['redis']['enable']``
   |enable service| Default value: ``true``.

``supermarket['redis']['log_directory']``
   |directory logs| |default_value_recommended| Default value: ``"#{node['supermarket']['log_directory']}/redis"``.

``supermarket['redis']['log_rotation']``
   |log_rotation| Default value: ``{ 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }``

``supermarket['redis']['port']``
   |port service| Default value: ``'16379'``.
