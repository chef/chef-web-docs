=====================================================
cookstyle
=====================================================

.. tag ruby_style_patterns

Most of the code that is authored when working with Chef is written as Ruby. Just about every file within a cookbook---with few exceptions!---is a Ruby file.

.. end_tag

cookstyle is a linting tool based on RuboCop designed to address the following issues:

* New releases of RuboCop typically contain new style rules. These often cause projects to fail style checks after the upgrade.
* The default configuration for RuboCop enables many checks that are inappropriate for cookbook development.

cookstyle addresses these issues by:

* Pinning to a specific version of RuboCop.
* Replacing the default RuboCop configuration with one that is more appropriate for cookbook development.

When a new version of RuboCop is released, an automated process disables new style rules in the default configuration.

For more information ...
=====================================================
For more information about cookstyle:

* `GitHub Readme <https://github.com/chef/cookstyle/blob/master/README.md>`_
