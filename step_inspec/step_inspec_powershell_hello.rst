.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test a 'hello' script: 

The following |windows powershell| script:

.. code-block:: ruby

   script = <<-EOH
     Write-Output 'hello'
   EOH

can be tested in the following ways.

For a newline:

.. code-block:: ruby

   describe powershell(script) do
     its('stdout') { should eq "hello\r\n" }
     its('stderr') { should eq '' }
   end

Removing whitespace ``\r\n`` from ``stdout``:

.. code-block:: ruby

   describe powershell(script) do
     its('strip') { should eq "hello" }
   end

No newline:

.. code-block:: ruby

   describe powershell("'hello' | Write-Host -NoNewLine") do
     its('stdout') { should eq 'hello' }
     its('stderr') { should eq '' }
   end
