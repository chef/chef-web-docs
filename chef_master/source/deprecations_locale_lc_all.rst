=======================================================================
Deprecation: Deprecation of lc_all from locale resource (CHEF-27)
=======================================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/deprecations_locale_lc_all.rst>`__

.. tag deprecations_locale_lc_all

Setting the *LC_ALL* variable is NOT recommended. As a system-wide setting, *LANG* should provide the desired behavior. *LC_ALL* is intended to be used for temporarily troubleshooting issues rather than an every day system setting.
Changing *LC_ALL* can break Chef's parsing of command output in unexpected ways. Use one of the more specific *LC_* properties as needed.

.. end_tag

This deprecation warning was added ln Chef 14.12. Support for property lc_all will be removed for Chef 16.0


Remediation
=======================================================================

Setting *LC_* variables varies by platform, but common locations to configure *LC_* variables are:

.. code-block:: ruby

	export LC_ALL="<locale_name>"

1. /etc/default/locale
2. /etc/sysconfig/i18n
3. /etc/environment


You can also use *file* resource and add this variable in any other file of your choice and then can source that file to reflect changes.

.. code-block:: ruby

	file "<path_to_file>" do
	  content "LC_ALL=<locale_name>"
	end


To check the locale value, run

.. code-block:: ruby

	locale -v

.. warning:: Be cautious while using *file* resource on any existing or above listed files. As it replaces all the file contents, you may loose any previous information.
