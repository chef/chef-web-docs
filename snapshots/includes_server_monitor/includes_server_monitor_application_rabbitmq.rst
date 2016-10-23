.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


rabbitmqctl is the management tool for RabbitMQ. It can be used to obtain status information and to ensure that message queuing is running properly. For more information about rabbitmqctl, see https://www.rabbitmq.com/man/rabbitmqctl.1.man.html.

To obtain status information for message queues, run the following command:

.. code-block:: bash

   $ export PATH=$PATH:/opt/opscode/bin:/opt/opscode/embedded/bin
     rabbitmqctl status

to return something similar to:

.. code-block:: bash

   Status of node rabbit@localhost ...
   [{pid,3044},
    {running_applications, [{rabbit,"RabbitMQ","2.7.1"},
                            {mnesia,"MNESIA CXC 138 12","4.7.1},
                            {os_mon,"CPO CXC 138 46","2.2.10},
                            ...
                            {kernel,"ERTS CXC 138 10","2.15.2"}]},
    {os,{unix,linux}},
    {erlang_version,"Erlang R15B02 (erts-5.9.2) [source] [64-bit] ..."},
    {memory,[{total,96955896},
             {processes,38634560},
             ...
             {ets,5850336}]},
    {vm_memory_high_watermark,0.39999999995176794},
    {vm_memory_limit,1658647347}]
    ... done
       
