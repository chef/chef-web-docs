+++
title = "Identity and access management (IAM) Actions"

draft = false

[menu]
  [menu.automate]
    title = "IAM Actions"
    parent = "automate/users/authorization"
    identifier = "automate/users/authorization/iam_actions.md IAM Actions"
    weight = 30
+++

Reference the chart on this page when creating a _Role_ to know which action grants access to what page in the browser.

_IAM Action_ lists the associated action or actions required to access that page in the browser.
Use `*` in these actions to give broad permissions to perform all associated actions such as get, list, create, delete, etc.
Specify the action to restrict user access to the specific action.

{{< responsive-table >}}

|  Task           | Browser Tab     | IAM Action       | API endpoint  | URL       |
| --------------- | --------------- | ---------------- | ------------- | --------- |
| View Events | Dashboards | event:* | /event_feed | `https://automate.example.com/dashboards/event-feed` |
| View and Search Events | Dashboards | [event:*, infra:nodes:list] | /event_feed | `https://automate.example.com/dashboards/event-feed` |
| View Service Group Data | Applications | applications:*  | /applications/service-groups | `https://automate.example.com/applications/service-groups` |
| View Client Runs | Infrastructure | infra:nodes:*   | /cfgmgmt/nodes | `https://automate.example.com/infrastructure/client-runs` |
| View Chef Infra Servers | Infrastructure | infra:infraServers:* | /infra/servers | `https://automate.example.com/infrastructure/chef-servers` |
| List Reports | Compliance | compliance:reporting:*  | /compliance/reporting/reports | `https://automate.example.com/compliance/reports/overview` |
| List Scan Jobs | Compliance | compliance:scannerJobs:* | /compliance/scanner/jobs | `https://automate.example.com/compliance/scan-jobs/jobs` |
| Manage Scan Jobs | Compliance | [compliance:scannerJobs:_, infra:nodes:_ , infra:nodeManagers:_, compliance:profiles:_ ] | /compliance/scanner/jobs | `https://automate.example.com/compliance/scan-jobs/jobs` |
| Manage Compliance Profiles | Compliance | compliance:profiles:* | /compliance/profiles | `https://automate.example.com/compliance/compliance-profiles` |
| Manage Notifications | Settings | notifications:* | /notifications | `https://automate.example.com/settings/notifications` |
| Manage Data Feed | Settings | datafeed:* | /data_feed/destination | `https://automate.example.com/settings/data-feed` |
| Manage Node Integrations | Settings | [infra:nodeManagers:_, infra:nodes:_ , secrets:* ] | /nodemanagers , /cfgmgmt/nodes , /secrets | `https://automate.example.com/settings/node-integrations` |
| Manage Node Credentials | Settings | secrets:* | /secrets | `https://automate.example.com/settings/node-credentials` |
| Manage Data Lifecycle | Settings | dataLifecycle:* | /data-lifecycle | `https://automate.example.com/settings/data-lifecycle` |
| Manage Users | Settings | iam:users:* | /iam/v2/users | `https://automate.example.com/settings/users` |
| Manage Teams | Settings | iam:teams:* | /iam/v2/teams | `https://automate.example.com/settings/teams` |
| Manage API Tokens | Settings | iam:tokens:* | /iam/v2/tokens | `https://automate.example.com/settings/tokens` |
| Manage Policies | Settings | iam:policies:* | /iam/v2/policies | `https://automate.example.com/settings/policies` |
| Manage Roles | Settings | iam:roles:* | /iam/v2/roles | `https://automate.example.com/settings/roles` |
| Manage Projects | Settings | iam:projects:* | /iam/v2/projects | `https://automate.example.com/settings/projects` |
| List Download Report Requests | Compliance | reportmanager:requests:list | /reportmanager/requests | `https://automate.example.com/reportmanager/requests` |
{{< /responsive-table >}}
