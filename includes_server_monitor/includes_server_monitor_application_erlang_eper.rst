.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

As root on the |chef server|, point to the bundled ``eper`` package of debugging tools. Replace the 2nd and 5th path entries and the ``X.XX.X`` value in the following path with the items that occur on the system.

.. code-block:: bash

   $ export ERL_LIB=:/opt/{chef-server,opscode}/embedded/service/{erchef,opscode-erchef}/lib/eper-X.XX.X/ebin/

Open an |erlang| command shell to begin diagnosing service issues on the |chef server|:

.. code-block:: bash

   Eshell V5.10.4  (abort with ^G)
   (erchef@127.0.0.1)1>

The ``dtop`` tool presents a view on the |erlang| virtual machine that is similar to the ``linuxdagnostic`` command. The period at the end of the dtop command is required for the command to take effect.

.. code-block:: bash

   (erchef@127.0.0.1)1> dtop:start().

To stop the ``dtop`` command, run:

.. code-block:: bash

   (erchef@127.0.0.1)1> dtop:stop().

To disconnect from the shell, use the following key sequence ``CTRL-g``, ``q``, and then ``ENTER``.

The output from the shell after the ``CTRL-g`` looks similar to:

.. code-block:: bash

   (erchef@127.0.0.1)1>
   User switch command

then enter ``q``, and then hit ``ENTER`` to exit the shell.

