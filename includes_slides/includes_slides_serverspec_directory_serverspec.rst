.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


|kitchen| utilizes bussers to manage test plugins. We'll be using the ``serverspec`` plugin:

.. code-block:: python

   test/
     └── integration
         └── default
             └── serverspec
                 └── default_spec.rb

.. code-block:: yaml

   suites:
     - name: default
       run_list:
         - recipe[apache::default]
