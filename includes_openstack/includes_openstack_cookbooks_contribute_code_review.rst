.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Some guidelines for code reviewers:

#. Never +1/+2R or +1A your own patch.
#. All patches must have a commit message that meets the standard commit message guidelines for |openstack| projects. Failure of the commit message to meet these guidelines should prevent a +1A by a core reviewer.
#. If the patch is more than just stylistic or typo fixes, it requires at least 2 core reviewers to add a +2R to the review before any core reviewer can +1A the review.
#. If the patch changes existing behavior of any cookbook in a backwards-incompatible way, a corresponding bump in the version in the cookbook's |metadata rb| must be included in patch set. Failure to do so should prevent a +1A by a core reviewer.
#. If the patch adds additional functionality to a library cookbook, a corresponding bump in version number in the |metadata rb| file should accompany the patch. Failure to do so should prevent a +1A by a core review.
#. Review the code in |gerrit| and make constructive suggestions and comments

Here are some general steps to validate the change:

#. Checkout `single stack <http://https://github.com/openstack/openstack-chef-repo>`_
#. Cherry-pick changes into respective local checkouts as pertains to the repos being changed
#. Point the |berksfile| at the local changes
#. ``chef exec rake aio_nova`` (for now just ubuntu)
#. Make sure everything converges
