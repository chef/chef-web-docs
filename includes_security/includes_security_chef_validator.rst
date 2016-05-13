.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Every request made by the |chef client| to the |chef server| must be an authenticated request using the |api chef server| and a private key. When the |chef client| makes a request to the |chef server|, the |chef client| authenticates each request using a private key located in ``/etc/chef/client.pem``. 
