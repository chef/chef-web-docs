On UNIX, Linux, and macOS systems, invoke the Chef Software Install script with:

{{< note >}}
Please replace `<YOUR LICENSE ID>` with your licenseId. You can get your license id from the
download portal [Chef Download Portal](https://chef.io/downloads).
Sample license Id example: de89a1c4-5fde-4fd7-9fd0-6e8307ca913d
{{< /note >}}

- For Commercial Persona use

```bash
curl -L https://chefdownload-commericial.chef.io/install.sh?license_id=<YOUR LICENSE ID> | sudo bash
```

- For Community Persona use

```bash
curl -L https://chefdownload-community.chef.io/install.sh | sudo bash
```
