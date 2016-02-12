.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To verify that a repository exists and is enabled:

.. code-block:: ruby

   describe apt('http://ppa.launchpad.net/juju/stable/ubuntu') do
     it { should exist }
     it { should be_enabled }
   end
