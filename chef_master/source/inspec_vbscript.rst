=====================================================
vbscript
=====================================================

.. include:: ../../includes_inspec_resources/includes_inspec_resource_vbscript.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_vbscript_syntax.rst

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_no_matchers.rst

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test a VBScript**

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
