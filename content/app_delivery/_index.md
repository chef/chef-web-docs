+++
title = "Chef Application Delivery"
description = "Deliver applications at scale with Chef App Delivery"
draft = false

[menu]
  [menu.app_delivery]
    title = "App Delivery"
    identifier = "app_delivery/index.md App Delivery"
    parent = "app_delivery"
    weight = 10
+++

[\[edit on GitHub\]](https://github.com/chef/chef-web-docs/blob/master/content/app_delivery/app_delivery.md)

## Chef App Delivery

Chef App Delivery combines the power of open source community based software development and enterprise class support.

|Chef Habitat|Chef Infra|Chef Automate|Chef Enterprise Distributions|Chef Community|
|---------------|---------------|---------------|---------------|---------------|
Developer friendly open source automation solution for defining, packaging, and delivering apps to almost any environment [Learn More](https://community.chef.io/products/chef-habitat/)|Powerful open source solution that transforms infrastructure into code and automates how infrastructure is configured, deployed, and managed across environments [Learn More](https://community.chef.io/products/chef-infra/)|Enterprise dashboard and analytics tool that enabeling cross-team collaboration with actionable insights for configuration and compliance across environments. [Learn More](https://community.chef.io/products/chef-automate/)|Dedicated services that include trusted, hardened, and production-ready software distributions, support, expert help,  training, reporting and much more.
[Learn More](https://www.chef.io/why-chef-enterprise) | Hundreds of pre-defined configuration templates built and maintained by the Chef Community.[Learn More](https://community.chef.io/) |

### More About Chef App Delivery

- Webinar: [Chef and Jenkins: Better Together](https://pages.chef.io/202007-Webinar-ChefJenkinsBetterTogether_01Register.html)
- ChefConf 2020: [At The Edge: App Configuration and Deployment as Code - A PaneraBread Cafe Automation Story](https://community.chef.io/resources/posts/at-the-edge-app-configuration-and-deployment-as-code)
- White Paper: [Automated Application Rollback Insurance for Release Teams](https://www.chef.io/wp-content/uploads/2020/09/Automated-Application-Rollback-Insurance-for-Release-Teams_White-Paper.pdf)

Chef App Delivery is an automation solution that enables companies to apply a technology agnostic and modular approach to defining, packaging and delivering application and infrastructure across on-prem, hybrid and cloud environments. Chef App Delivery frees DevOps teams from technical debt and antiquated processes, enabling them to deliver successful business outcomes across their entire IT estate.

Chef enables supporting app teams to:

- Overcome cultural challenges with the adoption of agile delivery practices that scale across development, operations and security.
- Deal with increasing complexity caused by the adoption of cloud-native architectures that add to the rising sea of dependencies while supporting existing systems.
- Leverage existing investments in existing Chef software configuration assets and other DevOps tools while accelerating the adoption of modern application architectures and delivery methods.

### Chef App Delivery Benefits

| Increase Productivity | Eliminate Defects Earlier and Deploy Faster | Reduce Operational Overhead|
|---------------|---------------|---------------|
|Save thousands of hours configuring, updating dependencies, versioning, testing and remediating apps across Dev, QA and Ops| Shift defect resolution from run-time to build-time and deploy to production up to 90% faster.| Shift defect resolution from run-time to build-time and deploy to production up to 90% faster.|

## Where Chef Fits in Continuous Delivery

Most organizations already have a source control, build server, and technology provisioning process. Chef doesn't replace these tools but makes them easier to manage, scale and validate. Chef creates universal, compliant artifacts that can be consumed by any pipeline automation tool, deployed to almost any environment and validated in real-time.

Chef Continuous Delivery Framework

![Continuous Delivery](continuous-delivery-puzzle.png)


## Chef App Delivery a Step Beyond Software Configuration and Packaging

Chef App Delivery is the evolution of Chef's software configuration capabilities and redefines the way applications are delivered. While traditional code-based configuration solutions are good for managing infrastructure-as-code they are not well suited for managing service architecture applications with many dependencies that are updated frequently and require quick actions like stop/start/restart.

Chef App Delivery takes a modular approach to configuration working down the stack as far as needed to package all of the components needed to run an application into a single immutable artifact. Each dependency has a plan of its own, maintained by its respective owner. Plans are stored in a single repository where they can be easily searched, shared, updated, customized, and versioned.

Once a plan is defined, the magic of Chef App delivery takes over. When an app is built, the resulting artifact contains metadata pointers for its full dependency chain. This ensures that the artifact a developer tests on their laptop remains consistent with the ones running in production, regardless of provider or platform.

With this type of detail updating, maintaining and auditing apps in production is significantly simplified.

## One App Delivery Solution. Multiple Beneficiaries

Chef App Delivery enables IT teams to overcome cultural barriers and improve the way teams work together to build, deploy and manage applications.

|Developer Productivity|Operational Consistency|Quality and Efficiency|Release Velocity|
|----------|----------|----------|----------|
| Developers get to use the technologies they are most comfortable with, while giving them on-demand access to DevTest environments and the ability to promote releases themselves.| Operations get codified tested, ready-to-go, compliant, artifacts that are consistently defined and built alongside the app and can be easily integrated with other DevOps tools. |QA teams no longer have to wait for environments to start testing and can receive updates when changes are made to supporting systems and see what apps are impacted.|Release teams no longer have to understand each aspect of the app. They can manage deployments across  environments at scale and see results in real time.|

## Codified & Consistent Windows Application Delivery Automation

Chef App Delivery is especially well suited for managing complex applications on Windows. Operating system level configuration concerns such as domains, firewalls and others can be managed with Chef Infra, while Chef Habitat handles the build and deployment of your applications
itself. Together with Chef InSpec you can guarantee that your application has been delivered safely and securely

## Chef App Delivery Core Features

![Application Delivery](zone123.png)

### Better Apps Start with Better Definitions

[Application definition](https://blog.chef.io/what-is-application-definition/) is the process of creating a codified operational runbook. Chef App Delivery explicitly models, defines and isolates dependencies as code and stores them in a common codebase along with the application binaries. By identifying and defining everything an application needs to be built, run and maintained as part of the development phase, failure identification is shifted-left from run-time to build-time.

### Universal Packaging and Cataloging

Application packaging continues to be one of the most ad-hoc managed processes in IT. Chef App Delivery provides a universal specification for packaging and running distributed applications. It enables application delivery teams to standardize the way the application is packaged regardless of the underpinning technology or runtime environment. Once a package is defined it is published as a signed, compressed, versioned artifact that includes everything defined in the manifest. Published artifacts are stored in a single-origin that can not be accessed by humans giving them immutability.

### Multi-Environment and Multi-Channel Management

Having a unified approach to packaging greatly simplifies CI/CD processes. Artifacts can be exported to run in a variety of runtimes with zero refactoring or rewriting. Release and security teams can quickly view the content of artifacts by reviewing the package contents via a GUI based UI. Using the same UI release teams can promote packages to different channels, set-up deployment patterns and even automatically roll-back a deployment when needed. Throughout the release process applications stream data to Chef Automate providing real-time visibility into an application's current running state, health, and version.

### Real-Time Data and Actionable Insights

Organizations must be able to not only deliver application updates quickly, but also validate that every instance of the application was successfully updated. Chef Dashboards track the status of applications holistically across all environments. With a click of the mouse, interested parties can see what applications have been updated, what the status is, where there are failures and determine whether they need to perform an automated roll-back or remediate and roll-forward.

### Modernize Any Application with Advanced Run-time Capabilities

Chef allows legacy apps to be in the same way cloud-native apps are eliminating dependencies on operating systems and middleware. The Chef Habitat Supervisor is a light-weight, intelligent agent that runs on/in a server, virtual machine, or container and manages the application according to the instructions defined in the Habitat Plan. Lifecycle hooks are used to program the supervisor for advanced capabilities including dynamic service bindings, clustering topologies, service discovery, health status and many other capabilities – this enables DevOps teams to apply the same modern application management best practices they use for cloud-native applications to all of their applications.

