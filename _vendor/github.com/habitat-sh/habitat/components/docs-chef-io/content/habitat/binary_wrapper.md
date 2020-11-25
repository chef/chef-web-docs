+++
title = "Binary Wrapper Packages"
description = "Tips and tricks for managing hardcoded library dependencies in binaries"

[menu]
  [menu.habitat]
    title = "Binary Wrapper Packages"
    identifier = "habitat/plans/binary-wrapper"
    parent = "habitat/plans"

+++

[\[edit on GitHub\]](https://github.com/habitat-sh/habitat/blob/master/components/docs-chef-io/content/habitat/binary_wrapper.md)

While Chef Habitat provides the best behavior for applications that can be compiled from source into the Chef Habitat ecosystem, it can also bring the same management benefits to applications distributed in binary-only form.

You can write plans to package up these binary artifacts with minimal special handling. This article covers some tips and tricks for getting this software into Chef Habitat.

## Override The Build Phases You Don't Need

A Chef Habitat package build proceeds in phases: download, verification, unpacking (where you would also patch source code, if you had it), build, and finally installation. Each of these phases has [default behavior]({{< relref "build_phase_callbacks" >}}) within the build system.

When building binary packages, you override the behavior of phases that do not apply to you. At the very minimum, you must override the `do_build` and `do_install` phases, for example:

```bash plan.sh
(...)
do_build() {
  # relocate library dependencies here, if needed -- see next topic
  return 0
}

do_install() {
  mkdir -p $pkg_prefix/bin
  cp $PLAN_CONTEXT/bin/hello_world $pkg_prefix/bin/hello_world
  chmod +x $pkg_prefix/bin/hello_world
}
```

## Relocate Hard-Coded Library Dependencies If Possible

On Linux, many binaries hardcode library dependencies to `/lib` or `/lib64` inside their ELF symbol table. Unfortunately, this means that Chef Habitat is unable to provide dependency isolation guarantees if packages are dependent on any operating system's libraries in those directories. These Chef Habitat packages will also fail to run in minimal environments like containers built using `hab-pkg-export-docker`, because there will not be a `glibc` inside `/lib` or `/lib64`.

> Note: On Windows, library dependency locations are not maintained in a binary file's headers. See [this MSDN article](https://msdn.microsoft.com/library/windows/desktop/ms682586(v=vs.85).aspx) for a complete explanation of how Windows binaries are located. However, it's typically sufficient to ensure that the dependent binaries are on the `PATH`. You should make sure to include all dependencies in the `pkg_deps` of a `plan.ps1` to ensure all of their respective `DLL`s are accessible by your application.

Most binaries compiled in a full Linux environment have a hard dependency on `/lib/ld-linux.so` or `/lib/ld-linux-x86_64.so`. In order to relocate this dependency to the Chef Habitat-provided variant, which is provided by `core/glibc`, use the `patchelf(1)` utility within your plan:

1. Declare a build-time dependency on `core/patchelf` as part of your `pkg_build_deps` line.
2. Invoke `patchelf` on any binaries with this problem during the `do_install()` phase. For example:

```bash
patchelf --interpreter "$(pkg_path_for core/glibc)/lib/ld-linux-x86-64.so.2" \
  "${pkg_prefix}/bin/somebinary"
```

3. The binary may have other hardcoded dependencies on its own libraries that you may need to relocate using other flags to `patchelf` like `--rpath`. For example, Oracle Java provides additional libraries in `lib/amd64/jli` that you will need to relocate to the Chef Habitat location:

```bash
export LD_RUN_PATH=$LD_RUN_PATH:$pkg_prefix/lib/amd64/jli
patchelf --interpreter "$(pkg_path_for core/glibc)/lib/ld-linux-x86-64.so.2" \
  --set-rpath ${LD_RUN_PATH} "${pkg_prefix}/bin/java"
```

4. For more information, please see the [patchelf](https://nixos.org/patchelf.html) documentation.

## Relocating library dependencies

In some situations it will be impossible for you to relocate library dependencies using `patchelf` as above. For example, if the version of `glibc` the software requires is different than that provided by an available version of `glibc` in a Chef Habitat package, attempting to `patchelf` the program will cause execution to fail due to ABI incompatibility.

Your software vendor's support policy might also prohibit you from modifying software that they ship you.

In these situations, you will have to give up Chef Habitat's guarantees of complete dependency isolation and continue to rely on the library dependencies provided by the host operating system. However, you can continue to use the features of the Chef Habitat Supervisor that provide uniform manageability across your entire fleet of applications.

## Fixing hardcoded interpreters

Binary packages often come with other utility scripts that have their interpreter, or "shebang", line (first line of a script) hardcoded to a path that will not exist under Chef Habitat. Examples are: `#!/bin/sh`, `#!/bin/bash`, `#!/bin/env` or `#!/usr/bin/perl`. It is necessary to modify these to point to the Chef Habitat-provided versions, and also declare a runtime dependency in your plan on the corresponding Chef Habitat package (for example, `core/perl`).

Use the `fix_interpreter` function within your plan to correct these interpreter lines during any phase, but most likely your `do_build` phase. For example:

```bash
fix_interpreter ${target} core/coreutils bin/env
```

The arguments to `fix_interpreter` are the file (represented here by `${target}`) you are trying to fix, the origin/name pair of the Chef Habitat package that provides that interpreter, and the interpreter pattern to search and replace in the target.

If you have many files you need to fix, or the binary package automatically generates scripts with hardcoded shebang lines, you may need to simply symlink Chef Habitat's version into where the binary package expects it to go:

```bash
ln -sv $(pkg_path_for coreutils)/bin/env /usr/bin/env
```

This is a last resort as it breaks the dependency isolation guarantees of Chef Habitat.
