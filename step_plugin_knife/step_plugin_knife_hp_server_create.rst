.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To provision a server and then perform a bootstrap operation (using |ssh|), enter:

.. code-block:: bash

   $ knife hp server create -f 101 -I 1236 -S hptesting -x ubuntu -i ~/.ssh/hptesting.pem -d omnibus -r 'role[base]' 2

to return something like:

.. code-block:: bash

   Instance ID: 65646
   Instance Name: hp15-185-114-127
   Flavor: 101
   Image: 1236
   SSH Key Pair: hptesting
   
   Waiting for server............................................
   Public IP Address: 15.185.114.127
   Private IP Address: 10.4.21.238
   
   Waiting for sshd..done
   Bootstrapping Chef on 15.185.114.127
   15.185.114.127 --2012-03-09 18:18:17--  http://chef.io/chef/install.sh
   ............
   
   ............
   15.185.114.127 [Fri, 09 Mar 2012 18:19:20 +0000] INFO: Chef Run complete in 25.468149268 seconds
   15.185.114.127 [Fri, 09 Mar 2012 18:19:20 +0000] INFO: Running report handlers
   15.185.114.127 [Fri, 09 Mar 2012 18:19:20 +0000] INFO: Report handlers complete
   
   Instance ID: 65646
   Instance Name: hp15-185-114-127
   Flavor: 101
   Image: 1236
   SSH Key Pair: hptesting
   Public IP Address: 15.185.114.127
   Private IP Address: 10.4.21.238
   Environment: _default
   Run List: role[base]