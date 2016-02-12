.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A ``os`` |inspec resource| block declares the platform to be tested:

.. code-block:: ruby

   describe os['family'] do
     it { should eq 'platform' }
   end

where

* ``'platform'`` is one of ``bsd``, ``debian``, ``linux``, ``redhat``, ``solaris``, ``suse``,  ``unix``, or ``windows``
