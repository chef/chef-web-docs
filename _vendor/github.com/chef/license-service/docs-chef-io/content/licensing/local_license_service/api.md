+++
title = "Chef Local License Service API"
draft = false
gh_repo = "license-service"

[menu]
  [menu.overview]
    title = "API"
    identifier = "overview/licensing/local/API"
    parent = "overview/licensing/local"
+++

This document describes the Chef Local License Service API endpoints that manage license data.

## /v1/listLicenses

The `/v1/listLicenses` endpoint has the following methods: `GET`.

### GET

The `GET` method lists all the licenses present within Chef Local License Service.

#### Response codes

| Response Code | Description |
|---------------|-------------|
| 200           | Success.    |
| 400           | Error.      |

#### Examples

```sh
curl --location --request GET 'http://<IP_ADDRESS>:8000/v1/listLicenses'
```

## /v1/loadLicense

The `/v1/loadLicense` endpoint has the following methods: `POST`.

This endpoint isn't available in airgapped environments.

### POST

The `POST` method loads license data for a single license by passing in a license ID.

#### Response codes

| Response Code | Description |
|---------------|-------------|
| 200           | Success.    |
| 400           | Error.      |

#### Examples

```sh
curl --location --request POST 'http://<IP_ADDRESS>:8000/v1/loadLicense' -d '{"LicenseId " : "<LICENSE_ID>" }'
```

## /v1/syncAllLicenses

The `/v1/syncAllLicenses` endpoint has the following methods: `GET`.

This endpoint isn't available in airgapped environments.

### GET

The `GET` method syncs licenses between Chef Local License Service and Chef's licensing server.

#### Response codes

| Response Code | Description |
|---------------|-------------|
| 200           | Success.    |
| 400           | Error.      |

#### Examples

```sh
curl --location --request GET 'http://<IP_ADDRESS>:8000/v1/syncAllLicenses'
```

## /v1/uploadLicense

The `/v1/uploadLicense` endpoint has the following methods: `POST`.

### POST

The `POST` method uploads license data.

with a request body similar to:

```json
{
  "id": "LICENSE_ID",
  "version": "2",
  "type": "LICENSE_TYPE",
  "generator": "chef/license-(devel)",
  "generatedOnDateUTC": "2023-03-28T10:50:58Z",
  "refreshLastDateUTC": "2023-03-28T10:50:58Z",
  "refreshNextDateUTC": "2033-03-28T10:50:58Z",
  "customer": "FIRST LAST",
  "customerId": "user@example.com",
  "customerVersion": "1",
  "bundle": "",
  "evidence": {
    "generated": "1680000658",
    "key_sha256": "256_SHA_STRING",
    "hash": "HASH_STRING"
  },
  "services": null,
  "features": [
    {
      "name": "Inspec-Parallel",
      "id": "c891f0fa-fa71-8b98-b694-7b5462595f35"
    }
  ],
  "asset": null,
  "entitlements": [
    {
      "name": "APPLICATION",
      "id": "APPLICATION_ID_STRING",
      "measure": "node",
      "limit": 1,
      "grace": {
        "limit": 0,
        "duration": 0
      },
      "period": {
        "start": "2023-03-28",
        "end": "2033-03-28"
      }
    }
  ]
}
```

#### Response codes

| Response Code | Description |
|---------------|-------------|
| 200           | Success.    |
| 400           | Error.      |

#### Examples

Upload license data in a data file:

```sh
curl --location --request POST 'http://<IP_ADDRESS>:8000/v1/uploadLicense' --header 'Content-Type: application/json' -d @LICENSE_FILENAME.json
```

Upload license data as a string:

```sh
curl --location --request POST 'http://<IP_ADDRESS>:8000/v1/uploadLicense' --header 'Content-Type: application/json' -d "<LICENSE_DATA_STRING>"
```
