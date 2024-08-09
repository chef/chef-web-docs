On Windows systems, invoke the Chef Software Install script using
Windows PowerShell:

{{< note >}}
Please replace `<YOUR LICENSE ID>` with your licenseId. You can get your license id from the
download portal [Chef Download Portal](https://chef.io/downloads).
Sample license Id example: de89a1c4-5fde-4fd7-9fd0-6e8307ca913d
{{< /note >}}

- For Commercial Persona use

```powershell
. { iwr -useb https://chefdownload-commerical.chef.io/install.ps1?license_id=<YOUR LICENSE ID> } | iex; install
```

- For Community Persona use

```powershell
. { iwr -useb https://chefdownload-community.chef.io/install.ps1 } | iex; install
```
