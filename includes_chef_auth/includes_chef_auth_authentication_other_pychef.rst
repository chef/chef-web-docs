.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


An API request can be made using |pychef|, which is a |python| library that meets the ``Mixlib::Authentication`` requirements so that it can easily interact with the |chef server|. The following example shows how an authenticated request can be made using the |api chef server| and |pychef|:

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

The previous examples assume that the current working directory is such that |pychef| can find a valid configuration file in the same manner as the |chef client| or |knife|. For more about |pychef|, see: https://github.com/coderanger/pychef.