.. The contents of this file are included in multiple topics.
.. This file describes a command or a subcommand for Knife.
.. This file should not be changed in a way that hinders its ability to appear in multiple documentation sets.

In chef-shell, it is possible to get extremely verbose debugging using the tracing feature in Interactive Ruby (IRb). chef-shell provides a shortcut for turning tracing on and off. For example:

.. code-block:: bash

   $ chef > tracing on
     /Users/danielsdeleo/.rvm/ree-1.8.7-2009.10/lib/ruby/1.8/tracer.rb:150: warning: tried to create Proc object without a block
     /Users/danielsdeleo/.rvm/ree-1.8.7-2009.10/lib/ruby/1.8/tracer.rb:146: warning: tried to create Proc object without a block
     tracing is on
       => nil

and:

.. code-block:: bash

   $ chef > tracing off
     #0:(irb):3:Object:-: tracing off
     #0:/opt/chef/embedded/lib/ruby/gems/1.9.3/gems/chef-11.4.4/lib/chef/shell/ext.rb:108:Shell::Extensions::ObjectCoreExtensions:>:       def off
     #0:/opt/chef/embedded/lib/ruby/gems/1.9.3/gems/chef-11.4.4/lib/chef/shell/ext.rb:109:Shell::Extensions::ObjectCoreExtensions:-:         :off
     #0:/opt/chef/embedded/lib/ruby/gems/1.9.3/gems/chef-11.4.4/lib/chef/shell/ext.rb:110:Shell::Extensions::ObjectCoreExtensions:<:       end
     #0:/opt/chef/embedded/lib/ruby/gems/1.9.3/gems/chef-11.4.4/lib/chef/shell/ext.rb:273:main:>:       def tracing(on_or_off)
     #0:/opt/chef/embedded/lib/ruby/gems/1.9.3/gems/chef-11.4.4/lib/chef/shell/ext.rb:274:main:-:         conf.use_tracer = on_or_off.on_off_to_bool
     #0:/opt/chef/embedded/lib/ruby/gems/1.9.3/gems/chef-11.4.4/lib/chef/shell/ext.rb:161:Shell::Extensions::Symbol:>:       def on_off_to_bool
     #0:/opt/chef/embedded/lib/ruby/gems/1.9.3/gems/chef-11.4.4/lib/chef/shell/ext.rb:162:Shell::Extensions::Symbol:-:         self.to_s.on_off_to_bool
     #0:/opt/chef/embedded/lib/ruby/gems/1.9.3/gems/chef-11.4.4/lib/chef/shell/ext.rb:148:Shell::Extensions::String:>:       def on_off_to_bool
     #0:/opt/chef/embedded/lib/ruby/gems/1.9.3/gems/chef-11.4.4/lib/chef/shell/ext.rb:149:Shell::Extensions::String:-:         case self
     #0:/opt/chef/embedded/lib/ruby/gems/1.9.3/gems/chef-11.4.4/lib/chef/shell/ext.rb:153:Shell::Extensions::String:-:           false
     #0:/opt/chef/embedded/lib/ruby/gems/1.9.3/gems/chef-11.4.4/lib/chef/shell/ext.rb:157:Shell::Extensions::String:<:       end
     #0:/opt/chef/embedded/lib/ruby/gems/1.9.3/gems/chef-11.4.4/lib/chef/shell/ext.rb:163:Shell::Extensions::Symbol:<:       end
     tracing is off
      => nil
     chef > 
