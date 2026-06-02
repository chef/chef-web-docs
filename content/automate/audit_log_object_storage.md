+++
title = "Store Audit Logs in S3 or MinIO"
draft = false

[menu]
  [menu.automate]
    title = "Audit Logs in S3/MinIO"
    parent = "automate/configuring_automate"
    identifier = "automate/configuring_automate/Audit Logs in S3 or MinIO"
    weight = 43
+++

You can configure Chef Automate to use an object storage backend (AWS S3 or MinIO) for audit log storage.
This is helpful when you want audit log data to live outside the local filesystem and to integrate with object-storage-based retention and access controls.

## How audit logging works

When audit logging is enabled, Chef Automate does the following:

- The load balancer writes `POST`, `PUT`, `PATCH`, and `DELETE` HTTP operations to `/hab/svc/automate-load-balancer/data/audit.log` and rotates the file based on audit input settings.
- If audit storage is configured, Fluent Bit tails the active `audit.log` file and uploads matching log entries to S3 or MinIO.

## Prerequisites

- Network connectivity from Chef Automate services to your AWS S3 or MinIO endpoint
- An existing bucket for audit logs
- Credentials for the storage bucket, or an IAM role and instance profile when using AWS

## Quick start

Use this section if you want the minimum configuration to start uploading audit logs to your bucket.

To create the minimum configuration for uploading audit logs, follow these steps:

