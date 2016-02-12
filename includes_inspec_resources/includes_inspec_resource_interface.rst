.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use the ``interface`` |inspec resource| to test basic network adapter properties, such as name, status, state, address, and link speed (in MB/sec).

* On |linux| platforms, ``/sys/class/net/#{iface}`` is used as source
* On the |windows| platform, the ``Get-NetAdapter`` cmdlet is used as source
