.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``require`` method is a standard Ruby method that can be used to list files that may be required by a platform, such as an external class library. As a best practice, even though the ``require`` method is often used at the top of a Ruby file, it is recommended that the use of the ``require`` method be used as part of the platform-specific ``collect_data`` block. For example, the Ruby WMI is required with Microsoft Windows:

.. code-block:: ruby

   collect_data(:windows) do
     require 'ruby-wmi'
     WIN32OLE.codepage = WIN32OLE::CP_UTF8
   
     kernel Mash.new
   
     host = WMI::Win32_OperatingSystem.find(:first)
     kernel[:os_info] = Mash.new
     host.properties_.each do |p|
       kernel[:os_info][p.name.wmi_underscore.to_sym] = host.send(p.name)
     end
   
     ...
   
   end

Ohai will attempt to fully qualify the name of any class by prepending ``Ohai::`` to the loaded class. For example both:

.. code-block:: ruby

   require Ohai::Mixin::ShellOut

and:

.. code-block:: ruby

   require Mixin::ShellOut

are both understood by the Ohai in the same way: ``Ohai::Mixin::ShellOut``.

When a class is an external class (and therefore should not have ``Ohai::`` prepended), use ``::`` to let the Ohai know. For example:

.. code-block:: ruby

   ::External::Class::Library
