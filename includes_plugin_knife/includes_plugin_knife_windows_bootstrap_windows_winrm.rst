.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``bootstrap windows winrm`` argument to bootstrap |chef client| installations in a |windows| environment, using |windows remote management| and the |ws management| protocol for communication. This argument requires the |fqdn| of the host machine to be specified. The |microsoft installer package| run silently during the bootstrap operation (using the ``/qn`` option).
