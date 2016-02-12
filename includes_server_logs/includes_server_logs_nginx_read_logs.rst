.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The |service nginx| access log format is as follows:

.. code-block:: bash

   log_format opscode '$remote_addr - $remote_user [$time_local]  '
     '"$request" $status "$request_time" $body_bytes_sent '
     '"$http_referrer" "$http_user_agent" "$upstream_addr" '
     '"$upstream_status" "$upstream_response_time" "$http_x_chef_version" '
     '"$http_x_ops_sign" "$http_x_ops_userid" "$http_x_ops_timestamp" '
      '"$http_x_ops_content_hash" $request_length';

A sample log line:

.. code-block:: bash

   192.168.4.1 - - [17/Feb/2012:16:02:42 -0800]  
     "GET /organizations/nginx/cookbooks HTTP/1.1" 200 
     "0.346" 12 "-" 
     "Chef Knife/0.10.4 (ruby-1.9.3-p0; 
                         ohai-0.6.10; 
                         x86_64-darwin11.2.0; 
                         +http://opscode.com
                         )" 
     "127.0.0.1:9460" "200" "0.339" "0.10.4" 
     "version=1.0" "adam" "2012-02-18T00:02:42Z" 
     "2jmj7l5rSw0yVb/vlWAYkK/YBwk=" 871

Field descriptions:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Field
     - Description
   * - ``$remote_addr``
     - The IP address of the client who made this request.
   * - ``$remote_user``
     - The HTTP basic auth user name of this request.
   * - ``$time_local``
     - The local time of the request.
   * - ``$request``
     - The HTTP request.
   * - ``$status``
     - The HTTP status code.
   * - ``$request_time``
     - The time it took to service the request.
   * - ``$body_bytes_sent``
     - The number of bytes in the HTTP response body.
   * - ``$http_referrer``
     - The HTTP referrer.
   * - ``$http_user_agent``
     - The user agent of the requesting client.
   * - ``$upstream_addr``
     - The upstream reverse proxy used to service this request.
   * - ``$upstream_status``
     - The upstream reverse proxy response status code.
   * - ``$upstream_response_time``
     - The upstream reverse proxy response time.
   * - ``$http_x_chef_version``
     - The version of |chef| used to make this request.
   * - ``$http_x_ops_sign``
     - The version of the authentication protocol.
   * - ``$http_x_ops_userid``
     - The client name that was used to sign this request.
   * - ``$http_x_ops_timestamp``
     - The timestamp from when this request was signed.
   * - ``$http_x_ops_content_hash``
     - The hash of the contents of this request.
   * - ``$request_length``
     - The length of this request.
