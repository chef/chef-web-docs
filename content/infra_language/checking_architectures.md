+++
title = "Chef Infra Language: Checking Architectures"
draft = false

gh_repo = "chef-web-docs"

[menu]
  [menu.infra]
    title = "Checking Architectures"
    identifier = "chef_infra/cookbook_reference/infra_language/checking_architectures.md Checking Architectures"
    parent = "chef_infra/cookbook_reference/infra_language"
    weight = 35
+++

Chef Infra Client 15.5 and later include a number of helper methods for checking the processor architecture of systems. These methods can be used in attribute files, recipes, and resources.

### _32_bit?

Determines if the current architecture is 32-bit.

### _64_bit?

Determines if the current architecture is 64-bit.

### arm?

Determines if the current architecture is arm.

### armhf?

Determines if the current architecture is 32-bit ARM hard float.

### i386?

Determines if the current architecture is i386.

### intel?

Determines if the current architecture is Intel.

### powerpc?

Determines if the current architecture is PowerPC.

### ppc64?

Determines if the current architecture is PowerPC 64bit Big Endian.

### ppc64le?

Determines if the current architecture is PowerPC 64bit Little Endian.

### s390?

Determines if the current architecture is s390.

### s390x?

Determines if the current architecture is s390x.

### sparc?

Determines if the current architecture is SPARC.
