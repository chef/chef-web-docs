.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``server create`` argument to create a new |google compute engine| cloud instance. This will provision a new image in |google compute engine|, perform a |chef client| bootstrap (using the |ssh| protocol), and then install the |chef client| on the target system so that it can be used to configure the node and to communicate with a |chef server|.