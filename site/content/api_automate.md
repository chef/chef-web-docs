+++
title = "Chef Automate API"
description = "DESCRIPTION"
draft = false

aliases = "/api_automate.html"

[menu]
  [menu.docs]
    title = "Chef Automate API"
    identifier = "chef automate api/api_automate.html"
    parent = "chef automate 1/reference"
    weight = 10
+++    

[\[edit on
GitHub\]](https://github.com/chef/chef-web-docs/blob/master/chef_master/source/api_automate.rst)

{{% chef_automate_mark %}}

{{% EOL_a1 %}}

The Chef Automate API is a REST API.

Stability Index
===============

Stability: 0 - Deprecated
-------------------------

This feature is known to be problematic, and changes are planned. Do not
rely on it. Use of the feature may cause warnings. Backwards
compatibility should not be expected.

Stability: 1 - Experimental
---------------------------

This feature is subject to change. It may change or be removed in future
versions.

Stability: 2 - Stable
---------------------

The API has proven satisfactory. Compatibility is a high priority, and
will not be broken unless absolutely necessary.

Authentication Methods
======================

Authentication to the Chef Automate server occurs via a specific set of
HTTP headers and two types of tokens:

-   `user token` is a short-lived (seven days) token and can be obtained
    from the Chef Automate dashboard by entering this URL in your
    browser:

    ``` none
    https://YOUR_AUTOMATE_HOST/e/YOUR_AUTOMATE_ENTERPRISE/#/dashboard?token
    ```

-   `data_collector token` is a long-lived token that can be set for
    your Chef Automate instance in `/etc/delivery/delivery.rb`. Add
    `data_collector['token'] = 'sometokenvalue'`, save your changes and
    then run `sudo automate-ctl reconfigure`.

Required Headers
----------------

The following authentication headers are required:

<table>
<colgroup>
<col style="width: 40%" />
<col style="width: 60%" />
</colgroup>
<thead>
<tr class="header">
<th>Feature</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>chef-delivery-enterprise</code></td>
<td>The name of the Chef Automate enterprise to use.</td>
</tr>
<tr class="even">
<td><code>chef-delivery-user</code></td>
<td>The Chef Automate user to use for the API calls.</td>
</tr>
<tr class="odd">
<td><code>chef-delivery-token</code></td>
<td>The Chef Automate user token used in conjunction with <code>chef-delivery-user</code>.</td>
</tr>
<tr class="even">
<td><code>x-data-collector-auth</code></td>
<td>Set this to <code>version=1.0</code> in order to use the long-lived <code>data_collector</code> authentication instead of authenticating via <code>chef-delivery-user</code> and <code>chef-delivery-token</code>.</td>
</tr>
<tr class="odd">
<td><code>x-data-collector-token</code></td>
<td>The value of the <code>data_collector</code> token as set in <code>/etc/delivery/delivery.rb</code> if <code>x-data-collector-auth</code> is used.</td>
</tr>
</tbody>
</table>

The Chef Automate API is located at `https://hostname` and has the
following endpoints:

API Endpoints
=============

/api/_status
-------------

The `/api/_status` endpoint can be used to check the health of the Chef
Automate server without authentication. A Chef Automate instance may be
configured as a standalone server or as a disaster recovery pair with
primary and standby servers. The response from this endpoint depends on
the type of configuration. This endpoint is located at `/api/_status`.

**Request**

``` xml
GET /api/_status
```

This method has no request body.

For example:

``` bash
curl -X GET "https://my-auto-server.test/api/_status"
```

**Response**

For a standalone server, the response will be similar to:

``` json
{
  "status": "pong",
  "configuration mode": "standalone",
  "upstreams": [
    {
      "postgres": {
        "status": "pong",
      },
      "lsyncd": {
        "status": "not_running",
      }
    }
  ]
}
```

The top-level `status` value refers to the state of the core Chef
Automate server only. It will return `pong` as long as the Chef Automate
server is healthy even if there's a problem with one of the upstream
systems; however, a response code of 500 will be returned in that case
(as described in the response code section below).

<div class="note" markdown="1">

<div class="admonition-title" markdown="1">

Note

</div>

`lsyncd` should always report a status of `not_running` in a standalone
configuration: any other value would indicate that it's configured when
it shouldn't be (`lsync` should only run on a disaster recovery
primary).

</div>

For the primary server in a disaster recovery pair, the response will be
similar to:

``` json
{
  "status": "pong",
  "configuration mode": "primary",
  "upstreams": [
    {
      "postgres": {
        "status": "pong",
        "standby_ip_address": "192.0.2.0",
        "pg_current_xlog_location": "0/3000D48"
      },
      "lsyncd": {
        "status": "pong",
        "latency": "0"
      }
    }
  ]
}
```

In this configuration, the `postgres` and `lsyncd` upstreams will
indicate the current state of disaster recovery replication. For
PostgreSQL, it will both indicate that it knows what the standby IP is
supposed to be and the current `location`. If the PostgreSQL replication
is working correctly, it should match the value of the PostgreSQL `xlog`
location reported by the standby (see below).

For `lsyncd`, if the replication is up-to-date, `latency` should return
0; it may be above zero if changes have been queued up for replication,
but it should quickly drop back down once the `lsyncd` server syncs
changes (which should happen either after a fixed delay or when a
certain number of changes have queued up). If it instead maintains a
number above zero (or even continues to grow), that would indicate that
there's an issue replicating Git data in Chef Automate.

For the standby server in a disaster recovery pair, the response will be
similar to:

``` json
{
  "status": "pong",
  "configuration mode": "cold_standby",
  "upstreams": [
    {
      "postgres": {
        "status": "pong",
        "pg_last_xlog_receive_location": "0/3000D48"
      },
      "lsyncd": {
         "status": "not_running",
      }
    }
  ]
}
```

In this configuration, `lsyncd` should not be running; any other value
would indicate a problem. For `postgres`, if the replication is
up-to-date, the `location` should match the value of the location on the
primary it's replicating. If it's lagging (or behind and doesn't
change), that would indicate an issue with PostgreSQL replication.

**Response Codes**

