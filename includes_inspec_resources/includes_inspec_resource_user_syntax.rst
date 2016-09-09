.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A ``user`` |inspec resource| block declares a user name, and then one (or more) matchers:

.. code-block:: ruby

   describe user('root') do
     it { should exist }
     its('uid') { should eq 1234 }
     its('gid') { should eq 1234 }
     its('group') { should eq 'root' }
     its('groups') { should eq ['root', 'other']}
     its('home') { should eq '/root' }
     its('shell') { should eq '/bin/bash' }
     its('mindays') { should eq 0 }
     its('maxdays') { should eq 90 }
     its('warndays') { should eq 8 }
   end

or with a filter:

.. code-block:: ruby

   describe users.where(uid: 0).entries do
     it { should eq ['root'] }
     its('uids') { should eq [1234] }
     its('gids') { should eq [1234] }
   end

where

* ``('root')`` is the user to be tested
* ``it { should exist }`` tests if the user exists
* ``gid``, ``group``, ``groups``, ``home``, ``maxdays``, ``mindays``, ``shell``, ``uid``, and ``warndays`` are valid matchers for this |inspec resource|
* ``where(uid: 0).entries`` represents a filter that runs the test only against the specified user identifier
