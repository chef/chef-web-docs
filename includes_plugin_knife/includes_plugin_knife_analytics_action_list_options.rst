.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This argument has the following options:

``--analytics-server-url HOST``
   The URL of the server on which |chef analytics| is running, including the organization name. For example: ``https://analytics.chef.io/org-name``.

``-b TIME``, ``--before TIME``
   The time before which data is returned.

``--identity-server-url HOST``
   The URL of the server on which the |service ocid| service is running. The |service ocid| service is used by |chef analytics| when communicating with the |chef server|.

``-p N``, ``--page N``
   The number of pages to be returned. Default value: ``1``.

``-s TIME``, ``--since TIME``
   The time after which data is returned.
