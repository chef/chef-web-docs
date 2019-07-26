``` ruby
powershell_script 'Install IIS' do
  code <<-EOH
  Import-Module ServerManager
  Add-WindowsFeature Web-Server
  EOH
  flags '-NoLogo, -NonInteractive, -NoProfile, -ExecutionPolicy Unrestricted, -InputFormat None, -File'
  guard_interpreter :powershell_script
  not_if '(Get-WindowsFeature -Name Web-Server).Installed'
end
```