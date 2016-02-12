=====================================================
Custom Resources 
=====================================================

.. warning:: This approach to building custom resources was introduced in |chef client|, version 12.5. If you are using an older version of the |chef client|, please use the version picker (in the top left of the navigation) to select your version, and then choose the same topic from the navigation tree ("Extend Chef > Custom Resources"). See also https://github.com/chef-cookbooks/compat_resource for using this features with previous versions of the |chef client|.

.. include:: ../../includes_custom_resources/includes_custom_resources.rst

Syntax
=====================================================
.. include:: ../../includes_custom_resources/includes_custom_resources_syntax.rst

Example
-----------------------------------------------------
.. include:: ../../includes_custom_resources/includes_custom_resources_syntax_example.rst

resource_name
-----------------------------------------------------
.. include:: ../../includes_custom_resources/includes_custom_resources_syntax_resource_name.rst

.. include:: ../../includes_custom_resources/includes_custom_resources_syntax_resource_name_example.rst

Scenario: website Resource
=====================================================
.. include:: ../../includes_custom_resources/includes_custom_resources_slide_website.rst

.. note:: Read this scenario as an HTML presentation at https://docs.chef.io/decks/custom_resources.html.

Create a Cookbook
-----------------------------------------------------
.. include:: ../../includes_custom_resources/includes_custom_resources_slide_website_cookbook.rst

Objectives
-----------------------------------------------------
.. include:: ../../includes_custom_resources/includes_custom_resources_slide_website_objectives.rst

What is needed?
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_custom_resources/includes_custom_resources_slide_website_objectives_requirements.rst

Define Properties
-----------------------------------------------------
.. include:: ../../includes_custom_resources/includes_custom_resources_slide_website_properties.rst

.. include:: ../../includes_custom_resources/includes_custom_resources_slide_website_properties_add.rst

Define Actions
-----------------------------------------------------
.. include:: ../../includes_custom_resources/includes_custom_resources_slide_website_actions.rst

Define Resource
-----------------------------------------------------
.. include:: ../../includes_custom_resources/includes_custom_resources_slide_website_resources.rst

package
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_custom_resources/includes_custom_resources_slide_website_resources_package.rst

template, httpd.service
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_custom_resources/includes_custom_resources_slide_website_resources_template_httpd_service.rst

template, httpd.conf
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_custom_resources/includes_custom_resources_slide_website_resources_template_httpd_conf.rst

directory
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_custom_resources/includes_custom_resources_slide_website_resources_directory.rst

service
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_custom_resources/includes_custom_resources_slide_website_resources_service.rst

Create Templates
-----------------------------------------------------
.. include:: ../../includes_custom_resources/includes_custom_resources_slide_website_templates.rst

httpd.conf.erb
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_custom_resources/includes_custom_resources_slide_website_templates_httpd_conf_erb.rst

Template Variables
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_custom_resources/includes_custom_resources_slide_website_templates_httpd_conf_erb_variables.rst

httpd.service.erb
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_custom_resources/includes_custom_resources_slide_website_templates_httpd_service_erb.rst

Final Resource
-----------------------------------------------------
.. include:: ../../includes_custom_resources/includes_custom_resources_website_final_resource.rst

Final Cookbook Directory
-----------------------------------------------------
.. include:: ../../includes_custom_resources/includes_custom_resources_slide_website_final_cookbook_directory.rst

Recipe
-----------------------------------------------------
.. include:: ../../includes_custom_resources/includes_custom_resources_slide_website_recipe.rst

Advanced Options
=====================================================
The following sections describe advanced options that may be used (or may be required) when building custom resources.

default_action
-----------------------------------------------------
.. include:: ../../includes_custom_resources/includes_custom_resources_syntax_default_action.rst

Override Properties
-----------------------------------------------------
.. include:: ../../includes_custom_resources/includes_custom_resources_syntax_override_properties.rst
