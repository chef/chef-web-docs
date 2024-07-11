On Windows systems, invoke the Chef Software Install script using
Windows PowerShell:

```powershell
For Commercial Persona use curl -L https://chefdownload-commercial.chef.io/stable/downloadScript?os_type=windows&license_id=<YOUR LICENSE ID>

For Trial Persona use curl -L https://chefdownload-trial.chef.io/stable/downloadScript?os_type=windows

For Opensource Persona use curl https://chefdownload-community.chef.io/stable/downloadScript?os_type=windows
```
enter your licenseId in place of licenseId

Once the script is download install using
```powershell
.\downloadScript
```