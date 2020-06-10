+++
title = "{{ or (replace .Name "_" " ") (replace .Name "-" " ")  | title }}"
draft = false

[menu]
  [menu.desktop]
    title = "{{ replace .Name "-" " " | title }}"
    identifier = "chef_desktop/{{ .Name }}.md {{ or (replace .Name "_" " ") (replace .Name "-" " ") | title }}"
    parent = "chef_desktop"
    weight = 10
+++

[\[edit on GitHub\]](https://github.com/chef/desktop-config/blob/master/docs/content/desktop/{{ .Name }}.md)
