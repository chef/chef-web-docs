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

{{% chef_generate_template %}}

## Requirements

{{< readFile_shortcode file="template_requirements.md" >}}

## Variables

{{< readFile_shortcode file="template_variables.md" >}}

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

{{< readFile_shortcode file="template_partials_variables_attribute.md" >}}

### render Method

{{< readFile_shortcode file = "template_partials_render_method.md" >}}
