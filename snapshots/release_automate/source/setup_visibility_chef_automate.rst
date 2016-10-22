.. THIS PAGE IS IDENTICAL TO docs.chef.io/setup_visibility_chef_automate.html BY DESIGN
.. THIS PAGE IS LOCATED AT THE /release/automate/ PATH.

=====================================================
Configure Data Collection
=====================================================

.. include:: ../../includes_chef_automate/includes_chef_automate_mark.rst

Before using the visibility capabilities of Chef Automate, you must perform some simple setup and configuration steps before the nodes in your cluster can send data to your Chef Automate server.

Use an external Elasticsearch cluster
=====================================================

Chef Automate uses Elasticsearch to store its data, and the default Chef Automate install includes a single Elasticsearch service. 
This is sufficient to run production work loads; however for greater data retention, we recommend using a multi-node Elasticsearch 
cluster with replication and sharding to store and protect your data.

Prerequisites
-----------------------------------------------------

* Chef Automate server with workflow and visibility installed
* Elasticsearch (version 2.3.0 or greater)

Elasticsearch configuration
-----------------------------------------------------

To utilize an external Elasticsearch installation, set the following configuration option in your
``/etc/delivery/delivery.rb``:

.. code-block:: ruby

   elasticsearch['urls'] = ['https://my-elaticsearch-cluster.mycompany.com']

The ``elasticsearch['urls']`` attribute should be an array of Elasticsearch nodes over
which Chef Automate will round-robin requests. You can also supply a single entry which corresponds to
a load-balancer or a third-party Elasticsearch-as-a-service offering.

After saving the file, run ``sudo delivery-ctl reconfigure``.

An additional Elasticsearch-related configuration properties is ``elasticsearch['host_header']``. This is the 
HTTP ``Host`` header to send with the request. When this attribute is unspecified, the default behavior is as follows:

  * If the ``urls`` parameter contains a single entry, the host of the supplied URI will be sent as the Host header.
  * If the ``urls`` parameter contains more than one entry, no Host header will be  sent.

When this attribute *is* specified, the supplied string will be sent as the ``Host`` header on all requests. This may be required for some third-party Elasticsearch offerings.

Add Chef Automate certificate to `trusted_certs` directory
==============================================================

The visibilty features of Chef Automate require that any self-signed Chef Automate SSL certificate (``HOSTNAME.crt``) is located 
in the ``/etc/chef/trusted_certs`` directory on any node that wants to send data to Chef Automate. This directory is the location into 
which SSL certificates are placed when a node has been bootstrapped with chef-client. 

To ensure the certificate is in the ``trusted_certs`` directory, you can use utilities such as `scp` or `rsync` to copy 
``/var/opt/delivery/nginx/ca/HOSTNAME.crt`` from the Chef Automate server to the ``/etc/chef/trusted_certs`` directory on the 
node in your Chef Automate cluster, or use ``knife ssl fetch`` and pass in the URL of the Chef Automate server when calling the ``fetch`` subcommand.

.. note:: This only applies to self-signed SSL certificates. Any certificate signed by certificate authority should work without any additional configuration required.

Configure Nodes
=====================================================

To view data in the **Node State** dashboard of Chef Automate, it must be ingested from 
Chef clients and/or servers through HTTP POST requests to a data collector endpoint on the Chef Automate server. 
Node data, resource convergence status, error messages, and other information is collected during chef-client runs and 
used to populate the dashboard. 

At a minimum, nodes must be configured to send their data to Chef Automate by specifying the data collector endpoint and a token value. You can further configure the data collector functionality 
depending on the needs and requirements of your business.

Prerequisites
-------------------------------------------------------

* Chef client (version 12.12.15 or greater)
* Chef server (version 12.8 or greater)

Understand and (optionally) create data collector tokens
-----------------------------------------------------------------

