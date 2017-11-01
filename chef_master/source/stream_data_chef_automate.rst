=====================================================
Stream Data from Chef Automate
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/stream_data_chef_automate.rst>`__

.. tag chef_automate_mark

.. image:: ../../images/chef_automate_full.png
   :width: 40px
   :height: 17px

.. end_tag

Chef Automate exposes an endpoint to stream the data that is visualized in the UI. Every event is
streamed as JSON and can be accessed from a websocket consumer by doing the following:

#. Make sure the visibility capability of Chef Automate has been installed and is running.
#. Connect a websocket consumer to the fully-qualified domain name of the Chef Automate server on port 3232.

   .. code-block:: none

      ws://10.194.11.67:3232
