.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``guard_interpreter`` property is set to ``:default`` by default for the |resource script_bash|, |resource script_csh|, |resource script_perl|, |resource script_python|, and |resource script_ruby| resources. When the ``guard_interpreter`` property is set to ``:default``, ``not_if`` or ``only_if`` guard statements **do not inherit** properties that are defined by the |resource script|-based resource.

.. warning:: The |resource batch| and |resource powershell_script| resources inherit properties by default. The ``guard_interpreter`` property is set to ``:batch`` or ``:powershell_script`` automatically when using a ``not_if`` or ``only_if`` guard statement within a |resource batch| or |resource powershell_script| resource, respectively.

For example, the ``not_if`` guard statement in the following resource example **does not inherit** the ``environment`` property:

.. code-block:: ruby

   bash 'javatooling' do
     environment 'JAVA_HOME' => '/usr/lib/java/jdk1.7/home'
     code 'java-based-daemon-ctl.sh -start'
     not_if 'java-based-daemon-ctl.sh -test-started'
   end

and requires adding the ``environment`` property to the ``not_if`` guard statement so that it may use the ``JAVA_HOME`` path as part of its evaluation:

.. code-block:: ruby

   bash 'javatooling' do
     environment 'JAVA_HOME' => '/usr/lib/java/jdk1.7/home'
     code 'java-based-daemon-ctl.sh -start'
     not_if 'java-based-daemon-ctl.sh -test-started', :environment => 'JAVA_HOME' => '/usr/lib/java/jdk1.7/home'
   end

To inherit properties, add the ``guard_interpreter`` property to the resource block and set it to the appropriate value:

* ``:bash`` for |resource script_bash|
* ``:csh`` for |resource script_csh|
* ``:perl`` for |resource script_perl|
* ``:python`` for |resource script_python|
* ``:ruby`` for |resource script_ruby|

For example, using the same example as from above, but this time adding the ``guard_interpreter`` property and setting it to ``:bash``:

.. code-block:: ruby

   bash 'javatooling' do
     guard_interpreter :bash
     environment 'JAVA_HOME' => '/usr/lib/java/jdk1.7/home'
     code 'java-based-daemon-ctl.sh -start'
     not_if 'java-based-daemon-ctl.sh -test-started'
   end

The ``not_if`` statement now inherits the ``environment`` property and will use the ``JAVA_HOME`` path as part of its evaluation.
