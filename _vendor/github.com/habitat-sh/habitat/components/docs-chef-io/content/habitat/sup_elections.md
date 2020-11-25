+++
title = "Leader Elections"

date = 2020-10-26T19:05:42-07:00
draft = false

[menu]
  [menu.habitat]
    title = "Leader Elections"
    identifier = "habitat/supervisors/Leader Elections"
    parent = "habitat/supervisors"
    weight = 40
+++

[\[edit on GitHub\]](https://github.com/habitat-sh/habitat/blob/master/components/docs-chef-io/content/habitat/sup_elections.md)

This document provides developer documentation on how the Chef Habitat system becomes self-sustaining. It is built upon the work from the [Linux from Scratch](http://www.linuxfromscratch.org/lfs/) project.

This instructions in this document may become rapidly out-of-date as we develop Chef Habitat further. Should you have questions, please join us in [Chef Discourse](https://discourse.chef.io/).

## Part I: Background

In order to bootstrap the system from scratch, you should be familiar with how the Linux From Scratch project works.

We add the following software to augment the Linux From Scratch toolchain:

* Statically built [BusyBox](https://www.busybox.net/) - used for the unzip implementation. This is copied in to tarball as `/tools/bin/busybox`.
* Statically built [Wget](https://www.gnu.org/software/wget/) with OpenSSL support - used by the build program to download sources. This is copied in to the tarball as `/tools/bin/wget.real`.
* Statically built [rq](https://github.com/dflemstr/rq) - used by the build program to verify configuration value types. This is copied in to the tarball as `/tools/bin/rq`.
* A symlink of `unzip` which points to the BusyBox binary and used by the build program to extract zipped source archives. This is copied in to the tarball as `/tools/bin/unzip -> busybox`.
* A copy of curl's [cacert.pem](https://curl.haxx.se/ca/cacert.pem) certificates - used by wget when connecting to SSL-enabled websites. This is copied into the tarball as `/tools/etc/cacert.pem`.
* A small wrapper script for `wget` so that we use the SSL certificates we added to the tarball. Its source is:

```bash
#!/tools/bin/busybox sh
exec /tools/bin/wget.real --ca-certificate /tools/etc/cacert.pem $*
```

Finally, we place a recent last-known-good copy of the `hab` binary inside `tools/bin`.

The entire tarball of bootstrap "tools" lives inside the [stage1 studio](https://s3-us-west-2.amazonaws.com/habitat-studio-stage1/habitat-studio-stage1-20180312233639.tar.xz) tarball. This should be unpacked into `/tools` on a Linux host that will serve as the build environment until the system is self-sustaining through the rest of this procedure.

Note: In order to build large amounts of software in the fastest way possible, we recommend you use a powerful machine, such as a `c4.4xlarge` on Amazon Web Services (AWS). While it may be possible to run these builds in Docker containers, in workstation virtual machines, or on older hosts, it's well worth it to spend a few dollars to save potentially dozens of hours of wait time.

## Part II: Stage 0

### Creating the stage1 Tarball

If you need to build the stage1 tarball from scratch, we will be following the [Linux from Scratch](http://www.linuxfromscratch.org/lfs/) guide, specifically from the start to the end of section II.5. ("Constructing a Temporary System"). By this point, you should be the `root` user with a `/mnt/lfs/tools` directory containing the cross compiled minimal toolchain. From here, we create a tarball of the `tools/` directory and append our Chef Habitat-specific software into it:

```bash
# Create a variable for the target tarball
$ TARFILE=~ubuntu/habitat-studio-stage1-$(date -u +%Y%m%d%H%M%S).tar

# Create the tarball
$ tar cf $TARFILE -C /mnt/lfs tools

# Install some Chef Habitat package which provide the extra, static software
$ hab pkg install core/cacerts core/wget-static core/busybox-static core/rq core/hab

$ mkdir -p tools/{bin,etc}

# Create the wget wrapper script
$ cat <<EOF > tools/bin/wget
#!/tools/bin/busybox sh
exec /tools/bin/wget.real --ca-certificate /tools/etc/cacert.pem \$*
EOF
$ chmod 755 tools/bin/wget

# Install the program binaries, symlinks, and certificates
$ cp -p $(hab pkg path core/wget-static)/bin/wget tools/bin/wget.real
$ cp -p $(hab pkg path core/busybox-static)/bin/busybox tools/bin/busybox
$ cp -p $(hab pkg path core/rq)/bin/rq tools/bin/rq
$ cp -p $(hab pkg path core/hab)/bin/hab tools/bin/hab
$ cp -p $(hab pkg path core/cacerts)/ssl/certs/cacert.pem tools/etc/cacert.pem
$ (cd tools/bin && ln -sv ./busybox unzip)

# Append the local `tools/` directory into the tarball and compress it
$ tar --append --file $TARFILE tools
$ xz --compress -9 --threads=0 --verbose $TARFILE

# Copy the tar.xz archive into the `tmp/` directory so that it will be picked
# up by the stage1 Studio later on
$ cp -v ${TARFILE}.xz /tmp/
```

### Freshening the stage1 Tarball

Alternatively, from time to time and especially with breaking changes to `hab`'s core behavior it is a good idea to update the software in the `habitat-studio-stage1` tarball, even if that means skipping the work of rebuilding the toolchain.

You can do this work on a Linux distribution such as Ubuntu, or perform these tasks in a Docker container if that's more convenient:

```bash
$ docker run --rm -ti -v $(pwd):/src ubuntu:xenial bash
```

These commands assume you are running in a Docker container and are missing some software:

```bash
# Install xz tools
$ apt-get update && apt-get install -y xz-utils

# Decompress the tarball and remove old version of hab
$ tarxz=/src/habitat-studio-stage1-20160612022150.tar.xz
$ xz --decompress --keep $tarxz
$ tar --delete --file=${tarxz/.xz/} tools/bin/hab

# Extract new version of hab in correct path structure
$ hart=/src/core-hab-0.6.0-20160701014820-x86_64-linux.hart
$ mkdir -p /tmp/tools/bin
$ tail -n +6 $hart \\
  | xzcat \\
  | (cd /tmp/tools/bin && tar x --no-anchored bin/hab --strip-components=7)

# Append new version of hab into tarball
$ (cd /tmp && tar --append --file=${tarxz/.xz/} tools)

# Rename tarball to current date and recompress with xz
$ dst=/src/habitat-studio-stage1-$(date -u +%Y%m%d%H%M%S).tar.xz
$ mv ${tarxz/.xz/} ${dst/.xz/}
$ xz --compress -9 --threads=0 --verbose ${dst/.xz/}
```

If you upload a new version of this tarball for broader use with the Studio software, it is worth updating the source location in the Studio's [hab-studio-type-stage1.sh](https://github.com/habitat-sh/habitat/blob/master/components/studio/libexec/hab-studio-type-stage1.sh) code (the line with `${STAGE1_TOOLS_URL}`). Note that simply to use or test a new tarball with Studio, you should only need to set the following before using `hab studio` commands:

* `export STAGE1_TOOLS_URL=habitat-studio-stage1-20160612022150.tar.xz`

and finally, place this tarball under `/tmp` which will help the Studio code find this tarball as if it was previously downloaded, and it will be used directly.

## Part III: Preparing to Build

In this stage, we rebuild all the base packages needed by Chef Habitat using the tools (compiler, etc.) from the existing tools tarball. You will need a copy of the [habitat](https://github.com/habitat-sh/habitat) and [core-plans](https://github.com/habitat-sh/core-plans) repos on your local disk. For our work, we will assume that everything is being run under a common parent directory called `habitat-sh/`. Assuming we want to rebuild the Chef Habitat software as of the last release tag (we'll use `0.56.0` here) and the core plans from latest, here's how to get set up:

```bash
$ mkdir habitat-sh
$ cd habitat-sh
$ git clone https://github.com/habitat-sh/habitat.git
$ (cd habitat && git checkout 0.56.0)
$ git clone https://github.com/habitat-sh/core-plans.git
```

Next, let's get our minimum Chef Habitat software to start us off:

```bash
# (Optional) Completely clean this build host--this will purge all Chef Habitat
# software, caches, and keys from this host!
$ rm -rf /hab

# Install the latest version of the 'hab' program
$ sudo -E ./habitat/components/hab/install.sh

# (Optional) Generate a 'core' origin key, if not already imported or created.
# Otherwise, you'll need to install the real 'core' origin key
$ hab origin key generate core
```

Finally, it's a good idea to clear out any work that might have been left over from previous builds:

```bash
$ sudo rm -rf ./results ./tmp/*.db
```

## Part IV: Stage 1

To simplify the process of setting up and entering a `stage1` Studio, use this [stage1 Studio](https://github.com/habitat-sh/core-plans/blob/master/bin/bootstrap/stage1-studio.sh) wrapper:

```bash
$ ./core-plans/bin/bootstrap/stage1-studio.sh enter
```

Now in the stage1 Studio:

```studio
# (Optional) run all test suites in do_check() build phases
$ export DO_CHECK=true
# Build all base plans in order
$ ./core-plans/bin/bootstrap/stage1-build-base-plans.sh
```

Once the set has finished building, we are going to use the newly built Studio immediately and move the artifacts to the side for more use:

```bash
# Exit the Studio
$ exit
# Save the stage1 artifacts
$ mv ./results ./results-stage1
# Install the just-built Studio
$ sudo hab pkg install ./results-stage1/core-hab-studio-*.hart
```

Now we're ready to use the stage1 packages to make a set of packages that are completely decoupled from the stage1 `tools/` infrastructure, which we'll call a "stage2" build.

## Part V: Stage 2

In this stage, we rebuild all the base packages needed by Chef Habitat using the tools (compiler, etc.) from the previous stage, thus making the system self-hosted. This phase involves not using existing packages that are published in any existing Builder API, so we're going to more carefully create a `default`-type Studio. If we use a fully-qualified package identifier and use the `HAB_STUDIO_BACKLINE_PKG` environment variable, this will skip the call back to a Builder instance.

To make this work, we need to get the fully-qualified package identifier of the `core/hab-backline` package we just built in stage1. You can use `ls -1 ./results-stage1/core-hab-backline-*.hart` to list the artifact. The naming of this file will help you to figure out the package identifier. For example this file:

```
./results-stage1/core-hab-backline-0.56.0-20180322160653-x86_64-linux.hart
```

Has a package identifier of `core/hab-backline/0.56.0/20180322160653`. In general, the `/` characters in a package identifier become `-` characters in an artifact name, and you drop the target info (i.e. `x86_64`) and file extension. For the remainder of this guide, let's assume that your fully-qualified package identifier is `core/hab-backline/0.56.0/20180322160653`.

Finally, to help set up environment variables for the Studio, we're going to use a [stage2 Studio](https://github.com/habitat-sh/core-plans/blob/master/bin/bootstrap/stage2-studio.sh) wrapper:

```bash
# Install only stage1 packages when setting up this Studio--that's why we're
# calling \`new\` explicitly before using
$ env HAB_STUDIO_BACKLINE_PKG=core/hab-backline/0.56.0/20180322160653 ./core-plans/bin/bootstrap/stage2-studio.sh new
# Enter the stage2 Studio
$ ./core-plans/bin/bootstrap/stage2-studio.sh enter
```

Now that we're in a Studio, it's been set up with an empty artifact cache. We're going to set things up so that our install logic won't need to call out to a Builder API:

```studio
# Copy all stage1 packages into the artifact cache
$ cp ./results-stage1/\*.hart /hab/cache/artifacts/
# Install all stage1 packages directly from the artifact cache
$ ls -1 /hab/cache/artifacts/*.hart | while read hart; do hab pkg install $hart; done
```

Okay, time to build all the base plans. As before, there is a wrapper to help here:

```studio
# (Optional) run all test suites in do_check() build phases
$ export DO_CHECK=true
# Build all base plans in order
$ ./core-plans/bin/bootstrap/stage2-build-base-plans.sh
```

By now we should have a full set of base packages that have been built using Chef Habitat packages. These should be suitable for use when building other packages. As a final cleanup:

```bash
# Exit the Studio
$ exit
# Save the stage2 artifacts
$ mv ./results ./results-stage2
```

## Part VI: Rebuild the World

At this point we have a solid set of base packages which can be used to built anything and everything else. As such, it makes sense to at least attempt to rebuild all the other core packages that haven't been touched to this point. The first task here is to generate the build list order of all remaining packages in our "world" and exclude all the base packages so that we can avoid building them yet another time (for no additional benefit). Luckily, there is a `build-order.rb` program in the `core-plans` repository that will generate such a list. The reason that this program is in Ruby is to take advantage of the topological sorting library in Ruby's stdlib (called `tsort`). If you've ever used `rake` before with tasks and dependencies, `tsort` is the magic which powers it.

So, we're going to find all relevant Plans, feed them to `build-order.rb`, exclude the base plans set, and format the results here:

```bash
# Install Ruby
$ sudo hab pkg install core/ruby
# Calculate build order of remaining plans and exclude base plans
$ find core-plans habitat/components -name plan.sh \
  | $(hab pkg path core/ruby)/bin/ruby ./core-plans/bin/build-order.rb --without-base \
  | cut -d ' ' -f 2 \
  | grep -v '^$' \
  > stage3_world_order
# Make a copy of the "master" list and use the working copy for building
# against
$ cp stage3_world_order stage3_world_order.working
```

As in the stage2 build, we need to get the fully-qualified package identifier of the `core/hab-backline` package we just built in stage2. You can use `ls -1 ./results-stage2/core-hab-backline-*.hart` to list the artifact. The naming of this file will help you to figure out the package identifier. For now, let's assume that the identifier corresponding to the artifact was `core/hab-backline/0.56.0/20180322181801`.

As before, to help set up environment variables for the Studio, we're going to use a [stage3 Studio](https://github.com/habitat-sh/core-plans/blob/master/bin/bootstrap/stage3-studio.sh) wrapper:

```bash
# Install only stage2 packages when setting up this Studio--that's why we're
# calling `new` explicitly before using
$ env HAB_STUDIO_BACKLINE_PKG=core/hab-backline/0.56.0/20180322181801 ./core-plans/bin/bootstrap/stage3-studio.sh new
# Enter the stage3 Studio
$ ./core-plans/bin/bootstrap/stage3-studio.sh enter
```

Now that we're in a Studio, it's been set up with an empty artifact cache. We're going to set things up so that our install logic won't need to call out to a Builder API:

```studio
# Copy all stage2 packages into the artifact cache
$ cp ./results-stage2/*.hart /hab/cache/artifacts/
# Install all stage2 packages directly from the artifact cache
$ ls -1 /hab/cache/artifacts/*.hart | while read hart; do hab pkg install $hart; done
```

Okay, time to build all the remaining plans. As before, there is a wrapper to help here:

```studio
# (Optional) run all test suites in do_check() build phases
$ export DO_CHECK=true
# Build all base plans in order
$ ./core-plans/bin/bootstrap/stage3-build-remaining-plans.sh stage3_world_order.working
```

If there are failures as you work through the remaining world, you may discover this is due to a) an older version of the software that can't build against a newer/different compiler, b) a failure that is currently in master and not yet caught (ex: source url now returns a 404), c) other issues which require more debugging and work. You can try to fix the package at this moment and re-run the `stage3-build-remaining-plan.sh` which will resume your failed build and continue. Alternatively, you could remove that Plan out of the rebuild set and deal with it separately. The catch here is that your failing package might become a dependency of another package later on, so you would want to remove those as well. Thankfully, there's a way you can get this list, by running another program in the `core-plans` repository. Note that you want to run this in the same common parent directory containing the `core-plans` and `habitat` git clones, and also outside of a Studio. Let's assume that the plan is for `core/doxygen`. You can run:

```bash
$ find core-plans habitat/components -name plan.sh \
  | $(hab pkg path core/ruby)/bin/ruby ./core-plans/bin/build-dependent-order.rb core/doxygen \
  | cut -d ' ' -f 2
```

in my case today, I got the following results back as output:

```
core-plans/clingo
core-plans/aspcud
core-plans/opam
core-plans/libyajl2
core-plans/msgpack
```

So what we want to do now (assuming you want to skip solving this issue right this second) is to edit the `stage3_world_order.working` file and delete the following lines:

```
core-plans/doxygen
core-plans/clingo
core-plans/aspcud
core-plans/opam
core-plans/libyajl2
core-plans/msgpack
```

Then, back in your Studio instance shell, re-run the build wrapper program:

```bash
$ ./core-plans/bin/bootstrap/stage3-build-remaining-plans.sh stage3_world_order.working
```

You'll want to make a note of which packages you've skipped, but since we have a master/unmodified copy of the build order you can see your changes with:

```bash
diff -u stage3_world_order stage3_world_order.working
```

Finally, assuming you have a *lot* of newly built packages, it's worthwhile to exit that Studio and save off the packages:

```bash
# Exit the Studio
$ exit
# Save the stage3 artifacts
$ mv ./results ./results-stage3
```

## Part VIII: Cleaning Up

While you don't have to wait for the end to completely clean up, it can be beneficial to be able to enter any of the stage1/stage2/stage3 Studios for reference. However, if and when you feel like you're finished with any of these Studio instances, you can clean them up with the associated Studio wrapper script. For example, to clean up all the staging Studio instances:

```bash
$ ./core-plans/bin/bootstrap/stage1-studio.sh rm
$ ./core-plans/bin/bootstrap/stage2-studio.sh rm
$ ./core-plans/bin/bootstrap/stage3-studio.sh rm
```

## Part IX: Next Steps

There is more to write here once you have your local artifacts in the various `results-stage*` directories. However next steps to consider are:

* Uploading the stage2 and stage3 artifacts to a Depot and possibly promote them to the stable channel