1. Create a TOML file that defines your storage settings.

   {{< foundation_tabs tabs-id="quickstart-storage-example-aws-s3-minio" >}}
     {{< foundation_tab active="true" panel-link="quickstart-storage-example-aws-s3" tab-text="AWS S3 storage">}}
     {{< foundation_tab panel-link="quickstart-storage-example-minio" tab-text="MinIO storage" >}}
   {{< /foundation_tabs >}}

   {{< foundation_tabs_panels tabs-id="quickstart-storage-example-aws-s3-minio" >}}
   {{< foundation_tabs_panel active="true" panel-id="quickstart-storage-example-aws-s3" >}}

    AWS S3 using an IAM role and instance profile:

    ```toml
    [global.v1.audit]

      [global.v1.audit.logging]
        enabled = true

      [global.v1.audit.storage]
        storage_type = "s3"
        endpoint = "<STORAGE_ENDPOINT>"
        bucket = "<BUCKET_NAME>"
        storage_region = "<AWS_REGION>"
    ```

    Replace the following:

    - `<STORAGE_ENDPOINT>` with your AWS S3 storage endpoint, for example `https://s3.amazonaws.com` or `https://s3.us-east-1.amazonaws.com`.
    - `<BUCKET_NAME>` with the S3 bucket.
    - `<AWS_REGION>` with the AWS regions, for example `us-east-1`.

   {{< /foundation_tabs_panel >}}

   {{< foundation_tabs_panel panel-id="quickstart-storage-example-minio" >}}

    MinIO using static credentials:

    ```toml
    [global.v1.audit]

      [global.v1.audit.logging]
        enabled = true

      [global.v1.audit.storage]
        storage_type = "minio"
        endpoint = "<MINIO_ENDPOINT>"
        bucket = "<BUCKET_NAME>"
        storage_region = "<REGION>"
        access_key = "<ACCESS_KEY>"
        secret_key = "<SECRET_KEY>"

        [global.v1.audit.storage.ssl]
          enabled = false
          verify_ssl = false
    ```

    Replace the following:

    - `<MINIO_ENDPOINT>` with your MinIO endpoint, for example `http://minio.example.com:9000`.
    - `<BUCKET_NAME>` with the MinIO bucket.
    - `<REGION>` with the MinIO region, for example `us-east-1`.
    - `<ACCESS_KEY>` with your MinIO access key.
    - `<SECRET_KEY>` with your MinIO secret key.

   {{< /foundation_tabs_panel >}}
   {{< /foundation_tabs_panels >}}

   For complete field descriptions and defaults, see [audit log settings reference](#audit-log-settings-reference).

1. Patch the Chef Automate configuration:

    ```shell
    sudo chef-automate config patch </PATH/TO/TOML/FILE> [flags]
    ```

    In a Chef Automate High Availability (HA) deployment, use the following flags:

    - `--automate` to patch the Automate node.
    - `--chef_server` to patch the Chef Infra Server node.

    For more information, see the [`chef-automate config patch` documentation](/automate/cli/#chef-automate-config-patch)

    After you patch the configuration, Automate starts running the audit log collector and uploads audit log data to the configured bucket.

1. Optional: Once audit logs are uploaded, you can configure the following:

   - a prefix inside the bucket to group objects
   - TLS options enable and verify a `root_cert` for private certificate authorities
   - local log rotation and tail input tuning
   - batching and timeouts
   - worker and queue tuning

For details on each field, see [audit log settings reference](#audit-log-settings-reference).

## Verify audit log configuration

To verify audit log uploads, follow these steps:

1. Confirm the configuration was applied:

    ```shell
    chef-automate config show | sed -n '/\[global\.v1\.audit\]/,/^\[/p'
    ```

1. In your configured S3 or MinIO storage bucket, confirm new objects are being written.

    If you don't see new objects right away, wait at least the configured `upload_timeout` (or reduce it temporarily) and ensure `total_file_size` is reachable for your traffic volume.

## Configure audit logs

### Configure local audit log rotation

Chef Automate rotates the local audit log file written by the load balancer.
To change the rotation size threshold, patch your Automate configuration:

1. Create a TOML file with the following content:

    ```toml
    [global.v1.audit]

      [global.v1.audit.input]
        max_file_size = "<FILE_SIZE>"
    ```

    Replace `<FILE_SIZE>` with the maximum size of the local audit log file before rotation occurs.

    {{< note >}}
    If you also set `[global.v1.audit.input].refresh_interval` or `[global.v1.audit.input].mem_buf_limit`, those values are passed through to Fluent Bit's Tail input (`Refresh_Interval` and `Mem_Buf_Limit`).

    See the [Fluent Bit Tail input documentation](https://docs.fluentbit.io/manual/pipeline/inputs/tail).
    {{< /note >}}

    Rotation behavior:

    - Chef Automate writes audit entries to `/hab/svc/automate-load-balancer/data/audit.log`.
    - When `audit.log` exceeds `max_file_size`, it's rotated to `audit.1.log`.
    - The load balancer shifts older rotated files up (`audit.1.log` -> `audit.2.log`, etc.).
    - Chef Automate keeps up to 10 rotated files (`audit.1.log` through `audit.10.log`).

1. Patch the Chef Automate configuration:

    ```shell
    sudo chef-automate config patch </PATH/TO/TOML/FILE>
    ```

### Configure upload behavior

These settings control object size splitting, multipart chunk size, and upload timeouts for collector uploads to S3 or MinIO.

{{< note >}}

Audit logs are uploaded asynchronously and aren't available in S3 or MinIO immediately after an event occurs.
In general, new objects appear after the collector reaches either the `upload_timeout` threshold or the `total_file_size` threshold, whichever happens first, subject to multipart `upload_chunk_size` behavior.

{{< /note >}}

If you don't set `[global.v1.audit.output]`, Chef Automate uses these defaults:

- `total_file_size = "100M"`
- `upload_chunk_size = "6M"`
- `upload_timeout = "10m"`

1. Create a TOML file with the following content:

    ```toml
    [global.v1.audit]

      [global.v1.audit.output]
        total_file_size = "100M"
        upload_chunk_size = "6M"
        upload_timeout = "10m"
    ```

    The `[global.v1.audit.output]` settings control the Fluent Bit S3 output plugin behavior.
    For details and constraints, see the [Fluent Bit S3 output plugin documentation](https://docs.fluentbit.io/manual/pipeline/outputs/s3).

    Set the following values:

    - `total_file_size`: Total size threshold before the output is split into additional objects.
    - `upload_chunk_size`: Multipart upload part size.
    - `upload_timeout`: Upload timeout.

1. Patch the Chef Automate configuration:

    ```shell
    sudo chef-automate config patch </PATH/TO/TOML/FILE>
    ```

### Configure audit log retention

Chef Automate can automatically delete old audit log objects from your S3 or MinIO bucket on a daily schedule.

**Rotating audit log objects stored in S3** are deleted based on their age in days.
**Requested-log export files** (generated when you call the audit request API) are deleted based on how long ago they were created (in hours or days).

#### Configure daily cleanup of stored audit logs

To enable daily deletion of audit log objects older than a set number of days, follow these steps:

1. Create a TOML file with the following content:

    ```toml
    [global.v1.audit]

      [global.v1.audit.retention]
        days = <DAYS>
        schedule_hour = <HOUR>
        schedule_minute = <MINUTE>
    ```

    Replace the following:

    - `<DAYS>` with the number of days to retain audit logs. Default value: `30`.

      Retention is enabled when `days` is greater than `0`.
      Set to `0` to disable automatic cleanup (unlimited retention).

    - `<HOUR>` with the hour (0-23) when cleanup runs. Default: `2` (2 AM).
    - `<MINUTE>` with the minute (0-59) when cleanup runs. Default: `0`.

1. Patch the Chef Automate configuration:

    ```shell
    sudo chef-automate config patch </PATH/TO/TOML/FILE>
    ```

#### Configure automatic deletion of requested log export files

When you request audit logs through the API, Chef Automate generates a log export file and stores it in your configured bucket under the `requested-logs/` path prefix.
These files are automatically cleaned up on an hourly schedule.

To configure how long requested-log files are retained before deletion, follow these steps:

1. Create a TOML file with the following content:

    ```toml
    [global.v1.audit]

      [global.v1.audit.async]
        requested_logs_retention_duration = "1hr"
    ```

    Replace `"1hr"` with your retention duration.
    Valid formats:

    - `"0"` disables automatic cleanup (files are retained indefinitely).
    - `"1hr"`, `"24hr"` retain for the specified number of hours.
    - `"7d"`, `"30d"` retain for the specified number of days.

    {{< note >}}
    If the value is invalid, Chef Automate disables cleanup (fail-closed) and logs a warning.
    {{< /note >}}

1. Patch the Chef Automate configuration:

    ```shell
    sudo chef-automate config patch </PATH/TO/TOML/FILE>
    ```

## Troubleshooting

- If uploads fail to MinIO with TLS enabled, verify the endpoint scheme (`http://` vs `https://`) matches the `ssl.enabled` setting.
- If you use a private CA for MinIO, provide `root_cert` and set `ssl.enabled = true`.
- If you use AWS IAM roles, omit `access_key` and `secret_key` to use the default AWS credential chain.

## Audit log settings reference

<!-- markdownlint-disable MD046 -->

The following defines the default audit log storage settings.
For a complete set of log storage settings, see the [reference examples](#audit-log-configuration-file-examples) below.

`[global.v1.audit.logging]`
: Controls whether audit logging is enabled.
  When disabled, Automate skips validation of the `storage`, `input`, `output`, and `async` fields.

  Default settings:

  ```toml
  [global.v1.audit.logging]
    enabled = false
  ```

: `enabled`
  : Whether logging is enabled. Must be `true` or `false`.

    If audit logging is disabled (`false`), Automate doesn't validate the audit `storage`, `input`, `output`, and `async` fields.

    Default value: `false`

`[global.v1.audit.async]`
: Controls asynchronous upload worker behavior.

  Default settings:

  ```toml
  [global.v1.audit.async]
    max_concurrent_workers = 4
    queue_size = 100
    multipart_chunk_size = "10MB"
    requested_logs_retention_duration = "1hr"
  ```

: `max_concurrent_workers`
  : If set, must be between `1` and `100`.

    Higher values increase throughput but also CPU and memory usage.

    Default value: `4`

: `queue_size`
  : If set, must be between `1` and `10000`.

    If full, new requests may be rejected.

    Default value: `100`

: `multipart_chunk_size`
  : Multipart upload part size.

    Must be a size in `M` or `G` (for example, `"10M"`, `"1G"`). Must be between 10 MB and 1 GB.

    Default value: `"10MB"`

    Format: `KB`, `MB`, or `GB` suffixes (use `"20MB"`, not `"20M"`).

: `requested_logs_retention_duration`
  : Controls how long requested audit log export files (stored under `requested-logs/` in your bucket) are kept before automatic hourly cleanup.

    Valid formats: `"0"` (disabled), `"1hr"`, `"24hr"`, `"7d"`, `"30d"`, and so on.
    Must use `hr` for hours or `d` for days.
    For example, `"24h"` is not valid. Use `"24hr"`.

    Default value: `"1hr"`

    If set to an invalid value, cleanup is disabled and a warning is logged.

`[global.v1.audit.input]`
: Controls how Fluent Bit tails the local audit log file written by the load balancer.

  Default settings:

  ```toml
  [global.v1.audit.input]
    max_file_size = "100MB"
    refresh_interval = "60"
    mem_buf_limit = "5M"
  ```

: `max_file_size`
  : The maximum size of the local audit log file before rotation occurs.

    Default value: `"100MB"`

    If set, must be greater than or equal to 1 MB using the following units: `K`/`KB`, `M`/`MB`, or `G`/`GB`. For example, `"500K"`, `"10M"`, `"1G"`, `"10MB"`. An empty string is invalid.

    The load balancer rotates the audit log file `/hab/svc/automate-load-balancer/data/audit.log` and keeps 10 rotated files.

: `refresh_interval`
  : Polling interval for Fluent Bit Tail input. If set, must be a positive integer number of seconds.

    Default value: `"60"`

    Positive value (seconds)

: `mem_buf_limit`
  : The in-memory buffer limit.

    Default value: `"5M"`

    Format: If set, must be a size in `M` without a suffix (for example, `"5M"`). An empty string is invalid.

`[global.v1.audit.storage]`
: Configures the object storage backend for audit logs.

  Default settings:

  ```toml
  [global.v1.audit.storage]
    storage_type = "s3"
    endpoint = "https://s3.amazonaws.com"
    storage_region = ""
    path_prefix = "audit-logs"
  ```

  All settings:

  ```toml
  [global.v1.audit.storage]
    storage_type = "s3"
    endpoint = "https://s3.<AWS_REGION>.amazonaws.com"
    bucket = "<BUCKET_NAME>"
    storage_region = "<AWS_REGION>"
    path_prefix = "audit-logs"
    access_key = "<ACCESS_KEY>"
    secret_key = "<SECRET_KEY>"
  ```

: `storage_type`
  : Must be `"s3"` or `"minio"`.

    Default value: `"s3"`

: `endpoint`
  : The AWS S3 or MinIO endpoint URL.

    Required for S3 when `bucket` is set, and always required for MinIO. For AWS S3, use a regional endpoint (for example, `https://s3.<AWS_REGION>.amazonaws.com`). For `us-east-1`, `https://s3.amazonaws.com` also works.

    Default value: `"https://s3.amazonaws.com"`

: `bucket`
  : Required. Uploads don't run unless a bucket is configured.

    Default value: n/a

: `storage_region`
  : Required for AWS S3 when `bucket` is set. For MinIO, use `"us-east-1"`.

    Default value: `""`

: `path_prefix`
  : Optional key prefix inside the bucket.

    Default value: `"audit-logs"`

: `access_key`
  : - For MinIO: required
    - For AWS: optional if using an IAM role or instance

    Default value: `""`

: `secret_key`
  : Required if `access_key` is set.

    Default value: `""`

`[global.v1.audit.storage.ssl]`
: Configures TLS for the object storage connection.
  Enable TLS for HTTPS endpoints, enforce certificate verification, and supply a CA certificate for private or self-signed certificates.

  Default settings:

  ```toml
  [global.v1.audit.storage.ssl]
    enabled = false
    verify_ssl = false
    root_cert = ""
  ```

: `enabled`
  : If using an HTTPS endpoint, set to `true`. If using an HTTP endpoint, set to `false`.

    If MinIO uses a private certificate authority or self-signed certificate, set to `true` and add PEM file contents to `root_cert`.

    Default value: `false`

: `verify_ssl`
  : Set to `true` if `enabled = true` and `root_cert` is set.

    Default value: `false`

: `root_cert`
  : PEM-encoded CA certificate (optional, for private CAs or self-signed certs).

    Required if `enabled` is `true`.

    Default value: `""`

`[global.v1.audit.output]`
: Controls how Fluent Bit batches and uploads audit log data to the object storage backend using the [Fluent Bit S3 output plugin](https://docs.fluentbit.io/manual/pipeline/outputs/s3).

  Default settings:

  ```toml
  [global.v1.audit.output]
    total_file_size = "12M"
    upload_chunk_size = "6M"
    upload_timeout = "10m"
  ```

: `total_file_size`
  : Total size threshold before the output is split into additional objects.

    Default value: `"12M"`

    Min value: `"1M"`

    Max value: `"50G"`

    Units: `M` or `G` only. Must be between 1 MB and 50GB, and must be greater than or equal to twice the `upload_chunk_size` value.

: `upload_chunk_size`
  : Min value: `"6M"`

    Max value: `"50M"`

    Units: `M` or `G` only. Must be between 6 MB and 50 MB.

    Default value: `"6M"`

: `upload_timeout`
  : Units: minutes only (`m`).

    Default value: `"10m"`

`[global.v1.audit.retention]`
: Configures automatic daily deletion of audit log objects stored in S3 or MinIO.

  Default settings:

  ```toml
  [global.v1.audit.retention]
    days = 30
    schedule_hour = 2
    schedule_minute = 0
  ```

: `days`
  : Number of days to retain audit logs.
    A value of `0` disables automatic cleanup (unlimited retention).
    A value greater than 0 enables cleanup and sets the retention period.

    Must be greater than or equal to `0`.

    Default value: `30`

: `schedule_hour`
  : Hour of day (0--23) when the daily cleanup job runs.

    Default value: `2` (2 AM)

: `schedule_minute`
  : Minute (0-59) when the daily cleanup job runs.

    Default value: `0`

<!-- markdownlint-enable MD046 -->

### Audit log configuration file examples

The following examples show all audit log settings in a single TOML file (logging, local rotation, S3 or MinIO storage, TLS settings, and upload behavior).
For a complete description of all settings, see [audit log configuration reference](#audit-log-settings-reference).

{{< foundation_tabs tabs-id="audit-log-configuration-examples" >}}
  {{< foundation_tab active="true" panel-link="audit-log-configuration-examples-default" tab-text="Default config">}}
  {{< foundation_tab panel-link="audit-log-configuration-examples-complete" tab-text="Complete config" >}}
{{< /foundation_tabs >}}

{{< foundation_tabs_panels tabs-id="audit-log-configuration-examples" >}}
{{< foundation_tabs_panel active="true" panel-id="audit-log-configuration-examples-default" >}}

The following TOML shows the default audit log settings:

```toml
[global.v1.audit]

  [global.v1.audit.logging]
    enabled = false

  [global.v1.audit.input]
    max_file_size = "100M"
    refresh_interval = "60"
    mem_buf_limit = "5M"

  [global.v1.audit.async]
    max_concurrent_workers = 4
    queue_size = 100
    multipart_chunk_size = "10M"
    requested_logs_retention_duration = "1hr"

  [global.v1.audit.retention]
    days = 30
    schedule_hour = 2
    schedule_minute = 0

  [global.v1.audit.storage]
    storage_type = "s3"
    # Chef Automate doesn't fill in `endpoint` or `storage_region` automatically.
    # When you enable S3 uploads (by setting `bucket`), set `endpoint` and `storage_region` too.
    path_prefix = "audit-logs/"

    [global.v1.audit.storage.ssl]
      enabled = false
      verify_ssl = false
      root_cert = ""

  [global.v1.audit.output]
    total_file_size = "12M"
    upload_chunk_size = "6M"
    upload_timeout = "10m"
```

{{< /foundation_tabs_panel >}}

{{< foundation_tabs_panel panel-id="audit-log-configuration-examples-complete" >}}

The following example includes all available settings:

```toml
[global.v1.audit]

  [global.v1.audit.logging]
    enabled = true

  [global.v1.audit.input]
    max_file_size = "100M"
    refresh_interval = "5"
    mem_buf_limit = "5M"

  [global.v1.audit.async]
    max_concurrent_workers = 4
    queue_size = 100
    multipart_chunk_size = "10M"
    requested_logs_retention_duration = "1hr"

  [global.v1.audit.retention]
    days = 30
    schedule_hour = 2
    schedule_minute = 0

  [global.v1.audit.storage]
    # Use "s3" for AWS S3 or "minio" for MinIO.
    storage_type = "<s3|minio>"
    endpoint = "http://www.example.com:9000"
    bucket = "audit-logs"
    storage_region = "us-east-1"
    path_prefix = "audit-logs/"
    access_key = "<ACCESS_KEY>"
    secret_key = "<SECRET_KEY>"

    [global.v1.audit.storage.ssl]
      # For HTTPS endpoints, set enabled to true
      # For HTTP endpoints, set enable to false
      enabled = false
      verify_ssl = false
      # For private CAs/self-signed certs, provide a PEM-encoded CA certificate.
      # root_cert = """-----BEGIN CERTIFICATE-----
      # ...
      # -----END CERTIFICATE-----"""

  [global.v1.audit.output]
    total_file_size = "100M"
    upload_chunk_size = "6M"
    upload_timeout = "10m"
```

{{< /foundation_tabs_panel >}}
{{< /foundation_tabs_panels >}}

## Retrieve audit logs

Chef Automate provides APIs through `user-settings-service` to request and download audit logs asynchronously.

### Authentication

All audit APIs require authentication.

All endpoints accept a bearer token (JWT) in the `Authorization` header:

```shell
curl -sS \
  -H "Authorization: Bearer <TOKEN>" \
  "https://<FQDN>/api/v0/audit/..."
```

Alternatively, you can use the `api-token` header in some API contexts.

{{< note >}}

`api-token` authentication works with the Admin request API, Status API, and Download API.
The Self request API doesn't accept `api-token` authentication; use a bearer (JWT) token for `GET /api/v0/audit/self/request`.

{{< /note >}}

Example using an API token header:

```shell
curl -sS \
  -H "api-token: $API_TOKEN" \
  "https://$FQDN/api/v0/audit/admin/request"
```

### Request administrator audit logs

- Method/Path: `GET /api/v0/audit/admin/request`
- Authentication: Required (Chef Automate admin session)
- Access control: Admin only
- Query parameters (all optional):
  - `usernames`: Comma-separated list of users to filter logs. If omitted, returns logs for all users.
  - `from`: Start time (RFC 3339 timestamp). Default: 3 hours ago.
  - `to`: End time (RFC 3339 timestamp). Default: now.
  - `order`: Sort order, `asc` or `desc`. Default: `desc`.
- Constraints:
  - The requested time range (`to` - `from`) must be 30 days or less.
  - If you omit both `from` and `to`, the request defaults to the last 3 hours.

Example:

```shell
curl -sS \
  -H "Authorization: Bearer <TOKEN>" \
  "https://<FQDN>/api/v0/audit/admin/request?usernames=user1,user2&from=2025-11-10T00:00:00Z&to=2025-11-11T00:00:00Z&order=desc"
```

Response:

```json
{
  "request_id": "f47ac10b-58cc-4372-a567-0e02b2c3d479",
  "status": "processing",
  "message": "Admin audit log generation started. Use the request ID to check status and download when ready."
}
```

### Request your own audit logs

You can request audit logs for your own activity.

- Method/Path: `GET /api/v0/audit/self/request`
- Authentication: Required (Chef Automate session)
- Access control: Self only
- Query parameters (all optional):
  - `from`: Start time (RFC 3339 timestamp). Default: 3 hours ago.
  - `to`: End time (RFC 3339 timestamp). Default: now.
  - `order`: Sort order, `asc` or `desc`. Default: `desc`.
- Constraints:
  - The requested time range (`to` - `from`) must be 30 days or less.
  - If you omit both `from` and `to`, the request defaults to the last 3 hours.

Example:

```shell
curl -sS \
  -H "Authorization: Bearer $TOKEN" \
  "https://$FQDN/api/v0/audit/self/request?from=2025-11-10T00:00:00Z&to=2025-11-11T00:00:00Z&order=desc"
```

Response:

```json
{
  "request_id": "f47ac10b-58cc-4372-a567-0e02b2c3d479",
  "status": "processing",
  "message": "Self audit log generation started. Use the request ID to check status and download when ready."
}
```

### Check request status

- Method/Path: `GET /api/v1/audit/status`
- Authentication: Required
- Access control: Self only (you can only view your own requested logs)
- Query parameters:
  - `request_id` (optional):
    - If omitted, returns the status of your latest request.
    - If provided, returns the status for that specific request ID.

Examples:

To get your latest request status:

```shell
curl -sS \
  -H "Authorization: Bearer <TOKEN>" \
  "https://<FQDN>/api/v1/audit/status"
```

To get the status for a specific request ID:

```shell
curl -sS \
  -H "Authorization: Bearer <TOKEN>" \
  "https://<FQDN>/api/v1/audit/status?request_id=<REQUEST_ID>"
```

Response fields:

- `request_id`: The UUID for the request.
- `status`: One of `processing`, `completed`, `error`, `not_found`.
- `file_size`: Present when `status` is `completed`. Human-readable size string (for example, `"10.7 KB"`).
- `download_url`: Present when `status` is `completed`. Use the returned URL/path to download the generated file.
  - The returned value may be an absolute URL (when an external FQDN is configured) or a relative path.
  - The download URL is formatted like `/api/v1/audit/download?request_id=<request_id>`.
- `error`: Present when `status` indicates an error. Possible values include `audit_disabled`, `request_not_found`, and `no_requested_logs`.
- `message`: Human-readable status/error details.

Example (completed):

```json
{
  "request_id": "a1c977e1-96a1-4a09-85f8-364721ff9f11",
  "status": "completed",
  "file_size": "10.7 KB",
  "download_url": "https://<FQDN>/api/v1/audit/download?request_id=a1c977e1-96a1-4a09-85f8-364721ff9f11",
  "error": "",
  "message": ""
}
```

### Download audit logs

- Method/Path: `GET /api/v1/audit/download`
- Authentication: Required
- Access control: Self only (you can only download your own audit logs)
- Query parameters:
  - `request_id` (optional):
    - If omitted, returns your last requested audit log file.
    - If provided, returns the audit log file for that specific request ID.
- Returns: The audit log file as a gzip-compressed download.

Each request generates a single file containing the audit logs for the full requested time range (up to 30 days).

The downloaded audit log file is gzip-compressed (for example, `audit_logs.log.gz`). To extract the log file, run:

```shell
gunzip <file-name>.log.gz
```

This produces the uncompressed log file:

```text
<file-name>.log
```

Examples:

```shell
# Download latest/last audit logs
curl -sS -L \
  -H "Authorization: Bearer <TOKEN>" \
  "https://<FQDN>/api/v1/audit/download" \
  -o audit-last.log.gz

# Download audit logs for a specific request_id
curl -sS -L \
  -H "Authorization: Bearer <TOKEN>" \
  "https://<FQDN>/api/v1/audit/download?request_id=<REQUEST_ID>" \
  -o "audit-<REQUEST_ID>.log.gz"
```