<table>
<colgroup>
<col style="width: 20%" />
<col style="width: 80%" />
</colgroup>
<thead>
<tr class="header">
<th>Response Code</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><code>200</code></p></td>
<td><p>All services are OK. The response will show the service status as <code>pong</code> or <code>not_running</code>. For example:</p>
<div class="sourceCode" id="cb1"><pre class="sourceCode json"><code class="sourceCode json"><span id="cb1-1"><a href="#cb1-1"></a><span class="fu">{</span></span>
<span id="cb1-2"><a href="#cb1-2"></a>  <span class="dt">&quot;status&quot;</span><span class="fu">:</span> <span class="st">&quot;pong&quot;</span><span class="fu">,</span></span>
<span id="cb1-3"><a href="#cb1-3"></a>  <span class="dt">&quot;configuration mode&quot;</span><span class="fu">:</span> <span class="st">&quot;standalone&quot;</span><span class="fu">,</span></span>
<span id="cb1-4"><a href="#cb1-4"></a>  <span class="dt">&quot;upstreams&quot;</span><span class="fu">:</span> <span class="ot">[</span></span>
<span id="cb1-5"><a href="#cb1-5"></a>    <span class="fu">{</span></span>
<span id="cb1-6"><a href="#cb1-6"></a>      <span class="dt">&quot;postgres&quot;</span><span class="fu">:</span> <span class="fu">{</span></span>
<span id="cb1-7"><a href="#cb1-7"></a>        <span class="dt">&quot;status&quot;</span><span class="fu">:</span> <span class="st">&quot;pong&quot;</span></span>
<span id="cb1-8"><a href="#cb1-8"></a>      <span class="fu">},</span></span>
<span id="cb1-9"><a href="#cb1-9"></a>      <span class="dt">&quot;lsyncd&quot;</span><span class="fu">:</span> <span class="fu">{</span></span>
<span id="cb1-10"><a href="#cb1-10"></a>        <span class="dt">&quot;status&quot;</span><span class="fu">:</span> <span class="st">&quot;not_running&quot;</span></span>
<span id="cb1-11"><a href="#cb1-11"></a>      <span class="fu">}</span></span>
<span id="cb1-12"><a href="#cb1-12"></a>    <span class="fu">}</span></span>
<span id="cb1-13"><a href="#cb1-13"></a>  <span class="ot">]</span></span>
<span id="cb1-14"><a href="#cb1-14"></a><span class="fu">}</span></span></code></pre></div></td>
</tr>
<tr class="even">
<td><p><code>500</code></p></td>
<td><p>One (or more) services are down. The response will show the service status as <code>fail</code> or <code>degraded</code>. For example:</p>
<div class="sourceCode" id="cb2"><pre class="sourceCode json"><code class="sourceCode json"><span id="cb2-1"><a href="#cb2-1"></a><span class="fu">{</span></span>
<span id="cb2-2"><a href="#cb2-2"></a>  <span class="dt">&quot;status&quot;</span><span class="fu">:</span> <span class="st">&quot;pong&quot;</span><span class="fu">,</span></span>
<span id="cb2-3"><a href="#cb2-3"></a>  <span class="dt">&quot;configuration mode&quot;</span><span class="fu">:</span> <span class="st">&quot;cold_standby&quot;</span><span class="fu">,</span></span>
<span id="cb2-4"><a href="#cb2-4"></a>  <span class="dt">&quot;upstreams&quot;</span><span class="fu">:</span> <span class="ot">[</span></span>
<span id="cb2-5"><a href="#cb2-5"></a>    <span class="fu">{</span></span>
<span id="cb2-6"><a href="#cb2-6"></a>      <span class="dt">&quot;postgres&quot;</span><span class="fu">:</span> <span class="fu">{</span></span>
<span id="cb2-7"><a href="#cb2-7"></a>        <span class="dt">&quot;status&quot;</span><span class="fu">:</span> <span class="st">&quot;fail&quot;</span><span class="fu">,</span></span>
<span id="cb2-8"><a href="#cb2-8"></a>        <span class="dt">&quot;pg_last_xlog_receive_location&quot;</span><span class="fu">:</span> <span class="st">&quot;0/3000D48&quot;</span></span>
<span id="cb2-9"><a href="#cb2-9"></a>      <span class="fu">},</span></span>
<span id="cb2-10"><a href="#cb2-10"></a>      <span class="dt">&quot;lsyncd&quot;</span><span class="fu">:</span> <span class="fu">{</span></span>
<span id="cb2-11"><a href="#cb2-11"></a>        <span class="dt">&quot;status&quot;</span><span class="fu">:</span> <span class="st">&quot;not_running&quot;</span></span>
<span id="cb2-12"><a href="#cb2-12"></a>      <span class="fu">}</span></span>
<span id="cb2-13"><a href="#cb2-13"></a>    <span class="fu">}</span></span>
<span id="cb2-14"><a href="#cb2-14"></a>  <span class="ot">]</span></span>
<span id="cb2-15"><a href="#cb2-15"></a><span class="fu">}</span></span></code></pre></div>
<p>For example, if replication is not running:</p>
<div class="sourceCode" id="cb3"><pre class="sourceCode json"><code class="sourceCode json"><span id="cb3-1"><a href="#cb3-1"></a><span class="fu">{</span></span>
<span id="cb3-2"><a href="#cb3-2"></a>  <span class="dt">&quot;status&quot;</span><span class="fu">:</span> <span class="st">&quot;pong&quot;</span><span class="fu">,</span></span>
<span id="cb3-3"><a href="#cb3-3"></a>  <span class="dt">&quot;configuration mode&quot;</span><span class="fu">:</span> <span class="st">&quot;primary&quot;</span><span class="fu">,</span></span>
<span id="cb3-4"><a href="#cb3-4"></a>  <span class="dt">&quot;upstreams&quot;</span><span class="fu">:</span> <span class="ot">[</span></span>
<span id="cb3-5"><a href="#cb3-5"></a>    <span class="fu">{</span></span>
<span id="cb3-6"><a href="#cb3-6"></a>      <span class="dt">&quot;postgres&quot;</span><span class="fu">:</span> <span class="fu">{</span></span>
<span id="cb3-7"><a href="#cb3-7"></a>        <span class="dt">&quot;status&quot;</span><span class="fu">:</span> <span class="st">&quot;degraded&quot;</span><span class="fu">,</span></span>
<span id="cb3-8"><a href="#cb3-8"></a>        <span class="dt">&quot;replication&quot;</span><span class="fu">:</span> <span class="st">&quot;fail&quot;</span><span class="fu">,</span></span>
<span id="cb3-9"><a href="#cb3-9"></a>        <span class="dt">&quot;description&quot;</span><span class="fu">:</span> <span class="st">&quot;Replication is not running. Check your configuration.&quot;</span></span>
<span id="cb3-10"><a href="#cb3-10"></a>      <span class="fu">},</span></span>
<span id="cb3-11"><a href="#cb3-11"></a>      <span class="dt">&quot;lsyncd&quot;</span><span class="fu">:</span> <span class="fu">{</span></span>
<span id="cb3-12"><a href="#cb3-12"></a>        <span class="dt">&quot;status&quot;</span><span class="fu">:</span> <span class="st">&quot;pong&quot;</span><span class="fu">,</span></span>
<span id="cb3-13"><a href="#cb3-13"></a>        <span class="dt">&quot;latency&quot;</span><span class="fu">:</span> <span class="st">&quot;0&quot;</span></span>
<span id="cb3-14"><a href="#cb3-14"></a>      <span class="fu">}</span></span>
<span id="cb3-15"><a href="#cb3-15"></a>    <span class="fu">}</span></span>
<span id="cb3-16"><a href="#cb3-16"></a>  <span class="ot">]</span></span>
<span id="cb3-17"><a href="#cb3-17"></a><span class="fu">}</span></span></code></pre></div></td>
</tr>
</tbody>
</table>

Compliance API
==============

Filters
-------

As the name implies, filters serve to narrow the scope of a search.
There are many endpoints in the Compliance API that support filters. For
each endpoint that supports filters, `filter` is listed as one of it's
parameters. In all cases when `filter` is included as a parameter, all
filters listed below are allowed for inclusion.

<table style="width:94%;">
<colgroup>
<col style="width: 23%" />
<col style="width: 70%" />
</colgroup>
<thead>
<tr class="header">
<th>Name</th>
<th>Filters search results based on scans that have:</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>start_time</code></td>
<td>end_times that are &gt;= <code>start_time</code></td>
</tr>
<tr class="even">
<td><code>end_time</code></td>
<td>end_times that are &lt;= <code>end_time</code></td>
</tr>
<tr class="odd">
<td><code>environment</code></td>
<td>run in <code>environment</code></td>
</tr>
<tr class="even">
<td><code>node_id</code></td>
<td>run on target with <code>node_id</code></td>
</tr>
<tr class="odd">
<td><code>node_name</code></td>
<td>run on target with <code>node_name</code></td>
</tr>
<tr class="even">
<td><code>platform</code></td>
<td>run on <code>platform</code></td>
</tr>
<tr class="odd">
<td><code>profile_id</code></td>
<td>run against this <code>profile_id</code></td>
</tr>
</tbody>
</table>

<div class="note" markdown="1">

<div class="admonition-title" markdown="1">

Note

</div>

Timestamps, are returned in and **must** be written in RFC 3339 format.
The following are examples of acceptable `start_time` and `end_time`
values for inclusion in a filter:

-   `2017-03-06T09:18:40Z`
-   `2017-03-06T09:18:40+00:00`

</div>

/compliance/market [compliance-market-api]
------------------

The Chef Automate server may store multiple compliance profiles.

The endpoint has the following methods: `GET`.

### GET (profiles)

Stability: **2 - Stable**

The `GET` method is used to get a list of compliance market profiles on
the Chef Automate server.

**Request**

``` none
GET /compliance/market/profiles
```

For example:

``` bash
curl -X GET "https://my-auto-server.test/compliance/market/profiles" \
-H "chef-delivery-enterprise: acme" \
-H "chef-delivery-user: john" \
-H "chef-delivery-token: 7djW35..."
```

**Response**

The response is similar to:

``` json
[
  {
    "name": "linux-baseline",
    "title": "DevSec Linux Security Baseline",
    "maintainer": "DevSec Hardening Framework Team",
    "copyright": "DevSec Hardening Framework Team",
    "copyright_email": "hello@dev-sec.io",
    "license": "Apache 2 license",
    "summary": "Test-suite for best-practice Linux OS hardening",
    "version": "2.1.0",
    "supports": [
      {
        "os-family": "linux"
      }
    ],
    "depends": null
  },
  {
    "name": "postgres-baseline",
    "title": "Hardening Framework Postgres Hardening Test Suite",
    "maintainer": "DevSec Hardening Framework Team",
    "copyright": "DevSec Hardening Framework Team",
    "copyright_email": "hello@dev-sec.io",
    "license": "Apache 2 license",
    "summary": "Test-suite for best-practice postgres hardening",
    "version": "2.0.1",
    "supports": [
      {
        "os-family": "unix"
      }
    ],
    "depends": null
  },
  {
    "name": "ssh-baseline",
    "title": "DevSec SSH Baseline",
    "maintainer": "DevSec Hardening Framework Team",
    "copyright": "DevSec Hardening Framework Team",
    "copyright_email": "hello@dev-sec.io",
    "license": "Apache 2 license",
    "summary": "Test-suite for best-practice SSH hardening",
    "version": "2.2.0",
    "supports": [
      {
        "os-family": "unix"
      }
    ],
    "depends": null
  }
]
```

**Response Codes**

<table>
<colgroup>
<col style="width: 20%" />
<col style="width: 80%" />
</colgroup>
<thead>
<tr class="header">
<th>Response Code</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>200</code></td>
<td>OK. The request was successful.</td>
</tr>
<tr class="even">
<td><code>401</code></td>
<td>Unauthorized. The user who made the request is not authorized to perform the action.</td>
</tr>
</tbody>
</table>

### GET (profile by `:name`)

Stability: **2 - Stable**

The `GET` method is used to get the profile of a given `:name`.

**Request**

``` none
GET /compliance/market/profiles/:name
```

For example:

``` bash
curl -X GET "https://my-auto-server.test/compliance/market/profiles/linux-baseline" \
-H "chef-delivery-enterprise: acme" \
-H "chef-delivery-user: john" \
-H "chef-delivery-token: 7djW35..."
```

**Response**

The response is similar to:

``` json
[
   {
      "name": "linux-baseline",
      "title": "DevSec Linux Security Baseline",
      "maintainer": "DevSec Hardening Framework Team",
      "copyright": "DevSec Hardening Framework Team",
      "copyright_email": "hello@dev-sec.io",
      "license": "Apache 2 license",
      "summary": "Test-suite for best-practice Linux OS hardening",
      "version": "2.1.0",
      "supports": [
         {
            "os-family": "linux"
         }
      ],
      "depends": null
  }
]
```

**Response Codes**

<table>
<colgroup>
<col style="width: 20%" />
<col style="width: 80%" />
</colgroup>
<thead>
<tr class="header">
<th>Response Code</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>200</code></td>
<td>OK. The request was successful.</td>
</tr>
<tr class="even">
<td><code>401</code></td>
<td>Unauthorized. The user who made the request is not authorized to perform the action.</td>
</tr>
</tbody>
</table>

