.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following test shows how to audit machines to ensure that |apache| is enabled and running:

.. code-block:: ruby

   control 'apache-1' do
     impact 0.3
     title 'Apache2 should be configured and running'
     describe service(apache.service) do
       it { should be_enabled }
       it { should be_running }
     end
   end
