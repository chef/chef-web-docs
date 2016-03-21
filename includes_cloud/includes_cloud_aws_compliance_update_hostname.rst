.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To update the hostname, do the following:

#. Run ``sudo -i`` to gain administrator privileges.

#. Run ``chef-marketplace-ctl hostname`` to view the current hostname.

#. Configure the ``api_fqdn`` in ``/etc/chef-marketplace/marketplace.rb``

   .. code-block:: bash

      $ echo 'api_fqdn "<new.hostname.com>"' | sudo tee -a /etc/chef-marketplace/marketplace.rb

#. Run ``chef-compliance-ctl stop && mv /etc/chef-compliance/chef-compliance.rb /etc/chef-compliance/chef-compliance.rb.bak`` to stop |chef compliance| and remove the configuration file.

#. Run ``chef-marketplace-ctl hostname <new.hostname.com>`` to update the hostname.

#. Run ``chef-compliance-ctl reconfigure`` to ensure |chef compliance| has beeen correctly configured with the new hostname.

#. Run ``chef-compliance-ctl restart`` to restart |chef compliance|
