# we use pushd/popd here, and /bin/sh of our chefes/buildkite image is not bash
# so we have to override the default shell here
SHELL=bash

assets:
	pushd themes/docs-new && make assets && popd

clean:
	pushd themes/docs-new && make clean && popd

clean_all:
	pushd themes/docs-new && make clean_all && popd

serve: assets
	hugo server --buildDrafts --noHTTPCache

lint:
	hugo -D
