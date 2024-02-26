+++
title = "azure_microsoft_defender_security_contact Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_microsoft_defender_security_contact"
identifier = "inspec/resources/azure/azure_microsoft_defender_security_contact Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_microsoft_defender_security_contact` Chef InSpec audit resource to test the properties of a Microsoft Defender for Cloud Security Contact configuration.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

```ruby
describe azure_microsoft_defender_security_contact(name: 'SECURITY_CONTACT_NAME') do
  it { should exist }
end
```

## Parameters

`name`
: The name of the resource.

## Properties

`id`
: The ID of the resource.

`name`
: The name of the resource.

`type`
: The resource type.

`properties.notificationsByRole.roles`
: Defines which RBAC roles will get email notifications from Microsoft Defender for Cloud.

`properties.notificationsByRole.state`
: Defines whether to send email notifications from AMicrosoft Defender for Cloud to persons with specific RBAC roles on the subscription.

`properties.emails`
: List of email addresses which will get notifications from Microsoft Defender for Cloud by the configurations defined in this security contact.

`properties.phone`
: The security contact's phone number.

`properties.alertNotifications.state`
: Defines if email notifications will be sent about new security alerts.

`properties.alertNotifications.minimalSeverity`
: Defines the minimal alert severity which will be sent as email notifications.

See the [Azure documentation on Defender for Cloud Security Contact configuration](https://learn.microsoft.com/en-us/rest/api/defenderforcloud/security-contacts/get?tabs=HTTP) for additional information. You may access any attribute in the response with the key names separated by dots (`.`).

## Examples

### Test if a name exists

```ruby
describe azure_microsoft_defender_security_contact(name: 'SECURITY_CONTACT_NAME') do
  its('name') { should eq 'SECURITY_CONTACT_NAME' }
end
```

### Test if a type exists

```ruby
describe azure_microsoft_defender_security_contact(name: 'SECURITY_CONTACT_NAME') do
  its('type') { should eq 'Microsoft.Security/securityContacts' }
end
```

### Test if a notification by role state exists

```ruby
describe azure_microsoft_defender_security_contact(name: 'SECURITY_CONTACT_NAME') do
  its('properties.notificationsByRole.state') { should eq 'On' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

The control passes if the filter returns at least one result.

```ruby
describe azure_microsoft_defender_security_contact(name: 'SECURITY_CONTACT_NAME') do
  it { should exist }
end
```

Use `should_not` if you expect zero matches.

```ruby
describe azure_microsoft_defender_security_contact(name: 'SECURITY_CONTACT_NAME') do
  it { should exist }
end
```

## Azure Permissions

Graph resources require specific privileges granted to your service principal. Please refer to the [Microsoft Documentation](https://docs.microsoft.com/en-us/azure/active-directory/develop/active-directory-integrating-applications#updating-an-application) for information on how to grant these permissions to your application.
