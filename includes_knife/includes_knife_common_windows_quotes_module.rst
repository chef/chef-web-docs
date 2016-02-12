.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The |chef client| version 12.4 release adds an optional feature to the |microsoft installer package| for |chef|. This feature enables the ability to pass quoted strings from the |windows powershell| command line without the need for triple single quotes (``''' '''``). This feature installs a |windows powershell| module (typically in ``C:\opscode\chef\modules``) that is also appended to the ``PSModulePath`` environment variable. This feature is not enabled by default. To activate this feature, run the following command from within |windows powershell|:

.. code-block:: bash

   $ Import-Module chef

or add ``Import-Module chef`` to the profile for |windows powershell| located at:

.. code-block:: bash

   ~\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
   
This module exports cmdlets that have the same name as the command-line tools---|chef client|, |knife|, |chef apply|---that are built into |chef|.

For example:

.. code-block:: bash

   $ knife exec -E 'puts ARGV' """&s0meth1ng"""

is now:

.. code-block:: bash

   $ knife exec -E 'puts ARGV' '&s0meth1ng'

and:

.. code-block:: bash

   $ knife node run_list set test-node '''role[ssssssomething]'''

is now:

.. code-block:: bash

   $ knife node run_list set test-node 'role[ssssssomething]'

To remove this feature, run the following command from within |windows powershell|:

.. code-block:: bash

   $ Remove-Module chef




