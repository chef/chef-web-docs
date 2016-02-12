.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

An ``audit_policy`` |inspec resource| block declares a parameter that belongs to an audit policy category or subcategory:

.. code-block:: ruby

   describe audit_policy do
     its('parameter') { should eq 'value' }
   end

where

* ``'parameter'`` must specify a parameter 
* ``'value'`` must be one of ``No Auditing``, ``Not Specified``, ``Success``, ``Success and Failure``, or ``Failure``
