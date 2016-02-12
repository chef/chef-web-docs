.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A ``csv`` |inspec resource| block declares the configuration data to be tested:

.. code-block:: ruby

   describe csv('file') do
     its('name') { should eq 'foo' }
   end

where

* ``'file'`` is the path to a |csv| file
* ``name`` is a configuration setting in a |csv| file
* ``should eq 'foo'`` tests a value of ``name`` as read from a |csv| file versus the value declared in the test
