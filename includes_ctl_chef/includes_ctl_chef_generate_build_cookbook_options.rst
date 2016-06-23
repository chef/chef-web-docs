.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This subcommand has the following options:

``-g GENERATOR_COOKBOOK_PATH``, ``--generator-cookbook GENERATOR_COOKBOOK_PATH``
   |chef generator| Default value: ``lib/chef-dk/skeletons``, under which is the default ``code_generator`` cookbook that is included as part of the |chef dk|.

``-C COPYRIGHT``, ``--copyright COPYRIGHT``
   Specify the copyright holder for copyright notices in generated files. Default value: ``The Authors``

``-m EMAIL``, ``--email EMAIL``
   Specify the email address of the author. Default value: ``you@example.com``.

``-a KEY=VALUE``, ``--generator-arg KEY=VALUE``
   Sets a property named ``KEY`` to the given ``VALUE`` on the generator context object in the generator cookbook. This allows custom generator cookbooks to accept optional user input on the command line.

``-I LICENSE``, ``--license LICENSE``
   Sets the license. Valid values are ``all_rights``, ``apache2``, ``mit``, ``gplv2``, or ``gplv3``. Default value: ``all_rights``.

``-h``, ``--help``
   |help subcommand|

``-v``, ``--version``
   |version chef|

