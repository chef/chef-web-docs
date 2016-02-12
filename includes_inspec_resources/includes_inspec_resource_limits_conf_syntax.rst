.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A ``limits_conf`` |inspec resource| block declares a domain to be tested, along with associated type, item, and value:

.. code-block:: ruby

   describe limits_conf('path') do
     its('domain') { should include ['type', 'item', 'value'] }
     its('domain') { should eq ['type', 'item', 'value'] }
   end

where

* ``('path')`` is the non-default path to the ``inetd.conf`` file
* ``'domain'`` is a user or group name, such as ``grantmc``
* ``'type'`` is either ``hard`` or ``soft``
* ``'item'`` is the item for which limits are defined, such as ``core``, ``nofile``, ``stack``, ``nproc``, ``priority``, or ``maxlogins``
* ``'value'`` is the value associated with the ``item``
