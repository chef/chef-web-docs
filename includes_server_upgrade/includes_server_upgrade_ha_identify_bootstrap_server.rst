.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The bootstrap server should be defined in the |chef private| configuration file, ``/etc/opscode/private-chef.rb``:

.. code-block:: ruby

   server "opc-backend-bootstrap.local",
     :ipaddress => "172.30.1.100",
     :role => "backend",
     :bootstrap => true

The bootstrap server will also contain a bootstrap file on the filesystem at ``/var/opt/opscode/bootstrapped``.