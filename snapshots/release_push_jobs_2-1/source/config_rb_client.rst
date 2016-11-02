

=====================================================
client.rb
=====================================================

.. tag config_rb_client_27

A client.rb file is used to specify the configuration details for the chef-client.

* This file is loaded every time this executable is run
* On UNIX- and Linux-based machines, the default location for this file is ``/etc/chef/client.rb``; on Microsoft Windows machines, the default location for this file is ``C:\chef\client.rb``; use the ``--config`` option from the command line to change this location
* This file is not created by default
* When a client.rb file is present in the default location, the settings contained within that client.rb file will override the default configuration settings

.. end_tag

Settings
==========================================================================
.. tag config_rb_client_settings_push_jobs

The client.rb configuration file has the following settings related to Chef push jobs:

``whitelist``
   A Hash that contains the whitelist used by Chef push jobs. For example:

   .. code-block:: ruby

      whitelist {
        'job-name' => 'command',
        'job-name' => 'command',
        'chef-client' => 'chef-client'
      }

   A job entry may also be ``'job-name' => {:lock => true}``, which will check the ``lockfile`` setting in the client.rb file before starting the job.

   .. warning:: The ``whitelist`` setting is available only when using Chef push jobs, a tool that runs jobs against nodes in an organization.

.. end_tag

