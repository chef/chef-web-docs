+++
title = "Deprecation: Removal of support for Ohai version 6 plugins (OHAI-10)"
draft = false

gh_repo = "chef-web-docs"
robots = "noindex"
sitemapExclude = true
aliases = "/deprecations_ohai_v6_plugins.html"
+++

Ohai 7.0 released with Chef Infra Client 11.12 introduced an improved plugin
DSL model. At the time we introduced deprecations for the existing
plugin DSL, which we referred to as V6 plugins. In Ohai/Chef Infra Client 14
we will remove the support for Ohai V6 plugins, causing a runtime error
if they're used.

## Remediation

If you have custom Ohai V6 plugins installed using cookbook or bootstrap
you will need to update these plugins to the Ohai V7 plugin format.

See the [Ohai Custom Plugins page](/ohai_custom/) for additional
information on writing V7 plugins.
