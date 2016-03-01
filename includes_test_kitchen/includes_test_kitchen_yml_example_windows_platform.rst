.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following example shows platform settings for the |windows| platform:

.. code-block:: yaml
   
   ---
   
   platforms:
     - name: eval-win2012r2-standard
       os_type: windows
       shell_type: powershell
       transport:
         name: winrm
   suites:
     - name: default

where ``os_type``, ``shell_type``, and the transport ``name`` are all required.
