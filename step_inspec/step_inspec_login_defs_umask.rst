.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test umask settings:

.. code-block:: ruby

   describe login_def do
     its('UMASK') { should eq '077' }
     its('PASS_MAX_DAYS') { should eq '90' }
   end
