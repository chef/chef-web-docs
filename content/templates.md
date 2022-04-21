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

{{% template %}}

The `templates` directory does not exist by default in a cookbook.
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
 - custom_web
   - recipes
     - default.rb
   - templates
     - http.erb
   - test
     - integration
        -  default
           -  default_test.rb
   - .gitignore
   - CHANGELOG.md
   - chefignore
   - kitchen.yml
   - LICENSE
   - metadata.rb
   - Policyfile.rb
   - README.md
```

## Requirements

{{% template_requirements %}}

## Variables

{{% template_variables %}}

## File Specificity

{{% template_specificity %}}

{{% template_specificity_pattern %}}

{{% template_specificity_example %}}

## Host Notation

{{% template_host_notation %}}

## Transfer Frequency

{{% template_transfer_frequency %}}

## Partial Templates

{{% template_partials %}}

### variables Attribute

{{% template_partials_variables_attribute %}}

### render Method

{{% template_partials_render_method %}}
