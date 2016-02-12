.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To update the hostname, do the following:

#. Run ``chef-marketplace-ctl hostname`` to view the current hostname.

#. Run ``chef-marketplace-ctl hostname <new.hostname.com>`` to update the hostname.

   .. note:: If the hostname is updated after the |chef server| has been set up, verify that the ``api_fqdn`` setting is correct in ``/etc/opscode/chef-server.rb``.

#. Run ``chef-server-ctl reconfigure && opscode-manage-ctl reconfigure`` to reconfigure the |chef server| with the new hostname.
