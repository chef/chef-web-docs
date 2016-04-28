.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


If |kitchen| fails due to being behind a proxy, update the |kitchen yml| file:

.. code-block:: yaml

   ---
   provisioner:
     name: chef_zero
     solo_rb:
       http_proxy: http://192.168.1.1
       https_proxy: http://192.168.2.2
