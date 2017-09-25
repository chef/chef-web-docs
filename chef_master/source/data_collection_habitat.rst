Data Collection with Habitat
=====================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/data_collection_habitat.rst>`__


The data collection capabilities of Chef Automate can also be used to collect and report on Habitat ring data. The Prism Habitat package collects this data and sends it to a Chef Automate server's REST API endpoint. You can configure settings like the data collector URL, token, the Habitat supervisor used to get the ring information, and so on. For more information on the Prism package, see :doc:`Habitat Prism </habitat_prism>`. For more information on Habitat, see the `Habitat site <https://habitat.sh/>`__.


Use an external Elasticsearch cluster (optional)
=====================================================

Chef Automate uses Elasticsearch to store its data, and the default Chef Automate install includes a single Elasticsearch service.
This is sufficient to run production workloads; however, for greater data retention, we recommend using a multi-node Elasticsearch cluster with replication and sharding to store and protect your data.

Prerequisites
-----------------------------------------------------

* Chef Automate server
* Elasticsearch (version 2.4.1 or greater; version 5.x is required for Chef Automate 1.6 and above)

Elasticsearch configuration
-----------------------------------------------------

To utilize an external Elasticsearch installation, set the following configuration option in your
``/etc/delivery/delivery.rb``:

.. code-block:: ruby

   elasticsearch['urls'] = ['https://my-elaticsearch-cluster.mycompany.com']

Or for a three node on premise install

.. code-block:: ruby

   elasticserach['urls'] = ['http://172.16.0.100:9200', 'http://172.16.0.101:9200', 'http://172.16.0.100:9202']

The ``elasticsearch['urls']`` attribute should be an array of Elasticsearch nodes over
which Chef Automate will round-robin requests. You can also supply a single entry which corresponds to
a load-balancer or a third-party Elasticsearch-as-a-service offering.

After saving the file, run ``sudo automate-ctl reconfigure``.

An additional Elasticsearch-related configuration properties is ``elasticsearch['host_header']``. This is the HTTP ``Host`` header to send with the request.
When this attribute is unspecified, the default behavior is as follows:

  * If the ``urls`` parameter contains a single entry, the host of the supplied URI will be sent as the Host header.
  * If the ``urls`` parameter contains more than one entry, no Host header will be  sent.

When this attribute *is* specified, the supplied string will be sent as the ``Host`` header on all requests. This may be required for some third-party Elasticsearch offerings.
