.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``passwords`` matcher tests if passwords are

* Encrypted
* Have direct logins disabled, as indicated by an asterisk (``*``)
* In the ``/etc/shadow`` file, as indicated by the letter x (``x``)

For example:

.. code-block:: ruby

   its('passwords') { should eq 'x' }
