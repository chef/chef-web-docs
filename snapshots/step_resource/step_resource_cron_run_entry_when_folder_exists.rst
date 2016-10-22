.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To run an entry if a folder exists:

.. code-block:: ruby

   cron 'ganglia_tomcat_thread_max' do
     command "/usr/bin/gmetric 
       -n 'tomcat threads max' 
       -t uint32 
       -v '/usr/local/bin/tomcat-stat 
       --thread-max'"
     only_if do File.exist?('/home/jboss') end
   end