When streaming data to Chef Automate, POST requests are sent to the data collector endpoint on the Chef Automate server. Those requests must be authenticated, 
and a token is used in the authentication process. The token is a SHA-256 checksum of a shared secret that Chef Automate's 
data collector uses to authenticate POST requests made to the data collector endpoint on the Chef Automate server. You may use any SHA-256 value for the token 
as long as the same value is used between Chef Automate and your Chef server and/or Chef clients. If unspecified in the Chef Automate server's ``delivery.rb`` file, the 
default value for the token is ``'93a49a4f2482c64126f7b6015e6b0f30284287ee4054ff8807fb63d9cbd1c506'``. You may use this value when configuring your nodes.

If you choose to create your own token, add ``data_collector['token'] = 'sometokenvalue'`` to your ``/etc/delivery/delivery.rb`` file on your Chef Automate server. Save your changes 
and then run ``sudo delivery-ctl reconfigure``.

Configure Chef client to send node and converge data
-------------------------------------------------------

The data collector functionality is used by the Chef client to send node and converge data to Chef Automate. This 
feature works for the following: Chef client, Chef solo (formerly "Chef client local mode"), and Chef solo legacy mode 
(formerly "Chef solo").

To send node and converge data to Chef Automate, modify your Chef config (that is
`client.rb`, `solo.rb`, or add an additional config file in an appropriate directory, such as
`client.d`) to contain the following configuration:

.. code-block:: ruby

   data_collector.server_url "https://my-automate-server.mycompany.com/data-collector/v0/"
   data_collector.token "TOKEN"

where ``my-automate-server.mycompany.com`` is the fully-qualified domain name of your Chef Automate server and
``TOKEN`` is the token value you are using for the authentication process.

Additional configuration options include:

  * ``data_collector.mode``: The mode in which the data collector is allowed to operate. This
    can be used to run data collector only when running as Chef Solo but not when using Chef client.
    Options: ``:solo`` (for both Solo Legacy Mode and Solo Mode), ``:client``, or ``:both``.  Default:
    ``:both``.
  * ``data_collector.raise_on_failure``: When the data collector cannot send the "starting a run"
    message to the data collector server, the data collector will be disabled for that run. In some
    situations, such as highly-regulated environments, it may be more reasonable to prevent Chef
    from performing the actual run. In these situations, setting this value to ``true`` will cause the
    Chef run to raise an exception before starting any converge activities. Default: ``false``.
  * ``data_collector.organization``: A user-supplied organization string that can be sent in
    payloads generated by the data collector when Chef is run in Solo mode. This allows users to
    associate their Solo nodes with faux organizations without the nodes being connected to an
    actual Chef server.

Configure Chef client to send InSpec data
-------------------------------------------------------

To send InSpec data as part of a Chef client run, you will need to use the `audit cookbook <https://github.com/chef-cookbooks/audit>`_. All profiles, which are configured to run during the audit cookbook execution, will send their results back to the Chef Automate server.

To configure the audit cookbook, you will first need to configure the Chef client to send node converge data, as previously described. The ``data_collector.server_url`` and ``data_collector.token`` values will be used as the reporting targets. Once you have done that, configure the the audit cookbook's collector by setting the ``audit.collector`` attribute to ``chef-visibility``. 

A complete audit cookbook attribute configuration would look something like this:

.. code-block:: javascript

    audit: {
      collector: 'chef-visibility',
      profiles: {
        'cis/cis-centos6-level1' => true
      }
    }

Configure Chef server to send server object data
-------------------------------------------------------

Chef server can be configured to send messages to Chef Automate whenever an action is taken on a Chef server object, such as when a cookbook is uploaded to 
the Chef server or when a user edits a role.

To enable this feature, add the following settings to ``/etc/opscode/chef-server.rb`` on the Chef server:

.. code-block:: ruby

   data_collector['root_url'] = 'https://my-automate-server.mycompany.com/data-collector/v0/'
   data_collector['token'] = 'TOKEN'

