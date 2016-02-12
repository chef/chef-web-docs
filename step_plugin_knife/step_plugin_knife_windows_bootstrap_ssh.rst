.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To bootstrap a |windows| machine using |ssh|:

.. code-block:: bash

   $ knife bootstrap windows ssh ec2-50-xx-xx-124.compute-1.amazonaws.com -r 'role[webserver],role[production]' -x Administrator -i ~/.ssh/id_rsa
