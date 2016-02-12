.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

|nginx| is an important entry point for data on the |chef server|, which means that debugging efforts frequently start with analyzing the |service nginx| service's ``access.log`` file. This log contains every HTTP request made to the front-end machine and can be very useful when investigating request rates and usage patterns. The following is an example log entry:

.. code-block:: ruby

   175.185.9.6 - - [12/Jul/2013:15:56:54 +0000] "GET 
   /organizations/exampleorg/data/firewall/nova_api HTTP/1.1" 200 
   "0.850" 452 "-" "Chef Client/0.10.2 (ruby-1.8.7-p302; ohai-0.6.4; 
   x86_64-linux; +http://opscode.com)" "127.0.0.1:9460" "200" 
   "0.849" "0.10.2" "version=1.0" "some_node.example.com" 
   "2013-07-12T15:56:40Z" "2jmj7l5rSw0yVb/vlWAYkK/YBwk=" 985

where important fields in this log include:

* The HTTP status code (``200``)
* The IP address of the requesting client (``175.185.9.6``)
* The timestamp (``[12/Jul/2013:15:56:54 +0000]``)
* The total request time (``"0.850"``)
* The request method (``GET``)
* The request URL (``/organizations/exampleorg/data/firewall/nova_api``)