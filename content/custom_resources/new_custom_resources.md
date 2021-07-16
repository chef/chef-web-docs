+++
title = "Custom Resources"
draft = false
gh_repo = "chef-web-docs"
aliases = ["/new_custom_resources.html"]

+++

- What is a custom resource?
- Common custom resource methods
  - Link to a full list of methods in document X
  - action, property, unified_mode, default
- Extending with libraries
- action_class
- extend, include
- use 'partial/_config_file'

- resource context
  - new_resource
  - current_resource
- resource collection
  - What it looks like (nested)
  -

Notes?

- resource provider split
  - helpers and methods that are included in the provider (anything above the first action) are only available to properties
  - helpers and methods from the action_class are available to the actions.

- what is a mixin and why we need to use it
-

Resource Partials
- Easily manage shared functionality

after_resource state
- Manage resource state information

compile_time property
- Available to all custom resources
