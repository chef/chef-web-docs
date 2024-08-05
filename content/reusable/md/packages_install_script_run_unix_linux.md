On UNIX, Linux, and macOS systems, invoke the Chef Software Install script with:

{{< note >}}Please replace `<YOUR LICENSE ID>` with your licenseId. For example license_id=testLicense01{{< /note >}}

- For Commercial Persona use

```bash
curl -L https://chefdownload-commericial.chef.io/install.sh?license_id=<YOUR LICENSE ID> | sudo bash
```

- For Trial Persona use

```bash
curl -L https://chefdownload-trial.chef.io/install.sh?license_id=<YOUR LICENSE ID> | sudo bash
```

- For Community Persona use

```bash
curl -L https://chefdownload-community.chef.io/install.sh | sudo bash
```
