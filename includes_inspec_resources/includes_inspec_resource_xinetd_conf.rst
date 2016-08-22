.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use the ``xinetd_conf`` |inspec resource| to test if a service is listed in the ``xinetd.conf`` file on |linux| and |unix| platforms. |xinetd|---the extended Internet service daemon---listens on all ports, and then loads the appropriate program based on a request. The ``xinetd.conf`` file is typically located at ``/etc/xinetd.conf`` and contains a list of Internet services associated to the ports on which that service will listen. Only enabled services may handle a request; only services that are required by the system should be enabled.
