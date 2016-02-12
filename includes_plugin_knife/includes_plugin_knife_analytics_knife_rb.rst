.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The |knife rb| file may be configured for the URL for |chef analytics|. Add the following setting to the |knife rb| file:

.. code-block:: ruby

   analytics_server_url 'https://ANALYTICS_URL/organizations/ORG_NAME'

For example:

.. code-block:: ruby

   analytics_server_url 'https://ec2-52-27-166-146.us-west-2.compute.amazonaws.com/organizations/learnchef'
