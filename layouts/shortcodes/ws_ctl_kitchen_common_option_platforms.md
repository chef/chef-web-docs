For example, if a kitchen.yml file contains the following:

``` javascript
- name: centos-7
- name: centos-8
- name: fedora-latest
- name: ubuntu-2004
- name: ubuntu-2004
```

then a regular expression like `(04|7)` would run Test Kitchen against
`centos-7`, `ubuntu-2004`, and `ubuntu-2004`. A regular expression like
`(ubuntu)` would run Test Kitchen against `ubuntu-2004` and
`ubuntu-2004`. A regular expression like `(fedora)` would run Test
Kitchen against only `fedora-latest`. Default: `all`.
