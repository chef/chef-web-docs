.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use the ``inetd_conf`` |inspec resource| to test if a service is enabled in the ``inetd.conf`` file on |linux| and |unix| platforms. |inetd|---the Internet service daemon---listens on dedicated ports, and then loads the appropriate program based on a request. The ``inetd.conf`` file is typically located at ``/etc/inetd.conf`` and contains a list of Internet services associated to the ports on which that service will listen. Only enabled services may handle a request; only services that are required by the system should be enabled.
