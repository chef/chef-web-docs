.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This argument has the following options:

``-C COPYRIGHT_HOLDER``, ``--copyright COPYRIGHT_HOLDER``
   The name of the copyright holder. This option places a copyright notice that contains the name of the copyright holder in each of the pre-created files. If this option is not specified, a copyright name of "COMPANY_NAME" is used instead; it can easily be modified later.

``-I LICENSE``, ``--license LICENSE``
   The type of license under which a cookbook is distributed: ``apachev2``, ``gplv2``, ``gplv3``, ``mit``, or ``none`` (default). This option places the appropriate license notice in the pre-created files: ``Apache v2.0`` (for ``apachev2``), ``GPL v2`` (for ``gplv2``), ``GPL v3`` (for ``gplv3``), ``MIT`` (for ``mit``), or ``license 'Proprietary - All Rights Reserved`` (for ``none``). Be aware of the licenses for files inside of a cookbook and be sure to follow any restrictions they describe.

``-m EMAIL``, ``--email EMAIL``
   The email address for the individual who maintains the cookbook. This option places an email address in each of the pre-created files. If not specified, an email name of "YOUR_EMAIL" is used instead; this can easily be modified later.

``-o PATH``, ``--cookbook-path PATH``
   The directory in which cookbooks are created. This can be a colon-separated path.

``-r FORMAT``, ``--readme-format FORMAT``
   The document format of the readme file: ``md`` (markdown) and ``rdoc`` (Ruby docs).

