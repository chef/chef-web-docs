+++
title = "{{ .Name | humanize | title | replaceRE `\s` ""  }}"
draft = false

layout = "cookstyle_cops"
data_path = ["cookstyle","{{ .Name }}"]

[menu]
  [menu.workstation]
    title = "{{ .Name | humanize | title | replaceRE `\s` "" }}"
    identifier = "chef_workstation/chef_workstation_tools/cookstyle/{{ .Name | humanize | title | replaceRE `\s` ""  }}"
    parent = "chef_workstation/chef_workstation_tools/cookstyle"
+++

<!-- The contents of this page are automatically generated from the {{ .Name }}.yaml file
in the docs-chef-io/data/cookstyle directory in the chef/cookstyle repository. -->
