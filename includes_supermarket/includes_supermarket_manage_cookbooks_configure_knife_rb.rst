.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The |knife rb| file on the workstation should be configured for use with the private |supermarket|.

To configure |knife rb| for the private |supermarket|, do the following:

#. Open the |knife rb| file in an editor.
#. Add the following setting:

   .. code-block:: ruby

      knife[:supermarket_site] = 'https://your-private-supermarket'

#. Save and close the file.
