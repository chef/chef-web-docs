=====================================================
Install |chef|!
=====================================================

|chef| is installed and configured in three main phases: setting up the |chef server|, setting up a workstation, and then installing the |chef client| on each node that will be under management by |chef|:

* :doc:`Install the Chef Server </install_server>`; the |chef server| may be :doc:`configured for high availability </server_high_availability>`, including `using Amazon Web Services <https://docs.chef.io/install_server_ha_aws.html>`_ machines and `on-premises using DRBD <https://docs.chef.io/install_server_ha_drbd.html>`_, and may be configured as `a single backend machine with multiple frontend machines <https://docs.chef.io/install_server_tiered.html>`_
* Set up your workstation by :doc:`installing the Chef DK </install_dk>`
* :doc:`Install the chef-client </install_bootstrap>`

|chef| also has additional features that can be enabled as part of the setup and configuration process. 

* The :doc:`Chef management console </manage>` provides a web user interface for managing objects on the |chef server|
* :doc:`Chef reporting </reporting>` enables |chef client| run reporting data from within the |chef manage|
* :doc:`Chef replication </server_replication>` enables the synchronization of data from a primary |chef server| to one (or more) secondary servers
* :doc:`Chef analytics </analytics>` provides real-time visibility into what is happening on the |chef server|, including what's changing, who made those changes, and when they occurred. |chef analytics| is :doc:`installed on dedicated hardware </install_analytics>`, separate from the |chef server|
* :doc:`Chef push jobs </push_jobs>` runs a job---an action or a command---against nodes independently of a |chef client| run. |push jobs| has :doc:`some additional configuration steps </install_push_jobs>`

In addition, there are some :doc:`post-configuration options </install_server_post>` for the |chef server|.
