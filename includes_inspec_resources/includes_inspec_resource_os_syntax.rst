.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A ``os`` |inspec resource| block declares the platform to be tested. The platform may specified via matcher or control block name. For example, using a matcher:

.. code-block:: ruby

   describe os[:family] do
     it { should eq 'platform_name' }
   end

or using the block name:

.. code-block:: ruby

   describe os[:family_name] do
     ...
   end

* ``'platform_name'`` (a string) or ``:family_name`` (a symbol) is one of ``aix``, ``bsd``, ``darwin``, ``debian``, ``hpux``, ``linux``, ``redhat``, ``solaris``, ``suse``,  ``unix``, or ``windows``
