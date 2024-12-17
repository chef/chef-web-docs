+++
title = "About Templates"
draft = false

gh_repo = "chef-web-docs"

aliases = ["/templates.html", "essentials_cookbook_templates.html"]

[menu]
  [menu.infra]
    title = "Templates"
    identifier = "chef_infra/cookbook_reference/templates.md Templates"
    parent = "chef_infra/cookbook_reference"
    weight = 100
+++

{{< readfile file="content/reusable/md/template.md" >}}

The `templates` directory doesn't exist by default in a cookbook.
Generate the `templates` directory and a template file from the `chef-repo/cookbooks` directory with the command:

```bash
chef generate template PATH_TO_COOKBOOK TEMPLATE_NAME
```

For example, this command generates a `httpd` template in the `custom_web` cookbook:

```bash
chef generate template cookbooks/custom_web httpd
```

The `custom_web` cookbook directory with a template has the structure:

```text
. cookbooks
├── README.md
└── custom_web
    ├── CHANGELOG.md
    ├── LICENSE
    ├── Policyfile.rb
    ├── README.md
    ├── chefignore
    ├── compliance
    │   ├── README.md
    │   ├── inputs
    │   ├── profiles
    │   └── waivers
    ├── kitchen.yml
    ├── metadata.rb
    ├── recipes
    │   └── default.rb
    ├── templates
    │   └── httpd.erb
    └── test
        └── integration
            └── default
                └── default_test.rb
```

## Requirements

{{< readfile file="content/reusable/md/template_requirements.md" >}}

## Variables

{{< readfile file="content/reusable/md/template_variables.md" >}}

## File Specificity

{{< readfile file="content/reusable/md/template_specificity.md" >}}

{{< readfile file="content/reusable/md/template_specificity_pattern.md" >}}

{{< readfile file="content/reusable/md/template_specificity_example.md" >}}

## Host Notation

{{< readfile file="content/reusable/md/template_host_notation.md" >}}

## Transfer Frequency

{{< readfile file="content/reusable/md/template_transfer_frequency.md" >}}

## Partial Templates

{{< readfile file="content/reusable/md/template_partials.md" >}}

### variables Attribute

{{< readfile file="content/reusable/md/template_partials_variables_attribute.md" >}}

### render Method

{{< readfile file="content/reusable/md/template_partials_render_method.md" >}}
