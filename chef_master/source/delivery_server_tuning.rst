=====================================================
Chef Automate Server Tuning
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/delivery_server_tuning.rst>`__

.. meta:: 
    :robots: noindex 

.. tag chef_automate_mark

.. image:: ../../images/a2_docs_banner.svg
   :target: https://automate.chef.io/docs

.. end_tag


.. tag EOL_a1

.. danger:: This documentation applies to a deprecated product </versions.html#deprecated-products-and-versions>`__. The new Chef Automate includes newer out-of-the-box compliance profiles, an improved compliance scanner with total cloud scanning functionality, better visualizations, role-based access control and many other features. The new Chef Automate is included as part of the Chef Automate license agreement and is `available via subscription <https://www.chef.io/pricing/>`_.

.. end_tag

.. tag delivery_server_tuning_general

The following settings are typically added to the server configuration file, including:

* Logging directories
* Maximum file sizes at which log rotation occurs
* The number of log files to keep

These values have the same default across all Chef Automate services, but individual services can have their values overwritten. Add the service-specific values to the ``delivery.rb`` file. The list of services delivery starts which include logging can be determined by looking in the ``node['delivery']['log_directory']`` directory.

``<service_name>['log_directory']``
   The directory in which log data is stored. The default value is the recommended value. Default value: ``/var/log/delivery/<service_name>``.

``<service_name>['log_rotation']['file_maxbytes']``
   The log rotation policy for this service. Log files are rotated when they exceed ``file_maxbytes``. The maximum number of log files in the rotation is defined by ``num_to_keep``. Default value: ``100 * 1024 * 1024`` (100MB).

``<service_name>['log_rotation']['num_to_keep']``
   The log rotation policy for this service. Log files are rotated when they exceed ``file_maxbytes``. The maximum number of log files in the rotation is defined by ``num_to_keep``. Default value: ``10``.

.. end_tag

