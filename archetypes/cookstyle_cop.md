+++
{{- $yaml_file := delimit (slice "cops_"  (.Name | lower)) "" -}}
{{- $yaml_data := index $.Site.Data "cookstyle" -}}
{{- $yaml_data := index $yaml_data (print $yaml_file) }}
title = "{{$yaml_data.short_name}}"
draft = false

layout = "cookstyle_cops"
data_path = ["cookstyle","cops_{{ .Name | lower }}"]

+++

<!-- The content of this page is automatically generated from the
cops_{{ .Name | lower }}.yml file in github.com/chef/cookstyle/blob/main/docs-chef-io/data/cookstyle/. -->
