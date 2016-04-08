.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``delivery-truck`` setting specifies configurations for specific phases of the |delivery| pipeline.

For example, configure the ``lint.rb`` recipe to run only |foodcritic| rule ``FC002``:

.. code-block:: javascript

     "delivery-truck": {
       "lint": {
         "foodcritic": {
           "only_rules": ["FC002"]
         }
       }
     }


.. 
.. To publish to the |chef server| that is part of this |delivery| configuration:
.. 
.. .. code-block:: javascript
.. 
..    "delivery-truck":{
..      "publish": {
..        "chef_server": "PATH_TO_SERVER"
..      }
..    }
.. 
.. 
.. "chef_server": false << chef-web-learn
.. 
.. To publish to |github|:
.. 
.. .. code-block:: javascript
.. 
..    "delivery-truck":{
..      "publish": {
..        "github": "chef/chef-web-docs"
..      }
..    }
.. 
.. 
.. To publish to a |git| repo:
.. 
.. .. code-block:: javascript
.. 
..    "delivery-truck":{
..      "publish": {
..        "git": "PATH_TO_GIT_REPO"
..      }
..    }
.. 
.. 
.. To publish to |supermarket|:
.. 
.. .. code-block:: javascript
.. 
..    "delivery-truck":{
..      "publish": {
..        "supermarket": "PATH_TO_SUPERMARKET"
..      }
..    }
.. 
.. To publish to |supermarket| with custom credentials:
.. 
.. .. code-block:: javascript
.. 
..    "delivery-truck":{
..      "publish": {
..        "supermarket": "PATH_TO_SUPERMARKET",
..        "supermarket-custom-credentials": "CREDENTIALS"
..      }
..    }
.. 
.. ``supermarket-custom-credentials`` requires the ``supermarket_user`` and ``supermarket_key`` credentials to be available from the ``secrets`` data bag on the |chef server| that is part of this |delivery| configuration.






