=====================================================
Cookstyle
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/cookstyle.rst>`__

.. tag ruby_style_patterns

Most of the code that is authored when working with Chef is written as Ruby. Just about every file within a cookbook---with few exceptions!---is a Ruby file.

.. end_tag

Cookstyle is a linting tool based on the RuboCop Ruby linting tool. Cookstyle helps you author better cookbook code in the following ways:

* Enforcing style conventions and best practices
* Evaluating the code in a cookbook against metrics like "line length" and "function size"
* Helping every member of a team to author similary structured code
* Estabilishing uniformity of source code
* Setting expectations for fellow (and future) project contributors

Cookstyle vs. Rubocop
=====================================================

Cookstyle resolves many issues when using Rubocop for linting of Chef cookbook code:

* New releases of RuboCop typically contain new style rules. If the latest Rubocop release is used cookbook tests often fail due to the new rules
* The default configuration for RuboCop enables many checks that are inappropriate for cookbook development, which requires users to maintain a large list of disabled cops.

Cookstyle addresses these issues by:

* Pinning to a specific version of RuboCop.
* Replacing the default RuboCop configuration with one that is more appropriate for cookbook development.

When a new version of RuboCop is released, an automated process disables new style rules in the default configuration.

Run Cookstyle
=====================================================
Cookstyle is run from the command line, typically against a single cookbook and all of the Ruby files contained within it:

.. code-block:: bash

   $ cookstyle /path/to/cookbook

Cookstyle may also be run from the root of an individual cookbook directory:

.. code-block:: bash

   $ cookstyle .

Cookstyle returns a list, via standard output, that shows the results of the evaluation:

.. code-block:: bash

   Inspecting 8 files
   CWCWCCCC

   Offences:

   cookbooks/apache/attributes/default.rb:1:1: C: Missing utf-8 encoding comment.
   default["apache"]["indexfile"] = "index1.html"
   ^
   cookbooks/apache/attributes/default.rb:1:9: C: Prefer single-quoted strings when you don't
   need string interpolation or special symbols.
   default["apache"]["indexfile"] = "index1.html"
           ^^^^^^^^
   cookbooks/apache/attributes/default.rb:1:19: C: Prefer single-quoted strings when you
   don't need string interpolation or special symbols.
   default["apache"]["indexfile"] = "index1.html"
                     ^^^^^^^^^^^

Output
-----------------------------------------------------
Cookstyle output:

* States the number of files found and examined. For example: ``Inspecting 8 files``
* Lists the results of those files as a series of symbols. For example: ``CWCWCCCC``
* For each symbol, states the file name, line number, character number, type of issue or error, describes the issue or error, and specifies the location in the source code at which the issue or error is located

A Cookstyle evaluation has the following syntax:

.. code-block:: none

   FILENAME:LINE_NUMBER:CHARACTER_NUMBER: TYPE_OF_ERROR: MESSAGE
   SOURCE CODE
   ^^^^^^^^^^^

For example:

.. code-block:: none

   cookbooks/apache/attributes/default.rb:1:9: C: Prefer single-quoted strings when you don't
   need string interpolation or special symbols.
   default["apache"]["indexfile"] = "index1.html"
           ^^^^^^^^

Symbols
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following symbols appear in the standard output and are used to indicate the result of an evaluation:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Symbol
     - Description
   * - ``.``
     - The file does not have any issues.
   * - ``C``
     - The file has an issue with convention.
   * - ``E``
     - The file contains an error.
   * - ``F``
     - The file contains a fatal error.
   * - ``W``
     - The file contains a warning.

Autocorrecting Cookstyle Warnings
=====================================================

Many of the Cookstyle Cops include the ability to autocorrect violations. To autocorrect code run the following from the cookbook directory:

.. code-block:: bash

   $ cookstyle -a .


Take particular care after running this command to make sure that the autocorrection logic resulted in appropriate cookbook code.

.rubocop.yml
=====================================================
Use a .rubocop.yml file in a cookbook to override the default settings in Cookstyle for enabled and disabled rules. Only enabled rules---either in the ``enabled.yml`` file in Cookstyle itself or rules that are specifically enabled in a cookbook's .rubocop.yml file---will be used during the evaluation. Any rule that becomes unhelpful should be disabled in the .rubocop.yml file.

Each cookbook has its own .rubocop.yml file, which means that each cookbook may have its own set of enabled, disabled, and custom rules. That said, it's more common for all cookbooks to have the same set of enabled, disabled, and custom rules. When RuboCop is run against a cookbook, the full set of enabled and disabled rules (as defined the ``enabled.yml`` and ``disabled.yml`` files in Cookstyle itself) are loaded first, and are then compared against the settings in the cookbook's .rubocop.yml file.

Custom rules should be specified in the .rubocop.yml file. The state of rules---enabled or disabled---in a .rubocop.yml file take precedence over the state of rules defined in the ``enabled.yml`` and ``disabled.yml`` files.

Syntax
-----------------------------------------------------
A .rubocop.yml file has the following syntax:

.. code-block:: yaml

   NAME_OF_RULE:
     Description: 'a description of a rule'
     Enabled : (true or false)
     KEY: VALUE

where

* ``NAME_OF_RULE`` is the name of a rule
* ``Description`` is the string that prints as part of the standard output that describes the rule if it is triggered during the evaluation
* ``Enabled`` enables a rule (``true``) or disables a rule (``false``); for non-custom rules, this value will override the settings in the ``enabled.yml`` and ``disabled.yml`` files in Cookstyle
* ``KEY: VALUE`` adds additional details for a rule, if necessary. For example, ``Max: 200`` sets the line length to 200 characters for the ``LineLength`` rule

.rubocop_todo.yml
-----------------------------------------------------
Use a .rubocop_todo.yml file to capture the current state of all evaluations, and then write them to a file. This allows evaluations to reviewed one at a time. Disable any evaluations that are unhelpful, and then address the ones that are.

To generate the .rubocop_todo.yml file, run the following command:

.. code-block:: bash

   $ cookstyle --auto-gen-config

.. note:: Rename this file to .rubocop.yml to adopt this evaluation state as the standard. Include this file in the .rubocop.yml file by adding ``inherit_from: .rubocop_todo.yml`` to the top of the .rubocop.yml file.

For more information ...
=====================================================
For more information about cookstyle:

* `GitHub Readme <https://github.com/chef/cookstyle/blob/master/README.md>`_