where ``my-automate-server.mycompany.com`` is the fully-qualified domain name of your Chef Automate server, and
``TOKEN`` is the token value you are using for the authentication process.

Save the file and run ``chef-server-ctl reconfigure`` to complete the process.

Additional configuration options include:

 * ``data_collector['timeout']``: timeout in milliseconds to abort an attempt to send a message to the
   Chef Automate server. Default: ``30000``.
 * ``data_collector['http_init_count']``: number of Chef Automate HTTP workers Chef server should start.
   Default: ``25``.
 * ``data_collector['http_max_count']``: maximum number of Chef Automate HTTP workers Chef server should
   allow to exist at any time. Default: ``100``.
 * ``data_collector['http_max_age']``: maximum age a Chef Automate HTTP worker should be allowed to live,
   specified as an Erlang tuple. Default: ``{70, sec}``.
 * ``data_collector['http_cull_interval']``: how often Chef server should cull aged-out Chef Automate
   HTTP workers that have exceeded their ``http_max_age``, specified as an Erlang tuple. Default: ``{1,
   min}``.
 * ``data_collector['http_max_connection_duration']``: maximum duration an HTTP connection is allowed
   to exist before it is terminated, specified as an Erlang tuple. Default: ``{70, sec}``.

Configure High Availability servers to send server object data
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

To configure front-end servers in your HA cluster to send their object data, perform the previous steps for configuring a Chef server as 
well as ensure that the ``fqdn`` field in all of your front-end Chef server ``chef-server.rb`` files are the same.

The following example sets the ``fqdn`` field to ``"my-chef-server.mycompany.com"`` in two front-end servers.

**chef-server.rb.FE1**

.. code-block:: ruby

   # This file generated by chef-backend-ctl gen-server-config
   # Modify with extreme caution.
   fqdn "my-chef-server.mycompany.com"
   use_chef_backend true
   data_collector['root_url'] = 'https://my-automate-server.mycompany.com/data-collector/v0/'
   data_collector['token'] = 'TOKEN'

**chef-server.rb.FE2**

.. code-block:: ruby

   # This file generated by chef-backend-ctl gen-server-config
   # Modify with extreme caution.
   fqdn "my-chef-server.mycompany.com"
   use_chef_backend true
   data_collector['root_url'] = 'https://my-automate-server.mycompany.com/data-collector/v0/'
   data_collector['token'] = 'TOKEN'

.. warning:: Failure to set the ``fqdn`` field to the same value will result in Chef Automate treating data from each of these front-end servers as separate Chef servers.

Send Habitat data to Visibility
-------------------------------------------------------

The visibility capabilities of Chef Automate can also be used to collect and report on Habitat ring data. The Prism Habitat package collects this data and sends it to an Chef Automate server's REST API endpoint. You can configure settings like the data collector URL, token, the Habitat supervisor used to get the ring information, and so on. For more information on the Prism package, see `Habitat Prism <https://docs.chef.io/habitat_prism.html>`__. For more information on Habitat, see the `Habitat site <https://habitat.sh/>`__.


Set up visibility with previous Chef Delivery installation
===============================================================

.. note:: Visibility is automatically installed as part of the Chef Automate installation. The following instructions **only** apply to customers who have previously installed Chef Delivery as a stand alone implementation. If you are using visibility in Chef Automate, you can skip this section.

To get started with the visibility capabilities in Chef Automate, modify ``/etc/delivery/delivery.rb``
on your Chef Delivery server and add the following settings:

.. code-block:: ruby

    insights['enable'] = true
    data_collector['token'] = 'TOKEN'

Create an authentication token (as described in the previous section) and then run ``sudo delivery-ctl reconfigure`` to complete the process.

Now that you have a token value selected, you are ready to configure your Chef server and any Chef client 
nodes to start streaming data to Chef Automate.

Troubleshooting: My data does not show up in the UI
=====================================================

.. include:: ../../includes_chef_automate/includes_chef_automate_visibility_no_data_troubleshoot.rst
