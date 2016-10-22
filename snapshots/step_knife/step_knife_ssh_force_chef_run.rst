.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To force a chef-client run on all of the web servers running Ubuntu on the Amazon EC2 platform, enter:

.. code-block:: bash

   $ knife ssh "role:web" "sudo chef-client" -x ubuntu -a ec2.public_hostname
   
to return something like:

.. code-block:: bash

   ec2-67-202-63-102.compute-1.amazonaws.com   [Fri, 22 Oct 2010 14:18:37 +0000] INFO: Starting Chef Run (Version 0.9.10)
   ec2-174-129-127-206.compute-1.amazonaws.com [Fri, 22 Oct 2010 14:18:37 +0000] INFO: Starting Chef Run (Version 0.9.10)
   ec2-184-73-9-250.compute-1.amazonaws.com    [Fri, 22 Oct 2010 14:18:38 +0000] INFO: Starting Chef Run (Version 0.9.10)
   ec2-75-101-240-230.compute-1.amazonaws.com  [Fri, 22 Oct 2010 14:18:38 +0000] INFO: Starting Chef Run (Version 0.9.10)
   ec2-184-73-60-141.compute-1.amazonaws.com   [Fri, 22 Oct 2010 14:18:38 +0000] INFO: Starting Chef Run (Version 0.9.10)
   ec2-174-129-127-206.compute-1.amazonaws.com [Fri, 22 Oct 2010 14:18:39 +0000] INFO: Chef Run complete in 1.419243 seconds
   ec2-174-129-127-206.compute-1.amazonaws.com [Fri, 22 Oct 2010 14:18:39 +0000] INFO: cleaning the checksum cache
   ec2-174-129-127-206.compute-1.amazonaws.com [Fri, 22 Oct 2010 14:18:39 +0000] INFO: Running report handlers
   ec2-174-129-127-206.compute-1.amazonaws.com [Fri, 22 Oct 2010 14:18:39 +0000] INFO: Report handlers complete
   ec2-67-202-63-102.compute-1.amazonaws.com   [Fri, 22 Oct 2010 14:18:39 +0000] INFO: Chef Run complete in 1.578265 seconds
   ec2-67-202-63-102.compute-1.amazonaws.com   [Fri, 22 Oct 2010 14:18:39 +0000] INFO: cleaning the checksum cache
   ec2-67-202-63-102.compute-1.amazonaws.com   [Fri, 22 Oct 2010 14:18:39 +0000] INFO: Running report handlers
   ec2-67-202-63-102.compute-1.amazonaws.com   [Fri, 22 Oct 2010 14:18:39 +0000] INFO: Report handlers complete
   ec2-184-73-9-250.compute-1.amazonaws.com    [Fri, 22 Oct 2010 14:18:40 +0000] INFO: Chef Run complete in 1.638884 seconds
   ec2-184-73-9-250.compute-1.amazonaws.com    [Fri, 22 Oct 2010 14:18:40 +0000] INFO: cleaning the checksum cache
   ec2-184-73-9-250.compute-1.amazonaws.com    [Fri, 22 Oct 2010 14:18:40 +0000] INFO: Running report handlers
   ec2-184-73-9-250.compute-1.amazonaws.com    [Fri, 22 Oct 2010 14:18:40 +0000] INFO: Report handlers complete
   ec2-75-101-240-230.compute-1.amazonaws.com  [Fri, 22 Oct 2010 14:18:40 +0000] INFO: Chef Run complete in 1.540257 seconds
   ec2-75-101-240-230.compute-1.amazonaws.com  [Fri, 22 Oct 2010 14:18:40 +0000] INFO: cleaning the checksum cache
   ec2-75-101-240-230.compute-1.amazonaws.com  [Fri, 22 Oct 2010 14:18:40 +0000] INFO: Running report handlers
   ec2-75-101-240-230.compute-1.amazonaws.com  [Fri, 22 Oct 2010 14:18:40 +0000] INFO: Report handlers complete
   ec2-184-73-60-141.compute-1.amazonaws.com   [Fri, 22 Oct 2010 14:18:40 +0000] INFO: Chef Run complete in 1.502489 seconds
   ec2-184-73-60-141.compute-1.amazonaws.com   [Fri, 22 Oct 2010 14:18:40 +0000] INFO: cleaning the checksum cache
   ec2-184-73-60-141.compute-1.amazonaws.com   [Fri, 22 Oct 2010 14:18:40 +0000] INFO: Running report handlers
   ec2-184-73-60-141.compute-1.amazonaws.com   [Fri, 22 Oct 2010 14:18:40 +0000] INFO: Report handlers complete
