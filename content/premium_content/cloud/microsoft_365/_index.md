+++
title = "Microsoft 365"

[menu.premium_content]
  identifier = "premium_content/cloud/microsoft_365"
  parent = "premium_content/cloud"
  title = "Microsoft 365"
  weight = 20
+++

The CIS Microsoft 365 benchmark from the [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks) defines secure configuration requirements for a Microsoft 365 tenant.
Chef Premium Content provides Chef InSpec audit profiles and remediation content for these benchmarks.
Coverage varies by benchmark and version. See the coverage tables on this page for details.
This content assesses tenant settings using PowerShell from a Windows host, rather than the configuration of that host.

## What the benchmarks check

The requirements cover the following areas at v1.4.0:

- **Accounts and authentication:** Multi-factor authentication, Conditional Access, and session settings
- **Application permissions:** Third-party applications, Safe Links, and admin consent
- **Data management:** Customer Lockbox, data loss prevention, and external access in Teams
- **Email security:** Attachment filtering, anti-phishing policies, and DMARC records
- **Auditing:** Audit log search and regular review of activity reports
- **Storage:** Document sharing, OneDrive sync, and external sharing links
- **Mobile devices:** Device management policies, device lock, and password requirements

The exact requirements differ by benchmark and version.

## Supported versions

| Benchmark | Audit versions | Remediation versions | Coverage |
| --- | --- | --- | --- |
| `CIS Microsoft 365` | v1.4.0 | v1.0.0 | Audit Ahead |

Audit is at a later benchmark version than remediation, so recommendation numbers don't always match between them.
See [how to read the coverage tables](/premium_content/#how-to-read-the-coverage-tables) for what each coverage term means.

## Available profiles

The benchmark ships as one Chef InSpec profile, `cis-microsoft365-foundations`, at benchmark v1.4.0.
The profile metadata and some of its settings use the older name, Office 365.

## What you can do with this content

### Audit

Run the profile with [Chef InSpec](/inspec/latest/) to assess your tenant against the benchmark and report which requirements pass and which fail.

#### Prepare the Windows host

Target a Windows host that has the following PowerShell modules installed:

- `MSOnline`
- `ExchangeOnlineManagement`
- `Microsoft.Online.SharePoint.PowerShell`
- `MicrosoftTeams`
- `AzureADPreview`
- `PowershellGet`

{{< warning >}}

Microsoft has retired two of these modules.
`MSOnline` stopped working in May 2025, and `AzureADPreview` began to stop working in October 2025.
The profile still connects through them, so the controls that use them can't run.
See [audit limitations](#audit-limitations) for the affected controls.

{{< /warning >}}

#### Provide an account

The account you use affects which controls can run:

- Controls 1.4, 2.5, 3.6, 6.1, and 6.2 connect to SharePoint Online and require the Global Administrator role.
- All other controls work with the Global Reader role.

Chef InSpec can't respond to a multi-factor authentication prompt for this account.
Don't turn off multi-factor authentication for the account.
Instead, give it an exception using the [Microsoft multi-factor authentication settings](https://learn.microsoft.com/en-us/azure/active-directory/authentication/howto-mfa-mfasettings).

#### Set the inputs

Pass the inputs in a YAML file with the `--input-file` option:

| Input | Purpose |
| --- | --- |
| `office365_organization` | Your organization name |
| `office365_domain` | Your Microsoft 365 domain |
| `office365_username` | The account that Chef InSpec signs in with |
| `office365_encryptedpass`, `office365_password` | The account password, either encrypted or in plain text |
| `office365_userquerylimit` | The limit to apply when querying users |
| `exchange_connection_uri` | The URI for the Exchange PowerShell session |
| `notify_outbound_spam_addresses` | The addresses to notify about outbound spam |
| `bcc_outbound_suspicious_addresses` | The addresses to copy on suspicious outbound email |
| `internal_domain_list` | The domains that are internal to your organization |
| `onedrivesync_allowed_domains` | The domains allowed for OneDrive sync |

An encrypted password is keyed to the Windows user that created it, so you can't share it between Windows users.

#### Run the profile

Use the `--no-backend-cache` option.
Some PowerShell commands in this profile can fail intermittently, and the profile can only retry them if Chef InSpec doesn't cache the failed result.

### Harden

Remediation content is available at benchmark v1.0.0, which is earlier than the audit version.
See the known limitations in the following section before you use it.

## Remediation

Remediation content is delivered as a [Chef Infra cookbook](/client/latest/cookbooks/), `remediation_cis_microsoft_365_foundations_v_1_0_0`, with all controls turned on by default.

The cookbook has the following known limitations:

- **Recommendation 1.6 isn't implemented.** The `LegacyAuthProtocolsEnabled` SharePoint Online setting blocks basic authentication sign-in, regardless of other multi-factor authentication settings.
- **Recommendation 2.3 isn't implemented.** The PowerShell that CIS provides uses properties that the supported cmdlet doesn't accept.
- **Recommendation 4.5 may fail.** It assumes that at least one transport rule already exists.

## Audit limitations

Check these limitations before you rely on the results:

- **Some controls depend on retired PowerShell modules.** Controls 1.1.1, 1.1.2, 1.1.3, 1.1.5, 1.1.6, 1.1.8, 1.1.9, 1.1.12, 1.1.15, 1.5, 1.6, 2.6, 4.9, and 4.10 connect through `MSOnline` or `AzureADPreview`, which Microsoft has retired. These controls can't run until the profile moves to supported modules, so don't treat their results as an assessment. For the retirement details, see [MSOnline and AzureAD PowerShell retirement](https://techcommunity.microsoft.com/blog/microsoft-entra-blog/action-required-msonline-and-azuread-powershell-retirement---2025-info-and-resou/4364991).
- **Some recommendations have no automated check.** These are 1.1.4, 1.1.7, 1.1.10, 1.1.11, 1.1.13, 1.1.14, 1.1.16, 2.1, 2.7, 2.9, 2.10, 2.11, 3.2, 5.3 through 5.15, and 7.1 through 7.13.
- **Disabling basic authentication can stop later scans.** If you apply audit recommendation 1.4 manually by turning off basic authentication for SharePoint Online, you can no longer scan or remediate SharePoint Online with automation.

## Access this content

Chef Premium Content is part of the Chef Enterprise entitlement.
See [Progress Chef Enterprise Edition](/enterprise_chef/) for what the entitlement includes, and contact your Chef account representative to confirm your access.

## Related

- [Cloud coverage](/premium_content/cloud/)
- [Chef Premium Content](/premium_content/)
- [Compliance solution overview](/solutions/compliance/)
- [The Chef Way of custom compliance checks](/solutions/compliance/custom_compliance_checks/)
- [Chef InSpec](/inspec/latest/)