### GET (profile by `:name` & `:version`)

Stability: **2 - Stable**

The `GET` method is used to get one specific :version of a profile of a
given `:name`.

**Request**

``` none
GET /compliance/market/profiles/:name/version/:version
```

For example:

``` bash
curl -X GET "https://my-auto-server.test/compliance/market/profiles/linux-baseline/version/2.1.0" \
-H "chef-delivery-enterprise: acme" \
-H "chef-delivery-user: john" \
-H "chef-delivery-token: 7djW35..."
```

**Response**

The response is similar to:

``` json
[
   {
      "name": "linux-baseline",
      "title": "DevSec Linux Security Baseline",
      "maintainer": "DevSec Hardening Framework Team",
      "copyright": "DevSec Hardening Framework Team",
      "copyright_email": "hello@dev-sec.io",
      "license": "Apache 2 license",
      "summary": "Test-suite for best-practice Linux OS hardening",
      "version": "2.1.0",
      "supports": [
         {
            "os-family": "linux"
         }
      ],
      "depends": null
  }
]
```

**Response Codes**

<table>
<colgroup>
<col style="width: 20%" />
<col style="width: 80%" />
</colgroup>
<thead>
<tr class="header">
<th>Response Code</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>200</code></td>
<td>OK. The request was successful.</td>
</tr>
<tr class="even">
<td><code>401</code></td>
<td>Unauthorized. The user who made the request is not authorized to perform the action.</td>
</tr>
</tbody>
</table>

### GET (profile tar by `:name`)

Stability: **2 - Stable**

The `GET` method is used to get the latest version of a market profile
tarball as specified by the `:name` parameter.

**Request**

``` none
GET /compliance/market/profiles/:name/tar
```

For example:

``` bash
curl -o linux-baseline.tar \
"https://my-auto-server.test/compliance/market/profiles/linux-baseline/tar" \
-H "chef-delivery-enterprise: acme" \
-H "chef-delivery-user: john" \
-H "chef-delivery-token: 7djW35..."
```

**Response**

TAR STREAM - download of the file requested (if it exists)

**Response Codes**

<table>
<colgroup>
<col style="width: 20%" />
<col style="width: 80%" />
</colgroup>
<thead>
<tr class="header">
<th>Response Code</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>200</code></td>
<td>OK. The request was successful.</td>
</tr>
<tr class="even">
<td><code>401</code></td>
<td>Unauthorized. The user who made the request is not authorized to perform the action.</td>
</tr>
<tr class="odd">
<td><code>404</code></td>
<td>Not found. The requested profile was not found.</td>
</tr>
</tbody>
</table>

### GET (profile tar by `:name` & `:version`)

Stability: **2 - Stable**

The `GET` method is used to get the market profile tarball for the given
`:name` and `:version`.

**Request**

``` none
GET /compliance/market/profiles/:name/version/:version/tar
```

For example:

``` bash
curl -o linux-baseline.tar \
"https://my-auto-server.test/compliance/market/profiles/linux-baseline/version/2.1.0/tar" \
-H "chef-delivery-enterprise: acme" \
-H "chef-delivery-user: john" \
-H "chef-delivery-token: 7djW35..."
```

**Response**

TAR STREAM - download of the file requested (if it exists)

**Response Codes**

<table>
<colgroup>
<col style="width: 20%" />
<col style="width: 80%" />
</colgroup>
<thead>
<tr class="header">
<th>Response Code</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>200</code></td>
<td>OK. The request was successful.</td>
</tr>
<tr class="even">
<td><code>401</code></td>
<td>Unauthorized. The user who made the request is not authorized to perform the action.</td>
</tr>
<tr class="odd">
<td><code>404</code></td>
<td>Not found. The requested profile was not found.</td>
</tr>
</tbody>
</table>

/compliance/nodes [compliance-nodes-api]
-----------------

