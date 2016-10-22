.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To pass a Microsoft Windows environment variable to a script:

.. code-block:: ruby

   powershell_script 'read-env-var' do
     cwd Chef::Config[:file_cache_path]
     environment ({'foo' => 'BAZ'})
     code <<-EOH
     $stream = [System.IO.StreamWriter] "./test-read-env-var.txt"
     $stream.WriteLine("FOO is $env:foo")
     $stream.close()
     EOH
   end
