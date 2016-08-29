.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

For example, a |vbscript| file similar to:

.. code-block:: ruby

   vbscript = <<-EOH
     WScript.Echo "hello"
   EOH

may be tested for multiple lines:

.. code-block:: ruby

   describe vbscript(vbscript) do
     its('stdout') { should eq "hello\r\n" }
   end

and tested for whitespace removal from standard output:

.. code-block:: ruby

   describe vbscript(vbscript) do
     its('strip') { should eq "hello" }
   end
