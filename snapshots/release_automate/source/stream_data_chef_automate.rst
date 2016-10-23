.. THIS PAGE IS IDENTICAL TO docs.chef.io/stream_data_chef_automate.html BY DESIGN
.. THIS PAGE IS LOCATED AT THE /release/automate/ PATH.

=====================================================
Stream Data from Chef Automate
=====================================================

.. include:: ../../includes_chef_automate/includes_chef_automate_mark.rst 


Chef Automate exposes an endpoint to stream the data that is visualized in the UI. Every event is 
streamed as JSON and can be accessed from a websocket consumer by doing the following:

#. Make sure the visibility capability of Chef Automate has been installed and is running. 
#. Connect a websocket consumer to the fully-qualified domain name of the Chef Automate server on port 3232. 

   .. code-block:: none
   
      ws://10.194.11.67:3232
