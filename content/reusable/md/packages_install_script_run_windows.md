On Windows systems, invoke the Chef Software Install script using
Windows PowerShell:

{{< note >}}Please replace `<YOUR LICENSE ID>` with your licenseId. For example license_id=testLicense01{{< /note >}}

- For Commercial Persona use

```powershell
. { iwr -useb https://chefdownload-commericial.chef.io/install.ps1?license_id=<YOUR LICENSE ID> } | iex; install
```

- For Trial Persona use

```powershell
. { iwr -useb https://chefdownload-trial.chef.io/install.ps1?license_id=<YOUR LICENSE ID> } | iex; install
```

- For Community Persona use

```powershell
. { iwr -useb https://chefdownload-community.chef.io/install.ps1 } | iex; install
```
