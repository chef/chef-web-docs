.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test a kitchen.yml file driver:

.. code-block:: ruby

   describe yaml('.kitchen.yaml') do
     its('driver.name') { should eq('vagrant') }
   end
