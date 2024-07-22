On Windows systems, invoke the Chef Software Install script using
Windows PowerShell:

- For Commercial Persona use

```powershell
. { iwr -useb https://chefdownload-commercial.chef.io/install.ps1?license_id=<YOUR LICENSE ID> } | iex; install
```

- For Trial Persona use

```powershell
. { iwr -useb https://chefdownload-trial.chef.io/install.ps1 } | iex; install
```

- For Community Persona use

```powershell
. { iwr -useb https://chefdownload-community.chef.io/install.ps1 } | iex; install
```

enter your licenseId in the place of YOUR LICENSE ID
