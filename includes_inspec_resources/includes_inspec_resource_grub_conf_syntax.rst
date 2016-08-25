.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A ``grub_conf`` |inspec resource| block declares a list of settings in a ``grub.conf`` file:

.. code-block:: ruby

   describe grub_conf('path', 'kernel') do
     its('setting') { should eq 'value' }
   end

or:

.. code-block:: ruby

   describe grub_conf('path') do
     its('default') { should eq '0' } # 
     its('setting') { should eq 'value' }
   end

where

* ``'service_name'`` is a service listed in the ``grub.conf`` file
* ``'path'`` is the path to the ``grub.conf`` file
* ``'kernel'`` specifies the default kernel (by using ``'default'``) or a specific kernel; ``'default'`` defines the position in the list of kernels at which the default kernel is defined, i.e. ``should eq '0'`` for the first kernel listed or ``'path', 'default'`` to use the default kernel as specified in the ``grub.conf`` file
* ``'value'`` is the value that is expected
