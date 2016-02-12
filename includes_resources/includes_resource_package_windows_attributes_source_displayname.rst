.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

If the ``source`` property is not specified, the package name MUST be exactly the same as the display name found in **Add/Remove programs** or exacty the same as the ``DisplayName`` property in the appropriate registry key:

.. code-block:: ruby

   HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Uninstall
   HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall
   HKEY_LOCAL_MACHINE\Software\Wow6464Node\Microsoft\Windows\CurrentVersion\Uninstall

.. note:: If there are multiple versions of a package installed with the same display name, all of those packages will be removed unless a version is provided in the ``version`` property or unless it can be discovered in the installer file specified by the ``source`` property.
