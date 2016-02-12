.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``be_socket`` matcher tests if the file exists as socket (``.sock``), such as ``/var/run/php-fpm.sock``:

.. code-block:: ruby

   it { should be_socket }
