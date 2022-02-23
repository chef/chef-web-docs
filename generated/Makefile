# we use pushd/popd here, and /bin/sh of our chefes/buildkite image is not bash
# so we have to override the default shell here
SHELL=bash

clean:
	rm -rf generated_content

build: clean
	hugo

update_cookstyle_cops: clean
	hugo mod get -u github.com/chef/cookstyle
	hugo mod get -u github.com/chef/cookstyle/docs-chef-io
	rm go.sum
	hugo mod clean
	hugo mod vendor
	hugo
