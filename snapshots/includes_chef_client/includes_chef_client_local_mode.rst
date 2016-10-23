.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Local mode is a way to run the chef-client against the chef-repo on a local machine as if it were running against the Chef server. Local mode relies on chef-zero, which acts as a very lightweight instance of the Chef server. chef-zero reads and writes to the ``chef_repo_path``, which allows all commands that normally work against the Chef server to be used against the local chef-repo. 

Local mode does not require a configuration file, instead it will look for a directory named ``/cookbooks`` and will set ``chef_repo_path`` to be just above that. (Local mode will honor the settings in a configuration file, if desired.) If the client.rb file is not found and no configuration file is specified, local mode will search for a knife.rb file.

Local mode will store temporary and cache files under the ``<chef_repo_path>/.cache`` directory by default. This allows a normal user to run the chef-client in local mode without requiring root access.
