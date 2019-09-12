By default, all hashing is done using SHA-1 and encoded in Base64.
Base64 encoding should have line breaks every 60 characters. Each
canonical header should be encoded in the following format:

``` none
Method:HTTP_METHOD
Hashed Path:HASHED_PATH
X-Ops-Content-Hash:HASHED_BODY
X-Ops-Timestamp:TIME
X-Ops-UserId:USERID
```

where:

-   `HTTP_METHOD` is the method used in the API request (`GET`, `POST`,
    and so on)
-   `HASHED_PATH` is the path of the request:
    `/organizations/NAME/name_of_endpoint`. The `HASHED_PATH` must be
    hashed using SHA-1 and encoded using Base64, must not have repeated
    forward slashes (`/`), must not end in a forward slash (unless the
    path is `/`), and must not include a query string.
-   The private key must be an RSA key in the SSL `.pem` file format.
    This signature is then broken into character strings (of not more
    than 60 characters per line) and placed in the header.

The Chef Infra Server decrypts this header and ensures its content
matches the content of the non-encrypted headers that were in the
request. The timestamp of the message is checked to ensure the request
was received within a reasonable amount of time. One approach generating
the signed headers is to use
[mixlib-authentication](https://github.com/chef/mixlib-authentication),
which is a class-based header signing authentication object similar to
the one used by Chef Infra Client.

Enable SHA-256
==============

Chef Server versions 12.4.0 and above support signing protocol version
1.3, which adds support for SHA-256 algorithms. It can be enabled on
Chef Infra Client via the `client.rb` file:

``` ruby
authentication_protocol_version = '1.3'
```

And on Chef knife via `config.rb`:

``` ruby
knife[:authentication_protocol_version] = '1.3'
```