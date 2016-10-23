.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``whyrun_supported?`` method is used to set a custom provider to support why-run mode. The syntax for the ``whyrun_supported?`` method is as follows:

.. code-block:: ruby

   def whyrun_supported?
     true
   end

where ``whyrun_supported?`` is set to ``true`` for any custom provider that supports using why-run mode. When why-run mode is supported by the a custom provider, the ``converge_by`` method is used to define the strings that are logged by the chef-client when it is run in why-run mode.
