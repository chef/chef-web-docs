+++
title = "Running Chef Habitat Linux Containers"
description = "Running Chef Habitat Linux Containers"

[menu]
  [menu.habitat]
    title = "Running Chef Habitat Linux Containers"
    identifier = "habitat/containers/running-habitat-linux-containers Linux Containers"
    parent = "habitat/containers"
    weight = 70

+++
[\[edit on GitHub\]](https://github.com/habitat-sh/habitat/blob/master/components/docs-chef-io/content/habitat/running_habitat_linux_containers.md)

When you run `hab pkg export docker`, you'll get a Docker container that provides a few things. First, a minimal Linux OS filesystem is provided, with just enough configuration (e.g., `/etc/passwd`, `/etc/resolv.conf`, etc.) to run. Second, the contents of the exported Chef Habitat package, along with its complete dependency tree, as well as a complete Chef Habitat Supervisor installation, are provided, unpacked, in the `/hab/pkgs` directory. Finally, an entry-point script that will start the Supervisor, running the exported Chef Habitat package, is provided, allowing the container itself to behave as though it were the Supervisor.

On Linux, the Chef Habitat Supervisor will normally run as the `root` user, and will start Chef Habitat services as the `pkg_svc_user` specified by that service. However, in some deployment scenarios, it undesirable--or even impossible--to run the Supervisor as `root`. The [OpenShift](https://www.openshift.com/) container platform, for instance, does not run containers as `root` by default, but as randomly-chosen anonymous user IDs. From version 0.53.0 onward, the Chef Habitat Supervisor can now run as an arbitrary user, providing users with more flexibility in how and where the use Chef Habitat.

In order to support this in containers and provide maximal flexibility, the contents of the `/hab` directory are both readable _and writable_ by the `root` _group_. When specifying a user to run a container process as, the user's primary group will be reported as `root` if no matching group can be found in `/etc/group`. This will allow the user to create and populate the `/hab/sup` directory for managing Supervisor state, as well as the `/hab/svc` directory, which will contain all the service's state. This is in line with [recommendations from OpenShift](https://docs.openshift.com/container-platform/3.3/creating_images/habitat/guidelines.html#openshift-container-platform-specific-guidelines) on how to create containers that can run as a non-root user, but nothing in Chef Habitat's implementation is specific to OpenShift; indeed, all the examples provided below use pure Docker.

## Caveats to Running as a Non-root User

"There's no such thing as a free lunch", as the saying goes, and that holds true here. If the Supervisor is running as a non-root user, any processes that it supervises will be run as the same user; any values that the process might specify via `pkg_svc_user` and `pkg_svc_group` are essentially ignored. Furthermore, any files written out by the service during its operation are also owned by that same user.

### Details

Actually, the Supervisor does not care what user it is running as; rather, it uses Linux capabilities to guide its behavior. If the process has the `CAP_SETUID`, `CAP_SETGID`, and `CAP_CHOWN` capabilities, it will be able to run processes as the specified `pkg_svc_user` and `pkg_svc_group` (`CAP_CHOWN` is needed to ensure that the service processes can read and write files within the service's state directories). The Supervisor checks for the presence of these capabilities, and does not rely on having a user ID of 0 or the username `root`.

## Container Deployment Scenarios

### Running a Chef Habitat Container as a Root User

This is the base case. If you are fine with running your container as `root`, you can do that directly:

```sh
docker run --rm -it core/redis:latest
```

Here, `core/redis:latest` would be the image exported from the `core/redis` Chef Habitat package. The Supervisor will run as normal, with supervised processes running as the desired user.

### Running a Chef Habitat Container as a Non-root User

If you cannot run as the `root` user, but you are fine with `root` being the container user's primary group, you can simply specify a user ID to run as. This user need not exist in the container itself, and it's better if it doesn't. Using pure Docker, it might look like this:

```sh
docker run --rm -it --user=888888 core/redis:latest
```

Again, we use our `core/redis` Chef Habitat package container; the user ID 888888 is simply a number chosen at random (this is how platforms like OpenShift operate). No user inside the container has this ID, meaning that the user will be an anonymous user with `root` as its primary group. Because of how we generate Chef Habitat containers, this fact ensures that the user has write permissions within the `/hab` directory.

Due to the current logic around package installation, there is an extra step needed if you would like to have your containerized Supervisors update either themselves or the services they supervise. When installing packages as a non-root user, Chef Habitat will download the origin keys and compressed hart files into the user's `${HOME}/.hab` directory, rather than the global `/hab/cache` directory. You will need to ensure that a user-writable directory is mounted into the container, and specify it as the user's home directory using the `HOME` environment variable. Using pure Docker with a volume that is accessible by the user, that might look like this:

```sh
docker volume create --driver local \\
       --opt type=tmpfs \\
       --opt device=tmpfs \\
       --opt o=size=100m,uid=888888 \\
       test_home

docker run --rm -it \\
       --user=888888 \\
       --mount type=volume,src=test_home,dst=/myhome \\
       --env HOME=/myhome \\
       core/redis:latest --auto-update --strategy=at-once
```

This is merely an illustration; use whatever volume management approaches and service update strategies that are appropriate for your container scheduling system and your local deployment.

As illustrated, updates of this kind are completely optional; you may prefer to move update responsibility to your container scheduler and treat your containers as immutable in this regard.

## Running a Chef Habitat Container as a Non-root User in a Non-root Group

If for whatever reason you do not want your user to be in the `root` group inside the container, you will need to add some additional volumes in order to create the needed directories. However, since you will (by definition) not have write permissions on the `/hab` directory as a whole, your Supervisor _will not_ be able to update either itself or the services it supervises.

To implement this using pure Docker, you could do something like this (the group ID of `999999` was again chosen arbitrarily, as with the user ID):

```sh
docker volume create --driver local \\
       --opt type=tmpfs \\
       --opt device=tmpfs \\
       --opt o=size=100m,uid=888888 \\
       sup_state

docker volume create --driver local \\
       --opt type=tmpfs \\
       --opt device=tmpfs \\
       --opt o=size=100m,uid=888888 \\
       svc_state

docker volume create --driver local \\
       --opt type=tmpfs \\
       --opt device=tmpfs \\
       --opt o=size=100m,uid=888888 \\
       launcher_state

docker run --rm -it \\
       --user=888888:999999 \\
       --mount type=volume,src=sup_state,dst=/hab/sup \\
       --mount type=volume,src=svc_state,dst=/hab/svc \\
       --mount type=volume,src=launcher_state,dst=/hab/launcher \\
       core/redis:latest
```

Again, this is just an illustrative example; use the appropriate strategies for your specific circumstances. The key information here is to ensure that the `/hab/sup`, `/hab/svc`, and `/hab/launcher` directories are writable by the user inside the container.
