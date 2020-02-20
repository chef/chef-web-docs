=======================================================
Deprecation: Easy Install Resource (CHEF-6)
=======================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/deprecations_easy_install.rst>`__

.. meta::
    :robots: noindex

The Python community recommends that users prefer ``pip`` rather than ``easy_install`` to install python packages.

The ``easy_install`` resource was deprecated in Chef Client 12.10, and will be removed in Chef Client 13.

The `Cookstyle <cookstyle.html>`__ cop `ChefDeprecations/EasyInstallResource <https://github.com/chef/cookstyle/blob/master/docs/cops_chefdeprecations.md#chefdeprecationseasyinstallresource>`__ has been introduced to detect this deprecation.

Remediation
===============

There is no built-in replacement for ``easy_install`` in Chef Infra Client at this time.
