=====================================================
RuboCop
=====================================================

.. tag ruby_style_patterns

Most of the code that is authored when working with Chef is written as Ruby. Just about every file within a cookbook---with few exceptions!---is a Ruby file.

.. end_tag

Use RuboCop to author better Ruby code:

* Enforce style conventions and best practices
* Evaluate the code in a cookbook against metrics like "line length" and "function size"
* Help every member of a team to author similary structured code
* Estabilish uniformity of source code
* Set expectations for fellow (and future) project contributors

RuboCop is a style and linting tool that analyzes all of the Ruby code that is authored in a cookbook against a number of rules. (RuboCop rules are sometimes referred to as "cops".) Each rule examines the code for a specific perspective, after which a list of warnings, deviations from patterns, potential errors, and fatal errors is generated.

RuboCop is built for Ruby developers by Ruby developers. As such, RuboCop will enforce the conventions that are defined by that community. As users of Chef and as authors of cookbooks, even though we are using Ruby, we do not always have the same objectives and goals. That said, there is enough of an overlap that using RuboCop as part of a cookbook authoring workflow is beneficial.

Each rule in RuboCop may be enabled and disabled. Custom rules may be created to assist with enforcing standards that are unique to any cookbook authoring team.

Run RuboCop
=====================================================
RuboCop is run from the command line, typically against a single cookbook and all of the Ruby files contained within it:

.. code-block:: bash

   $ rubocop /path/to/cookbook

RuboCop may also be run from the root of an individual cookbook directory:

.. code-block:: bash

   $ rubocop .

RuboCop returns a list, via standard output, that shows the results of the evaluation:

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
RuboCop output:

* States the number of files found and examined. For example: ``Inspecting 8 files``
* Lists the results of those files as a series of symbols. For example: ``CWCWCCCC``
* For each symbol, states the file name, line number, character number, type of issue or error, describes the issue or error, and specifies the location in the source code at which the issue or error is located

A RuboCop evaluation has the following syntax:

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

.rubocop.yml
=====================================================
Use a .rubocop.yml file in a cookbook to override the default settings in RuboCop for enabled and disabled rules. Only enabled rules---either in the ``enabled.yml`` file in RuboCop itself or rules that are specifically enabled in a cookbook's .rubocop.yml file---will be used during the evaluation. Any rule that becomes unhelpful should be disabled in the .rubocop.yml file.

Each cookbook has its own .rubocop.yml file, which means that each cookbook may have its own set of enabled, disabled, and custom rules. That said, it's more common for all cookbooks to have the same set of enabled, disabled, and custom rules. When RuboCop is run against a cookbook, the full set of enabled and disabled rules (as defined the ``enabled.yml`` and ``disabled.yml`` files in RuboCop itself) are loaded first, and are then compared against the settings in the cookbook's .rubocop.yml file.

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
* ``Enabled`` enables a rule (``true``) or disables a rule (``false``); for non-custom rules, this value will override the settings in the ``enabled.yml`` and ``disabled.yml`` files in RuboCop
* ``KEY: VALUE`` adds additional details for a rule, if necessary. For example, ``Max: 200`` sets the line length to 200 characters for the ``LineLength`` rule

A typical ``.rubocop.yml`` that is used with Chef looks like:

.. code-block:: yaml

   AlignParameters:
     Enabled: false

   Encoding:
     Enabled: false

   LineLength:
     Max: 200

   StringLiterals:
     Enabled: false

These settings disable three rules that are enabled in RuboCop by default: ``AlignParameters``, ``Encoding``, and ``StringLiterals``, and sets the ``LineLength`` for Ruby files in cookbooks to ``200`` characters, which is set to ``80`` in the default rule.

.. note:: For all of the rules that are available in RuboCop, see the ``/opt/chefdk/embedded/lib/ruby/gems/<ruby_version#>/gems/rubocop-<version#>/config/`` directory.

.rubocop_todo.yml
-----------------------------------------------------
Use a .rubocop_todo.yml file to capture the current state of all evaluations, and then write them to a file. This allows evaluations to reviewed one at a time. Disable any evaluations that are unhelpful, and then address the ones that are.

To generate the .rubocop_todo.yml file, run the following command:

.. code-block:: bash

   $ rubocop --auto-gen-config

.. note:: Rename this file to .rubocop.yml to adopt this evaluation state as the standard. Include this file in the .rubocop.yml file by adding ``inherit_from: .rubocop_todo.yml`` to the top of the .rubocop.yml file.

For more information ...
=====================================================
For more information about RuboCop:

* `Rubocop GitHub Repo <https://github.com/bbatsov/rubocop>`_
