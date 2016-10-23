.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Reporting has the following minimum requirements:

* Chef server 12
* chef-client version 11.6.0 (or later)

Reporting can make use of an external database, but to do so Reporting 1.5.5 or later is needed along with Chef server 12.2.0 or later.

The Reporting client is built into the chef-client and can run on all platforms that chef-client is supported on.

.. warning:: Reporting does not work on chef-client version 11.8.0; upgrade to chef-client version 11.8.2 (or later) if Reporting is being run in your organization.

.. warning:: The only supported versions of Reporting are 1.5.5 or later.
