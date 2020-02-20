===========================================================
Deprecation: DNF Package allow_downgrade Property (CHEF-10)
===========================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/deprecations_dnf_package_allow_downgrade.rst>`__

.. meta::
    :robots: noindex

The underlying ``dnf`` command in Red Hat based operating systems does not require ``--allow-downgrade`` like the previous ``yum`` command did. This property does not affect the ``dnf_resource`` resource execution and should be removed.

Remediation
===============

Remove the ``allow_downgrade`` property on the ``dnf_package`` resource.
