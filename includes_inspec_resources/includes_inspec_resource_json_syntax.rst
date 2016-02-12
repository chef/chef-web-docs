.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A ``json`` |inspec resource| block declares the data to be tested:

.. code-block:: ruby

   describe json do
     its('name') { should eq 'foo' }
   end

where

* ``name`` is a configuration setting in a |json| file
* ``should eq 'foo'`` tests a value of ``name`` as read from a |json| file versus the value declared in the test
