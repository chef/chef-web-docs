.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The |client rb| configuration file has the following settings related to |push jobs|:

``whitelist``
   A |ruby hash| that contains the whitelist used by |push jobs|. For example:

   .. code-block:: ruby

      whitelist {
        'job-name' => 'command',
        'job-name' => 'command',
        'chef-client' => 'chef-client'
      }

   A job entry may also be ``'job-name' => {:lock => true}``, which will check the ``lockfile`` setting in the |client rb| file before starting the job.

   .. warning:: The ``whitelist`` setting is available only when using |push jobs|, a tool that runs jobs against nodes in an organization.
