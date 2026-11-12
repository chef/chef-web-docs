+++
title = "About Chef InSpec"
draft = false
linkTitle = "InSpec"

[cascade]
  breadcrumbs = true
  [cascade.params]
    swiftype_search_products = ["inspec-7.3"]
    version_selector_product = "inspec"
    version_selector = true
    this_version_text = "Chef InSpec 7.3"
    section_root = "/inspec/7.3"
    menu_id = "inspec_7_3"
    breadcrumbs = true
    st_robots = ''

[menu.inspec_7_3]
    title = "About Chef InSpec"
    identifier = "about"
    weight = 10
+++

Chef InSpec is an open-source framework for testing and auditing your applications and infrastructure.
It compares the actual state of your system with the desired state that you express in easy-to-read and easy-to-write Chef InSpec code.
It detects violations and displays findings in the form of a report, but puts you in control of remediation.

Chef InSpec is a run-time framework and rule language used to specify compliance, security, and policy requirements.
It includes a collection of resources that help you write auditing controls quickly and easily.

## How does Chef InSpec work?

Chef InSpec uses profiles to audit infrastructure. An [InSpec profile](/inspec/7.3/profiles/) organizes multiple controls into a reusable artifact.
You can describe your profiles with metadata, version them, pin them to specific versions of InSpec, define specific platforms that a profile can test, and define profile dependencies.

A control defines a regulatory recommendation or requirement for the state of a system. Each profile can have many controls and each control audits different aspects of a system.

Chef InSpec resources allow you to test specific parts of your infrastructure.
Chef InSpec has [resources](/inspec/7.3/resources/) for testing different applications and platforms, including AWS, Azure, AliCloud, and GCP cloud infrastructure, and you can create your own [custom resources](/inspec/7.3/profiles/custom_resources) if we don't have a resource that meets your needs.

[InSpec reporters](/inspec/7.3/configure/reporters/) format and deliver the results of an InSpec audit run.
You can output results to the standard output; to text formats like JSON, HTML, or plain text; or send the results directly to [Chef Automate](/automate/).

## Use cases

Run your tests wherever your infrastructure is---locally or in the cloud.
Chef InSpec is designed for platforms and treats operating systems as special cases.
Chef InSpec helps you, whether you use Windows Server on your own hardware or
run Linux in Docker containers in the cloud. As for the cloud, you can use Chef
InSpec to target applications and services running on Alibaba, AWS, Azure, and GCP.

## Additional Resources

### Open-source profiles

The InSpec community created several open-source profiles that are free to use.
Use the `inspec supermarket profiles` command to list the available profiles, or view them in [Chef Supermarket](https://supermarket.chef.io/tools?q=&type=compliance_profile). This includes the [DevSec Hardening Framework](https://dev-sec.io/), a set of server hardening profiles.

### Premium profiles

Chef offers [premium CIS- and STIG-based profiles](https://www.chef.io/products/chef-premium-content) for compliance scanning across a range of enterprise assets.

### Learning

- [Chef Training](https://www.chef.io/training)
- [Chef InSpec webinars](https://www.chef.io/webinars?products=chef-inspec&page=1)
- [Chef Resource Library](https://www.chef.io/resources?products=chef-inspec&page=1)

### Community

- [Chef InSpec on Discourse](https://discourse.chef.io/c/inspec/10)
- [Chef InSpec in the Chef Blog](https://www.chef.io/blog/category/chef-inspec)
- [Chef InSpec Community Resources](https://community.chef.io/tools/chef-inspec)

### Support

- [Chef Support](https://www.chef.io/support)
- [Chef Help Center](https://community.progress.com/s/products/chef)

### GitHub repositories

- [inspec GitHub organization](https://github.com/inspec)
- [inspec repository](https://github.com/inspec/inspec/)
- [inspec-alicloud repository](https://github.com/inspec/inspec-alicloud/)
- [inspec-aws repository](https://github.com/inspec/inspec-aws/)
- [inspec-azure](https://github.com/inspec/inspec-azure/)
- [inspec-gcp repository](https://github.com/inspec/inspec-gcp/)
- [inspec-k8s repository](https://github.com/inspec/inspec-k8s/)
- [inspec train repository](https://github.com/inspec/train)
