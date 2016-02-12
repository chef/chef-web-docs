.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A ``group`` |inspec resource| block declares a group, and then the details to be tested, such as if the group is a local group, the group identifier, or if the group exists:

.. code-block:: ruby

   describe group('group_name') do
     it { should exist }
     its('gid') { should eq 0 }
   end

where

* ``'group_name'`` must specify the name of a group on the system
* ``exist`` and ``'gid'`` are valid matchers for this |inspec resource|
