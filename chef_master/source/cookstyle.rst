=====================================================
|cookstyle|
=====================================================

.. include:: ../../includes_ruby/includes_ruby_style_patterns.rst

|cookstyle| is a linting tool based on |rubocop| designed to address the following issues:

* New releases of |rubocop| typically contain new style rules. These often cause projects to fail style checks after the upgrade.
* The default configuration for |rubocop| enables many checks that are inappropriate for cookbook development.

|cookstyle| addresses these issues by:

* Pinning to a specific version of |rubocop|.
* Replacing the default |rubocop| configuration with one that is more appropriate for cookbook development.

When a new version of |rubocop| is released, an automated process disables new style rules in the default configuration.

For more information ...
=====================================================
For more information about |cookstyle|:

* `GitHub Readme <https://github.com/chef/cookstyle/blob/master/README.md>`_
