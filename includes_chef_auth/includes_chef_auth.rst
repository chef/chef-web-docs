.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


All communication with the |chef server| must be authenticated using the |api chef server|, which is a REST API that allows requests to made to the |chef server|. Only authenticated requests will be authorized. Most of the time, and especially when using |knife|, the |chef client|, or the |chef server| web interface, the use of the |api chef server| is transparent. In some cases, the use of the |api chef server| requires more detail, such as when making the request in |ruby| code, with a |knife| plugin, or when using |curl|.