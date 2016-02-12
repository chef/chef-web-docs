.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To override the default behavior and include secure credentials in an image:

.. code-block:: bash

    $ knife container docker init example/apache2 -r 'recipe[apache2]' --include-credentials

You will need to define the ``container_service`` for the services defined by the ``apache2`` recipe. These are managed by the |runit| init scheme that comes with |chef container|. For more information about ``container_service``, see https://docs.chef.io/containers.html#container-services.