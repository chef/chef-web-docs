+++
title = "Microsoft 365"

[menu.premium_content]
  identifier = "premium_content/cloud/microsoft_365"
  parent = "premium_content/cloud"
  title = "Microsoft 365"
  weight = 20
+++

Microsoft 365 tenant settings control who can sign in, share files, and send email across an organization.
A single setting can affect every user, so these settings are a common focus of security reviews.

Chef Premium Content covers Microsoft 365 against the [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks).
This content assesses tenant settings using PowerShell from a Windows host, rather than the configuration of that host.

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

#### Provide an account

The account you use affects which controls can run:

- Controls 1.4, 2.5, 3.6, 6.1, and 6.2 connect to SharePoint Online and require the Global Administrator role.
- All other controls work with the Global Reader role.

Chef InSpec can't complete a multi-factor authentication check for this account.
Don't turn off multi-factor authentication for the account.
Instead, give it an exception using the [Microsoft multi-factor authentication settings](https://docs.microsoft.com/en-us/azure/active-directory/authentication/howto-mfa-mfasettings).

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

An encrypted password is keyed to the Windows user that created it, so you can't share it between users.

#### Run the profile

Use the `--no-backend-cache` option.
Some PowerShell commands in this profile can fail intermittently, and the profile can only retry them if Chef InSpec doesn't cache the failed result.

### Harden

Remediation content is available at benchmark v1.0.0, which is earlier than the audit version.
See the known limitations in the following section before you use it.

## Remediation

Remediation content is delivered as a [Chef Infra cookbook](/client/latest/cookbooks/), `remediation_cis_microsoft_365_foundations_v_1_0_0`, with all controls turned on by default.

The cookbook has the following known limitations:

- **Recommendation 1.6 isn't implemented.** The `LegacyAuthProtocolsEnabled` SharePoint Online setting blocks basic authentication sign-in, regardless of additional multi-factor authentication settings.
- **Recommendation 2.3 isn't implemented.** The PowerShell code that CIS provides sets properties that `Set-AtpPolicyForO365` doesn't support.
- **Recommendation 4.5 may fail.** It assumes that at least one transport rule already exists.

## Audit limitations

Check these limitations before you rely on the results:

- **Some recommendations have no automated check.** These are 1.1.4, 1.1.7, 1.1.10, 1.1.11, 1.1.13, 1.1.14, 1.1.16, 2.1, 2.7, 2.9, 2.10, 2.11, 3.2, 5.3 through 5.15, and 7.1 through 7.13.
- **Disabling basic authentication can stop later scans.** If you apply audit recommendation 1.4 manually by turning off basic authentication for SharePoint Online, you can no longer scan or remediate SharePoint Online features using automation.

## Access this content

Chef Premium Content is part of the Chef Enterprise entitlement.
See [Progress Chef Enterprise Edition](/enterprise_chef/) for what the entitlement includes, and contact your Chef account representative to confirm your access.

## Related

- [Cloud coverage](/premium_content/cloud/)
- [Chef Premium Content](/premium_content/)
- [Compliance solution overview](/solutions/compliance/)
- [The Chef way of custom compliance checks](/solutions/compliance/custom_compliance_checks/)
- [Chef InSpec](/inspec/latest/)
