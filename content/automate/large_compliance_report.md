+++
title = "Large Compliance Report Ingestion"

draft = false

[menu]
  [menu.automate]
    title = "Large Compliance Report Ingestion"
    parent = "automate/configure"
    identifier = "automate/configure/large_compliance_report.md Large Compliance Report Ingestion"
    weight = 70
+++

{{< note >}}

- Chef Automate version **4.2.x** and later support Large Compliance Report ingestion.
- This feature isn't available for Chef Automate High Availability (HA).

{{< /note >}}

Chef Automate fails to ingest compliance reports larger than 4 MB sent through the data collector endpoint. The Chef Automate data collector returns the error to the client.

The following architecture change enables Chef Automate to ingest reports larger than 4 MB.

![LCR Architecture](/images/automate/lcr_architecture.jpg)

With this configuration, Chef Automate allows ingestion of large compliance reports and sends data to OpenSearch and an externally deployed MinIO service. In this configuration, Chef Automate expects a MinIO server running outside the Chef Automate ecosystem.

With this configuration, Chef Automate can:

- Allow ingestion of compliance reports larger than 4MB,
- Exporting or downloading complete reports larger than 4MB in size.

This change affects Chef Automate data ingestion performance because:

- Chef Automate processes much more data than usual.
- Chef Automate uploads data to an external service over a network.

The impact depends on different factors like network configuration and machine configuration.
Here is a benchmark test summary report run on

- Instance Type: **16 vCPU, 30 GB memory**
- Number of Compliance Targets: **20K**
- You deploy **OpenSearch** and **PostgreSQL** internally

| Report Size | Supported Concurrency |
| --- | --- |
| 1 MB | 100 |
| 5 MB | 50 |
| 8 MB | 30 |
| 12 MB | 20 |

## Prerequisites

{{< note >}} Chef Automate installation doesn't include a MinIO server. {{< /note >}}

- An external MinIO server that Chef Automate can connect to

### MinIO

MinIO is a high-performance object storage system released under the GNU Affero General Public License v3.0. Its API is compatible with the Amazon S3 cloud storage service. MinIO is available on the public cloud, in every Kubernetes distribution, on private clouds, and at the edge.

For more information on how to set up MinIO on a bare-metal server, see how to [set up MinIO](https://docs.min.io/enterprise/aistor-object-store/).

## Enable Chef Automate to ingest large compliance reports

To enable Chef Automate to ingest large compliance reports:

1. Create a `patch.toml` if one doesn't already exist for your Chef Automate installation.

2. Add the following configuration to the `patch.toml` file:

```toml
[global.v1.external.minio]
    ##Don't add the protocol(http or https) for MinIO server endpoint. ex. mydomain.com:1234
    endpoint = "<minio server end point>:<port>"
    root_user = "<username>"
    root_password = "<password>"

    ## Uncomment and fill out if want to modify the number of workers to run in parallel to communicate with OpenSearch for preparing the doc for export, default value is 50
    #concurrent_open_search_requests = 50
    ## Uncomment and fill out if want to modify the number of workers to run in parallel to communicate with MINIO server for preparing the doc for export, default value is 10
    #concurrent_minio_requests = 10
    ## Uncomment and fill out if external MINIO is configured with SSL
    #enable_ssl = true
    #cert = """$(cat </path/to/cert_file.crt>)"""

[global.v1.large_reporting]
    enable_large_reporting = true

## Uncomment and fill out if you want to modify the bucket name used to store data in the MinIO server; the default name is 'default'.
## If MINIO is configured to use any public cloud platforms like S3, Azure blob storage, or Google Cloud Storage, It's mandatory to modify the bucket name other than `default`
#[report_manager.v1.sys.objstore]
#  bucket = "default"
```

1. Patch the config by running the following command:

```toml
`chef-automate config patch patch.toml`
```

## Use Amazon S3 as object storage

{{< warning >}} The configuration below isn't tested for benchmark numbers. Run benchmark testing before you adopt this approach. {{< /warning >}}

Chef Automate can connect to Amazon S3 for large compliance reports if you reuse the MinIO configuration in the following way:

```toml
[global.v1.external.minio]
        ## endpoint has to be s3.amazonaws.com
        endpoint = "s3.amazonaws.com"
        root_user = "<access_key>"
        root_password = "<secret_key>"
```
