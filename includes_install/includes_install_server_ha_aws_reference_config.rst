.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following example shows a |chef server rb| file:

.. code-block:: ruby

   topology "ha"
   ha['provider'] = 'aws'
   ha['aws_access_key_id'] = '[DELETED]'
   ha['aws_secret_access_key'] = '[DELETED]'
   ha['ebs_volume_id'] = 'vol-xxxxx'
   ha['ebs_device'] = '/dev/xvdf'
   
   server 'ip-172-31-24-97.us-west-1.compute.internal',
     :ipaddress => '172.31.24.97',
     :role => 'backend',
     :bootstrap => true
   
   server 'ip-172-31-24-98.us-west-1.compute.internal',
     :ipaddress => '172.31.24.98',
     :role => 'backend'
   
   backend_vip 'ip-172-31-24-180.us-west-1.compute.internal',
     :ipaddress => '172.31.24.180',
     :device => 'eth0',
     :heartbeat_device => 'eth0'
   
   server 'ip-172-31-30-47.us-west-1.compute.internal',
     :ipaddress => '172.31.30.47',
     :role => 'frontend'
   
   api_fqdn 'ec2-54-183-175-188.us-west-1.compute.amazonaws.com'