.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``delivery.rb`` file contains all of the non-default configuration settings used by the |delivery|. (The default settings are built-in to the |delivery| configuration and should only be added to the ``delivery.rb`` file to apply non-default values.) These configuration settings are processed when the ``delivery-server-ctl reconfigure`` command is run, such as immediately after setting up |delivery| or after making a change to the underlying configuration settings after the server has been deployed. The ``delivery.rb`` file is a |ruby| file, which means that conditional statements can be used in the configuration file.
