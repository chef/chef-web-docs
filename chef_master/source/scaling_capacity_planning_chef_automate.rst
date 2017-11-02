============================================================
Scaling and Capacity Planning for Automate Node Visibility
============================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/scaling_capacity_planning_chef_automate.rst>`__

.. tag chef_automate_mark

.. image:: ../../images/chef_automate_full.png
   :width: 40px
   :height: 17px

.. end_tag

The following disk and CPU utilization metrics for the node visibility feature in Chef Automate can be used when performing scaling and capacity planning on your Chef Automate server.

Determining Storage Needs
==================================================
Each time a node converges, Chef sends the information about the recipes and resources used during the run, as well as
the node object itself (including its attributes), to the Chef Automate server. Therefore, the storage requirements for
Chef Automate depend on your node object size, amount of resources evaluated during a converge, fleet size, and convergence interval.

For example, if your average node object is 15KB (with a five percent size buffer for resource/recipe information) and you converge
every 15 minutes, the following formula can be used to calculate your total disk utilization for a day.

.. code-block:: none

   (15KB Node Object * 1.05) * 4 converges/hour * 24 hours = 1,512 KB (1.512 MB)

In this example, a single node would require approximately 1.512 MB of disk space per day. With this knowledge, you can easily
compute the disk space requirements for your entire fleet depending on your node size and convergence interval.

To determine your node size, you can run the following command:

For a chef-server connected node

.. code-block:: none

   $ chef-shell -z
   chef (12.13.37)> "#{node.to_json.size/1024} KB"

For a chef-solo node

.. code-block:: none

   $ chef-shell -a
   chef (12.13.37)> "#{node.to_json.size/1024} KB"

Message Throughput
==================================================
On a machine provisioned with 4 CPUs and 16GB RAM (the recommended compute resources for a Chef Automate Server),
Chef Automate is able to reliably process 9000 concurrent converge messages.

When a converge message is received, Chef Automate places the converge message on a queue managed by RabbitMQ. Depending on
CPU utilization, it can take additional time for Chef Automate to process a significant burst of messages.
