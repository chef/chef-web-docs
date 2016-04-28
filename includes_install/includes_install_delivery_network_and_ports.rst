.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


|delivery| has the following network and port requirements:

  .. list-table::
     :widths: 100 250 100 100
     :header-rows: 1

     * - Ports
       - Description
       - Server
       - State
     * - 10000-10003
       - TCP Push Jobs
       - Chef server
       - LISTEN
     * - 8989
       - TCP Delivery Git (SCM)
       - Delivery server
       - LISTEN
     * - 443
       - TCP HTTP Secure
       - Chef server, Delivery server
       - LISTEN
     * - 22
       - TCP SSH
       - All
       - LISTEN
     * - 80
       - TCP HTTP
       - Chef server, Delivery server
       - LISTEN
     * - 5672
       - TCP Analytics MQ
       - n/a
       - n/a
     * - 10012-10013
       - TCP Analytics Messages/Notifier
       - n/a
       - n/a
