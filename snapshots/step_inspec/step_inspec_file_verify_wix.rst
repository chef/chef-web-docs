.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

WiX includes serveral tools -- such as ``candle`` (preprocesses and compiles source files into object files), ``light`` (links and binds object files to an installer database), and ``heat`` (harvests files from various input formats). The following example uses a whitespace array and the InSpec ``file`` audit resource to verify if these three tools are present:

.. code-block:: ruby

   %w(
     candle.exe
     heat.exe
     light.exe
   ).each do |utility|
     describe file("C:/wix/#{utility}") do
       it { should be_file }
     end
   end

