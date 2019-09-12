To send a `POST` request as JSON data, convert the message to JSON and
include the correct content-type header. For example:

``` ruby
http_request 'posting data' do
  action :post
  url 'http://example.com/check_in'
  message ({:some => 'data'}.to_json)
  headers({'AUTHORIZATION' => "Basic #{
    Base64.encode64('username:password')}",
    'Content-Type' => 'application/data'
  })
end
```