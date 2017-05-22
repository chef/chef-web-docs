=====================================================
Authentication for Elasticsearch and Kibana
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/elasticsearch_and_kibana_auth.rst>`__

.. tag chef_automate_mark

.. image:: ../../images/chef_automate_full.png
   :width: 40px
   :height: 17px

.. end_tag

Visibility data in Chef Automate is stored in `Elasticsearch <https://www.elastic.co/products/elasticsearch>`__ and viewable in the Visibility UI as well as `Kibana <https://www.elastic.co/products/kibana>`__. Access to Chef Automate's Elasticsearch and Kibana is protected by the same authentication used by the Chef Automate user interface. Elasticsearch and Kibana authentication is enabled by default.


How It Works
============

* User logs into the Chef Automate UI normally.
* Chef Automate stores information about the user's session in browser local storage as well as a browser cookie.
* If authentication is enabled for Elasticsearch or Kibana, Chef Automate's web server will look for the session cookie and validate the session is valid and active.
   * If the session is valid and active, the request is permitted.
   * If the session is invalid, or if no session information is present, the server returns a ``401 Unauthorized`` message.


Accessing Elasticsearch with Authentication - Visibility UI
===========================================================

The Visibility UI performs a number of queries to Elasticsearch in order to present the Visibility data. The Chef Automate server will validate each of the Elasticsearch requests with the session cookie information as described in the **How It Works** section above.


Accessing Elasticsearch with Authentication - API/CLI
=====================================================

If you wish to access Elasticsearch via your Chef Automate server via a CLI tool (such as ``curl``) or an API client (such as `elasticsearch-ruby <https://github.com/elastic/elasticsearch-ruby>`__), you must pass three additional HTTP headers in your requests for your request to be properly authenticated:

* ``chef-delivery-user``: the Chef Automate username for whom a token has been generated
* ``chef-delivery-token``: a valid token generated for the user
* ``chef-delivery-enterprise``: the Chef Automate enterprise name. This is the string after the ``/e/`` in your Chef Automate URLs.
    * Example: if your Workflow dashboard URL is ``https://my-automate-server.mycompany.biz/e/coolcompany/#/dashboard``, your enterprise is ``coolcompany``

To generate a token, use the ``delivery token`` command of the :doc:`Delivery CLI </delivery_cli>`.

For example, to pass the required headers using curl:

.. code-block:: bash

   curl https://my-automate-server.mycompany.biz/elasticsearch/_cat/indices -H "chef-delivery-user: myuser" -H "chef-delivery-enterprise: coolcompany" -H "chef-delivery-token: s00pers33krett0ken"


Accessing Kibana with Authentication
====================================

Your browser must have a valid cookie containing a valid token before access to Kibana will be permitted. If you encounter a "401 Unauthorized" error message, follow these steps:

* Log into the Chef Automate UI normally.
* Change your browser URI to ``/kibana``.
   * Example: ``https://my-automate-server.mycompany.biz/kibana``


Configuration
=============

.. warning:: It is strongly recommended that authentication to Elasticsearch and Kibana remain enabled at all times. Without authentication, any user with network access to your Automate server will be able to view any available Visibility data.

If you wish to disable authentication for either Kibana or Elasticsearch, you may use the following configuration parameters in your ``/etc/delivery/delivery.rb`` configuration file:

* ``elasticsearch['enable_auth']``: If ``true``, a valid user/enterprise/token must be supplied in a cookie or in HTTP headers for the request to be accepted and passed to Elasticsearch. If ``false``, all Elasticsearch queries are permitted without authentication. Default: ``true``
* ``kibana['enable_auth']``: If ``true``, a valid user/enterprise/token must be supplied in a cookie or in HTTP headers for access to be granted to the Kibana UI. If ``false``, all Kibana access is permitted without authentication. Default: ``true``
