+++
title = "Supervisor Log Codes"
description = "Supervisor log code key reference"

[menu]
  [menu.habitat]
    title = "Supervisor Log Codes"
    identifier = "habitat/reference/sup-log-key"
    parent = "habitat/reference"

+++

[\[edit on GitHub\]](https://github.com/habitat-sh/habitat/blob/master/components/docs-chef-io/content/habitat/sup_log_keys.md)

When running services with the Chef Habitat Supervisor you'll see log output similar to this:

```output
redis.default(SR): Initializing
redis.default(SV): Starting
redis.default(O):
```

The letters in parentheses are called "log keys" and signify what type of log message is being shown. This can be useful for log filtering.

They are mostly organized by the part of the Chef Habitat Supervisor code base that they are running from, so they often are of value to somebody troubleshooting problems in the Chef Habitat Supervisor source code.

The meanings of the keys are as follows:

| Key | Description |
|-----|-------------|
| CE | Census |
| CFG | Global configuration |
| CS | Create service: When a service is being started |
| ER | Errors |
| FW | Generic file watcher |
| HG | Messages from the HTTP gateway |
| MN | Main |
| MR | Manager |
| O | Standard output |
| PH | Package hooks |
| PK | Package |
| PT | Path |
| PW | Peer file watcher |
| SC | Service configuration |
| SH | Starting a shell with `hab sup sh` |
| SI | Unix signals |
| SOT | Structured output |
| SR | Service runtime |
| SU | Service updater |
| SV | Supervisor |
| SY | "sys" utility |
| UCW | User-config watcher |
| UR | Users utility |
| UT | Utilities |
