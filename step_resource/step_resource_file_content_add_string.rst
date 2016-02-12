.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following example specifies a directory, and then uses the ``content`` property to add a string to the file created in that directory: 

.. code-block:: ruby

   status_file = '/path/to/file/status_file'
   
   file status_file do
     owner 'root'
     group 'root'
     mode '0755'
     content 'My favourite foremost coastal Antarctic shelf, oh Larsen B!'
   end
