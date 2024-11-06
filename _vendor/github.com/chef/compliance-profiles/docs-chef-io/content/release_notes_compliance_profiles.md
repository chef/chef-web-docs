+++
title = "Chef Compliance Audit Profiles release notes"
draft = false

[menu]
  [menu.release_notes]
    title = "Chef Compliance Audit Profiles"
    identifier = "release_notes/compliance/Chef Compliance Profiles"
    parent = "release_notes/compliance"
    weight = 10
+++

## 20241106

### New Features

- CIS Oracle Linux 9 v2.0.0(Audits)
- CIS Debian Linux 12 v1.0.1(Audits)
- CIS Debian Linux 11 v2.0.0(Audits)
- CIS Windows Server 2022 v3.0.0(Audits)

## 20240910

### New Features

- CIS Amazon Linux 2023 v1.0.0(Audits)
- CIS Apple Mac OS 13.0 Ventura v2.0.0(Audits)
- CIS Windows Server 2012r2 v3.0.0(Audits)
- CIS MariaDB v1.0.0 (Audits)
- CIS Azure Foundation v2.0.0 (Audits)
- CIS AWS Foundation v2.0.0 (Audits)
- CIS Microsoft Windows 11 Enterprise Benchmark v3.0.0
- STIG Oracle Linux 8 v1.8.0
- CIS RHEL7 v4.0.0(Audits)
- CIS RHEL8 v3.0.0(Audits)
- CIS Oracle Linux 9 v1.0.0(Audits)
- CIS VMWare Esxi 7.0 v1.3.0(Audits)
- CIS IBM AIX 7.2 Benchmark v1.1.0(Audits)
- STIG Oracle Linux 8 v1.8.0(Audits)
- CIS Windows Server 2016 v3.0.0(Audits)
- CIS Windows Server 2019 v3.0.1(Audits)
- STIG RHEL 9 v1.1.0(Audits)
- STIG Microsoft IIS Server 10.0 v2(Audits)
- STIG Postgres SQL Server v2(Audits)

### Improvements

- CIS CentOS Linux 7 v3.1.2 Benchmark Level 1 - Server controls were incorrect; improved the password regex check.
- CIS Rhel 7 v3.1.1 code optimisation.
- CIS RHEL 9 v1.0.0 for control 5.6.2 regex fixed for login path.
- CIS RHEL 9 v1.0.0 fixed 17 controls to verify tests in defined commands and files.

### Bug Fixes

- RHEL 7v2.0.0 Control 1.2.3 Ensure gpgcheck is globally activated is showing as failing.

## 20240226

### New features

Added the following compliance profiles:

- CIS Amazon Linux 2023 v1.0.0 (Audits)
- CIS Apple Mac OS 13.0 Ventura v2.0.0 (Audits)
- CIS Windows Server 2012r2 v3.0.0 (Audits)

### Bug fixes

- Fixed the CIS CentOS Linux 7 v3.1.2 Benchmark Level 1 - Server profile to correctly audit password content.

## 20231030

### New features

- STIG Windows Server 2022 v1.2.0(Audits)
- CIS Windows Server 2022 v2.0.0(Audits)
- CIS Windows Server 2016 v2.0.0(Audits)

## 20230905

### New features

- CIS Oracle Solaris 11.4 v1.0.0(Audits)
- CIS Windows Server 2019 v2.0.0(Audits)

## 20230623

### New features

- CIS Ubuntu 22.04 v1.0.0 (Audit).
- CIS SUSE Linux Enterprise 12v3.1.0 (Audit).
- STIG Windows 11 v1r2. (Audit)
- CIS Amazon EKS v1.0.0. (Audit)

### Improvements

- CIS RHEL 8 v2.0.0 fix for controls that require sudo permission which gave a false positive.
- CIS RHEL 7 v3.1.1 fix for controls that require sudo permission which gave a false positive.
- CIS CentOS Linux 8 v2.0.0 fix for controls that require sudo permission which gave a false positive.
- CIS Azure Foundation v1.5.0 implemented Azure API & Powershell MSOnline cmdlet for controls (1.1, 1.2, 1.9, 1.11, 1.12).

### Bug fixes

- CIS CentOS Linux 7 Benchmark v3.1.2 : UMASK wrong check issue(Control 5.5.5)

## 20230509

### New features

- CIS Oracle MySQL Community Server 5.7 v2.0.0 (Audit).
- CIS Azure Foundation v1.5.0 (Audit).
- CIS Redhat Openshift v1.3.0 (Audit).
- CIS IBM AIX 7.1 v2.1.0 (Audit).
- CIS RHEL 8 v2.0.0 (Audit).
- CIS RHEL 9 v1.0.0 (Audit).

## 20221212

### New features

- CIS VMWare ESXi 7.0 v1.1.0 (Audit).
- CIS Rocky Linux 8 v1.0.0 (Audit).
- STIG Windows Server 2019 v2r2 (Audits).
- CIS Windows Server 2019 v1.3.0 (Audits)
- CIS Windows Server 2016 v1.4.0 (Audits)

### Improvements

- Added platform support for CIS RHEL 7 v3.1.1. & CIS Amazon Linux 2 v2.0.0.

### Bug fixes

- Added platform support for Amazon Linux 2, RHEL 7 and RHEL 8.
- Optimized redundant API calls by caching SharePoint tenant library for CIS Microsoft Office 365.
- Readme updated on access level for CIS Microsoft Sharepoint 2016 v1.1.0

## 20220913

### New features

- CIS Alma Linux v2.0.0 (Audit).
- CIS Oracle Linux 8 v2.0.0 (Audit).
- CIS Google Kubernetes Engine v1.2.0 (Audit).
- CIS MS Office 365 v1.4.0.

### Bug fixes

- CIS MS Office 365 v1.4.0 scale fix for control 4.3, 5.2, and 5.1 (Audit).

## 20220808

### New features

- CIS Apache HTTP Server 2.4 v2.0.0 (Audit).
- CIS Windows Server 2022 v1.0.0 (Audit).
- STIG Ubuntu 20.04 v1.2.0 (Audit).

### Improvements

- CIS Windows Server 2016 v1.3.0 (added audit procedure to manual controls and removed special characters in the control's title).
- CIS MSSQL Server 2016 v1.3.0 (added audit procedure to manual controls and removed special characters in the control's title).
- CIS Oracle 12c v3.0.0 (added audit procedure to manual controls and removed special characters in the control's title).
- CIS Oracle 18c v1.0.0 (added audit procedure to manual controls and removed special characters in the control's title).
- CIS Oracle 19c v1.0.0 (added audits procedure to manual controls and removed special characters in the control's title).

### Bug fixes

- CIS RHEL 8 v2.0.0 fix for control 6.2.7 implementation mismatch (Audit).
