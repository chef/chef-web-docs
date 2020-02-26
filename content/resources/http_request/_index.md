---
title: http_request resource
resource: http_request
draft: false
aliases:
- /resource_http_request.html
menu:
  docs:
    title: http_request
    identifier: chef_infra/cookbook_reference/resources/http_request http_request
    parent: chef_infra/cookbook_reference/resources
    weight: 580
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **http_request** resource to send an HTTP request (`GET`,

    `PUT`, `POST`, `DELETE`, `HEAD`, or `OPTIONS`) with an arbitrary

    message. This resource is often useful when custom callbacks are

    necessary.'
resource_new_in: null
handler_types: false
syntax_description: "A **http_request** resource block sends HTTP requests with an\
  \ arbitrary\nmessage. For example, send a `DELETE` request to\n`'http://www.chef.io/some_page?message=please_delete_me'`.\n\
  \n``` ruby\nhttp_request 'please_delete_me' do\n  url 'http://www.chef.io/some_page'\n\
  \  action :delete\nend\n```"
syntax_code_block: null
syntax_properties_list: null
syntax_full_code_block: "http_request 'name' do\n  headers                    Hash\n\
  \  message                    Object # defaults to 'name' if not specified\n  url\
  \                        String\n  action                     Symbol # defaults\
  \ to :get if not specified\nend"
syntax_full_properties_list:
- '`http_request` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`headers`, `message`, and `url` are properties of this resource, with the Ruby
  type shown. See "Properties" section below for more information about all of the
  properties that may be used with this resource.'
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :delete:
    markdown: Send a `DELETE` request.
  :get:
    markdown: "Default. Send a `GET` request.\n Changed in Chef Client 12.0 to deprecate\
      \ the hard-coded query string from earlier versions. Cookbooks that rely on\
      \ this string need to be updated to manually add it to the URL as it is passed\
      \ to the resource."
  :head:
    markdown: Send a `HEAD` request.
  :nothing:
    shortcode: resources_common_actions_nothing.md
  :options:
    markdown: Send an `OPTIONS` request.
  :post:
    markdown: Send a `POST` request.
  :put:
    markdown: Send a `PUT` request.
properties_list:
- property: headers
  ruby_type: Hash
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: A Hash of custom headers.
- property: message
  ruby_type: Object
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The message that is sent by the HTTP request. Default value: the

      `name` of the resource block. See "Syntax" section above for more

      information.'
- property: url
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The URL to which an HTTP request is sent.
properties_shortcode: null
properties_multiple_packages: false
resource_directory_recursive_directories: false
resources_common_atomic_update: false
properties_resources_common_windows_security: false
remote_file_prevent_re_downloads: false
remote_file_unc_path: false
ps_credential_helper: false
ruby_style_basics_chef_log: false
debug_recipes_chef_shell: false
template_requirements: false
resources_common_properties: true
resources_common_notification: true
resources_common_guards: true
common_resource_functionality_multiple_packages: false
resources_common_guard_interpreter: false
remote_directory_recursive_directories: false
common_resource_functionality_resources_common_windows_security: false
handler_custom: false
cookbook_file_specificity: false
unit_file_verification: false
examples_list:
- example_heading: Send a GET request
  text_blocks:
  - code_block: "http_request 'some_message' do\n  url 'http://example.com/check_in'\n\
      end"
  - markdown: 'The message is sent as

      `http://example.com/check_in?message=some_message`.'
- example_heading: Send a POST request
  text_blocks:
  - markdown: 'To send a `POST` request as JSON data, convert the message to JSON
      and

      include the correct content-type header. For example:'
  - code_block: "http_request 'posting data' do\n  action :post\n  url 'http://example.com/check_in'\n\
      \  message ({:some => 'data'}.to_json)\n  headers({'AUTHORIZATION' => \"Basic\
      \ #{\n    Base64.encode64('username:password')}\",\n    'Content-Type' => 'application/data'\n\
      \  })\nend"
- example_heading: Transfer a file only when the remote source changes
  text_blocks:
  - shortcode: resource_remote_file_transfer_remote_source_changes.md

---
