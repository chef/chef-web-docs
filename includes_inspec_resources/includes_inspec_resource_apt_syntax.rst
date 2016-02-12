.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

An ``apt`` |inspec resource| block tests the contents of |apt| and |ppa| repositories:

.. code-block:: ruby

   describe apt('path') do
     it { should exist }
     it { should be_enabled }
   end

where

* ``apt('path')`` must specify an |apt| or |ppa| repository
* ``('path')`` may be an ``http://`` address, a ``ppa:`` address, or a short ``repo-name/ppa`` address
* ``exist`` and ``be_enabled`` are a valid matchers for this |inspec resource|
