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

After saving the file, run ``delivery-ctl reconfigure``.

An additional Elasticsearch-related configuration properties is ``elasticsearch['host_header']``. This is the 
HTTP ``Host`` header to send with the request. When this attribute is unspecified, the default behavior is as follows:

  * If the ``urls`` parameter contains a single entry, the host of the supplied URI will be sent as the Host header.
  * If the ``urls`` parameter contains more than one entry, no Host header will be  sent.

When this attribute *is* specified, the supplied string will be sent as the ``Host`` header on all requests. This may be required for some third-party Elasticsearch offerings.

Adding Chef Automate certificate to `trusted_certs` directory
================================================================

The visibilty features of |automate| require that the |automate| SSL certificate is located in the |path trusted_certs| directory 
on any node that wants to send data to |auatomate|. This directory is the location into which |ssl| certificates are 
placed when a node has been bootstrapped with |chef client|. To place the |automate| certificate on a node in the cluster, use 
utilities such as `scp` or `rsync` to perform the copy operation.


Setting up visibility with previous Chef Delivery installation
================================================================

.. note:: Visibility is automatically installed as part of the Chef Automate installation. The following instructions **only** apply to customers who have previously installed Chef Delivery as a stand alone implementation. If you are using visibility in |automate|, you can skip this section.

To get started with the visibility capabilities in |automate|, modify ``/etc/delivery/delivery.rb``
on your Chef Delivery server and add the following settings:

.. code-block:: ruby

    insights['enable'] = true
    data_collector['token'] = 'TOKEN'

The ``TOKEN`` is a shared secret that Chef Automate's data collector will use to authenticate POST
requests made to the data collector endpoint. If unspecified, the default value for the token is
``'93a49a4f2482c64126f7b6015e6b0f30284287ee4054ff8807fb63d9cbd1c506'``.

Save your changes and then run ``delivery-ctl reconfigure`` to complete the setup process.
