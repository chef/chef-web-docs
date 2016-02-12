.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To render a template with global |yum| configuration parameters:

.. code-block:: ruby

   yum_globalconfig '/my/chroot/etc/yum.conf' do
     cachedir '/my/chroot/etc/yum.conf'
     keepcache 'yes'
     debuglevel '2'
     installroot '/my/chroot'
     action :create
   end



