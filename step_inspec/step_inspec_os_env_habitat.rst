.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test Habitat environment variables:

|habitat| uses the ``os_env`` resource to `test environment variables <https://github.com/habitat-sh/habitat/blob/master/test/hab_inspec/controls/clean_env.rb>`_. The environment variables are first defined in a whitespace array, after which each environment variable is tested:

.. code-block:: ruby

   hab_env_vars = %w(HAB_AUTH_TOKEN
                     HAB_CACHE_KEY_PATH
                     HAB_DEPOT_URL
                     HAB_ORG
                     HAB_ORIGIN
                     HAB_ORIGIN_KEYS
                     HAB_RING
                     HAB_RING_KEY
                     HAB_STUDIOS_HOME
                     HAB_STUDIO_ROOT
                     HAB_USER)

   hab_env_vars.each do |e|
     describe os_env(e) do
       its('content') { should eq nil }
     end
   end
