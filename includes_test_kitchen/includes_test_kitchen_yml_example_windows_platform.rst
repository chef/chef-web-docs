.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following example shows platform settings for the |windows| platform:

.. code-block:: yaml
   
   ---
   
   platforms:
     - name: eval-win2012r2-standard
       os_type: windows
       transport:
         name: winrm
         elevated: true

If ``name`` begins with ``win`` then the ``os_type`` defaults to ``windows``. The ``winrm`` transport is the default on Windows operating systems. Here ``elevated`` is true which runs windows commands via a scheduled task to imitate a local user.
