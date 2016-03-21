.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

#. Log into |chef server| webui and download the starter kit.  Build the URL by appending ``/getting_started`` to the to the fully qualified path of organization.  For example, ``http://<fqdn>/organizations/<your_org>/getting_started``.

#. .. include:: ../../step_install/step_install_aws_chef_server_extract_starter_kit.rst
#. .. include:: ../../step_install/step_install_aws_chef_server_knife_ssl_fetch.rst
#. .. include:: ../../step_install/step_install_aws_chef_server_knife_client_list.rst
#. Add virtual machines to the |chef server|.
#. Bootstrap nodes with the |chef server|.
