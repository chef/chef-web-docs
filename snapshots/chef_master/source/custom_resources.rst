=====================================================
Custom Resources 
=====================================================

.. warning:: This approach to building custom resources was introduced in chef-client, version 12.5. It is the recommended approach for all custom resources starting with that version of the chef-client. Refer to the `notes about custom resources <https://docs.chef.io/custom_resources_notes.html>`_ if you're curious about other approaches that use the older styles. If you are using an older version of the chef-client, please use the version picker (in the top left of the navigation) to select your version, and then choose the same topic from the navigation tree ("Extend Chef > Custom Resources"). See also https://github.com/chef-cookbooks/compat_resource for using this features with previous versions of the chef-client.

.. include:: ../../includes_custom_resources/includes_custom_resources.rst

Syntax
=====================================================
.. include:: ../../includes_custom_resources/includes_custom_resources_syntax.rst

Example
-----------------------------------------------------
.. include:: ../../includes_custom_resources/includes_custom_resources_syntax_example.rst

resource_name
-----------------------------------------------------
.. note:: .. include:: ../../includes_ruby/includes_ruby_style_patterns_hyphens.rst

.. include:: ../../includes_dsl_custom_resource/includes_dsl_custom_resource_method_resource_name.rst

.. include:: ../../includes_dsl_custom_resource/includes_dsl_custom_resource_method_resource_name_example.rst

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
.. This file is hooked into a slide deck
.. This is the consolidated version of includes_custom_resources_slide_website_final_resource_part1, includes_custom_resources_slide_website_final_resource_part2, includes_custom_resources_slide_website_final_resource_part3

.. code-block:: ruby

   property :instance_name, String, name_property: true
   property :port, Fixnum, required: true
   
   action :create do
     package 'httpd' do
       action :install
     end
   
     template "/lib/systemd/system/httpd-#{instance_name}.service" do
       source 'httpd.service.erb'
       variables(
         :instance_name => instance_name
       )
       owner 'root'
       group 'root'
       mode '0644'
       action :create
     end

     template "/etc/httpd/conf/httpd-#{instance_name}.conf" do
       source 'httpd.conf.erb'
       variables(
         :instance_name => instance_name,
         :port => port
       )
       owner 'root'
       group 'root'
       mode '0644'
       action :create
     end
   
     directory "/var/www/vhosts/#{instance_name}" do
       recursive true
       owner 'root'
       group 'root'
       mode '0755'
       action :create
     end
   
     service "httpd-#{instance_name}" do
       action [:enable, :start]
     end
       
   end

Final Cookbook Directory
-----------------------------------------------------
.. include:: ../../includes_custom_resources/includes_custom_resources_slide_website_final_cookbook_directory.rst

Recipe
-----------------------------------------------------
.. include:: ../../includes_custom_resources/includes_custom_resources_slide_website_recipe.rst

Custom Resource DSL
=====================================================
The following sections describe additional Custom Resource DSL methods that were not used in the preceding scenario:

converge_if_changed
-----------------------------------------------------
.. include:: ../../includes_dsl_custom_resource/includes_dsl_custom_resource_method_converge_if_changed.rst

Multiple Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_custom_resource/includes_dsl_custom_resource_method_converge_if_changed_multiple.rst

default_action
-----------------------------------------------------
.. include:: ../../includes_dsl_custom_resource/includes_dsl_custom_resource_method_default_action.rst

load_current_value
-----------------------------------------------------
.. include:: ../../includes_dsl_custom_resource/includes_dsl_custom_resource_method_load_current_value.rst

new_resource.property
-----------------------------------------------------
.. include:: ../../includes_dsl_custom_resource/includes_dsl_custom_resource_method_new_resource.rst

property
-----------------------------------------------------
.. include:: ../../includes_dsl_custom_resource/includes_dsl_custom_resource_method_property.rst

desired_state
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_custom_resource/includes_dsl_custom_resource_method_property_desired_state.rst

identity
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_custom_resource/includes_dsl_custom_resource_method_property_identity.rst

Block Arguments
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_custom_resource/includes_dsl_custom_resource_method_property_block_argument.rst

property_is_set?
-----------------------------------------------------
.. include:: ../../includes_dsl_custom_resource/includes_dsl_custom_resource_method_property_is_set.rst

provides
-----------------------------------------------------
.. include:: ../../includes_dsl_custom_resource/includes_dsl_custom_resource_method_provides.rst

override
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_custom_resource/includes_dsl_custom_resource_method_provides_override.rst

reset_property
-----------------------------------------------------
.. include:: ../../includes_dsl_custom_resource/includes_dsl_custom_resource_method_reset_property.rst
