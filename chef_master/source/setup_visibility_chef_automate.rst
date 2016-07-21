=====================================================
Setup and Configure Visibility in Chef Automate
=====================================================

Before using the visibility capabilities of |automate|, you must perform some simple setup and configuration steps to enable visibility.

Prerequisites
================================================================

* Chef Automate Server with workflow and visibility installed
* Elasticsearch (version 2.3.0 or greater)

Elasticsearch Configuration
================================================================

Chef Automate uses Elasticsearch to store its data, and the default Chef Automate install includes a
single Elasticsearch service. This single service is sufficient for testing but is likely to not be
sufficient for production loads. Therefore, we recommend using a multi-node Elasticsearch cluster
with replication and sharding to store and protect your data.

To utilize an external Elasticsearch installation, set the following configuration option in your
``/etc/delivery/delivery.rb``:

.. code-block:: ruby

   elasticsearch['urls'] = ['https://my-elaticsearch-cluster.mycompany.com']

The ``elasticsearch['urls']`` attribute should be an array of Elasticsearch nodes over
which |automate| will round-robin requests. You can also supply a single entry which corresponds to
a load-balancer or a third-party Elasticsearch-as-a-service offering.

After saving the file, run ``sudo delivery-ctl reconfigure``.

An additional Elasticsearch-related configuration properties is ``elasticsearch['host_header']``. This is the 
HTTP ``Host`` header to send with the request. When this attribute is unspecified, the default behavior is as follows:

  * If the ``urls`` parameter contains a single entry, the host of the supplied URI will be sent as the Host header.
  * If the ``urls`` parameter contains more than one entry, no Host header will be  sent.

When this attribute *is* specified, the supplied string will be sent as the ``Host`` header on all requests. This may be required for some third-party Elasticsearch offerings.

Understanding and (optionally) creating data collector tokens
================================================================

When streaming data to |automate|, POST requests are sent to the data collector endpoint on the |automate| server. Those requests must be authenticated, 
and a token is used in the authentication process. The token is a SHA-256 checksum of a shared secret that Chef Automate's 
data collector uses to authenticate POST requests made to the data collector endpoint on the |automate| server. You may use any SHA-256 value for the token 
as long as the same value is used between |automate| and your Chef server and/or Chef clients. If unspecified in the |automate| server's ``delivery.rb`` file, the 
default value for the token is ``'93a49a4f2482c64126f7b6015e6b0f30284287ee4054ff8807fb63d9cbd1c506'``. You may use this value when configuring your nodes.

If you choose to create your own token, add ``data_collector['token'] = 'sometokenvalue'`` to your ``/etc/delivery/delivery.rb`` file. Save your changes 
and then run ``sudo delivery-ctl reconfigure``.

Setting up visibility with previous Chef Delivery installation
================================================================

.. note:: Visibility is automatically installed as part of the Chef Automate installation. The following instructions **only** apply to customers who have previously installed Chef Delivery as a stand alone implementation. If you are using visibility in |automate|, you can skip this section.

To get started with the visibility capabilities in |automate|, modify ``/etc/delivery/delivery.rb``
on your Chef Delivery server and add the following settings:

.. code-block:: ruby

    insights['enable'] = true
    data_collector['token'] = 'TOKEN'

Create an authentication token (as described in the previous section) and then run ``sudo delivery-ctl reconfigure`` to complete the process.

Now that you have a token value selected, you are ready to configure your Chef server and any Chef client 
nodes to start streaming events to |automate|. See :doc:`Ingest Data </ingest_data_chef_automate>` for more details.