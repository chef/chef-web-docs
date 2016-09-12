.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A ``json`` |inspec resource| block declares the data to be tested. Assume the following |json| file:

.. code-block:: javascript

   {
     "name" : "hello",
     "meta" : {
       "creator" : "John Doe"
     },
     "array": [
       "zero",
       "one"
     ]
   }

This file can be queried using:

.. code-block:: ruby

   describe json('/paht/to/name.json') do
     its('name') { should eq 'hello' }
     its(['meta','creator']) { should eq 'John Doe' }
     its(['array', 1]) { should eq 'one' }
   end

where

* ``name`` is a configuration setting in a |json| file
* ``should eq 'foo'`` tests a value of ``name`` as read from a |json| file versus the value declared in the test
