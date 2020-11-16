# we use pushd/popd here, and /bin/sh of our chefes/buildkite image is not bash
# so we have to override the default shell here
SHELL=bash

assets:
	pushd themes/docs-new && make assets && popd

clean:
	pushd themes/docs-new && make clean && popd
	rm -rf resources/

clean_all:
	pushd themes/docs-new && make clean_all && popd
	rm -rf resources/
	rm -rf results/

serve: assets
	hugo server --buildDrafts --noHTTPCache --buildFuture

serve_ignore_vendor: assets
	hugo server --buildDrafts --noHTTPCache --buildFuture --ignoreVendorPaths github.com/**

lint: assets
	hugo -D


# Generates blank resource pages, one for each yaml file in data/client/resources
# And an index page that lists all the resources.
resource_files:
	rm content/resources/*
	dataDir=data/infra/resources; \
	for f in $$(ls $${dataDir}); \
		do echo $${f}; \
		file=$${f%.yaml}; \
		hugo new -k resource content/resources/$${file}.md ; \
	done
	hugo new -k all_the_resources content/resources/_index.md ;