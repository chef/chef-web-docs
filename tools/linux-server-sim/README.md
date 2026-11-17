# Linux server compliance simulation

This container provides an Ubuntu 24.04 target for testing the Linux server
recipe and InSpec profile without connecting to a host. It checks package,
account, and file assertions. Docker Desktop doesn't provide the systemd
manager the `service` resource needs on this target, so the service assertions
fail in the container. Use a disposable Linux host with systemd to verify
service state.

Build the image from the repository root:

```shell
docker build --platform linux/amd64 -t linux-server-sim:5.24.24 tools/linux-server-sim
```

Start the container and converge the cookbook:

```shell
docker run --rm --detach --platform linux/amd64 --name linux-server-test linux-server-sim:5.24.24
docker exec linux-server-test apt-get update
docker exec --workdir /linux-compliance/cookbooks/example linux-server-test chef-client --local-mode --override-runlist example
```

Run the profile, save JSON evidence, and test the sample waiver:

```shell
docker exec linux-server-test inspec exec /linux-server-baseline --reporter cli json:/tmp/linux-server-results.json
docker exec linux-server-test inspec exec /linux-server-baseline --waiver-file /linux-server-baseline/waivers.yml
docker rm --force linux-server-test
```

The assessment returns exit code `100` because the service assertions fail in
this container. The waiver run returns `101` because it skips the control.
Neither result is a substitute for assessing a real server.
