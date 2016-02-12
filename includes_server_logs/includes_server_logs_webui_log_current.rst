.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The |service webui| service's ``current.log`` file contains a history of all requests that were made to the |chef server| web user interface. Errors that may be found in this log are typically the cause of failed HTTP requests that were made to another service. The following is an example log entry for a successful request:

.. code-block:: ruby

   2013-08-06_16:03:53.50265  Started GET "/nodes" for 172.28.0.148 at 2013-08-06 16:03:53 +0000
   2013-08-06_16:03:53.50462  Processing by NodesController#index as HTML
   2013-08-06_16:03:54.29635  Rendered nodes/_navigation.html.haml (11.5ms)
   2013-08-06_16:03:54.29741  Rendered nodes/index.html.haml within layouts/application (36.5ms)
   2013-08-06_16:03:54.31334  Completed 200 OK in 808ms (Views: 59.0ms)
   2013-08-06_16:03:54.31447  cache: [GET /nodes] miss

A failed request, on the other hand produces a large amount of output. The following is a partial example log entry for a failed request:

.. code-block:: ruby

   2013-08-06_16:05:15.45445  Started GET "/clients" for 172.28.0.148 at 2013-08-06 16:05:15 +0000
   2013-08-06_16:05:15.54797  Processing by ClientsController#index as HTML
   2013-08-06_16:05:15.76841  [Tue, 06 Aug 2013 16:05:15 +0000] ERROR: Server returned error for http://1
   2013-08-06_16:05:19.77373  [Tue, 06 Aug 2013 16:05:19 +0000] ERROR: Server returned error for http://1
   2013-08-06_16:05:26.77612  [Tue, 06 Aug 2013 16:05:26 +0000] ERROR: Server returned error for http://1
   2013-08-06_16:05:37.77876  [Tue, 06 Aug 2013 16:05:37 +0000] ERROR: Server returned error for http://1
   2013-08-06_16:05:57.78131  [Tue, 06 Aug 2013 16:05:57 +0000] ERROR: Server returned error for http://1
   
   [..SNIP..] 
   
   2013-08-06_16:06:51.32997  A Net::HTTPFatalError occurred in clients#index:
   2013-08-06_16:06:51.32997  
   2013-08-06_16:06:51.32997    502 "Bad Gateway"
   2013-08-06_16:06:51.32997    /opt/opscode/embedded/lib/ruby/1.9.1/net/http.rb:2632:in 'error!'
   2013-08-06_16:06:51.32998  
   2013-08-06_16:06:51.32998  -------------------------------
   2013-08-06_16:06:51.32998  Request:
   2013-08-06_16:06:51.32998  -------------------------------
   2013-08-06_16:06:51.32999 
   2013-08-06_16:06:51.32999    * URL	: https://172.31.6.215/clients
   2013-08-06_16:06:51.32999    * IP address: 127.0.0.1 
   2013-08-06_16:06:51.32999    * Parameters: {"action"=>"index", "controller"=>"clients"}
   2013-08-06_16:06:51.33000    * Rails root: /opt/opscode/embedded/service/opscode-webui
   2013-08-06_16:06:51.33000 
   2013-08-06_16:06:51.33000  -------------------------------
   2013-08-06_16:06:51.33000  Session:
   2013-08-06_16:06:51.33001  -------------------------------

