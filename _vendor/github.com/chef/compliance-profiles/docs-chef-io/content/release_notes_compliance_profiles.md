+++
title = "Chef Compliance Audit Profiles Release Notes"
draft = false

[menu]
  [menu.release_notes]
    title = "Chef Compliance Audit Profiles"
    identifier = "release_notes/compliance/Chef Compliance Profiles"
    parent = "release_notes/compliance"
    weight = 10
+++

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
- CIS IBM AIX 7.1 v2.0.0 (Audit).
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
