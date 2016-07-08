=====================================================
Stream Data from |automate|
=====================================================

.. include:: ../../includes_chef_automate/includes_chef_automate_mark.rst 


Chef Automate exposes an endpoint to stream the data that is visualized in the UI. Every event is 
streamed as JSON and can be accessed from a websocket consumer by doing the following:

#. Make sure the visibility capability of |automate| has been installed and is running. 
#. Connect a websocket consumer to the fully-qualified domain name of the |automate| server on port 3232. 

   .. code-block:: none
   
      ws://10.194.11.67:3232
