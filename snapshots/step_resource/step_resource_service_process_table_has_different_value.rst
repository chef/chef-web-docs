.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To handle situations when the process table has a different value than the name of the service script:

.. code-block:: ruby

   service 'samba' do
     pattern 'smbd'
     action [:enable, :start]
   end
