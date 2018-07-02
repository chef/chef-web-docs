=====================================================
chef-compliance.rb
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/config_rb_compliance.rst>`__

.. tag chef_automate_mark

.. image:: ../../images/chef_automate_full.png
   :width: 40px
   :height: 17px

.. end_tag

.. tag EOL_compliance_server

.. warning:: The standalone Chef Compliance server is deprecated. The standalone Chef Compliance server's end-of-life date is December 31, 2018. `Chef Automate 2 <https://www.chef.io/automate/>`__ has all of the functionality of Chef Compliance Server and also includes newer out-of-the-box compliance profiles, an improved compliance scanner with total cloud scanning functionality, better visualizations, role-based access control and many other features not found in Chef Compliance Server. 

.. end_tag

The ``/etc/chef-compliance/chef-compliance.rb`` file is the default configuration file used by Chef Compliance.

If changes are made to this file, reconfigure the Chef Compliance server by running the following command:

.. code-block:: bash

   $ chef-compliance-ctl reconfigure

.. note:: .. tag chef_subscriptions

          This feature is included as part of the Chef Automate license agreement and is `available via subscription <https://www.chef.io/pricing/>`_.

          .. end_tag

Settings
==========================================================================
This configuration file has the following settings:

``core.licensed_node_count``
   The number of node licenses. Default value: ``25``.

``core.log_level``
   Changes the log level of Chef Compliance from the default value of ``'debug'``, which is the most verbose. These are all the supported levels, sorted by verbosity: ``'debug'``, ``'info'``, ``'notice'``, ``'warning'``, ``'error'`` and ``'critical'``. Requires Chef Compliance version ``1.5.13`` or newer.

``fqdn``
   Sets the FQDN of the Chef Compliance server. By default, this is derived from your system's hostname. Do **not** use the ``=`` to set the option. For example: ``fqdn 'chef-compliance.example.com'``.

``ssl.certificate``
   Full path to the SSL certificate file that is used by the Chef Compliance web UI. Default value: ``/var/opt/chef-compliance/ssl/ca/HOSTNAME.crt``.

``ssl.certificate_key``
   Full path to the ssl certificate key file to use by the Chef Compliance web UI. Default value: ``/var/opt/chef-compliance/ssl/ca/HOSTNAME.key``.

``verify_tls``
   Verify the TLS certificate when Chef Compliance connects locally to get the refresh token. Default value: ``false``.

Here's an example content for ``/etc/chef-compliance/chef-compliance.rb``:

.. code-block:: bash

   core.licensed_node_count 100
   core.log_level      'info'
   fqdn                'chef-compliance.example.com'
   ssl.certificate     '/etc/chef-compliance/ssl/my.crt'
   ssl.certificate_key '/etc/chef-compliance/ssl/my.key'
   verify_tls          true

.. note:: You can see all available settings along with their default values in ``/etc/chef-compliance/chef-compliance-running.json``.
