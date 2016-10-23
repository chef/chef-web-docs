.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


All communication with the Chef server must be authenticated using the Chef server API, which is a REST API that allows requests to be made to the Chef server. Only authenticated requests will be authorized. Most of the time, and especially when using knife, the chef-client, or the Chef server web interface, the use of the Chef server API is transparent. In some cases, the use of the Chef server API requires more detail, such as when making the request in Ruby code, with a knife plugin, or when using cURL.
