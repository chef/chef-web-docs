On Windows systems, invoke the Chef Software Install script using
Windows PowerShell:

- For Commercial Persona use

{{< note >}}Please replace `<YOUR LICENSE ID>` with your licenseId.{{< /note >}}

```powershell
. { iwr -useb https://chefdownload-commericial.chef.io/install.ps1?license_id=<YOUR LICENSE ID> } | iex; install
```

- For Trial Persona use

{{< note >}}For Trial Persona licene Id is not mandatory please add if you have one. Please replace `<YOUR LICENSE ID>` with your licenseId.{{< /note >}}

```powershell
. { iwr -useb https://chefdownload-trial.chef.io/install.ps1?license_id=<YOUR LICENSE ID> } | iex; install
```

- For Community Persona use

```powershell
. { iwr -useb https://chefdownload-community.chef.io/install.ps1 } | iex; install
```
