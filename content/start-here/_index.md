+++
title = "How to use Chef Docs"
draft = false
st_robots = "noindex, follow"
toc = false
+++

## Coming soon

## Four navigation layers

**Layer 1—I want to&hellip;** Goal/task-based discovery. Best for everyone, especially new users who don't yet know which product owns their problem.

**Layer 2—[The Chef Way](/chef-way/)** Recommended, opinionated practices. Best for practitioners and architects who want the "right" way, not just a list of options.

**Layer 3—Products** Product-specific navigation, organized by version. Best for experienced users who already know what they're using.

**Layer 4—Reference** Exhaustive technical lookup—CLI, resources, APIs, configuration. Best for experts who know exactly what they need.

## How Chef Docs is organized

The left navigation groups everything into five kinds of thing. Knowing which kind you're looking at tells you what to expect:

- **Start here**—orientation. What Chef is, how these docs work, and how to choose.
- **Products**—things you install, run, and version, such as Chef Infra Client, Chef InSpec, and Chef 360 Platform. Each has its own releases and supported versions.
- **Solutions**—recommended ways to combine products to reach an outcome. [Chef Desktop](/desktop/) and the [Effortless Pattern](/effortless/) are solutions: they're not separate things to install instead of the products, they're patterns for using several products together.
- **Resources**—supporting material that isn't tied to one product, such as licensing, supported platforms, downloads, and release notes.
- **Archive**—material kept for reference that isn't recommended for new work.

Two more terms appear throughout the documentation:

- A **capability** is something a product does, such as cookbooks, Policyfiles, or compliance scanning. Capabilities live inside a product's documentation rather than beside it.
- A **deployment model** is how you run a product—self-hosted or SaaS. It's a property of a product, not a separate product. Chef 360 SaaS and Chef SaaS are deployment models, so you'll find them with the products they deploy.

Product lifecycle status is recorded on the [supported versions](/versions/) page. Products marked **Deprecated** in the navigation are still documented, but check that page before starting new work with them.

## Find your door

{{% chef_way label="way" %}}
**New to Chef?** Start with [Chef fundamentals](/platform_overview/) and get your first environment working before diving into a specific product.
{{% /chef_way %}}

- **If you know the outcome you want**—for example, "scan for compliance," "bootstrap a node," or "package an app"—use each product's Getting Started guide.
- **If you know the product**—go straight to that product's version-specific docs in the left sidebar.
- **If you need a command, resource, or API**—use each product's Reference section.
- **If you're stuck**—check each product's Troubleshooting page.
- **If you're upgrading or migrating**—see [supported versions](/versions/) and each product's upgrade guide.
- **If you want Chef's recommended approach**—see [The Chef Way](/chef-way/).
