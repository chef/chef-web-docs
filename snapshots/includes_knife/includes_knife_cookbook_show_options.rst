.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This argument has the following options:

``COOKBOOK_VERSION``
   The version of a cookbook to be shown. If a cookbook has only one version, this option does not need to be specified. If a cookbook has more than one version and this option is not specified, a list of cookbook versions is returned.

``-f FQDN``, ``--fqdn FQDN``
   The FQDN of the host.

``FILE_NAME``
   The name of a file that is associated with a cookbook.

``-p PLATFORM``, ``--platform PLATFORM``
   The platform for which a cookbook is designed.

``PART``
   The part of the cookbook to show: ``attributes``, ``definitions``, ``files``, ``libraries``, ``providers``, ``recipes``, ``resources``, or ``templates``. More than one part can be specified.

``-V PLATFORM_VERSION``, ``--platform-version PLATFORM_VERSION``
   The version of the platform.

``-w``, ``--with-uri``
   Show the corresponding URIs.

