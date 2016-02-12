.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


If the |rabbitmq| queue that is used by |chef analytics| stops consuming messages, the |chef server| data partition will fill up and may affect the overall performance of the |chef server| application itself. The settings for the |rabbitmq| queue are tunable, including for queue length monitoring, queue capacity, maximum number of messages that can be in the queue before messages are dropped, the point at which messages are dropped, for settings used by the |rabbitmq mgmt|, and so on.
