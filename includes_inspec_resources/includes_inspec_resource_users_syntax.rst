.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A ``users`` |inspec resource| block declares a user name, and then one (or more) matchers:

.. code-block:: ruby

   describe users.where(uid: 0).entries do
     it { should eq ['root'] }
     its('uids') { should eq [1234] }
     its('gids') { should eq [1234] }
   end

where

* ``gid``, ``group``, ``groups``, ``home``, ``maxdays``, ``mindays``, ``shell``, ``uid``, and ``warndays`` are valid matchers for this |inspec resource|
* ``where(uid: 0).entries`` represents a filter that runs the test only against matching users, such as:

  .. code-block:: ruby

     describe users.where { username =~ /.*/ } do
       it { should exist }
     end

  or:

  .. code-block:: ruby

     describe users.where { uid =~ /^S-1-5-[0-9-]+-501$/ } do
       it { should exist }
     end
