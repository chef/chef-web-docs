---
title: apt_repository resource
resource: apt_repository
draft: false
aliases:
- /resource_apt_repository.html
menu:
  infra:
    title: apt_repository
    identifier: chef_infra/cookbook_reference/resources/apt_repository apt_repository
    parent: chef_infra/cookbook_reference/resources
    weight: 90
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **apt_repository** resource to specify additional APT

    repositories. Adding a new repository will update the APT package cache

    immediately.'
resource_new_in: null
handler_types: false
syntax_description: "An **apt_repository** resource specifies APT repository information\
  \ and\nadds an additional APT repository to the existing list of repositories:\n\
  \n``` ruby\napt_repository 'nginx' do\n  uri        'http://nginx.org/packages/ubuntu/'\n\
  \  components ['nginx']\nend\n```"
syntax_code_block: null
syntax_properties_list:
- '`apt_repository` is the resource'
- '`name` is the name of the APT repository, or the name of the resource block. Must
  not contain spaces.'
- '`uri` is a base URI for the distribution where the APT packages are located at'
- '`components` is an array of package groupings in the repository'
syntax_full_code_block: "apt_repository 'name' do\n  arch               String, false\n\
  \  cache_rebuild      true, false # default value: true\n  components         Array\n\
  \  cookbook           String, false\n  deb_src            true, false # default\
  \ value: false\n  distribution       String, false # default value: The LSB codename\
  \ of the host such as 'bionic'.\n  key                String, Array, false\n  key_proxy\
  \          String, false\n  keyserver          String, false # default value: \"\
  keyserver.ubuntu.com\"\n  repo_name          String # default value: 'name' unless\
  \ specified\n  trusted            true, false # default value: false\n  uri    \
  \            String\n  action             Symbol # defaults to :add if not specified\n\
  end"
syntax_full_properties_list:
- '`apt_repository` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`arch`, `cache_rebuild`, `components`, `cookbook`, `deb_src`, `distribution`, `key`,
  `key_proxy`, `keyserver`, `repo_name`, `trusted`, and `uri` are the properties available
  to this resource.'
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :add:
    markdown: Default. Creates a repository file at `/etc/apt/sources.list.d/` and
      builds the repository listing.
  :remove:
    markdown: Removes the repository listing.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: arch
  ruby_type: String, false
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Constrain packages to a particular CPU architecture such as `i386`

      or `amd64`.'
- property: cache_rebuild
  ruby_type: true, false
  required: false
  default_value: 'true'
  new_in: null
  description_list:
  - markdown: Determines whether to rebuild the APT package cache.
- property: components
  ruby_type: Array
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: Package groupings, such as 'main' and 'stable'.
- property: cookbook
  ruby_type: String, false
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'If key should be a cookbook_file, specify a cookbook where the key

      is located for files/default. Default value is nil, so it will use

      the cookbook where the resource is used.'
- property: deb_src
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: 'Determines whether or not to add the repository as a source repo as

      well.'
- property: distribution
  ruby_type: String, false
  required: false
  default_value: The LSB codename of the host such as 'bionic'.
  new_in: null
  description_list:
  - markdown: 'Usually a distribution''s codename, such as trusty, xenial or bionic.

      Default value: the codename of the node''s distro.'
- property: key
  ruby_type: String, Array, false
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'If a keyserver is provided, this is assumed to be the fingerprint;

      otherwise it can be either the URI of GPG key for the repo, or a

      cookbook_file.'
- property: key_proxy
  ruby_type: String, false
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: If set, a specified proxy is passed to GPG via `http-proxy=`.
- property: keyserver
  ruby_type: String, false
  required: false
  default_value: '"keyserver.ubuntu.com"'
  new_in: null
  description_list:
  - markdown: The GPG keyserver where the key for the repo should be retrieved.
- property: repo_name
  ruby_type: String
  required: false
  default_value: The resource block's name
  new_in: '14.1'
  description_list:
  - markdown: 'An optional property to set the repository name if it differs from

      the resource block''s name. The value of this setting must not

      contain spaces.'
- property: trusted
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: 'Determines whether you should treat all packages from this

      repository as authenticated regardless of signature.'
- property: uri
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The base of the Debian distribution.
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
- example_heading: Add repository with basic settings
  text_blocks:
  - code_block: "apt_repository 'nginx' do\n  uri        'http://nginx.org/packages/ubuntu/'\n\
      \  components ['nginx']\nend"
- example_heading: Enable Ubuntu multiverse repositories
  text_blocks:
  - code_block: "apt_repository 'security-ubuntu-multiverse' do\n  uri          'http://security.ubuntu.com/ubuntu'\n\
      \  distribution 'trusty-security'\n  components   ['multiverse']\n  deb_src\
      \      true\nend"
- example_heading: Add the Nginx PPA, autodetect the key and repository url
  text_blocks:
  - code_block: "apt_repository 'nginx-php' do\n  uri          'ppa:nginx/stable'\n\
      end"
- example_heading: 'Add the JuJu PPA, grab the key from the keyserver, and add source

    repo'
  text_blocks:
  - code_block: "apt_repository 'juju' do\n  uri 'http://ppa.launchpad.net/juju/stable/ubuntu'\n\
      \  components ['main']\n  distribution 'trusty'\n  key 'C8068B11'\n  keyserver\
      \ 'keyserver.ubuntu.com'\n  action :add\n  deb_src true\nend"
- example_heading: Add repository that requires multiple keys to authenticate packages
  text_blocks:
  - code_block: "apt_repository 'rundeck' do\n  uri 'https://dl.bintray.com/rundeck/rundeck-deb'\n\
      \  distribution '/'\n  key ['379CE192D401AB61', 'http://rundeck.org/keys/BUILD-GPG-KEY-Rundeck.org.key']\n\
      \  keyserver 'keyserver.ubuntu.com'\n  action :add\nend"
- example_heading: Add the Cloudera Repo of CDH4 packages for Ubuntu 12.04 on AMD64
  text_blocks:
  - code_block: "apt_repository 'cloudera' do\n  uri          'http://archive.cloudera.com/cdh4/ubuntu/precise/amd64/cdh'\n\
      \  arch         'amd64'\n  distribution 'precise-cdh4'\n  components   ['contrib']\n\
      \  key          'http://archive.cloudera.com/debian/archive.key'\nend"
- example_heading: Remove a repository from the list
  text_blocks:
  - code_block: "apt_repository 'zenoss' do\n  action :remove\nend"

---
