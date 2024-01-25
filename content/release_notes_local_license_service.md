+++
title = "Chef Local License Service Release Notes"
draft = false
product = []

[menu]
  [menu.release_notes]
    title = "Chef Local License Service"
    identifier = "release_notes/Chef Local License Service"
    parent = "release_notes"
    weight = 80
+++

Chef Local License Service provides license keys to commercially licensed Chef software in an online or air-gapped environment.
You load license key data on Local License Service and then specify the Local License Service URL or IP address to each instance of a Chef application, then the application connects with Local License Service and retrieves a license key each time it runs automatically.

For large or isolated (airgapped) fleets, Chef Local License Service has several benefits:

- End users don't need to know the license keys for the Chef products they're using, only the Local License Service URL.
- You can control network communications to the internet as Local License Service is designed to work in isolation with Chef products.
- You don't have to manage secrets on each node that a Chef application is installed on.
- The Local License Service URL changes less frequently than a license key.
- You can scale Chef Local License Service to match your workload.

See the [Chef Local License Service documentation](/licensing/local_license_service/) for more information.

## 0.1.0

### Features

Chef Local License Service has four API endpoints that you can use to manage licenses.

#### /v1/listLicenses

The `/v1/listLicenses` endpoint lists all licenses present on Chef Local Licensing Service.

#### /v1/loadLicense

The `/v1/loadLicense` endpoint loads a single license by passing in a license key. This endpoint isn't available in airgapped environments.

#### /v1/syncAllLicenses

The `/v1/syncAllLicenses` endpoint syncs the license data from the local License datastore to Chef's licensing server. This endpoint isn't available in airgapped environments.

#### /v1/uploadLicense

The `/v1/uploadLicense` endpoint uploads a license.
