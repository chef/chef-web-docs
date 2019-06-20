=====================================================
Stream Data from Chef Automate
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/stream_data_chef_automate.rst>`__

.. tag chef_automate_mark

.. image:: ../../images/a2_docs_banner.svg
   :target: https://automate.chef.io/docs

.. end_tag


.. tag EOL_a1

.. danger:: This documentation applies to a deprecated version of Chef Automate and will reach its `End-Of-Life on December 31, 2019 </https://docs.chef.io/versions.html#deprecated-products-and-versions>`__. See the `Chef Automate site <https://automate.chef.io/docs/quickstart/>`__ for current documentation. The new Chef Automate includes newer out-of-the-box compliance profiles, an improved compliance scanner with total cloud scanning functionality, better visualizations, role-based access control and many other features. The new Chef Automate is included as part of the Chef Automate license agreement and is `available via subscription <https://www.chef.io/pricing/>`_.

.. end_tag

Chef Automate exposes an endpoint to stream the data that is visualized in the UI. Every event is
streamed as JSON and can be accessed from a websocket consumer by doing the following:

#. Make sure the node visibility capability of Chef Automate has been installed and is running.
#. Connect a websocket consumer to the fully-qualified domain name of the Chef Automate server on port 3232.

   .. code-block:: none

      ws://10.194.11.67:3232
