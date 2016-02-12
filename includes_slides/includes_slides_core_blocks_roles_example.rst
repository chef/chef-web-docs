.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


.. image:: ../../images/blocks_roles_example.svg

.. 
.. the following is the legacy slide. the question is: does that mean anything if it's in the first overview someone sees? suggestion: make it more visual. the image is just a mockup attempt.
.. 
.. Define reusable roles:
..
.. .. code-block:: javascript
.. 
..    chef_type:           role
..    default_attributes:
..      my-app:
..        application:
..          package:     mysite-A.tar.gz
..          package_sum: 73e5cf3287e4d903d3828da5be1ab228ea33152447551b4e489e659268f643b2
..          package_url: http://demo-framework.s3.amazonaws.com/mysite-A.tar.gz
..    description:         Role for a myapp webserver
..    env_run_lists:
..    json_class:          Chef::Role
..    name:                myapp_A_webserver
..    override_attributes:
..    run_list:
..      recipe[my-app::application]
..      recipe[my-app::webserver]
.. 
.. 
