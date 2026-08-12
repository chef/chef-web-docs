+++
title = "Chef Download APIs release notes"
draft = false
linkTitle = "Chef Download APIs"
summary = "Chef Download APIs release notes"

[menu]
  [menu.release_notes]
    title = "Chef Download APIs"
    identifier = "release_notes/Chef Download APIs"
    parent = "release_notes"
    weight = 30
+++

## 2026-08-05

Chef Download Service URLs now include the artifact filename in generated download links, so you can more easily identify, cache, and manage downloaded binaries in your own systems. Existing download behavior for current API consumers doesn't change. For details, see the [file endpoint section in the Chef Commercial Download API documentation](https://docs.chef.io/download/commercial/#files).

## 2023-12-20

We deployed the [Chef Commercial Download API](/download/commercial/).
Commercial customers can use this API to download Chef software packages and retrieve metadata.

The Commercial Download API replaces the legacy Omnitruck API.
