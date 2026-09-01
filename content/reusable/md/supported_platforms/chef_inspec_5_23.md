
<!-- markdownlint-disable MD036 -->

**Commercially-supported platforms**

The following table lists the commercially-supported platforms and versions for Chef InSpec.

| Platform                     | Architecture                                   | Version                                                                   |
| ---------------------------- | ---------------------------------------------- | ------------------------------------------------------------------------- |
| Amazon Linux                 | `x86_64`, `aarch64`                            | `2.x`                                                                     |
| Debian                       | `x86_64`, `aarch64` (10.x and 11.x)            | `9`, `10`, `11`                                                           |
| macOS                        | `x86_64`, `aarch64` (M1 processors)            | `12.x`, `13.x`, `14.x`                                                    |
| Oracle Enterprise Linux      | `x86_64`, `aarch64`                            | `7.x`, `8.x`, `9.x`                                                       |
| Red Hat Enterprise Linux     | `x86_64`, `aarch64` (7.x and 8.x only)         | `7.x`, `8.x`, `9.x`                                                       |
| SUSE Linux Enterprise Server | `x86_64`, `aarch64` (15.x only)                | `12.x`, `15.x`                                                            |
| Ubuntu                       | `x86_64`, `aarch64` (only `18.04` and `20.04`) | `16.04`, `18.04`, `20.04`                                                 |
| Windows                      | `x86_64`                                       | `2016`, `10` (all channels except "insider" builds), `2019`, `11`, `2022` |

**Derived platforms**

The following table lists supported derived platforms and versions for Chef InSpec.

| Platform    | Architecture        | Version | Parent platform |
| ----------- | ------------------- | ------- | --------------- |
| AlmaLinux   | `x86_64`, `aarch64` | `8.x`   | CentOS          |
| Rocky Linux | `x86_64`, `aarch64` | `8.x`   | CentOS          |

Chef InSpec Target Mode (`inspec --target`) may be functional on additional platforms, versions, and architectures but aren't validated by Chef Software, Inc.
