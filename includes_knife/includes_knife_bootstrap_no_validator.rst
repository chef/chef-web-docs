.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The |organization pem| is typically added to the |chef repo hidden| directory on the workstation. When a node is bootstrapped from that workstation, the |organization pem| is used to authenticate the newly-created node to the |chef server| during the initial |chef client| run. Starting with |chef client| version 12.1, it is possible to bootstrap a node using the |user pem| file instead of the |organization pem| file. This is known as a "validatorless bootstrap".

To create a node via the |user pem| file, simply delete the |organization pem| file on the workstation. For example:

.. code-block:: bash

   $ rm -f /home/lamont/.chef/myorg-validator.pem

and then make the following changes in the |knife rb| file:

* Remove the ``validation_client_name`` setting
* Edit the ``validation_key`` setting to be something that isn't a path to an existent |organization pem| file. For example: ``/nonexist``.

As long as a |user pem| is also present on the workstation from which the validatorless bootstrap operation will be initiated, the bootstrap operation will run and will use the |user pem| file instead of the |organization pem| file.

When running a validatorless ``knife bootstrap`` operation, the output is similar to:

.. code-block:: bash

   desktop% knife bootstrap 10.1.1.1 -N foo01.acme.org \
     -E dev -r 'role[base]' -j '{ "foo": "bar" }' \
     --ssh-user vagrant --sudo
   Node foo01.acme.org exists, overwrite it? (Y/N)
   Client foo01.acme.org exists, overwrite it? (Y/N)
   Creating new client for foo01.acme.org
   Creating new node for foo01.acme.org
   Connecting to 10.1.1.1
   10.1.1.1 Starting first Chef Client run...
   [....etc...]
