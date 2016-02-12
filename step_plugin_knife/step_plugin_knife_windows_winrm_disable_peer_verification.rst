.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. add this, but don't include in the docs. save for in case it's needed someday.

To disable peer verification:

.. code-block:: bash

   $ knife winrm -m 192.168.0.6 -x 'mydomain\myuser' -P "$PASSWORDVAR" -t ssl --winrm-ssl-verify-mode verify_none ipconfig 

.. warning:: Use this option carefully. Disabling peer verification may allow the remote system's certificate to be a target of spoofing attacks.