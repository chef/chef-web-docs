.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following is an example of using the ``platform_family?`` method and an ``if`` statement to ensure that a specific binary is used for a specific platform. In this case, if the platform is |redhat enterprise linux| then use the ``/usr/bin/pip`` binary and for everything else use the ``/usr/local/bin/pip`` binary.

.. code-block:: ruby

   if platform_family?('rhel')
     pip_binary = '/usr/bin/pip'
   else
     pip_binary = '/usr/local/bin/pip'
   end
