.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

To send a ``POST`` request that has a |json| message body and uses basic authentication:

.. code-block:: ruby

   http_request 'posting data' do
     action :post
     url 'http://example.com/check_in'
     message :some => 'data'
     headers({'AUTHORIZATION' => "Basic #{
       Base64.encode64('username:password')
       }"
     })
   end

The message is posted as ``application/data`` and not ``multipart/form-data`` or ``application/x-www-form-urlencoded``.

