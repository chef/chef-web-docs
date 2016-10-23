.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 

On Ubuntu systems, AppArmor is enabled in enforcing mode by default. Chef products do not have a profile available to run under AppArmor. In order for the Chef products to run, AppArmor must set to ``Complaining`` mode or disabled.

To determine if AppArmor is installed, run the following command:

.. code-block:: bash

   $ sudo apparmor_status

To install AppArmor, run the following command:

.. code-block:: bash

   $ sudo apt-get install apparmor-utils —yes

If a response other than ``"0 processes are in enforce mode"`` or ``"0 profiles are in enforce mode."`` is returned, AppArmor must be set to ``Complaining`` mode or disabled.

To set AppArmor to ``Complaining`` mode, run:

.. code-block:: bash

   $ sudo aa-complain /etc/apparmor.d/*

Or to disable AppArmor entirely, run:

.. code-block:: bash

   $ sudo invoke-rc.d apparmor kill
   $ sudo update-rc.d -f apparmor remove

and then check the status:

.. code-block:: bash

   $ sudo apparmor_status
