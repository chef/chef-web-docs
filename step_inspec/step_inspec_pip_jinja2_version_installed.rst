.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test if Jinja2 2.8 is installed on the system:

.. code-block:: ruby

   describe pip('Jinja2') do
     it { should be_installed }
     its('version') { should eq '2.8' }
   end
