.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Fieri is an optional service what will check cookbook versions for certain metrics.  This helps to determine the quality of the cookbook.

As of Supermarket 2.7 Fieri now lives within the Supermarket code base.

If you are using a private |supermarket|, you can activate the Fieri service like this:

First, add Fieri to your features attribute:

.. code-block:: ruby

   ['supermarket_omnibus']['config']['features'] = "tools,github,announcement,fieri"

Then add the following Fieri attributes

.. code-block:: ruby

  ['supermarket_omnibus']['config']['fieri_key'] = "#{random string you generate}"
  ['supermarket_omnibus']['config']['fieri_supermarket_endpoint'] = "#{your_supermarket_url}"
  ['supermarket_omnibus']['config']['fieri_results_endpoint'] = "#{your_supermarket_url}/api/v1/cookbook-versions/evaluation

Then reconfigure your Supermarket

.. code-block:: bash

(your-supermarket-node) $ sudo supermarket-ctl reconfigure


.. code-block:: bash
(your-supermarket-node) $ sudo supermarket-ctl restart

After this, you should see a "Quality" tab when viewing a cookbook through the Supermarket GUI.  Click on this tab and you will see the results of the metrics run by Fieri.
