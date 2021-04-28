# we use pushd/popd here, and /bin/sh of our chefes/buildkite image is not bash
# so we have to override the default shell here
SHELL=bash

assets:
	pushd themes/docs-new && make assets && popd

clean_all:
	pushd themes/docs-new && make clean_all && popd
	rm -rf resources/
	hugo mod clean

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

# Generates blank Cookstyle Cop pages, one for each yaml file in
# _vendor/github.com/chef/cookstyle/docs-chef-io/data/cookstyle directory
# And an index page that lists all of the cops.
cookstyle_cops_pages:
	rm -rf content/workstation/cookstyle/*
	dataDir=_vendor/github.com/chef/cookstyle/docs-chef-io/data/cookstyle; \
	for f in $$(ls $${dataDir}); \
		do echo $${f}; \
		file=$${f%.yml}; \
		file=$${file#cops_}; \
		if [ $${file} != .gitkeep ]; then \
			hugo new -k cookstyle_cop content/workstation/cookstyle/$${file}.md; \
		fi ; \
	done
	hugo new -k cookstyle_cops_all content/workstation/cookstyle/cops.md ;
