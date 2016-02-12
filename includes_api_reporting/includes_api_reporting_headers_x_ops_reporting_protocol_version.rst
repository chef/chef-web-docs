.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use to specify the protocol version for the Reporting API. This header must be set to ``0.1.0``.

* A request to the |api chef server| that does not include this header and the correct value will return a 404 response code.
* A request to the |api chef server| that includes this header with an incorrect value will return a 406 reponse code.

If the protocol version is incorrect (or unspecified), the |chef client| run will proceed normally, but |reporting| data will not be collected for that |chef client| run unless the ``enable_reporting_url_fatals`` setting is ``true`` in the |client rb| file for that node.
