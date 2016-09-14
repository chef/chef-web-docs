.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Since the |inspec| shell is |pry| based the shell also acts as an interactive |ruby| session. |ruby| expressions may be written, and then evaluated. To open the shell in a command window:

.. code-block:: bash

    $ inspec shell
    Welcome to the interactive InSpec Shell
    To find out how to use it, type: help

and then add |ruby|:

.. code-block:: bash

   inspec> 1 + 2
   => 3

Type ``exit`` to exit the shell:

.. code-block:: bash

    $ inspec> exit
