.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To mount a remote file system and add it to the file systems table:

.. code-block:: ruby

   mount '/export/www' do
     device 'nas1prod:/export/web_sites'
     fstype 'nfs'
     options 'rw'
     action [:mount, :enable]
   end