Get the latest scan data for all nodes (or nodes that match
[Filters](#filters)), then aggregate the compliance results from the
latest scans at the specified point in time.

The endpoint has the following methods: `GET`.

### GET (nodes)

Stability: **2 - Stable**

The `GET` method returns aggregated compliance results across one or
more nodes.

**Parameters**

<table>
<colgroup>
<col style="width: 13%" />
<col style="width: 12%" />
<col style="width: 47%" />
<col style="width: 26%" />
</colgroup>
<thead>
<tr class="header">
<th>Parameter</th>
<th>Type</th>
<th>Description</th>
<th>Default</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>filters</code></td>
<td>string</td>
<td><div class="line-block">The search keywords, as well as any qualifiers.<br />
Any and all <a href="#filters">Filters</a> may be used.</div></td>
<td></td>
</tr>
<tr class="even">
<td><code>order</code></td>
<td>string</td>
<td><div class="line-block">The direction of the sort.<br />
Can be either <code>asc</code> or <code>desc</code>.</div></td>
<td><code>desc</code></td>
</tr>
<tr class="odd">
<td><code>page</code></td>
<td>integer</td>
<td>Page number for paginated data.</td>
<td><blockquote>
<p><code>1</code></p>
</blockquote></td>
</tr>
<tr class="even">
<td><code>per_page</code></td>
<td>integer</td>
<td>Items per page.</td>
<td><blockquote>
<p><code>10</code></p>
</blockquote></td>
</tr>
<tr class="odd">
<td><code>sort</code></td>
<td>string</td>
<td><div class="line-block">What to sort results by.<br />
Can be any of the following:</div>
<blockquote>
<ul>
<li><code>environment</code></li>
<li><code>latest_report.controls.failed.critical</code></li>
<li><code>latest_report.controls.failed.total</code></li>
<li><code>latest_report.end_time</code></li>
<li><code>latest_report.status</code></li>
<li><code>name</code></li>
<li><code>platform</code></li>
<li><code>status</code></li>
</ul>
</blockquote></td>
<td><code>latest_report.end_time</code></td>
</tr>
</tbody>
</table>

**Request**

``` none
GET /compliance/nodes
```

For example:

``` bash
curl -X GET "https://my-auto-server.test/compliance/nodes" \
-H "chef-delivery-enterprise: acme" \
-H "chef-delivery-user: john" \
-H "chef-delivery-token: 7djW35..."
```

**Response**

The response is similar to:

``` json
[
  {
    "id": "74a54a28-c628-4f82-86df-61c43866db6a",
    "name": "teal-spohn",
    "platform": {
      "name": "centos"
    },
    "environment": "DevSec Prod Alpha",
    "latest_report": {
      "id": "3ca95021-84c1-43a6-a2e7-be10edcb238d",
      "end_time": "2017-04-04T10:18:41+01:00",
      "status": "failed",
      "controls": {
        "total": 113,
        "passed": {
          "total": 22
        },
        "skipped": {
          "total": 68
        },
        "failed": {
          "total": 23,
          "minor": 0,
          "major": 0,
          "critical": 23
        }
      }
    }
  },
  {
    "id": "99516108-8126-420e-b03e-a90a52f25751",
    "name": "red-brentwood",
    "platform": {
      "name": "debian"
    },
    "environment": "DevSec Prod Zeta",
    "latest_report": {
      "id": "44024b50-2e0d-42fa-a57c-25e05e48a1b5",
      "end_time": "2017-03-06T09:18:41Z",
      "status": "failed",
      "controls": {
        "total": 59,
        "passed": {
          "total": 23
        },
        "skipped": {
          "total": 14
        },
        "failed": {
          "total": 22,
          "minor": 0,
          "major": 0,
          "critical": 22
        }
      }
    }
  }
]
```

**Response Codes**

<table>
<colgroup>
<col style="width: 19%" />
<col style="width: 80%" />
</colgroup>
<thead>
<tr class="header">
<th>Response Code</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>200</code></td>
<td>OK. The request was successful.</td>
</tr>
<tr class="even">
<td><code>400</code></td>
<td>Bad Request. Something is wrong with the request. Client should look closely at the request they're making.</td>
</tr>
<tr class="odd">
<td><code>401</code></td>
<td>Unauthorized. The user who made the request is not authorized to perform the action.</td>
</tr>
<tr class="even">
<td><code>500</code></td>
<td>Internal Server Error. Problem on the backend.</td>
</tr>
</tbody>
</table>

### GET (node by `:id`)

Stability: **2 - Stable**

The `GET` method is used to get the profile of a given node `:id`.

**Request**

``` none
GET /compliance/nodes/:id
```

For example:

``` bash
curl -X GET "https://my-auto-server.test/compliance/nodes/74a54a28-c628-4f82-86df-61c43866db6a" \
-H "chef-delivery-enterprise: acme" \
-H "chef-delivery-user: john" \
-H "chef-delivery-token: 7djW35..."
```

**Response**

The response is similar to:

``` json
{
  "id": "74a54a28-c628-4f82-86df-61c43866db6a",
  "name": "teal-spohn",
  "platform": {
    "name": "centos",
    "release": "5.11"
  },
  "environment": "DevSec Prod Alpha",
  "latest_report": {
    "id": "3ca95021-84c1-43a6-a2e7-be10edcb238d",
    "end_time": "2017-04-04T10:18:41+01:00",
    "status": "failed",
    "controls": {
      "total": 113,
      "passed": {
        "total": 22
      },
      "skipped": {
        "total": 68
      },
      "failed": {
        "total": 23,
        "minor": 0,
        "major": 0,
        "critical": 23
      }
    }
  },
  "profiles": [
    {
      "name": "linux-baseline",
      "version": "2.0.1",
      "id": "b53ca05fbfe17a36363a40f3ad5bd70aa20057eaf15a9a9a8124a84d4ef08015"
    },
    {
      "name": "ssh-baseline",
      "version": "2.1.1",
      "id": "3984753145f0db693e2c6fc79f764e9aff78d892a874391fc5f5cc18f4675b68"
    }
  ]
}
```

**Response Codes**

<table>
<colgroup>
<col style="width: 20%" />
<col style="width: 80%" />
</colgroup>
<thead>
<tr class="header">
<th>Response Code</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>200</code></td>
<td>OK. The request was successful.</td>
</tr>
<tr class="even">
<td><code>400</code></td>
<td>Bad Request. Something is wrong with the request. Client should look closely at the request they're making.</td>
</tr>
<tr class="odd">
<td><code>404</code></td>
<td>Not Found. The resource was not found.</td>
</tr>
<tr class="even">
<td><code>500</code></td>
<td>Internal Server Error. Problem on the backend.</td>
</tr>
</tbody>
</table>

/compliance/profiles [compliance-profile-api]
--------------------

The Chef Automate server may store multiple compliance profiles,
namespaced by owners.

The endpoint has the following methods: `GET` and `POST`.

### GET (by `:owner`)

Stability: **2 - Stable**

The `GET` method is used to get a list of compliance profiles namespaced
by `:owner` on the Chef Automate server.

**Request**

``` none
GET /compliance/profiles/:owner
```

For example:

``` bash
curl -X GET "https://my-auto-server.test/compliance/profiles/john" \
-H "chef-delivery-enterprise: acme" \
-H "chef-delivery-user: john" \
-H "chef-delivery-token: 7djW35..."
```

**Response**

The response is similar to:

``` json
[
  {
    "name": "linux-baseline",
    "title": "DevSec Linux Security Baseline",
    "maintainer": "DevSec Hardening Framework Team",
    "copyright": "DevSec Hardening Framework Team",
    "copyright_email": "hello@dev-sec.io",
    "license": "Apache 2 license",
    "summary": "Test-suite for best-practice Linux OS hardening",
    "version": "2.1.0",
    "supports": [
      {
        "os-family": "linux"
      }
    ],
    "depends": null
  },
  {
    "name": "ssh-baseline",
    "title": "DevSec SSH Baseline",
    "maintainer": "DevSec Hardening Framework Team",
    "copyright": "DevSec Hardening Framework Team",
    "copyright_email": "hello@dev-sec.io",
    "license": "Apache 2 license",
    "summary": "Test-suite for best-practice SSH hardening",
    "version": "2.2.0",
    "supports": [
      {
        "os-family": "unix"
      }
    ],
    "depends": null
  }
]
```

**Response Codes**

<table>
<colgroup>
<col style="width: 20%" />
<col style="width: 80%" />
</colgroup>
<thead>
<tr class="header">
<th>Response Code</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>200</code></td>
<td>OK. The request was successful.</td>
</tr>
<tr class="even">
<td><code>401</code></td>
<td>Unauthorized. The user who made the request is not authorized to perform the action.</td>
</tr>
<tr class="odd">
<td><code>404</code></td>
<td>Not Found. The :owner specified in the request was not found.</td>
</tr>
</tbody>
</table>

### POST

Stability: **2 - Stable**

The `POST` method is used to upload a compliance profile (as a tarball)
namespaced by `:owner`.

**Request**

``` none
POST /compliance/profiles/:owner
```

For example:

``` bash
tar -cvzf /tmp/new-profile.tar.gz /home/user/new-profile
curl -X POST "https://my-auto-server.test/compliance/profiles/john" \
-H "chef-delivery-enterprise: acme" \
-H "chef-delivery-user: john" \
-H "chef-delivery-token: 7djW35..." \
--form "file=@/tmp/new-profile.tar.gz"
```

**Response**

No Content

**Response Codes**

<table>
<colgroup>
<col style="width: 20%" />
<col style="width: 80%" />
</colgroup>
<thead>
<tr class="header">
<th>Response Code</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>200</code></td>
<td>OK. The request was successful.</td>
</tr>
<tr class="even">
<td><code>401</code></td>
<td>Unauthorized. The user who made the request is not authorized to perform the action.</td>
</tr>
<tr class="odd">
<td><code>500</code></td>
<td>Internal Error. Profile check failed.</td>
</tr>
</tbody>
</table>

### GET (by `:owner` & `:name`)

Stability: **2 - Stable**

The `GET` method is used to return details of a particular profile
`:name` belonging to an `:owner`.

This method has no parameters.

**Request**

``` none
GET /compliance/profiles/:owner/:name
```

For example:

``` bash
curl -X GET "https://my-auto-server.test/compliance/profiles/john/linux-baseline" \
-H "chef-delivery-enterprise: acme" \
-H "chef-delivery-user: john" \
-H "chef-delivery-token: 7djW35..."
```

**Response**

The response is similar to:

``` json
[
  {
    "name": "linux-baseline",
    "title": "DevSec Linux Security Baseline",
    "maintainer": "DevSec Hardening Framework Team",
    "copyright": "DevSec Hardening Framework Team",
    "copyright_email": "hello@dev-sec.io",
    "license": "Apache 2 license",
    "summary": "Test-suite for best-practice Linux OS hardening",
    "version": "2.1.0",
    "supports": [
      {
        "os-family": "linux"
      }
    ],
    "depends": null
  }
]
```

**Response Codes**

<table>
<colgroup>
<col style="width: 20%" />
<col style="width: 80%" />
</colgroup>
<thead>
<tr class="header">
<th>Response Code</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>200</code></td>
<td>OK. The request was successful.</td>
</tr>
<tr class="even">
<td><code>401</code></td>
<td>Unauthorized. The user who made the request is not authorized to perform the action.</td>
</tr>
<tr class="odd">
<td><code>404</code></td>
<td>Not Found. The <code>:profile</code> specified in the request was not found.</td>
</tr>
</tbody>
</table>

### GET (by `:owner` & `:name` & `:version`)

Stability: **2 - Stable**

The `GET` method is used to return details of a particular `:version` of
a profile `:name`, belonging to an `:owner`.

This method has no parameters.

**Request**

``` none
GET /compliance/profiles/:owner/:name/version/:version
```

For example:

``` bash
curl -X GET "https://my-auto-server.test/compliance/profiles/john/linux-baseline/version/2.1.0" \
-H "chef-delivery-enterprise: acme" \
-H "chef-delivery-user: john" \
-H "chef-delivery-token: 7djW35..."
```

**Response**

The response is similar to:

``` json
[
  {
    "name": "linux-baseline",
    "title": "DevSec Linux Security Baseline",
    "maintainer": "DevSec Hardening Framework Team",
    "copyright": "DevSec Hardening Framework Team",
    "copyright_email": "hello@dev-sec.io",
    "license": "Apache 2 license",
    "summary": "Test-suite for best-practice Linux OS hardening",
    "version": "2.1.0",
    "supports": [
      {
        "os-family": "linux"
      }
    ],
    "depends": null
  }
]
```

**Response Codes**

<table>
<colgroup>
<col style="width: 20%" />
<col style="width: 80%" />
</colgroup>
<thead>
<tr class="header">
<th>Response Code</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>200</code></td>
<td>OK. The request was successful.</td>
</tr>
<tr class="even">
<td><code>401</code></td>
<td>Unauthorized. The user who made the request is not authorized to perform the action.</td>
</tr>
<tr class="odd">
<td><code>404</code></td>
<td>Not Found. The <code>:profile</code> specified in the request was not found.</td>
</tr>
</tbody>
</table>

### DELETE

Stability: **2 - Stable**

The `DELETE` method is used to remove a particular `:version` of a
profile `:name`, belonging to an `:owner`.

**Request**

``` none
DELETE /compliance/profiles/:owner/:name/version/:version
```

For example:

``` bash
curl -X DELETE "https://my-auto-server.test/compliance/profiles/john/linux-baseline/version/2.1.0" \
-H "chef-delivery-enterprise: acme" \
-H "chef-delivery-user: john" \
-H "chef-delivery-token: 7djW35..."
```

**Response**

No Content

**Response Codes**

<table>
<colgroup>
<col style="width: 20%" />
<col style="width: 80%" />
</colgroup>
<thead>
<tr class="header">
<th>Response Code</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>200</code></td>
<td>OK. The request was successful.</td>
</tr>
<tr class="even">
<td><code>401</code></td>
<td>Unauthorized. The user who made the request is not authorized to perform the action.</td>
</tr>
<tr class="odd">
<td><code>404</code></td>
<td>Not Found. The <code>:owner</code> or <code>:name</code> specified in the request was not found.</td>
</tr>
</tbody>
</table>

### GET (profile tar by `:owner` and `:name`)

Stability: **2 - Stable**

The `GET` is used to download tarball of a particular a profile `:name`,
belonging to an `:owner`.

**Request**

``` none
GET /compliance/profiles/:owner/:name/tar
```

For example:

``` bash
curl -X GET "https://my-auto-server.test/compliance/profiles/john/linux-baseline/tar" \
-H "chef-delivery-enterprise: acme" \
-H "chef-delivery-user: john" \
-H "chef-delivery-token: 7djW35..." > /tmp/profile.tar.gz
```

**Response**

TAR STREAM

**Response Codes**

<table>
<colgroup>
<col style="width: 20%" />
<col style="width: 80%" />
</colgroup>
<thead>
<tr class="header">
<th>Response Code</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>200</code></td>
<td>OK. The request was successful.</td>
</tr>
<tr class="even">
<td><code>401</code></td>
<td>Unauthorized. The user who made the request is not authorized to perform the action.</td>
</tr>
<tr class="odd">
<td><code>404</code></td>
<td>Not Found. The <code>:owner</code> or <code>:name</code> specified in the request was not found.</td>
</tr>
</tbody>
</table>

### GET (profile tar by `:owner` `:name` `:version`)

Stability: **2 - Stable**

The `GET` is used to download tarball of a particular `:version` of a
profile `:name`, belonging to an `:owner`.

**Request**

``` none
GET /compliance/profiles/:owner/:name/version/:version/tar
```

For example:

``` bash
curl -X GET "https://my-auto-server.test/compliance/profiles/john/linux-baseline/version/2.1.0/tar" \
-H "chef-delivery-enterprise: acme" \
-H "chef-delivery-user: john" \
-H "chef-delivery-token: 7djW35..." > /tmp/profile.tar.gz
```

**Response**

TAR STREAM

**Response Codes**

<table>
<colgroup>
<col style="width: 20%" />
<col style="width: 80%" />
</colgroup>
<thead>
<tr class="header">
<th>Response Code</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>200</code></td>
<td>OK. The request was successful.</td>
</tr>
<tr class="even">
<td><code>401</code></td>
<td>Unauthorized. The user who made the request is not authorized to perform the action.</td>
</tr>
<tr class="odd">
<td><code>404</code></td>
<td>Not Found. The <code>:owner</code> or <code>:profile</code> specified in the request was not found.</td>
</tr>
</tbody>
</table>

/compliance/reports [compliance-reports-api]
-------------------

Get the latest scan data for all nodes (or nodes that match
[Filters](#filters)), from the latest scans at the specified point in
time.

The endpoint has the following methods: `GET`.

### GET (reports)

Stability: **2 - Stable**

The `GET` method returns aggregated compliance results across one or
more nodes.

**Parameters**

<table>
<colgroup>
<col style="width: 13%" />
<col style="width: 12%" />
<col style="width: 47%" />
<col style="width: 26%" />
</colgroup>
<thead>
<tr class="header">
<th>Parameter</th>
<th>Type</th>
<th>Description</th>
<th>Default</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>filters</code></td>
<td>string</td>
<td><div class="line-block">The search keywords, as well as any qualifiers.<br />
Any and all <a href="#filters">Filters</a> may be used.</div></td>
<td></td>
</tr>
<tr class="even">
<td><code>order</code></td>
<td>string</td>
<td><div class="line-block">The direction of the sort.<br />
Can be either <code>asc</code> or <code>desc</code>.</div></td>
<td><code>desc</code></td>
</tr>
<tr class="odd">
<td><code>page</code></td>
<td>integer</td>
<td>Page number for paginated data.</td>
<td><blockquote>
<p><code>1</code></p>
</blockquote></td>
</tr>
<tr class="even">
<td><code>per_page</code></td>
<td>integer</td>
<td>Items per page.</td>
<td><blockquote>
<p><code>10</code></p>
</blockquote></td>
</tr>
<tr class="odd">
<td><code>sort</code></td>
<td>string</td>
<td><div class="line-block">What to sort results by.<br />
Can be any of the following:</div>
<blockquote>
<ul>
<li><code>node_name</code></li>
<li><code>latest_report.end_time</code></li>
<li><code>latest_report.status</code></li>
<li><code>latest_report.controls.failed.total</code></li>
<li><code>latest_report.controls.failed.critical</code></li>
</ul>
</blockquote></td>
<td><code>latest_report.end_time</code></td>
</tr>
</tbody>
</table>

**Request**

``` none
GET /compliance/reports
```

For example:

``` bash
curl -X GET "https://my-auto-server.test/compliance/reports" \
-H "chef-delivery-enterprise: acme" \
-H "chef-delivery-user: john" \
-H "chef-delivery-token: 7djW35..."
```

**Response**

The response is similar to:

``` json
[
  {
    "id": "3ca95021-84c1-43a6-a2e7-be10edcb238d",
    "node_id": "74a54a28-c628-4f82-86df-61c43866db6a",
    "node_name": "teal-spohn",
    "end_time": "2017-04-04T10:18:41+01:00",
    "status": "failed",
    "controls": {
      "total": 113,
      "passed": {
        "total": 22
      },
      "skipped": {
        "total": 68
      },
      "failed": {
        "total": 23,
        "minor": 0,
        "major": 0,
        "critical": 23
      }
    }
  },
  {
    "id": "bb93e1b2-36d6-439e-ac70-a41504242605",
    "node_id": "74a54a28-c628-4f82-86df-61c43866db6a",
    "node_name": "teal-spohn",
    "end_time": "2017-04-03T10:18:41+01:00",
    "status": "failed",
    "controls": {
      "total": 113,
      "passed": {
        "total": 22
      },
      "skipped": {
        "total": 68
      },
      "failed": {
        "total": 23,
        "minor": 0,
        "major": 0,
        "critical": 23
      }
    }
  },
  {
    "id": "44024b50-2e0d-42fa-a57c-25e05e48a1b5",
    "node_id": "99516108-8126-420e-b03e-a90a52f25751",
    "node_name": "red-brentwood",
    "end_time": "2017-03-06T09:18:41Z",
    "status": "failed",
    "controls": {
      "total": 59,
      "passed": {
        "total": 23
      },
      "skipped": {
        "total": 14
      },
      "failed": {
        "total": 22,
        "minor": 0,
        "major": 0,
        "critical": 22
      }
    }
  }
]
```

**Response Codes**

<table>
<colgroup>
<col style="width: 19%" />
<col style="width: 80%" />
</colgroup>
<thead>
<tr class="header">
<th>Response Code</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>200</code></td>
<td>OK. The request was successful.</td>
</tr>
<tr class="even">
<td><code>400</code></td>
<td>Bad Request. Something is wrong with the request. Client should look closely at the request they're making.</td>
</tr>
<tr class="odd">
<td><code>401</code></td>
<td>Unauthorized. The user who made the request is not authorized to perform the action.</td>
</tr>
<tr class="even">
<td><code>500</code></td>
<td>Internal Server Error. Problem on the backend.</td>
</tr>
</tbody>
</table>

### GET (report by `:id`)

Stability: **2 - Stable**

The `GET` method is used to get the report of a given report `:id`.

**Request**

``` none
GET /compliance/reports/:id
```

For example:

``` bash
curl -X GET "https://my-auto-server.test/compliance/reports/74a54a28-c628-4f82-86df-61c43866db6a" \
-H "chef-delivery-enterprise: acme" \
-H "chef-delivery-user: john" \
-H "chef-delivery-token: 7djW35..."
```

**Response**

The response is similar to:

``` none
{
  "id": "3ca95021-84c1-43a6-a2e7-be10edcb238d",
  "version": "1.17.0",
  "profiles": [
    {
      "name": "linux-baseline",
      "title": "DevSec Linux Security Baseline",
      "version": "2.0.1",
      "summary": "Test-suite for best-practice os hardening",
      "license": "",
      "copyright": "Hardening Framework Team",
      "copyright_email": "hello@hardening.io",
      "controls": [
      .
      .
      .
      ]
    }
  ]
}
```

**Response Codes**

<table>
<colgroup>
<col style="width: 20%" />
<col style="width: 80%" />
</colgroup>
<thead>
<tr class="header">
<th>Response Code</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>200</code></td>
<td>OK. The request was successful.</td>
</tr>
<tr class="even">
<td><code>400</code></td>
<td>Bad Request. Something is wrong with the request. Client should look closely at the request they're making.</td>
</tr>
<tr class="odd">
<td><code>401</code></td>
<td>Unauthorized. The user who made the request is not authorized to perform the action.</td>
</tr>
<tr class="even">
<td><code>404</code></td>
<td>Not Found. The resource was not found.</td>
</tr>
</tbody>
</table>

/compliance/search/profiles [compliance-search-api]
---------------------------

Retrieves a list of profile summary data, based on the filters and
parameters listed below.

The endpoint has the following methods: `GET`.

### GET (list of profiles)

Stability: **1 - Experimental**

The `GET` method returns a list of profile summary data filtered down
using [Filters](#filters).

**Parameters**

The following parameters are applicable to /search/profiles:

<table>
<colgroup>
<col style="width: 13%" />
<col style="width: 12%" />
<col style="width: 47%" />
<col style="width: 26%" />
</colgroup>
<thead>
<tr class="header">
<th>Parameter</th>
<th>Type</th>
<th>Description</th>
<th>Default</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>filters</code></td>
<td>string</td>
<td><div class="line-block">The search keywords, as well as any qualifiers.<br />
Any and all <a href="#filters">Filters</a> may be used.</div></td>
<td></td>
</tr>
<tr class="even">
<td><code>order</code></td>
<td>string</td>
<td><div class="line-block">The direction of the sort.<br />
Can be either <code>asc</code> or <code>desc</code>.</div></td>
<td><code>desc</code></td>
</tr>
<tr class="odd">
<td><code>page</code></td>
<td>integer</td>
<td>Page number for paginated data.</td>
<td><blockquote>
<p><code>1</code></p>
</blockquote></td>
</tr>
<tr class="even">
<td><code>per_page</code></td>
<td>integer</td>
<td>Items per page.</td>
<td><blockquote>
<p><code>10</code></p>
</blockquote></td>
</tr>
<tr class="odd">
<td><code>sort</code></td>
<td>string</td>
<td><div class="line-block">What to sort results by.<br />
Can be any of the following:</div>
<blockquote>
<ul>
<li><code>node_name</code></li>
<li><code>latest_report.end_time</code></li>
<li><code>latest_report.status</code></li>
<li><code>latest_report.controls.failed.total</code></li>
<li><code>latest_report.controls.failed.critical</code></li>
</ul>
</blockquote></td>
<td><code>latest_report.end_time</code></td>
</tr>
</tbody>
</table>

**Request**

``` none
GET /compliance/search/profiles
```

For example:

``` bash
curl -X GET "https://my-auto-server.test/compliance/search/profiles" \
-H "chef-delivery-enterprise: acme" \
-H "chef-delivery-user: john" \
-H "chef-delivery-token: 7djW35..."
```

**Response**

The response is similar to:

``` json
[
  {
    "name": "apache-baseline",
    "title": "DevSec Apache Baseline",
    "id": "65707cb4299e5e821c687f6d5a704ffd3e21f6139a9ad0cc3b438c343b129d8c",
    "version": "2.0.1"
  },
  {
    "name": "linux-baseline",
    "title": "DevSec Linux Security Baseline",
    "id": "b53ca05fbfe17a36363a40f3ad5bd70aa20057eaf15a9a9a8124a84d4ef08015",
    "version": "2.0.1"
  },
  {
    "name": "linux-baseline",
    "title": "DevSec Linux Security Baseline",
    "id": "9f40334d8d485a70b7fd1c8387b0116a29512714c7bfb32a563ec3c97090ff59",
    "version": "2.1.0"
  },
  {
    "name": "ssh-baseline",
    "title": "DevSec SSH Baseline",
    "id": "f42d2f48c9acd48f52324d52ec575ca9028e405eb303f69cb34d79eb0e588b5c",
    "version": "2.2.0"
  },
  {
    "name": "ssh-baseline",
    "title": "DevSec SSH Baseline",
    "id": "3984753145f0db693e2c6fc79f764e9aff78d892a874391fc5f5cc18f4675b68",
    "version": "2.1.1"
  }
]
```

**Response Codes**

<table>
<colgroup>
<col style="width: 19%" />
<col style="width: 80%" />
</colgroup>
<thead>
<tr class="header">
<th>Response Code</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>200</code></td>
<td>OK. The request was successful.</td>
</tr>
<tr class="even">
<td><code>401</code></td>
<td>Unauthorized. The user who made the request is not authorized to perform the action.</td>
</tr>
<tr class="odd">
<td><code>404</code></td>
<td>Not Found. The resource was not found.</td>
</tr>
</tbody>
</table>

/compliance/stats/failures [compliance-stats-api]
--------------------------

Get the latest scan data for all nodes (or nodes that match
[Filters](#filters)), then aggregate the compliance results from the
latest scans at the specified point in time.

The endpoint has the following methods: `GET`.

### GET (failures)

Stability: **1 - Experimental**

The `GET` method returns aggregated stats failure results across one or
more nodes.

**Parameters**

<table>
<colgroup>
<col style="width: 13%" />
<col style="width: 12%" />
<col style="width: 47%" />
<col style="width: 26%" />
</colgroup>
<thead>
<tr class="header">
<th>Parameter</th>
<th>Type</th>
<th>Description</th>
<th>Default</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>filters</code></td>
<td>string</td>
<td><div class="line-block">The search keywords, as well as any qualifiers.<br />
Any and all <a href="#filters">Filters</a> may be used.</div></td>
<td></td>
</tr>
<tr class="even">
<td><code>size</code></td>
<td>integer</td>
<td><div class="line-block">The top &lt;size&gt; records make up the aggregation.</div></td>
<td><code>10</code></td>
</tr>
<tr class="odd">
<td><code>types</code></td>
<td>string</td>
<td><div class="line-block">Required to have at least one type set.<br />
A '+' delimited list of the following:</div>
<blockquote>
<ul>
<li><code>control</code></li>
<li><code>environment</code></li>
<li><code>platform</code></li>
<li><code>profile</code></li>
</ul>
</blockquote></td>
<td></td>
</tr>
</tbody>
</table>

**Request**

``` none
GET /compliance/stats/failures
```

For example:

``` bash
curl -X GET "https://my-auto-server.test/compliance/stats/failures?types=profile+control&size=3" \
-H "chef-delivery-enterprise: acme" \
-H "chef-delivery-user: john" \
-H "chef-delivery-token: 7djW35..."
```

**Response**

The response is similar to:

``` json
{
  "profiles": [
    {
      "name": "linux-baseline",
      "id": "b53ca05fbfe17a36363a40f3ad5bd70aa20057eaf15a9a9a8124a84d4ef08015",
      "failures": 2
    }
  ],
  "controls": [
    {
      "name": "os-02",
      "profile": "",
      "failures": 2
    },
    {
      "name": "os-05",
      "profile": "",
      "failures": 2
    },
    {
      "name": "sysctl-01",
      "profile": "",
      "failures": 2
    }
  ]
}
```

**Response Codes**

<table>
<colgroup>
<col style="width: 19%" />
<col style="width: 80%" />
</colgroup>
<thead>
<tr class="header">
<th>Response Code</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>200</code></td>
<td>OK. The request was successful.</td>
</tr>
<tr class="even">
<td><code>400</code></td>
<td>Bad Request. Something is wrong with the request. Client should look closely at the request they're making.</td>
</tr>
<tr class="odd">
<td><code>401</code></td>
<td>Unauthorized. The user who made the request is not authorized to perform the action.</td>
</tr>
</tbody>
</table>

/compliance/stats/profiles
--------------------------

Get the latest scan data for all nodes (or nodes that match
[Filters](#filters)), then for each profile, aggregate the compliance
results from the latest scans at the specified point in time.

The endpoint has the following methods: `GET`.

### GET (profiles)

Stability: **1 - Experimental**

The `GET` method returns aggregated stats profile results across one or
more nodes.

**Parameters**

<table>
<colgroup>
<col style="width: 13%" />
<col style="width: 12%" />
<col style="width: 47%" />
<col style="width: 26%" />
</colgroup>
<thead>
<tr class="header">
<th>Parameter</th>
<th>Type</th>
<th>Description</th>
<th>Default</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>filters</code></td>
<td>string</td>
<td><div class="line-block">The search keywords, as well as any qualifiers.<br />
Any and all <a href="#filters">Filters</a> may be used.</div></td>
<td></td>
</tr>
<tr class="even">
<td><code>size</code></td>
<td>integer</td>
<td><div class="line-block">The number of profiles to consider in summary.</div></td>
<td><code>10000</code></td>
</tr>
</tbody>
</table>

**Request**

``` none
GET /compliance/stats/profiles
```

For example:

``` bash
curl -X GET "https://my-auto-server.test/compliance/stats/profiles?size=4" \
-H "chef-delivery-enterprise: acme" \
-H "chef-delivery-user: john" \
-H "chef-delivery-token: 7djW35..."
```

**Response**

The response is similar to:

``` json
[
  {
    "name": "linux-baseline",
    "id": "b53ca05fbfe17a36363a40f3ad5bd70aa20057eaf15a9a9a8124a84d4ef08015",
    "failures": 45,
    "majors": 0,
    "minors": 0,
    "criticals": 45,
    "passed": 45,
    "skipped": 0
  },
  {
    "name": "apache-baseline",
    "id": "65707cb4299e5e821c687f6d5a704ffd3e21f6139a9ad0cc3b438c343b129d8c",
    "failures": 0,
    "majors": 0,
    "minors": 0,
    "criticals": 0,
    "passed": 0,
    "skipped": 14
  },
  {
    "name": "ssh-baseline",
    "id": "3984753145f0db693e2c6fc79f764e9aff78d892a874391fc5f5cc18f4675b68",
    "failures": 0,
    "majors": 0,
    "minors": 0,
    "criticals": 0,
    "passed": 0,
    "skipped": 68
  }
]
```

**Response Codes**

<table>
<colgroup>
<col style="width: 19%" />
<col style="width: 80%" />
</colgroup>
<thead>
<tr class="header">
<th>Response Code</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>200</code></td>
<td>OK. The request was successful.</td>
</tr>
<tr class="even">
<td><code>400</code></td>
<td>Bad Request. Something is wrong with the request. Client should look closely at the request they're making.</td>
</tr>
<tr class="odd">
<td><code>401</code></td>
<td>Unauthorized. The user who made the request is not authorized to perform the action.</td>
</tr>
<tr class="even">
<td><code>500</code></td>
<td>Internal Server Error. Problem on the backend.</td>
</tr>
</tbody>
</table>

### GET (profile summary by `:profile_id`)

Stability: **1 - Experimental**

The `GET` method returns aggregated stats profile summary results across
one or more nodes per `:profile_id`.

**Parameters**

<table>
<colgroup>
<col style="width: 13%" />
<col style="width: 12%" />
<col style="width: 47%" />
<col style="width: 26%" />
</colgroup>
<thead>
<tr class="header">
<th>Parameter</th>
<th>Type</th>
<th>Description</th>
<th>Default</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>filters</code></td>
<td>string</td>
<td><div class="line-block">The search keywords, as well as any qualifiers.<br />
Any and all <a href="#filters">Filters</a> may be used.</div></td>
<td></td>
</tr>
</tbody>
</table>

**Request**

``` none
GET /compliance/stats/profiles/:profile_id/summary
```

For example:

``` bash
curl -X GET \
"https://my-auto-server.test/compliance/stats/profiles/b53ca05fbfe17a36363a40f3ad5bd70aa20057eaf15a9a9a8124a84d4ef08015/summary?size=4" \
-H "chef-delivery-enterprise: acme" \
-H "chef-delivery-user: john" \
-H "chef-delivery-token: 7djW35..."
```

**Response**

The response is similar to:

``` json
{
  "stats": {
    "failed": 45,
    "passed": 45,
    "skipped": 0,
    "failed_nodes": 2,
    "total_nodes": 2
  },
  "name": "linux-baseline",
  "title": "DevSec Linux Security Baseline",
  "supports": [
    {
      "os-family": "linux"
    }
  ],
  "version": "2.0.1",
  "license": "Apache 2 license",
  "maintainer": "Hardening Framework Team",
  "copyright": "Hardening Framework Team",
  "copyright_email": "hello@hardening.io",
  "summary": "Test-suite for best-practice os hardening"
}
```

**Response Codes**

<table>
<colgroup>
<col style="width: 19%" />
<col style="width: 80%" />
</colgroup>
<thead>
<tr class="header">
<th>Response Code</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>200</code></td>
<td>OK. The request was successful.</td>
</tr>
<tr class="even">
<td><code>400</code></td>
<td>Bad Request. Something is wrong with the request. Client should look closely at the request they're making.</td>
</tr>
<tr class="odd">
<td><code>401</code></td>
<td>Unauthorized. The user who made the request is not authorized to perform the action.</td>
</tr>
<tr class="even">
<td><code>500</code></td>
<td>Internal Server Error. Problem on the backend.</td>
</tr>
</tbody>
</table>

### GET (profile controls stats by `:profile_id`)

Stability: **1 - Experimental**

The `GET` method returns aggregated controls stats per `:profile_id`
across latest scans on all or filtered nodes.

**Parameters**

<table>
<colgroup>
<col style="width: 13%" />
<col style="width: 12%" />
<col style="width: 47%" />
<col style="width: 26%" />
</colgroup>
<thead>
<tr class="header">
<th>Parameter</th>
<th>Type</th>
<th>Description</th>
<th>Default</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>filters</code></td>
<td>string</td>
<td><div class="line-block">The search keywords, as well as any qualifiers.<br />
Any and all <a href="#filters">Filters</a> may be used.</div></td>
<td></td>
</tr>
</tbody>
</table>

**Request**

``` none
GET /compliance/stats/profiles/:profile_id/controls
```

For example:

``` bash
curl -X GET \
"https://my-auto-server.test/compliance/stats/profiles/b53ca05fbfe17a36363a40f3ad5bd70aa20057eaf15a9a9a8124a84d4ef08015/controls" \
-H "chef-delivery-enterprise: acme" \
-H "chef-delivery-user: john" \
-H "chef-delivery-token: 7djW35..."
```

**Response**

The response is similar to:

``` json
[
  {
    "control": "os-01",
    "title": "Trusted hosts login",
    "passed": 2,
    "failed": 0,
    "skipped": 0,
    "impact": 1
  },
  {
    "control": "os-02",
    "title": "Check owner and permissions for /etc/shadow",
    "passed": 0,
    "failed": 2,
    "skipped": 0,
    "impact": 1
  },
  {
    "control": "os-03",
    "title": "Check owner and permissions for /etc/passwd",
    "passed": 2,
    "failed": 0,
    "skipped": 0,
    "impact": 1
  }
]
```

**Response Codes**

<table>
<colgroup>
<col style="width: 19%" />
<col style="width: 80%" />
</colgroup>
<thead>
<tr class="header">
<th>Response Code</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>200</code></td>
<td>OK. The request was successful.</td>
</tr>
<tr class="even">
<td><code>400</code></td>
<td>Bad Request. Something is wrong with the request. Client should look closely at the request they're making.</td>
</tr>
<tr class="odd">
<td><code>401</code></td>
<td>Unauthorized. The user who made the request is not authorized to perform the action.</td>
</tr>
<tr class="even">
<td><code>500</code></td>
<td>Internal Server Error. Problem on the backend.</td>
</tr>
</tbody>
</table>

/compliance/stats/summary
-------------------------

Get the latest scan data for all nodes (or nodes that match
[Filters](#filters)), then provide summary including number of nodes,
environments, platforms and profiles, the pass or failed status,
duration, and earliest scan start_time.

The endpoint has the following methods: `GET`.

### GET (summary)

Stability: **1 - Experimental**

The `GET` method returns summary data across latest scans on all or
filtered nodes.

**Parameters**

<table>
<colgroup>
<col style="width: 13%" />
<col style="width: 12%" />
<col style="width: 47%" />
<col style="width: 26%" />
</colgroup>
<thead>
<tr class="header">
<th>Parameter</th>
<th>Type</th>
<th>Description</th>
<th>Default</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>filters</code></td>
<td>string</td>
<td><div class="line-block">The search keywords, as well as any qualifiers.<br />
Any and all <a href="#filters">Filters</a> may be used.</div></td>
<td></td>
</tr>
</tbody>
</table>

**Request**

``` none
GET /compliance/stats/summary
```

For example:

``` bash
curl -X GET "https://my-auto-server.test/compliance/stats/summary" \
-H "chef-delivery-enterprise: acme" \
-H "chef-delivery-user: john" \
-H "chef-delivery-token: 7djW35..."
```

**Response**

The response is similar to:

``` json
{
  "stats": {
    "nodes": 2,
    "platforms": 2,
    "environments": 2,
    "profiles": 3
  },
  "status": "failed",
  "duration": 2505600.636833,
  "start_date": "2017-03-06T09:18:40Z"
}
```

**Response Codes**

<table>
<colgroup>
<col style="width: 19%" />
<col style="width: 80%" />
</colgroup>
<thead>
<tr class="header">
<th>Response Code</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>200</code></td>
<td>OK. The request was successful.</td>
</tr>
<tr class="even">
<td><code>400</code></td>
<td>Bad Request. Something is wrong with the request. Client should look closely at the request they're making.</td>
</tr>
<tr class="odd">
<td><code>401</code></td>
<td>Unauthorized. The user who made the request is not authorized to perform the action.</td>
</tr>
<tr class="even">
<td><code>500</code></td>
<td>Internal Server Error. Problem on the backend.</td>
</tr>
</tbody>
</table>

/compliance/stats/summary/controls
----------------------------------

Get the latest scan data for all nodes (or nodes that match
[Filters](#filters)), then for each profile, aggregate the compliance
results from the latest scans at the specified point in time.

The endpoint has the following methods: `GET`.

### GET (summary controls)

Stability: **1 - Experimental**

The `GET` method returns aggregated stats for all controls across latest
scans on all or filtered nodes.

**Parameters**

<table>
<colgroup>
<col style="width: 13%" />
<col style="width: 12%" />
<col style="width: 47%" />
<col style="width: 26%" />
</colgroup>
<thead>
<tr class="header">
<th>Parameter</th>
<th>Type</th>
<th>Description</th>
<th>Default</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>filters</code></td>
<td>string</td>
<td><div class="line-block">The search keywords, as well as any qualifiers.<br />
Any and all <a href="#filters">Filters</a> may be used.</div></td>
<td></td>
</tr>
</tbody>
</table>

**Request**

``` none
GET /compliance/stats/summary/controls
```

For example:

``` bash
curl -X GET "https://my-auto-server.test/compliance/stats/summary/controls" \
-H "chef-delivery-enterprise: acme" \
-H "chef-delivery-user: john" \
-H "chef-delivery-token: 7djW35..."
```

**Response**

The response is similar to:

``` json
{
  "failures": 45,
  "majors": 0,
  "minors": 0,
  "criticals": 45,
  "passed": 45,
  "skipped": 82
}
```

**Response Codes**

<table>
<colgroup>
<col style="width: 19%" />
<col style="width: 80%" />
</colgroup>
<thead>
<tr class="header">
<th>Response Code</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>200</code></td>
<td>OK. The request was successful.</td>
</tr>
<tr class="even">
<td><code>400</code></td>
<td>Bad Request. Something is wrong with the request. Client should look closely at the request they're making.</td>
</tr>
<tr class="odd">
<td><code>401</code></td>
<td>Unauthorized. The user who made the request is not authorized to perform the action.</td>
</tr>
<tr class="even">
<td><code>500</code></td>
<td>Internal Server Error. Problem on the backend.</td>
</tr>
</tbody>
</table>

/compliance/stats/summary/nodes
-------------------------------

Get the latest scan data for all nodes (or nodes that match
[Filters](#filters)), then for each profile, aggregate the compliance
results from the latest scans at the specified point in time.

The endpoint has the following methods: `GET`.

### GET (summary nodes)

Stability: **1 - Experimental**

The `GET` method returns aggregated stats for all nodes across latest
scans on all or filtered nodes.

**Parameters**

<table>
<colgroup>
<col style="width: 13%" />
<col style="width: 12%" />
<col style="width: 47%" />
<col style="width: 26%" />
</colgroup>
<thead>
<tr class="header">
<th>Parameter</th>
<th>Type</th>
<th>Description</th>
<th>Default</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>filters</code></td>
<td>string</td>
<td><div class="line-block">The search keywords, as well as any qualifiers.<br />
Any and all <a href="#filters">Filters</a> may be used.</div></td>
<td></td>
</tr>
</tbody>
</table>

**Request**

``` none
GET /compliance/stats/summary/nodes
```

For example:

``` bash
curl -X GET "https://my-auto-server.test/compliance/stats/summary/nodes" \
-H "chef-delivery-enterprise: acme" \
-H "chef-delivery-user: john" \
-H "chef-delivery-token: 7djW35..."
```

**Response**

The response is similar to:

``` json
{
  "compliant": 0,
  "skipped": 0,
  "noncompliant": 2,
  "high_risk": 2,
  "medium_risk": 0,
  "low_risk": 0
}
```

**Response Codes**

<table>
<colgroup>
<col style="width: 19%" />
<col style="width: 80%" />
</colgroup>
<thead>
<tr class="header">
<th>Response Code</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>200</code></td>
<td>OK. The request was successful.</td>
</tr>
<tr class="even">
<td><code>400</code></td>
<td>Bad Request. Something is wrong with the request. Client should look closely at the request they're making.</td>
</tr>
<tr class="odd">
<td><code>401</code></td>
<td>Unauthorized. The user who made the request is not authorized to perform the action.</td>
</tr>
<tr class="even">
<td><code>500</code></td>
<td>Internal Server Error. Problem on the backend.</td>
</tr>
</tbody>
</table>

/compliance/stats/trend/controls
--------------------------------

Get the latest scan data for all nodes (or nodes that match
[Filters](#filters)), aggregate the control results from the latest
scans, build a date histogram, and return it.

The endpoint has the following methods: `GET`.

### GET (controls trend)

Stability: **1 - Experimental**

The `GET` method returns a date histogram of aggregated control-oriented
compliance data.

**Parameters**

<table>
<colgroup>
<col style="width: 13%" />
<col style="width: 12%" />
<col style="width: 47%" />
<col style="width: 26%" />
</colgroup>
<thead>
<tr class="header">
<th>Parameter</th>
<th>Type</th>
<th>Description</th>
<th>Default</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>filters</code></td>
<td>string</td>
<td><div class="line-block">The search keywords, as well as any qualifiers.<br />
Any and all <a href="#filters">Filters</a> may be used.</div></td>
<td></td>
</tr>
<tr class="even">
<td><code>interval</code></td>
<td>integer</td>
<td><div class="line-block">The granularity in seconds of the trend data.</div></td>
<td><code>86400</code> (#secs in a day)</td>
</tr>
</tbody>
</table>

**Request**

``` none
GET /compliance/stats/trend/controls
```

For example:

``` bash
curl -X GET \
"https://my-auto-server.test/compliance/stats/trend/controls?filters=start_time:2017-04-01T00%3A00%3A00%2B00%3A00+end_time:2017-04-05T00%3A00%3A00%2B00%3A00&interval=86400" \
-H "chef-delivery-enterprise: acme" \
-H "chef-delivery-user: john" \
-H "chef-delivery-token: 7djW35..."
```

**Response**

The response is similar to:

``` json
[
  {
    "report_time": "2017-04-02T00:00:00+0000",
    "passed": 23,
    "failed": 22,
    "skipped": 14
  },
  {
    "report_time": "2017-04-03T00:00:00+0000",
    "passed": 23,
    "failed": 22,
    "skipped": 14
  },
  {
    "report_time": "2017-04-04T00:00:00+0000",
    "passed": 45,
    "failed": 45,
    "skipped": 82
  },
  {
    "report_time": "2017-04-05T00:00:00+0000",
    "passed": 45,
    "failed": 45,
    "skipped": 82
  }
]
```

**Response Codes**

<table>
<colgroup>
<col style="width: 19%" />
<col style="width: 80%" />
</colgroup>
<thead>
<tr class="header">
<th>Response Code</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>200</code></td>
<td>OK. The request was successful.</td>
</tr>
<tr class="even">
<td><code>400</code></td>
<td>Bad Request. Something is wrong with the request. Client should look closely at the request they're making.</td>
</tr>
<tr class="odd">
<td><code>401</code></td>
<td>Unauthorized. The user who made the request is not authorized to perform the action.</td>
</tr>
<tr class="even">
<td><code>500</code></td>
<td>Internal Server Error. Problem on the backend.</td>
</tr>
</tbody>
</table>

/compliance/stats/trend/nodes
-----------------------------

Get the latest scan data for all nodes (or nodes that match
[Filters](#filters)), aggregate the compliance results from the latest
scans, build a date histogram, and return it.

The endpoint has the following methods: `GET`.

### GET (nodes trend)

Stability: **1 - Experimental**

The `GET` method returns a date histogram of aggregated node-oriented
compliance data.

**Parameters**

<table>
<colgroup>
<col style="width: 13%" />
<col style="width: 12%" />
<col style="width: 47%" />
<col style="width: 26%" />
</colgroup>
<thead>
<tr class="header">
<th>Parameter</th>
<th>Type</th>
<th>Description</th>
<th>Default</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>filters</code></td>
<td>string</td>
<td><div class="line-block">The search keywords, as well as any qualifiers.<br />
Any and all <a href="#filters">Filters</a> may be used.</div></td>
<td></td>
</tr>
<tr class="even">
<td><code>interval</code></td>
<td>integer</td>
<td><div class="line-block">The granularity in seconds of the trend data.</div></td>
<td><code>86400</code> (#secs in a day)</td>
</tr>
</tbody>
</table>

**Request**

``` none
GET /compliance/stats/trend/nodes
```

For example:

``` bash
curl -X GET \
"https://my-auto-server.test/compliance/stats/trend/nodes?filters=start_time:2017-04-01T00%3A00%3A00%2B00%3A00+end_time:2017-04-05T00%3A00%3A00%2B00%3A00&interval=86400" \
-H "chef-delivery-enterprise: acme" \
-H "chef-delivery-user: john" \
-H "chef-delivery-token: 7djW35..."
```

**Response**

The response is similar to:

``` json
[
  {
    "report_time": "2017-04-02T00:00:00+0000",
    "passed": 0,
    "failed": 1,
    "skipped": 0
  },
  {
    "report_time": "2017-04-03T00:00:00+0000",
    "passed": 0,
    "failed": 1,
    "skipped": 0
  },
  {
    "report_time": "2017-04-04T00:00:00+0000",
    "passed": 0,
    "failed": 2,
    "skipped": 0
  },
  {
    "report_time": "2017-04-05T00:00:00+0000",
    "passed": 0,
    "failed": 2,
    "skipped": 0
  }
]
```

**Response Codes**

<table>
<colgroup>
<col style="width: 19%" />
<col style="width: 80%" />
</colgroup>
<thead>
<tr class="header">
<th>Response Code</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>200</code></td>
<td>OK. The request was successful.</td>
</tr>
<tr class="even">
<td><code>400</code></td>
<td>Bad Request. Something is wrong with the request. Client should look closely at the request they're making.</td>
</tr>
<tr class="odd">
<td><code>401</code></td>
<td>Unauthorized. The user who made the request is not authorized to perform the action.</td>
</tr>
<tr class="even">
<td><code>500</code></td>
<td>Internal Server Error. Problem on the backend.</td>
</tr>
</tbody>
</table>

/compliance/suggestions [compliance-suggestions-api]
-----------------------

Get the latest scan data for all nodes (or nodes that match
[Filters](#filters)), then for each profile, aggregate the compliance
results from the latest scans and build a date histogram and return it.

The endpoint has the following methods: `GET`.

### GET (suggestions)

Stability: **1 - Experimental**

The `GET` method returns a date histogram of aggregated node-oriented
compliance data.

**Parameters**

<table>
<colgroup>
<col style="width: 16%" />
<col style="width: 15%" />
<col style="width: 55%" />
<col style="width: 12%" />
</colgroup>
<thead>
<tr class="header">
<th>Parameter</th>
<th>Type</th>
<th>Description</th>
<th>Default</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>type</code></td>
<td>string</td>
<td><div class="line-block">Required. The <code>type</code> for which<br />
we want suggestions.<br />
The value can be any of the following:</div>
<blockquote>
<ul>
<li><code>environment</code></li>
<li><code>node</code></li>
<li><code>platform</code></li>
<li><code>profile</code></li>
</ul>
</blockquote></td>
<td></td>
</tr>
<tr class="even">
<td><code>text</code></td>
<td>string</td>
<td><div class="line-block">Required. The <code>text</code> we search for within<br />
our type.</div></td>
<td></td>
</tr>
<tr class="odd">
<td><code>size</code></td>
<td>integer</td>
<td>The number of suggestions we want.</td>
<td>10</td>
</tr>
</tbody>
</table>

**Request**

``` none
GET /compliance/suggestions
```

For example:

``` bash
curl -X GET \
"https://my-auto-server.test/compliance/suggestions?type=environment&text=Prod&size=5 \
-H "chef-delivery-enterprise: acme" \
-H "chef-delivery-user: john" \
-H "chef-delivery-token: 7djW35..."
```

**Response**

The response is similar to:

``` json
[
  {
    "text": "DevSec Prod Alpha",
    "score": 4.4892697
  },
  {
    "text": "DevSec Prod Zeta",
    "score": 3.9768348
  }
]
```

**Response Codes**

<table>
<colgroup>
<col style="width: 19%" />
<col style="width: 80%" />
</colgroup>
<thead>
<tr class="header">
<th>Response Code</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>200</code></td>
<td>OK. The request was successful.</td>
</tr>
<tr class="even">
<td><code>400</code></td>
<td>Bad Request. Something is wrong with the request. Client should look closely at the request they're making.</td>
</tr>
<tr class="odd">
<td><code>401</code></td>
<td>Unauthorized. The user who made the request is not authorized to perform the action.</td>
</tr>
</tbody>
</table>

/compliance/version [compliance-version-api]
-------------------

Get the version of Compliance API.

The endpoint has the following methods: `GET`.

### GET (version)

Stability: **2 - Stable**

The `GET` method returns the version of the running Compliance API.

**Request**

``` none
GET /compliance/version
```

For example:

``` bash
curl -X GET \
"https://my-auto-server.test/compliance/version \
-H "chef-delivery-enterprise: acme" \
-H "chef-delivery-user: john" \
-H "chef-delivery-token: 7djW35..."
```

**Response**

The response is similar to:

``` json
{
  "api": "compliance",
  "version": "1.9.65"
}
```

**Response Codes**

<table>
<colgroup>
<col style="width: 19%" />
<col style="width: 80%" />
</colgroup>
<thead>
<tr class="header">
<th>Response Code</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>200</code></td>
<td>OK. The request was successful.</td>
</tr>
<tr class="even">
<td><code>401</code></td>
<td>Unauthorized. The user who made the request is not authorized to perform the action.</td>
</tr>
</tbody>
</table>
