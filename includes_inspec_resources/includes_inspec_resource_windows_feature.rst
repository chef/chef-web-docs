.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use the ``windows_feature`` |inspec resource| to test features on |windows|. The ``Get-WindowsFeature`` cmdlet returns the following values: ``Property Name``, ``DisplayName``, ``Description``, ``Installed``, and ``InstallState``, returned as a |json| object similar to:

.. code-block:: javascript

   {
     "Name": "XPS-Viewer",
     "DisplayName": "XPS Viewer",
     "Description": "The XPS Viewer reads, sets permissions, and digitally signs XPS documents.",
     "Installed": false,
     "InstallState": 0
   }
