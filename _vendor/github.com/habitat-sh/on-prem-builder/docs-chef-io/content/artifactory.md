+++
title = "Chef Habitat Builder on-prem and Artifactory"

[menu]
  [menu.habitat]
    title = "Artifactory"
    identifier = "habitat/builder/on-prem/artifactory"
    parent = "habitat/builder/on-prem"
    weight = 20
+++


If you are interested in using an existing instance of Artifactory as your object store instead of MinIO,
we are providing this capability as an early preview/alpha for testing.

Before you begin, you will need to have the following:

- the URL to the Artifactory instance
- an API key to authenticate to the instance
- a repo for the Habitat artifacts

Once you have the above, modify the your `bldr.env` based on the same config in `bldr.env.sample` in order to enable Artifactory.

Once you have `bldr.env` updated, you can do an install normally using the `install.sh` script.

After logging into the Depot Web UI and creating your origins, you can try uploading some packages and check your Artifactory instance to ensure that they are present in the repo you specified.

If you run into any issues, see the Support section below.

## Running a local Artifactory

If you just want to do a quick test, you can also run a local Artifactory instance. In order to do that, you can do the following:

```bash
sudo hab svc load core/artifactory
```

This spins up a local Artifactory instance, which you can view at: `http://localhost:8081/artifactory/webapp/#/home`

## Managing Builder Artifacts on Artifactory

If you use Artifactory for your Habitat Builder on-prem artifact store, we recommend reading about [Artifactory's best practices for disaster recovery](https://jfrog.com/whitepaper/best-practices-for-artifactory-backups-and-disaster-recovery/).
