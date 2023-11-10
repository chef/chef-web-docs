+++
title = "Chef Local License Service Overview"
draft = false
gh_repo = "license-service"

[menu]
  [menu.overview]
    title = "Overview"
    identifier = "overview/licensing/local/overview"
    parent = "overview/licensing/local"
    weight = 1
+++

Chef Local License Service provides license keys to commercially licensed Chef software in an online or air-gapped environment.
Local License Service doesn't grant licenses, it stores and shares the licenses that a customer has already obtained.
You load license key data on Local License Service and then specify the Local License Service URL or IP address to each instance of a Chef application, then the application automatically connects with Local License Service and retrieves a license key each time it runs.

For large or isolated (airgapped) fleets, Chef Local License Service has several benefits:

- End users don't need to know the license keys for the Chef products they're using, only the Local License Service URL.
- You can control network communications to the internet as Local License Service is designed to work in isolation with Chef products.
- You don't have to manage secrets on each node that a Chef application is installed on.
- The Local License Service URL changes less frequently than a license key.
- You can scale Chef Local License Service to match your workload.

## How Chef Local License Service works

After installing Local License Service and uploading licensing data, users can configure Chef applications to retrieve licenses from a Local License Service URL or IP address.
Chef applications cache license keys that they've received from Local License Service while they're running and must reconnect to Local License Service to retrieve a license key when they restart.
Local License Service can automatically synchronize commercial licenses from Chef's licensing server (assuming the service has internet connectivity).

## Get Chef Local License Service

Contact [Chef Support](https://community.progress.com/s/products/chef) to gain access to the deployment binaries for this service.
