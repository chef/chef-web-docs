.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A |rubocop yml| file has the following syntax:

.. code-block:: yaml

   NAME_OF_RULE:
     Description: 'a description of a rule'
     Enabled : (true or false)
     KEY: VALUE

where

* ``NAME_OF_RULE`` is the name of a rule
* ``Description`` is the string that prints as part of the standard output that describes the rule if it is triggered during the evaluation
* ``Enabled`` enables a rule (``true``) or disables a rule (``false``); for non-custom rules, this value will override the settings in the ``enabled.yml`` and ``disabled.yml`` files in |rubocop|
* ``KEY: VALUE`` adds additional details for a rule, if necessary. For example, ``Max: 200`` sets the line length to 200 characters for the ``LineLength`` rule

A typical ``.rubocop.yml`` that is used with |chef| looks like:

.. code-block:: yaml

   AlignParameters:
     Enabled: false
   
   Encoding:
     Enabled: false
   
   LineLength:
     Max: 200
   
   StringLiterals:
     Enabled: false

These settings disable three rules that are enabled in |rubocop| by default: ``AlignParameters``, ``Encoding``, and ``StringLiterals``, and sets the ``LineLength`` for |ruby| files in cookbooks to ``200`` characters, which is set to ``80`` in the default rule.

.. note:: For all of the rules that are available in |rubocop|, see the ``/opt/chefdk/embedded/lib/ruby/gems/<ruby_version#>/gems/rubocop-<version#>/config/`` directory.
