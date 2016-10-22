.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following Ohai example shows part of a file that gets initial kernel attribute values:

.. code-block:: ruby

   Ohai.plugin(:Kernel) do
     provides 'kernel', 'kernel/modules'
   
     def init_kernel
       kernel Mash.new
       [['uname -s', :name], ['uname -r', :release],
       ['uname -v', :version], ['uname -m', :machine]].each do |cmd, property|
         so = shell_out(cmd)
         kernel[property] = so.stdout.split($/)[0]
       end
       kernel
     end
     
     ...
   
     collect_data(:darwin) do
       kernel init_kernel
       kernel[:os] = kernel[:name]
   
       so = shell_out('sysctl -n hw.optional.x86_64')
       if so.stdout.split($/)[0].to_i == 1
         kernel[:machine] = 'x86_64'
       end
    
       modules = Mash.new
       so = shell_out('kextstat -k -l')
       so.stdout.lines do |line|
         if line =~ /(\d+)\s+(\d+)\s+0x[0-9a-f]+\s+0x([0-9a-f]+)\s+0x[0-9a-f]+\s+([a-zA-Z0-9\.]+) \(([0-9\.]+)\)/
           kext[$4] = { :version => $5, :size => $3.hex, :index => $1, :refcount => $2 }
         end
       end
    
       kernel[:modules] = modules
     end
    
     ...
