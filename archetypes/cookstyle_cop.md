+++
title = "{{ .Name | replaceRE `Chef_` `Chef/` | replaceRE `_` ` ` }}"
draft = false

layout = "cookstyle_cops"
data_path = ["cookstyle","cops_{{ .Name | lower }}"]

+++

<!-- The content of this page is automatically generated from the
cops_{{ .Name | lower }}.yml file in github.com/chef/cookstyle/blob/master/docs-chef-io/data/cookstyle/. -->
