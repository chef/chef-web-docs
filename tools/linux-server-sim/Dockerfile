FROM chef/chef:latest@sha256:4b98144da63fa091d9b2b856ca92c3abd69683d05cfc22ad4107879afb2ddad6 AS chef
FROM chef/inspec:5.24.24@sha256:f9c925997434bf7aca82b238b365a167372089bf8968a54391b796bf68c145a5 AS inspec

FROM ubuntu:24.04@sha256:73b999393d07f2bf65a40373778a44dc9a6d54ad7718d29247d8ff9413c4d6a8

ENV CHEF_LICENSE=accept

COPY --from=chef /opt/chef /opt/chef
COPY --from=inspec /opt/inspec /opt/inspec
COPY cookbooks/example /linux-compliance/cookbooks/example
COPY profile /linux-server-baseline

ENV PATH="/opt/chef/bin:/opt/inspec/bin:${PATH}"

ENTRYPOINT []

CMD ["sleep", "infinity"]
