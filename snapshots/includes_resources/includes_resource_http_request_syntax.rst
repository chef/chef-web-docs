.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A **http_request** resource block sends HTTP requests with an arbitrary message. For example, send a ``DELETE`` request to ``'http://www.chef.io/some_page?message=please_delete_me'``.

.. code-block:: ruby

   http_request 'please_delete_me' do
     url 'http://www.chef.io/some_page'
     action :delete
   end

The full syntax for all of the properties that are available to the **http_request** resource is:

.. code-block:: ruby

   http_request 'name' do
     headers                    Hash
     message                    Object # defaults to 'name' if not specified
     notifies                   # see description
     provider                   Chef::Provider::HttpRequest
     subscribes                 # see description
     url                        String
     action                     Symbol # defaults to :get if not specified
   end

where 

* ``http_request`` is the resource
* ``name`` is the name of the resource block
* ``:action`` identifies the steps the chef-client will take to bring the node into the desired state
* ``headers``, ``message``, ``provider``, and ``url`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.
