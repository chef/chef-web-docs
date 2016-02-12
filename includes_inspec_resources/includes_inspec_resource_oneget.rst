.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use the ``oneget`` |inspec resource| to test if the named package and/or package version is installed on the system. This resource uses |oneget|, which is `part of the Windows Management Framework 5.0 and Windows 10 <https://github.com/OneGet/oneget>`__. This resource uses the ``Get-Package`` cmdlet to return all of the package names in the |oneget| repository.
