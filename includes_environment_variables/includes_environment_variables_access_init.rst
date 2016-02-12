.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Ideally, a service's init script would contain everything needed to properly start that service, including the necessary environment. Ensuring that the init script itself contains the necessary environment changes ensures that the service will start properly whenever it is being started using its init script, whether that be from the |resource service| resource or directly from the shell. In classic |unix systemv| init scripts, the environment can be altered just as it can be altered in any other shell script, by using a shell variable marked with the export keyword:

.. code-block:: ruby

   export IMPORTANT_VAR='value'
