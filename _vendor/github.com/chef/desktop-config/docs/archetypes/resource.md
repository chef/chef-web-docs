+++
title = "{{ or (replace .Name "_" " ") (replace .Name "-" " ")  | title }}"
draft = false
desktop_resource = "{{ .Name }}"

[menu]
  [menu.desktop]
    title = "{{ replace .Name "-" " " }}"
    identifier = "desktop/resources/{{ .Name }}.md {{ or (replace .Name "_" " ") (replace .Name "-" " ") | title }}"
    parent = "desktop/resources"
+++

{{< desktop_resource_yaml >}}
