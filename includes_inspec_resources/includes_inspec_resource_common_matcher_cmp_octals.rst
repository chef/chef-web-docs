.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Improve printing of octal values:

.. code-block:: ruby

   describe file('/proc/cpuinfo') do
     its('mode') { should cmp '0345' }
   end

prints something similar to:

.. code-block:: bash

   expected: 0345
   got: 0444

