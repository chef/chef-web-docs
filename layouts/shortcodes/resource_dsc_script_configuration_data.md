The following example shows how to specify custom configuration data
using the `configuration_data` property:

``` ruby
dsc_script 'BackupUser' do
  configuration_data <<-EOH
    @{
     AllNodes = @(
          @{
          NodeName = "localhost";
          PSDscAllowPlainTextPassword = $true
          })
     }
  EOH
  code <<-EOH
    $user = 'backup'
    $password = ConvertTo-SecureString -String "YourPass$(random)" -AsPlainText -Force
    $cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $user, $password

   User $user
     {
       UserName = $user
       Password = $cred
       Description = 'Backup operator'
       Ensure = "Present"
       Disabled = $false
       PasswordNeverExpires = $true
       PasswordChangeRequired = $false
     }
   EOH
end
```