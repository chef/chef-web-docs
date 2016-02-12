.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


.. image:: ../../images/blocks_environments_example.svg



.. 
.. the following is the legacy slide. the question is: does that mean anything if it's in the first overview someone sees? suggestion: make it more visual. the image is just a mockup attempt.
.. 
.. Define reusable environments:
.. 
.. .. code-block:: javascript
.. 
..    chef_type:           environment
..    cookbook_versions:
..      database: 2.2.0 
..    default_attributes:
..      myapp:
..        version: 1.2.3
..    description:         for development nodes
..    json_class:          Chef::Environment
..    name:                development
..    override_attribute
.. 
