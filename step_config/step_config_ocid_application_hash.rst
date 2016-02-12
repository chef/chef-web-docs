.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To define |oauth| 2 information for both |chef analytics| and |supermarket|, create a |ruby hash| similar to:

   .. code-block:: ruby

      oc_id['applications'] = {
        'analytics' => {
          'redirect_uri' => 'https://analytics.rhel.aws'
        },
        'supermarket' => {
          'redirect_uri' => 'https://vagrantup.com/auth'
        }
      }
