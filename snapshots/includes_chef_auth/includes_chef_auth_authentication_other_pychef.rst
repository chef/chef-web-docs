.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


An API request can be made using PyChef, which is a Python library that meets the ``Mixlib::Authentication`` requirements so that it can easily interact with the Chef server. The following example shows how an authenticated request can be made using the Chef server API and PyChef:

.. code-block:: python

   from chef import autoconfigure, Node
   
   api = autoconfigure()
   n = Node('web1')
   print n['fqdn']
   n['myapp']['version'] = '1.0'
   n.save()

and the following example shows how to make API calls directly:

.. code-block:: python

   from chef import autoconfigure
    
   api = autoconfigure()
   print api.api_request('GET', '/clients')

The previous examples assume that the current working directory is such that PyChef can find a valid configuration file in the same manner as the chef-client or knife. For more about PyChef, see: https://github.com/coderanger/pychef.
