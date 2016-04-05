.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

You must authenticate access to the |git| server that comes with |delivery|. The |git| server runs on port 8989 by default. 

.. note:: This authentication step is for the |git| server that comes with |delivery|. If you actually integrate with |github|, as described below, you will not need to do this.

Run this SSH command; enter Yes when prompted.

  .. code-block:: bash

     $ ssh -l USER@ENTERPRISE -p 8989 DELIVERY_SERVER_IP_ADDRESS

You should get output similar to this:

  .. code-block:: bash

     $ ssh -l sally@chef -p 8989 10.194.11.99
       The authenticity of host '[10.194.11.99]:8989 ([10.194.11.99]:8989)' can't be established.
       RSA key fingerprint is ba:db:0c:97:f8:d4:6d:0f:0b:57:0d:0f:0e:a4:15:01.
       Are you sure you want to continue connecting (yes/no)? yes
       Warning: Permanently added '[10.194.11.99]:8989' (RSA) to the list of known hosts.
       channel 0: protocol error: close rcvd twice
       Hi sally@chef! You've successfully authenticated, but Chef Delivery does not provide shell access.
                            Connection to 10.194.11.99 closed.


Your workstation is now set up for use with |delivery|.
