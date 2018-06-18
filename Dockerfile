FROM python:2.7.14
RUN curl -L https://omnitruck.chef.io/install.sh | bash -s -- -c current -P chefdk
ENV PATH /opt/chefdk/embedded/bin:$PATH
WORKDIR /build_dir
ENTRYPOINT [ "doctools/docker_build.sh" ]
