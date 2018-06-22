===========================================================
Deprecation: Deprecation of old shell_out APIs (CHEF-26)
===========================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/deprecations_shell_out.rst>`__

.. tag deprecations_shell_out

The functionality of mutiple old `shell_out` APIs has been collapsed into the `shell_out` API itself, and the old methods
have been deprecated.

.. end_tag

The `shell_out_compact` API has been migrated into `shell_out`, so those methods can be renamed.  The functionality of
`shell_out_compact_timeout` and `shell_out_with_timeout` have been migrated into `shell_out` for internal resources, and will
be migrated into custom resources and LWRPs in Chef-15, in the meantime consumers should use shell_out with a
`timeout: new_resource.timeout` option.  The functionality of `shell_out_with_systems_locale` has been replaced by the
`default_env: false` flag.

The "banged" versions of those APIs (e.g. `shell_out_compact!`) changes identically to use `shell_out!`.


Example
=====================================================

The following code examples need to be changed to the corresponding code below:

.. code-block:: ruby

  shell_out_compact("rpm", "-qa")
  shell_out_compact_timeout("rpm", "-qa")
  shell_out_with_timeout("rpm", "-qa")
  shell_out_with_systems_locale("rpm", "-qa")

Remediation
=====================================================

You now need to use shell_out! instead:

.. code-block:: ruby

  shell_out("rpm", "-qa")
  shell_out("rpm", "-qa", timeout: new_resource.timeout)
  shell_out("rpm", "-qa", timeout: new_resource.timeout)
  shell_out("rpm", "-qa", default_env: false)
