
**RHEL/Enterprise Linux family**

| Platform                 | Architecture                | Version                                 | Tier                    | Agent | Agentless | Installer       |
| ------------------------ | --------------------------- | --------------------------------------- | ----------------------- | ----- | --------- | --------------- |
| Red Hat Enterprise Linux | `x86_64`, `aarch64`         | `8.x`, `9.x`, `10.x`                    | Validated and supported | Yes   | Yes       | Native, Habitat |
| Red Hat Enterprise Linux | `s390x`, `ppc64le`, `ppc64` | `8.x`                                   | Validated and supported | No    | Yes       | Habitat         |
| CentOS                   | `x86_64`, `aarch64`         | `7.x`                                   | Validated and supported | Yes   | Yes       | Native, Habitat |
| CentOS                   | `ppc64le`, `ppc64`          | `7.x`                                   | Validated and supported | No    | Yes       | Habitat         |
| Oracle Enterprise Linux  | `x86_64`, `aarch64`         | `7.x`, `8.x`                            | Validated and supported | Yes   | Yes       | Native, Habitat |
| Amazon Linux             | `x86_64`, `aarch64`         | `2.x`, `2023`                           | Validated and supported | Yes   | Yes       | Native, Habitat |
| Rocky Linux              | `x86_64`, `aarch64`         | `8.x`, `9.x`                            | Supported (untested)    | Yes   | Yes       | Habitat         |
| AlmaLinux                | `x86_64`, `aarch64`         | `8.x`, `9.x`, `10.x`                    | Supported (untested)    | Yes   | Yes       | Habitat         |
| CentOS Stream            | `x86_64`, `aarch64`         | current non--End-Of-Life (EOL) releases | User-reported           | Yes   | Yes       | Habitat         |
| Fedora                   | `x86_64`, `aarch64`         | current non-EOL releases                | User-reported           | Yes   | Yes       | Habitat         |

**Debian/Ubuntu family**

| Platform              | Architecture        | Version                            | Tier                    | Agent | Agentless | Installer       |
| --------------------- | ------------------- | ---------------------------------- | ----------------------- | ----- | --------- | --------------- |
| Debian                | `x86_64`, `aarch64` | `10`, `11`                         | Validated and supported | Yes   | Yes       | Native, Habitat |
| Ubuntu (LTS releases) | `x86_64`, `aarch64` | `18.04`, `20.04`, `22.04`, `24.04` | Validated and supported | Yes   | Yes       | Native, Habitat |
| Kali Linux            | `x86_64`            | current non-EOL releases           | User-reported           | Yes   | Yes       | Habitat         |
| Linux Mint            | `x86_64`            | current non-EOL releases           | User-reported           | Yes   | Yes       | Habitat         |
| Pop!_OS               | `x86_64`            | current non-EOL releases           | User-reported           | Yes   | Yes       | Habitat         |
| Raspberry Pi OS       | `aarch64`           | current non-EOL releases           | User-reported           | Yes   | Yes       | Habitat         |
| Ubuntu (non-LTS)      | `x86_64`, `aarch64` | current non-LTS releases           | User-reported           | Yes   | Yes       | Habitat         |

**SUSE family**

| Platform                      | Architecture        | Version        | Tier                    | Agent | Agentless | Installer       |
| ----------------------------- | ------------------- | -------------- | ----------------------- | ----- | --------- | --------------- |
| SUSE Linux Enterprise Server  | `x86_64`, `aarch64` | `12`, `15`     | Validated and supported | Yes   | Yes       | Native, Habitat |
| SUSE Linux Enterprise Server  | `s390x`             | `12`, `15`     | Validated and supported | No    | Yes       | Habitat         |
| openSUSE                      | `x86_64`, `aarch64` | `15.x`         | User-reported           | Yes   | Yes       | Habitat         |
| SUSE Linux Enterprise Desktop | `x86_64`, `aarch64` | `12.x`, `15.x` | User-reported           | Yes   | Yes       | Habitat         |

**Windows**

| Platform                                  | Architecture | Version                                                  | Tier                    | Agent | Agentless | Installer    |
| ----------------------------------------- | ------------ | -------------------------------------------------------- | ----------------------- | ----- | --------- | ------------ |
| Windows                                   | `x86_64`     | `10`, `11`, Server `2016`, `2019` (LTSC), `2022`, `2025` | Validated and supported | Yes   | Yes       | Native (MSI) |
| Windows Server, Semi-annual channel (SAC) | `x64`        | Server Core only                                         | User-reported           | Yes   | Yes       | Habitat      |

**macOS**

| Platform | Architecture | Version        | Tier                    | Agent | Agentless | Installer |
| -------- | ------------ | -------------- | ----------------------- | ----- | --------- | --------- |
| macOS    | `aarch64`    | `13.x`, `14.x` | Validated and supported | Yes   | Yes       | Native    |

**IBM AIX**

| Platform | Architecture | Version                                 | Tier                    | Agent | Agentless | Installer |
| -------- | ------------ | --------------------------------------- | ----------------------- | ----- | --------- | --------- |
| IBM AIX  | `powerpc`    | `7.1` (TL5 SP2 or higher), `7.2`, `7.3` | Validated and supported | No    | Yes       | Habitat   |

**Oracle Solaris**

| Platform       | Architecture | Version                                 | Tier                    | Agent | Agentless | Installer |
| -------------- | ------------ | --------------------------------------- | ----------------------- | ----- | --------- | --------- |
| Oracle Solaris | `i86pc`      | `11.3` (16.17.4 and later only), `11.4` | Validated and supported | Yes   | Yes       | Habitat   |
| Oracle Solaris | `sparc`      | `11.3` (16.17.4 and later only), `11.4` | Validated and supported | No    | Yes       | Habitat   |

**FreeBSD**

| Platform | Architecture | Version | Tier                    | Agent | Agentless | Installer |
| -------- | ------------ | ------- | ----------------------- | ----- | --------- | --------- |
| FreeBSD  | `amd64`      | `13.x`  | Validated and supported | Yes   | Yes       | Habitat   |

**Specialized and network Linux**

| Platform      | Architecture | Version                  | Tier          | Agent | Agentless | Installer |
| ------------- | ------------ | ------------------------ | ------------- | ----- | --------- | --------- |
| Arista EOS    | `x86_64`     | current non-EOL releases | User-reported | Yes   | Yes       | Habitat   |
| Cumulus Linux | `x86_64`     | current non-EOL releases | User-reported | Yes   | Yes       | Habitat   |
| XCP-ng        | `x86_64`     | `8.x`                    | User-reported | Yes   | Yes       | Habitat   |

**Other community platforms**

| Platform            | Architecture | Version                  | Tier          | Agent | Agentless | Installer |
| ------------------- | ------------ | ------------------------ | ------------- | ----- | --------- | --------- |
| Alibaba Cloud Linux | `x86_64`     | `2.x`                    | User-reported | Yes   | Yes       | Habitat   |
| Arch Linux          | `x86_64`     | current version          | User-reported | Yes   | Yes       | Habitat   |
| Clear Linux         | `x86_64`     | current non-EOL releases | User-reported | Yes   | Yes       | Habitat   |
| OpenIndiana Hipster | `x86_64`     | current non-EOL releases | User-reported | Yes   | Yes       | Habitat   |
| SmartOS             | `x86_64`     | current non-EOL releases | User-reported | Yes   | Yes       | Habitat   |
| Virtuozzo           | `x86_64`     | current non-LTS releases | User-reported | Yes   | Yes       | Habitat   |
