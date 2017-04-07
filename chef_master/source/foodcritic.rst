=====================================================
About Foodcritic
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/foodcritic.rst>`__

Changed in Chef DK 1.3: false positives in FC007 and FC016 have been resolved; new rules have been added requiring the license (FC068), supports (FC067), and chef_version (FC066) metadata properties in cookbooks. Removed in Chef DK 1.3: FC003, which required gating certain code when running on Chef Solo has been removed; FC023, which preferred conditional (only_if / not_if) code within resources has been removed.

Use Foodcritic to check cookbooks for common problems:

* Style
* Correctness
* Syntax
* Best practices
* Common mistakes
* Deprecations

Foodcritic looks for lint-like behavior and reports it!

Foodcritic is a static linting tool that analyzes all of the Ruby code that is authored in a cookbook against a number of rules, and then returns a list of violations. Because Foodcritic is a static linting tool, using it is fast. The code in a cookbook is read, broken down, and then compared to Foodcritic rules. The code is **not** run (a chef-client run does not occur). Foodcritic does not validate the intention of a recipe, rather it evaluates the structure of the code, and helps enforce specific behavior, detect portability of recipes, identify potential run-time failures, and spot common anti-patterns.

When Foodcritic returns a violation, this does not automatically mean the code needs to be changed. It is important to first understand the intention of the rule before making the changes it suggests. For example, rule ``FC003`` describes a scenario where a recipe uses the ``search`` method in the Recipe DSL to retrieve data from the Chef server. Rule ``FC003`` may suggest that a cookbook will raise an error if that cookbook is run in a situation where a Chef server is not present. Adopting this rule is only necessary when chef-solo is part of the team's workflow (because chef-solo does not use a Chef server).

Run Foodcritic
=====================================================
Foodcritic is run from the command line, typically against a single cookbook and all of the Ruby files contained within it:

.. code-block:: bash

   $ foodcritic /path/to/cookbook

Foodcritic may also be run from the root of an individual cookbook directory:

.. code-block:: bash

   $ foodcritic .

Foodcritic returns a list, via standard output, that shows the results of the evaluation:

.. code-block:: bash

   FC003: Check whether you are running with chef server before using server-specific features: ./recipes/ip-logger.rb:1
   FC008: Generated cookbook metadata needs updating: ./metadata.rb:2
   FC008: Generated cookbook metadata needs updating: ./metadata.rb:3

Output
-----------------------------------------------------
Foodcritic output:

* States a Foodcritic rule. For example: ``FC003``
* Describes the rule, based on the results of the evaluation. For example: ``Check whether you are running with chef server before using server-specific features``
* Specifies the file path. For example: ``./recipes/ip-logger.rb``
* Specifes the line number. For example: ``1``

A Foodcritic evaluation has the following syntax:

.. code-block:: bash

   RULENUMBER: MESSAGE: FILEPATH:LINENUMBER

For example:

.. code-block:: bash

   FC008: Generated cookbook metadata needs updating: ./metadata.rb:3

Rules
=====================================================
A complete list of Foodcritic rules are available on the `Foodcritic website <http://foodcritic.io>`__.

Custom Rules
-----------------------------------------------------
The following rules for Foodcritic have been developed by the Chef community:

* `/customink-webops/foodcritic-rules <https://github.com/customink-webops/foodcritic-rules>`_
* `/etsy/foodcritic-rules <https://github.com/etsy/foodcritic-rules>`_

Exclude Rules
-----------------------------------------------------
Run the following command to exclude a Foodcritic rule:

.. code-block:: bash

   $ foodcritic . --tags ~RULE

For example, to exclude rule ``FC003``:

.. code-block:: bash

   $ foodcritic . --tags ~FC003

Foodcritic CLI
=====================================================
The ``foodcritic`` command is used to run Foodcritic against one (or more) cookbooks.

This command has the following syntax:

.. code-block:: bash

   $ foodcritic COOKBOOK_PATH

This command has the following options:

``-C``, ``--[no-]context``
   Use to show lines matched against Foodcritic rules, rather than the default summary.

``-f TAGS``, ``--epic-fail TAGS``
   Use to trigger a build failure if any of the specified tags are matched.

``-I PATH``, ``--include PATH``
   Use to specify the path to a file that contains additional Foodcritic rules.

``-r``, ``--[no-]repl``
   Use to drop into a REPL for interactive rule editing.

``-S PATH``, ``--search-grammar PATH``
   Use to specify the path to a file that contains additional grammar used when validating search syntax.

``-t TAGS``, ``--tags TAGS``
   Use to only the specified tags when checking against Foodcritic rules.

``-V``, ``--version``
   Use to display the version of Foodcritic.

For more information ...
=====================================================
For more information about Foodcritic:

* `http://www.foodcritic.io/ <http://www.foodcritic.io/>`_
