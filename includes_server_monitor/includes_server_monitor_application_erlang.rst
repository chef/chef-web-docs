.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Many components of the |chef server| are written using |erlang| and run on the |beam| virtual machine. One feature of |erlang| and |beam| is the ability to interact with the running service using a command shell. For example:

.. code-block:: bash

   $ cd /opt/opscode/embedded
     export PATH=$PATH:/opt/opscode/bin:/opt/opscode/embedded/bin
     bin/erl -setcookie service_name -name me@127.0.0.1 -remsh service_name@127.0.0.1

where ``service_name`` is ``bifrost`` or ``erchef``. This command will then open a shell that is connected to the |erchef| processes:

.. code-block:: bash

   $ Erlang R15B02 (erts-5.9.2) [source] [64-bit] ...

.. warning:: Connecting to the |erlang| processes should only be done when directed by |company_name| support services.

To connect to the |service bifrost| service, use the following command:

.. code-block:: bash

   $ erl -setcookie oc_bifrost -name me@127.0.0.1 -remsh oc_bifrost@127.0.0.1

To connect to the |service erchef| service, use the following command:

.. code-block:: bash

   $ erl -setcookie erchef -name me@127.0.0.1 -remsh erchef@127.0.0.1

To disconnect from the shell, use the following key sequence ``CTRL-g``, ``q``, and then ``ENTER``.

The output from the shell after the ``CTRL-g`` looks similar to:

.. code-block:: bash

   (erchef@127.0.0.1)1>
   User switch command

then enter ``q``, and then hit ``ENTER`` to exit the shell.

Some commands should not be entered when interacting with a running service while using the command shell, including:

* ``q()`` kills the |erlang| node
* ``init:stop()``
* ``exit`` or ``exit()`` does nothing
