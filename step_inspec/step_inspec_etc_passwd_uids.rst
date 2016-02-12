.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test usernames and UIDs:

.. code-block:: ruby

   describe passwd do
     its('usernames') { should eq ['root', 'www-data'] }
     its('uids') { should eq [0, 33] }
   end
